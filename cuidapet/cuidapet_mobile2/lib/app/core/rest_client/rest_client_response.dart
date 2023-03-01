class RestClientResponse<T> {
  final T? data;
  final int? statusCode;
  final String? statusMessage;

  const RestClientResponse({this.data, this.statusCode, this.statusMessage});
}
