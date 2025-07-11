import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'format_log.dart';

void configureLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final formattedLog = formatLog(record);
    if (kDebugMode) {
      print(formattedLog);
    }
    if (record.level >= Level.FINE) {
      ///TODO(Artur): log for example to firebase
    }
  });
}
