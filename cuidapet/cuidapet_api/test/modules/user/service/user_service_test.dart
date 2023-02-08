
import 'package:cuidapet_api/application/exceptions/service_exception.dart';
import 'package:cuidapet_api/application/exceptions/user_notfound_exception.dart';
import 'package:cuidapet_api/application/helpers/jwt_helper.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/entities/user.dart';
import 'package:cuidapet_api/modules/user/data/i_user_repository.dart';
import 'package:cuidapet_api/modules/user/service/i_user_service.dart';
import 'package:cuidapet_api/modules/user/service/user_service.dart';
import 'package:cuidapet_api/modules/user/view_models/refresh_token_view_model.dart';
import 'package:cuidapet_api/modules/user/view_models/user_refresh_token_input_model.dart';
import 'package:dotenv/dotenv.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../core/log/mock_logger.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late IUserRepository userRepository;
  late ILogger log;
  late IUserService userService;
  late DotEnv env;

  setUp(() {
    userRepository = MockUserRepository();
    log = MockLogger();
    userService = UserService(userRepository: userRepository, log: log);
    registerFallbackValue(User());
    env = DotEnv()..load();
  });

  group('Group test loginWithEmailPassword', () {
    test('Should login with email and password', () async {
      //Arrange
      final id = 1;
      final email = 'rodrigorahman@gmail.com';
      final password = '123123';
      final supplierUser = false;
      final userMock = User(id: id, email: email);
      when(() => userRepository.loginWithEmailPassword(
          email, password, supplierUser)).thenAnswer((_) async => userMock);

      //Act
      final user = await userService.loginWithEmailPassword(
          email, password, supplierUser);

      //Assert
      expect(user, userMock);
      verify(() => userRepository.loginWithEmailPassword(
          email, password, supplierUser)).called(1);
    });

    test(
        'Should login with email and password and return UserNotfoundException',
        () async {
      //Arrange
      final email = 'rodrigorahman@gmail.com';
      final password = '123123';
      final supplierUser = false;
      when(() => userRepository.loginWithEmailPassword(
              email, password, supplierUser))
          .thenThrow(UserNotfoundException(message: 'Usuário não encontrado'));

      //Act
      final call = userService.loginWithEmailPassword;

      //Assert
      expect(() => call(email, password, supplierUser),
          throwsA(isA<UserNotfoundException>()));
      verify(() => userRepository.loginWithEmailPassword(
          email, password, supplierUser)).called(1);
    });
  });

  group('Group test loginWithSocial', () {
    test('Should login social with success', () async {
      //Arrange
      final email = 'rodrigorahman@academiadoflutter.com.br';
      final socialKey = '123';
      final socialType = 'Facebook';

      final userReturnLogin = User(
          id: 1, email: email, socialKey: socialKey, registerType: socialType);
      when(() => userRepository.loginByEmailSocialKey(
              email, socialKey, socialType))
          .thenAnswer((_) async => userReturnLogin);
      //Act
      final user =
          await userService.loginWithSocial(email, '', socialType, socialKey);

      //Assert
      expect(user, userReturnLogin);
      verify(() => userRepository.loginByEmailSocialKey(
          email, socialKey, socialType)).called(1);
    });

    test('Should login social with user not found and create a new user',
        () async {
      //Arrange
      final email = 'rodrigorahman@academiadoflutter.com.br';
      final socialKey = '123';
      final socialType = 'Facebook';

      final userCreated = User(
        id: 1,
        email: email,
        socialKey: socialKey,
        registerType: socialType,
      );

      when(() => userRepository.loginByEmailSocialKey(
              email, socialKey, socialType))
          .thenThrow(UserNotfoundException(message: 'Usuário não encontrado'));

      when(() => userRepository.createUser(any<User>()))
          .thenAnswer((_) async => userCreated);
      //Act
      final user =
          await userService.loginWithSocial(email, '', socialType, socialKey);

      //Assert
      expect(user, userCreated);
      verify(() => userRepository.loginByEmailSocialKey(
          email, socialKey, socialType)).called(1);
      verify(() => userRepository.createUser(any<User>())).called(1);
    });
  });

  group('Group test refreshToken', () {
    test('Should refresh token with success', () async {
      //Arrange
      env.map['refresh_token_not_before_hours'] = '0';
      final userId = 1;
      final accessToken = JwtHelper.generateJWT(userId, null);
      final refreshToken = JwtHelper.refreshToken(accessToken);
      final model = UserRefreshTokenInputModel(
        user: userId,
        accessToken: accessToken,
        dataRequest: '{"refresh_token": "$refreshToken"}',
      );
      when(() => userRepository.updateRefreshToken(any()))
          .thenAnswer((_) async => _);
      //Act
      final responseToken = await userService.refreshToken(model);

      //Assert
      expect(responseToken, isA<RefreshTokenViewModel>());
      expect(responseToken.accessToken, isNotEmpty);
      expect(responseToken.refreshToken, isNotEmpty);
      verify(() => userRepository.updateRefreshToken(any())).called(1);
    });

    test('Should try refresh token JWT but return validate erro (Bearer)',
        () async {
      //Arrange
      final model = UserRefreshTokenInputModel(
        user: 1,
        accessToken: 'accessToken',
        dataRequest: '{"refresh_token": "123"}',
      );
      //Act
      final call = userService.refreshToken;

      //Assert
      expect(() => call(model), throwsA(isA<ServiceException>()));
    });

    test('Should try refresh token JWT but return validate erro (JwtException)',
        () async {
      //Arrange
      final userId = 1;
      final accessToken = JwtHelper.generateJWT(userId, null);
      final refreshToken = JwtHelper.refreshToken('123');
      final model = UserRefreshTokenInputModel(
        user: userId,
        accessToken: accessToken,
        dataRequest: '{"refresh_token": "$refreshToken"}',
      );
      //Act
      final call = userService.refreshToken;

      //Assert
      expect(() => call(model), throwsA(isA<ServiceException>()));
    });
  });

}
