import 'package:logger/logger.dart';

import 'app_logger.dart';

class AppLoggerImpl implements AppLogger {
  final _logger = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(printTime: true, lineLength: 74, methodCount: 0),
  );
  var _messages = <String>[];

  @override
  void debug(message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  @override
  void error(message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  @override
  void info(message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  @override
  void warning(message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);

  @override
  void append(message) => _messages.add(message);

  @override
  void closeAppend() {
    info(_messages.join('\n'));
    _messages = const <String>[];
  }
}
