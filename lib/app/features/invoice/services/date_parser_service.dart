import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';

/// Centralized, strict date parsing service.
///
/// - Supports multiple formats with strict validation.
/// - Prevents rollover by verifying numeric tokens against parsed values.
/// - Handles time-inclusive ISO strings via `DateTime.parse` with date-part checks.
class DateParserService {
  /// When true, ambiguous numeric dates prefer US order (MM/dd, M/d).
  /// When false, prefer DMY order (dd/MM, d/M).
  final bool preferUsFormat;

  DateParserService({this.preferUsFormat = false});

  /// Attempts strict parsing across supported formats.
  /// Returns a normalized `DateTime` (date-only) or null when parsing fails.
  DateTime? parseFlexible(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;

    // 0) ISO datetime with time component (e.g., yyyy-MM-ddTHH:mm:ssZ or offsets)
    if (dateStr.contains('T')) {
      try {
        final d = DateTime.parse(dateStr); // throws on invalid ISO
        // Verify date part matches numeric input to block rollover
        final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})T').firstMatch(dateStr);
        if (m != null) {
          final y = int.parse(m.group(1)!);
          final mo = int.parse(m.group(2)!);
          final da = int.parse(m.group(3)!);
          if (y != d.year || mo != d.month || da != d.day) {
            throw FormatException('ISO datetime rollover detected: $dateStr');
          }
        }
        return DateTime(d.year, d.month, d.day);
      } catch (_) {}
    }

    // Ordered patterns depending on preference
    final List<_Pattern> patterns = preferUsFormat
        ? [
            _Pattern('MM/dd/yyyy', separator: '/'),
            _Pattern('M/d/yyyy', separator: '/'),
            _Pattern('dd/MM/yyyy', separator: '/'),
            _Pattern('d/M/yyyy', separator: '/'),
            _Pattern('yyyy-MM-dd', separator: '-'),
          ]
        : [
            _Pattern('dd/MM/yyyy', separator: '/'),
            _Pattern('d/M/yyyy', separator: '/'),
            _Pattern('MM/dd/yyyy', separator: '/'),
            _Pattern('M/d/yyyy', separator: '/'),
            _Pattern('yyyy-MM-dd', separator: '-'),
          ];

    for (final pat in patterns) {
      try {
        final df = DateFormat(pat.format);
        final d = df.parseStrict(dateStr);
        // Numeric token validation to prevent rollover and accept variable widths
        final parts = dateStr.split(pat.separator);
        if (pat.separator == '/') {
          if (parts.length == 3) {
            final token1 = int.tryParse(parts[0]);
            final token2 = int.tryParse(parts[1]);
            final token3 = int.tryParse(parts[2]);
            if (token1 == null || token2 == null || token3 == null) {
              throw const FormatException('Non-numeric tokens');
            }
            // Map tokens by pattern order
            switch (pat.format) {
              case 'dd/MM/yyyy':
              case 'd/M/yyyy':
                if (token1 != d.day || token2 != d.month || token3 != d.year) {
                  throw FormatException('Rollover detected for ${pat.format}: $dateStr');
                }
                break;
              case 'MM/dd/yyyy':
              case 'M/d/yyyy':
                if (token2 != d.day || token1 != d.month || token3 != d.year) {
                  throw FormatException('Rollover detected for ${pat.format}: $dateStr');
                }
                break;
            }
          }
        } else {
          // yyyy-MM-dd
          final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(dateStr);
          if (m != null) {
            final y = int.parse(m.group(1)!);
            final mo = int.parse(m.group(2)!);
            final da = int.parse(m.group(3)!);
            if (y != d.year || mo != d.month || da != d.day) {
              throw FormatException('Rollover detected for ${pat.format}: $dateStr');
            }
          }
        }
        return DateTime(d.year, d.month, d.day);
      } catch (_) {}
    }

    debugPrint('DateParserService: Could not parse date "$dateStr"');
    return null;
  }
}

/// Internal helper describing a date pattern and separator for tokenization.
class _Pattern {
  final String format;
  final String separator;
  const _Pattern(this.format, {required this.separator});
}