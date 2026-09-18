import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Minimal CSV export + share for the workforce optimization screens.
/// Keeps exports dependency-free (no spreadsheet packages).
class WorkforceExportHelper {
  static String toCsv(List<String> headers, List<List<String>> rows) {
    String escape(String value) => '"${value.replaceAll('"', '""')}"';
    final lines = <String>[headers.map(escape).join(',')];
    for (final row in rows) {
      lines.add(row.map(escape).join(','));
    }
    return lines.join('\n');
  }

  /// Writes [content] to a temp file and opens the platform share sheet.
  /// Returns the file path, or null when sharing is unavailable.
  static Future<String?> shareTextFile({
    required String filename,
    required String content,
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsString(content);
      await Share.shareXFiles([XFile(file.path)], text: filename);
      return file.path;
    } catch (_) {
      return null;
    }
  }

  /// Writes raw [bytes] to a temp file and opens the platform share sheet.
  static Future<String?> shareBytes({
    required String filename,
    required Uint8List bytes,
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles([XFile(file.path)], text: filename);
      return file.path;
    } catch (_) {
      return null;
    }
  }

  static String fileTimestamp() {
    final now = DateTime.now();
    String two(int v) => v.toString().padLeft(2, '0');
    return '${now.year}${two(now.month)}${two(now.day)}-${two(now.hour)}${two(now.minute)}';
  }
}
