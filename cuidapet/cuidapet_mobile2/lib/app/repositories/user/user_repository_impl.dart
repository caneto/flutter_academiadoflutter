import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/confirm_login_model.dart';
import '../../models/social_network_model.dart';
import '../../models/user_model.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;

  UserRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await _restClient.unauth().post<void>(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
        },
      );
    } on RestClientException catch (e, s) {
      if (e.statusCode == HttpStatus.badRequest &&
          e.response.data['message'].contains('Usuário já cadastrado')) {
        _log.error(e.error, e, s);
        Error.throwWithStackTrace(UserExistsException(), s);
      }

      _log.error('Erro ao cadastrar usuário', e, s);
      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao registrar usuário'),
        s,
      );
    }
  }

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _restClient.unauth().post<Map<String, dynamic>>(
        '/auth/',
        data: {
          'login': email, // por dentro do backend é login, não email
          'password': password,
          'supplier_user': false,
          'social_login': false,
        },
      );

      return response.data!['access_token'];
    } on RestClientException catch (e, s) {
      _loginRestClientError(e, s);
    }
  }

  @override
  Future<ConfirmLoginModel> confirmLogin() async {
    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();

      final response = await _restClient.auth().patch<Map<String, dynamic>>(
        '/auth/confirm',
        data: {
          'ios_token': Platform.isIOS ? deviceToken : null,
          'android_token': Platform.isAndroid ? deviceToken : null,
        },
      );

      return ConfirmLoginModel.fromJson(response.data!);
    } on RestClientException catch (e, s) {
      _log.error('Erro ao confirmar login', e, s);

      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao confirmar login'),
        s,
      );
    }
  }

  @override
  Future<UserModel> getLoggedUser() async {
    try {
      final response = await _restClient.get<Map<String, dynamic>>('/user/');

      return UserModel.fromMap(response.data!);
    } on RestClientException catch (e, s) {
      const errorMessage = 'Erro ao buscar dados do usuário logado';
      _log.error(errorMessage, e, s);

      Error.throwWithStackTrace(
        const Failure(message: errorMessage),
        s,
      );
    }
  }

  @override
  Future<String> loginSocial(SocialNetworkModel model) async {
    try {
      final response = await _restClient.unauth().post<Map<String, dynamic>>(
        '/auth/',
        data: {
          'login': model.email, // Trocar email pór login 
          'social_login': true,
          'avatar': model.avatar,
          'social_type': model.type,
          'social_key': model.id,
          'supplier_user': false,
        },
      );

      return response.data!['access_token'];
    } on RestClientException catch (e, s) {
      _loginRestClientError(e, s);
    }
  }

  Never _loginRestClientError(
    RestClientException error,
    StackTrace stackTrace,
  ) {
    if (error.statusCode == HttpStatus.forbidden) {
      return Error.throwWithStackTrace(
        const Failure(
          message: 'Usuário inconsistente. Entre em contato com o suporte',
        ),
        stackTrace,
      );
    }
    _log.error('Erro ao realizar login', error, stackTrace);

    return Error.throwWithStackTrace(
      const Failure(
        message: 'Erro ao realizar login. Tente novamente mais tarde',
      ),
      stackTrace,
    );
  }
}
