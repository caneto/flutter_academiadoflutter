import 'package:cuidapet_api/application/config/database_connection_configuration.dart';
import 'package:cuidapet_api/application/database/database_connection.dart';
import 'package:cuidapet_api/application/logger/i_logger.dart';
import 'package:cuidapet_api/entities/user.dart';
import 'package:cuidapet_api/modules/user/data/i_user_repository.dart';
import 'package:cuidapet_api/modules/user/data/user_repository.dart';
import 'package:cuidapet_api/modules/user/service/i_user_service.dart';
import 'package:cuidapet_api/modules/user/service/user_service.dart';
import '../../../core/log/mock_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late IUserRepository userRepository;
  late ILogger log;
  late IUserService userService;

  group('Integration test', () {
    setUp(() {
      var databaseConnection = DatabaseConnectionConfiguration(
          host: 'localhost',
          user: 'root',
          port: 3306,
          password: 'academiadoflutter',
          databaseName: 'cuidapet_db');
          
      log = MockLogger();
      userRepository = UserRepository(
        connection: DatabaseConnection(databaseConnection),
        log: log,
      );
      userService = UserService(
        userRepository: userRepository,
        log: log,
      );
    });

    test('integrationTeste', () async {
      //Arrange
      final id = 26;
      final email = 'rodrigorahmanacademia@gmail.com';
      final password = '123123';
      final supplierUser = false;
      final userMock = User(id: id, email: email);
      // when(() => userRepository.loginWithEmailPassword(
      //     email, password, supplierUser)).thenAnswer((_) async => userMock);

      //Act
      final user = await userService.loginWithEmailPassword(
          email, password, supplierUser);

      //Assert
      expect(user.email, equals(email));
      // verify(() => userRepository.loginWithEmailPassword(
      //     email, password, supplierUser)).called(1);
    });
  });
}
