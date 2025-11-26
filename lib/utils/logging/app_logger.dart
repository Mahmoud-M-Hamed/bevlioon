import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger instance = AppLogger._internal();

  AppLogger._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      lineLength: 180,
      methodCount: 0,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  void logInfo(String message) => _logger.i(message);

  void logDebug(String message) => _logger.d(message);

  void logWarning(String message) => _logger.w(message);

  void logError(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  void logTrace(String message) => _logger.t(message);
}
