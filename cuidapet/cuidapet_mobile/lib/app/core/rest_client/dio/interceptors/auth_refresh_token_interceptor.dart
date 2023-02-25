import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../modules/core/auth/auth_store.dart';
import '../../../exceptions/expire_token_exception.dart';
import '../../../helpers/constants.dart';
import '../../../local_storage/local_storage.dart';
import '../../../logger/app_logger.dart';
import '../../rest_client.dart';
import '../../rest_client_exception.dart';

class AuthRefreshTokenInterceptor extends Interceptor {
  final AuthStore _authStore;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final RestClient _restClient;
  final AppLogger _log;

  AuthRefreshTokenInterceptor({
    required AuthStore authStore,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required RestClient restClient,
    required AppLogger log,
  })  : _authStore = authStore,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _restClient = restClient,
        _log = log;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      final responseStatusCode = err.response?.statusCode ?? 0;
      final requestPath = err.requestOptions.path;

      if (responseStatusCode == HttpStatus.forbidden ||
          responseStatusCode == HttpStatus.unauthorized) {
        if (requestPath != '/auth/refresh') {
          final authRequired =
              err.requestOptions.extra[Constants.restClientAuthRequiredKey] ??
                  false;

          if (authRequired) {
            _log.append('##### REFRESH TOKEN #####');
            await _refreshToken();
            await _retryRequest(err, handler);
          } else {
            Error.throwWithStackTrace(err, StackTrace.current);
          }
        } else {
          Error.throwWithStackTrace(err, StackTrace.current);
        }
      } else {
        Error.throwWithStackTrace(err, StackTrace.current);
      }
    } on ExpireTokenException {
      _authStore.logout();
      handler.next(err);
    } on DioError catch (e) {
      handler.next(e);
    } catch (e, s) {
      _log.error('Rest client error', e, s);
      handler.next(err);
    } finally {
      _log.closeAppend();
    }
  }

  Future<void> _refreshToken() async {
    try {
      final refreshToken =
          await _localSecureStorage.read(Constants.localStorageRefreshTokenKey);

      if (refreshToken == null) {
        throw ExpireTokenException();
      }

      final resultRefreshToken = await _restClient.auth().put(
        '/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      await _localStorage.write<String>(
        Constants.localStorageAccessTokenKey,
        resultRefreshToken.data['access_token'],
      );

      await _localSecureStorage.write(
        Constants.localStorageRefreshTokenKey,
        resultRefreshToken.data['refresh_token'],
      );
    } on RestClientException catch (e, s) {
      _log.error('Erro ao tentar fazer refresh token', e, s);
      throw ExpireTokenException();
    }
  }

  Future<void> _retryRequest(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    _log.append('######## Retry request ########');
    final requestOptions = err.requestOptions;

    final result = await _restClient.request(
      requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      headers: requestOptions.headers,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
