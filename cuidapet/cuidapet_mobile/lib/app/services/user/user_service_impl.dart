// ignore_for_file: directives_ordering

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/exceptions/user_not_exists_exception.dart';
import '../../core/helpers/constants.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';
import '../../repositories/user/user_repository.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final UserRepository _userRepository;
  final AppLogger _log;

  UserServiceImpl({
    required UserRepository userRepository,
    required AppLogger log,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _userRepository = userRepository,
        _log = log;

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
}
