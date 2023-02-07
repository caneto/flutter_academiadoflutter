import 'package:dio/dio.dart';

import '../../helpers/constants.dart';
import '../../helpers/enviroments.dart';
import '../rest_client.dart';
import '../rest_client_exception.dart';
import '../rest_client_response.dart';

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

  DioRestClient({BaseOptions? baseOptions}) {
    _dio = Dio(baseOptions ?? _defaultOptions);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra['auth_riquired'] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaultOptions.extra['auth_riquired'] = false;
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
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
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
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
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
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
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
      final response = await _dio.post(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
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
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
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
      final response = await _dio.request(
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

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
    Response<dynamic> response,
  ) async {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

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
