// ignore_for_file: public_member_api_docs, sort_constructors_first

class RestClientResponse<T> {
  T? data;
  int? statusCode;
  String? statusMessage;

  RestClientResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
  });
  
}
