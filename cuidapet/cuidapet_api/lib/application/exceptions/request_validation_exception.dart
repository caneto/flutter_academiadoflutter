
class RequestValidationException implements Exception {
  final Map<String, String> errors;

  RequestValidationException(this.errors);
  
}