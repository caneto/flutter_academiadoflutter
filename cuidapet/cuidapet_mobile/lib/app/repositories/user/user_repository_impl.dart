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
}
