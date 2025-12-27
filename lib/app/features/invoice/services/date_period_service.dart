import 'package:flutter/foundation.dart';

import 'package:carenest/app/features/invoice/models/date_period.dart';
import 'package:carenest/app/features/invoice/repositories/period_config_repository.dart';
import 'package:carenest/app/features/invoice/services/date_parser_service.dart';

/// Exception representing failures in period calculation.
class PeriodCalculationException implements Exception {
  final String message;
  PeriodCalculationException(this.message);
  @override
  String toString() => 'PeriodCalculationException: $message';
}

/// Service for robust date period calculations.
///
/// Provides:
/// - Week period calculation respecting different week start conventions.
/// - Resolution of invoice periods using employee-client configurations.
/// - Graceful handling of invalid/malformed dates with clear error messages.
/// - Debug logging for auditability.
class DatePeriodService {
  final PeriodConfigRepository _repository;
  final DateParserService _parser;

  DatePeriodService(this._repository, [DateParserService? parser])
      : _parser = parser ?? DateParserService();

  /// Compute the week period (inclusive) for a given date.
  ///
  /// Parameters:
  /// - `date`: Target date.
  /// - `weekStartDay`: Week start day as `DateTime.monday (1)` .. `DateTime.sunday (7)`.
  /// Returns a `DatePeriod` from start-of-week to end-of-week.
  DatePeriod weekPeriodFor(DateTime date, {int weekStartDay = DateTime.monday}) {
    final normalized = DateTime(date.year, date.month, date.day);
    int wd = normalized.weekday; // 1..7
    int ws = weekStartDay;
    if (ws < DateTime.monday || ws > DateTime.sunday) {
      ws = DateTime.monday;
    }
    // Days to subtract to reach start of week
    final deltaToStart = (wd - ws + 7) % 7;
    final start = normalized.subtract(Duration(days: deltaToStart));
    final end = start.add(const Duration(days: 6));
    debugPrint(
        'DatePeriodService.weekPeriodFor: date=$normalized, weekStart=$ws => start=$start, end=$end');
    return DatePeriod(start: start, end: end);
  }

  // Parsing delegated to DateParserService

  /// Derive a period from a set of item date strings.
  ///
  /// Behavior:
  /// - Filters out invalid dates.
  /// - If there are no valid dates, throws `PeriodCalculationException`.
  /// - If all valid dates fall within a single week, returns that week period.
  /// - If dates span multiple weeks, returns the union from the earliest week-start
  ///   to the latest week-end, based on the provided `weekStartDay`.
  DatePeriod derivePeriodFromItems(List<String> itemDates,
      {int weekStartDay = DateTime.monday}) {
    // Parse once and capture invalids for diagnostic logging
    final parsedEntries = <MapEntry<String, DateTime?>>[];
    for (final raw in itemDates) {
      final parsed = _parser.parseFlexible(raw);
      parsedEntries.add(MapEntry(raw, parsed));
    }

    final validDates = parsedEntries
        .where((e) => e.value != null)
        .map((e) => DateTime(e.value!.year, e.value!.month, e.value!.day))
        .toList();

    final invalidDates = parsedEntries
        .where((e) => e.value == null)
        .map((e) => e.key)
        .toList();

    if (invalidDates.isNotEmpty) {
      debugPrint(
          'DatePeriodService.derivePeriodFromItems: Ignoring invalid dates: $invalidDates (count=${invalidDates.length})');
    }

    if (validDates.isEmpty) {
      throw PeriodCalculationException('No valid dates found to derive period');
    }

    // Group dates by week key (start-of-week)
    DateTime startOfWeek(DateTime d) => weekPeriodFor(d, weekStartDay: weekStartDay).start;
    final weeks = validDates.map(startOfWeek).toSet().toList()..sort((a, b) => a.compareTo(b));

    if (weeks.length == 1) {
      return weekPeriodFor(validDates.first, weekStartDay: weekStartDay);
    }

    final firstWeekStart = weeks.first;
    final lastWeekEnd = weekPeriodFor(weeks.last, weekStartDay: weekStartDay).end;
    final period = DatePeriod(start: firstWeekStart, end: lastWeekEnd);
    debugPrint(
        'DatePeriodService.derivePeriodFromItems: multi-week union => ${period.start} to ${period.end}');
    return period;
  }

  /// Resolve period for an employee-client pair.
  ///
  /// Rules:
  /// - If explicit `startDate` and `endDate` are provided, they win (normalized).
  /// - Otherwise, attempt to load `PeriodConfig` to get `weekStartDay`.
  /// - If `itemDates` are provided, derive a period based on weekly grouping.
  /// - If nothing is provided, fall back to the previous completed week using
  ///   configured `weekStartDay` (or Monday when not configured).
  Future<DatePeriod> resolvePeriodForEmployeeClient({
    required String employeeEmail,
    required String clientEmail,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? itemDates,
  }) async {
    int weekStartDay = DateTime.monday;

    // Try load configuration
    try {
      final config = await _repository.getConfig(employeeEmail, clientEmail);
      if (config != null) {
        weekStartDay = config.weekStartDay;
        debugPrint(
            'DatePeriodService.resolve: Using configured weekStartDay=$weekStartDay for $employeeEmail/$clientEmail');
      } else {
        debugPrint(
            'DatePeriodService.resolve: No config found for $employeeEmail/$clientEmail, using default Monday');
      }
    } catch (e) {
      debugPrint('DatePeriodService.resolve: Error loading config: $e');
    }

    // Explicit dates provided
    if (startDate != null && endDate != null) {
      final s = DateTime(startDate.year, startDate.month, startDate.day);
      final e = DateTime(endDate.year, endDate.month, endDate.day);
      return DatePeriod(start: s, end: e);
    }

    // Partial explicit
    if (startDate != null) {
      final s = DateTime(startDate.year, startDate.month, startDate.day);
      final w = weekPeriodFor(s, weekStartDay: weekStartDay);
      return DatePeriod(start: s, end: w.end);
    }
    if (endDate != null) {
      final e = DateTime(endDate.year, endDate.month, endDate.day);
      final w = weekPeriodFor(e, weekStartDay: weekStartDay);
      return DatePeriod(start: w.start, end: e);
    }

    // Use item dates if available
    if (itemDates != null && itemDates.isNotEmpty) {
      try {
        return derivePeriodFromItems(itemDates, weekStartDay: weekStartDay);
      } catch (e) {
        debugPrint('DatePeriodService.resolve: Derivation failed: $e');
      }
    }

    // Fallback to previous completed week based on now
    final now = DateTime.now();
    final currentWeek = weekPeriodFor(now, weekStartDay: weekStartDay);
    final prevWeekEnd = currentWeek.start.subtract(const Duration(days: 1));
    final prevWeek = weekPeriodFor(prevWeekEnd, weekStartDay: weekStartDay);
    debugPrint('DatePeriodService.resolve: Fallback to previous week => ${prevWeek.start} to ${prevWeek.end}');
    return prevWeek;
  }
}