import 'package:flutter/foundation.dart';
import 'package:invo_app/app/error_handling/error_handler.dart';
import 'package:logging/logging.dart';

class CrashlyticsErrorListener implements ErrorListener {
  @override
  void onError(LogRecord record) {
    final object = record.object;

    if (object is FlutterErrorDetails) {
      ///TODO(Artur): uncomment once firebase configured
      // FirebaseCrashlytics.instance.recordFlutterError(object);
    } else {
      // FirebaseCrashlytics.instance.recordError(record.error, record.stackTrace);
    }
  }
}
