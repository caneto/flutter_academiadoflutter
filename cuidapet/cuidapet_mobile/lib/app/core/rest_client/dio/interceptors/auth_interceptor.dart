import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../modules/core/auth/auth_store.dart';
import '../../../helpers/constants.dart';
import '../../../local_storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AuthStore _authStore;

  AuthInterceptor({
    required LocalStorage localStorage,
    required AuthStore authStore,
  })  : _localStorage = localStorage,
        _authStore = authStore;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authRequired =
        options.extra[Constants.restClientAuthRequiredKey] ?? false;

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constants.localStorageAccessTokenKey);

      if (accessToken == null) {
        await _authStore.logout();
        handler.reject(
          DioError(
            requestOptions: options,
            error: 'Expire Token',
            type: DioErrorType.cancel,
          ),
        );
      }

      options.headers[HttpHeaders.authorizationHeader] = accessToken;
    } else {
      options.headers.remove(HttpHeaders.authorizationHeader);
    }

    handler.next(options);
  }
}
