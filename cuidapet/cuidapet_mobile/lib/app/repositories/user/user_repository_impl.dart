import 'dart:io';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client.dart';
import '../../core/rest_client/rest_client_exception.dart';
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
