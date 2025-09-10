import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';

final log = Logger('NDISApp'); // Or any name you prefer

void setupLogger() {
  Logger.root.level = Level.ALL; // Log all levels during development
  Logger.root.onRecord.listen((record) {
    debugPrint(
        '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
    if (record.error != null) {
      debugPrint('ERROR: ${record.error}');
    }
    if (record.stackTrace != null) {
      debugPrint('STACKTRACE: ${record.stackTrace}');
    }
  });
}