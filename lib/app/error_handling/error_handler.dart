import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class InvoErrorHandler implements IErrorHandler {
  InvoErrorHandler._();

  static final InvoErrorHandler _instance = InvoErrorHandler._();
  static IErrorHandler get instance => _instance;

  final _listeners = <ErrorListener>{};

  @override
  void onFlutterError(FlutterErrorDetails details) {
    final record = LogRecord(
      Level.SHOUT,
      details.toString(),
      'ErrorHandler',
      details.exception,
      details.stack,
    );
    _notifyListeners(record);
  }

  @override
  void onError(Object error, StackTrace? stackTrace) {
    final record = LogRecord(
      Level.SHOUT,
      error.toString(),
      'ErrorHandler',
      error,
      stackTrace,
    );
    _notifyListeners(record);
  }

  void _notifyListeners(LogRecord record) {
    for (final listener in _listeners) {
      listener.onError(record);
    }
  }

  @override
  void addListener(ErrorListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(ErrorListener listener) {
    _listeners.remove(listener);
  }

  @override
  void dispose() {
    _listeners.clear();
  }

  @override
  bool onPlatformError(Object error, StackTrace? stackTrace) {
    final record = LogRecord(
      Level.SHOUT,
      error.toString(),
      'PlatformErrorHandler',
      null,
      stackTrace,
      null,
      stackTrace?.toString() ?? '',
    );
    _notifyListeners(record);

    return true;
  }
}

abstract interface class IErrorHandler {
  void onFlutterError(FlutterErrorDetails details);
  bool onPlatformError(Object error, StackTrace? stackTrace);
  void onError(Object error, StackTrace? stackTrace);
  void addListener(ErrorListener listener);
  void removeListener(ErrorListener listener);
  void dispose();
}

abstract interface class ErrorListener {
  void onError(LogRecord record);
}
