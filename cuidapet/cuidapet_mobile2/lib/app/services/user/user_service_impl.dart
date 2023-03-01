// ignore_for_file: directives_ordering

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/exceptions/user_not_exists_exception.dart';
import '../../core/helpers/constants.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';
import '../../models/social_login_type.dart';
import '../../models/social_network_model.dart';
import '../../repositories/social/social_repository.dart';
import '../../repositories/user/user_repository.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final UserRepository _userRepository;
  final SocialRepository _socialRepository;
  final AppLogger _log;

  UserServiceImpl({
    required AppLogger log,
    required UserRepository userRepository,
    required SocialRepository socialRepository,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _log = log,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _userRepository = userRepository,
        _socialRepository = socialRepository;

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }

      await _userRepository.register(email: email, password: password);

      final userRegisterCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error('Erro ao criar usuário no firebsse', e, s);

      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao criar usuário'),
        s,
      );
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;

      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }

      if (loginMethods.contains('password')) {
        final credentials = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final verifiedUser = credentials.user?.emailVerified ?? false;

        if (!verifiedUser) {
          await credentials.user?.sendEmailVerification();
          throw const Failure(
            message: 'E-mail não confirmado. Verifique sua caixa de spam.',
          );
        }

        final user =
            await _userRepository.login(email: email, password: password);
        await _saveAccessToken(user);
        //final xx = await _localStorage
        //    .read<String>(Constants.localStorageAccessTokenKey);
        //if (kDebugMode) {
        //  print(xx);
        //}
        await _confirmLogin();
        await _getUserData();
      } else {
        throw const Failure(message: 'Login not found');
      }
    } on FirebaseAuthException catch (e, s) {
      _log.error('Invalid user or password $e');
      Error.throwWithStackTrace(
        const Failure(message: 'Usuário ou senha inválidos'),
        s,
      );
    }
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage
      .write<String>(Constants.localStorageAccessTokenKey, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(
      Constants.localStorageRefreshTokenKey,
      confirmLoginModel.refreshToken,
    );
  }

  Future<void> _getUserData() async {
   final userModel = await _userRepository.getLoggedUser();
    await _localStorage.write<String>(
       Constants.localStorageLoggedUserDataKey,
       userModel.toJson(),
    );
  }

   @override
  Future<void> socialLogin(SocialLoginType type) async {
    try {
      final SocialNetworkModel socialNetworkModel;
      final AuthCredential authCredential;
      final firebaseAuth = FirebaseAuth.instance;

      switch (type) {
        case SocialLoginType.facebook:
          socialNetworkModel = await _socialRepository.facebookLogin();
          authCredential =
              FacebookAuthProvider.credential(socialNetworkModel.accessToken);
          break;
        case SocialLoginType.google:
          socialNetworkModel = await _socialRepository.googleLogin();
          authCredential = GoogleAuthProvider.credential(
            accessToken: socialNetworkModel.accessToken,
            idToken: socialNetworkModel.id,
          );
          break;
      }

      final loginMethods = await firebaseAuth
          .fetchSignInMethodsForEmail(socialNetworkModel.email);

      if (loginMethods.isNotEmpty && !loginMethods.contains(type.domain)) {
        throw Failure(message: 'Login não pode ser feito por ${type.value}.');
      }

      await firebaseAuth.signInWithCredential(authCredential);
      final result = await _userRepository.loginSocial(socialNetworkModel);
      await _saveAccessToken(result);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e, s) {
      _socialLoginError(type, e, s);
    } on PlatformException catch (e, s) {
      _socialLoginError(type, e, s);
    }
  }

  Never _socialLoginError(SocialLoginType type, dynamic e, StackTrace s) {
    _log.error('Erro ao realizar login com ${type.value}', e, s);

    return Error.throwWithStackTrace(
      const Failure(message: 'Erro ao realizar login'),
      s,
    );
  }
}
