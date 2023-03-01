// ignore_for_file: always_put_required_named_parameters_first

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../modules/core/auth/auth_store.dart';
import '../../helpers/constants.dart';
import '../../helpers/enviroments.dart';
import '../../local_storage/local_storage.dart';
import '../../logger/app_logger.dart';
import '../rest_client.dart';
import '../rest_client_exception.dart';
import '../rest_client_response.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/auth_refresh_token_interceptor.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    baseUrl: Environments.params(Constants.envBaseUrlKey) ?? '',
    connectTimeout: int.parse(
      Environments.params(Constants.envRestClientConnectTimeout) ?? '0',
    ),
    receiveTimeout: int.parse(
      Environments.params(Constants.envRestClientReceiveTimeout) ?? '0',
    ),
  );

  DioRestClient({
    BaseOptions? baseOptions,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required AuthStore authStore,
    required AppLogger log,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(localStorage: localStorage, authStore: authStore),
      if (kDebugMode) LogInterceptor(requestBody: true, responseBody: true),
      AuthRefreshTokenInterceptor(
        authStore: authStore,
        localStorage: localStorage,
        localSecureStorage: localSecureStorage,
        restClient: this,
        log: log,
      ),
    ]);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra[Constants.restClientAuthRequiredKey] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultOptions.extra[Constants.restClientAuthRequiredKey] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      _throwRestClientException(e, s);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      _throwRestClientException(e, s);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      _throwRestClientException(e, s);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      _throwRestClientException(e, s);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter<T>(response);
    } on DioError catch (e, s) {
      _throwRestClientException(e, s);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );

      return _dioResponseConverter(response);
    } on DioError catch (e, s) {
      _throwRestClientException(e, s);
    }
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response<dynamic> response) =>
      RestClientResponse<T>(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );

  Never _throwRestClientException(DioError dioError, StackTrace s) {
    final response = dioError.response;
    final responseStatusCode = response?.statusCode;
    final responseStatusMessage = response?.statusMessage;

    return Error.throwWithStackTrace(
      RestClientException(
        error: dioError.error,
        statusCode: responseStatusCode,
        message: responseStatusMessage,
        response: RestClientResponse(
          data: response?.data,
          statusCode: responseStatusCode,
          statusMessage: responseStatusMessage,
        ),
      ),
      s,
    );
  }
}
