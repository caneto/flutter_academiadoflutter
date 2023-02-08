import 'rest_client_response.dart';

class RestClientException implements Exception {
  final int? statusCode;
  final String? message;
  final dynamic error;
  final RestClientResponse response;

  const RestClientException({
    required this.error,
    required this.response,
    this.statusCode,
    this.message,
  });

  @override
  String toString() =>
      'RestClientException(statusCode: $statusCode, message: $message, error: $error, response: $response)';
}
