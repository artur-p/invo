import 'package:logging/logging.dart';

String formatLog(LogRecord record) {
  final buffer = StringBuffer()
    ..write(
      '${record.level.name}: ${record.time} [${record.loggerName}] ${record.message}',
    );

  if (record.error != null) {
    buffer.write('\n${record.error}');
  }
  if (record.stackTrace != null) {
    buffer.write('\n${record.stackTrace}');
  }

  return buffer.toString();
}
