
class DatabaseException implements Exception {
  
  String? message;
  Exception? exception;
  DatabaseException({
    this.message,
    this.exception,
  });

  @override
  String toString() => 'DatabaseException(message: $message, exception: $exception)';
}
