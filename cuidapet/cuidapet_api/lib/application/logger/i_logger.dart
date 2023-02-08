abstract class ILogger {
  void debug(dynamic message, [dynamic? error, StackTrace? stackTrace]);
  void error(dynamic message, [dynamic? error, StackTrace? stackTrace]);
  void warning(dynamic message, [dynamic? error, StackTrace? stackTrace]);
  void info(dynamic message, [dynamic? error, StackTrace? stackTrace]);
}