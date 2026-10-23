import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';

/// One contiguous portion of a shift that falls inside a single NDIS time
/// band. A 15:00–23:00 weekday shift produces two windows: 15:00–20:00
/// (weekday daytime) and 20:00–23:00 (weekday evening).
class NdisBandWindow {
  final DateTime start;
  final DateTime end;
  final NDISItem? item;
  final double hours;

  const NdisBandWindow({
    required this.start,
    required this.end,
    required this.hours,
    this.item,
  });

  Duration get duration => end.difference(start);
}

/// Splits a shift at the NDIS Price Arrangements time-band boundaries.
///
/// Bands (Core supports):
///   Weekday daytime   06:00–20:00 Mon–Fri
///   Weekday evening   20:00–24:00 Mon–Fri
///   Weekday night     00:00–06:00 Mon–Fri
///   Saturday / Sunday / Public holiday   whole day
///
/// The class only produces time windows; the caller decides how to price and
/// group them. Support categories that do not vary by band (therapy, plan
/// management) naturally resolve to the same item in every window and can be
/// merged back into a single line.
class NdisTimeBandSplitter {
  final NDISMatcher matcher;

  NdisTimeBandSplitter(this.matcher);

  /// Build the band windows between [start] and [end].
  ///
  /// Windows are cut at 06:00 and 20:00 local time and at every midnight. The
  /// result covers the whole interval exactly once (no gaps or overlaps).
  static List<({DateTime start, DateTime end})> windows(
    DateTime start,
    DateTime end,
  ) {
    if (!end.isAfter(start)) return const [];

    final cuts = <DateTime>{start, end};
    var day = DateTime(start.year, start.month, start.day);
    final lastDay = DateTime(end.year, end.month, end.day);

    while (!day.isAfter(lastDay)) {
      for (final hour in const [6, 20]) {
        final boundary = DateTime(day.year, day.month, day.day, hour);
        if (boundary.isAfter(start) && boundary.isBefore(end)) {
          cuts.add(boundary);
        }
      }
      final nextMidnight = DateTime(day.year, day.month, day.day + 1);
      if (nextMidnight.isAfter(start) && nextMidnight.isBefore(end)) {
        cuts.add(nextMidnight);
      }
      day = nextMidnight;
    }

    final sorted = cuts.toList()..sort();
    return [
      for (var i = 0; i < sorted.length - 1; i++)
        (start: sorted[i], end: sorted[i + 1]),
    ];
  }

  /// Resolve the support item for each band window and distribute
  /// [totalHours] across the windows in proportion to their scheduled length.
  ///
  /// [fallbackItem] is used when the matcher cannot find a band-specific item
  /// within the same support category (e.g. non-time-banded supports).
  List<NdisBandWindow> split({
    required DateTime start,
    required DateTime end,
    required double totalHours,
    required Set<String> holidays,
    NDISItem? fallbackItem,
  }) {
    final raw = windows(start, end);
    if (raw.isEmpty) return const [];

    final preferredCategory = fallbackItem?.supportCategoryNumber;
    final preferredGroup = fallbackItem?.registrationGroupNumber;
    final holidayList = holidays.toList(growable: false);

    final resolved = <({DateTime start, DateTime end, NDISItem? item})>[];
    for (final window in raw) {
      NDISItem? item;
      try {
        item = matcher.findBestMatch(
          shiftStart: window.start,
          dynamicHolidays: holidayList,
          preferredSupportCategoryNumber: _nonEmpty(preferredCategory),
          preferredRegistrationGroupNumber: _nonEmpty(preferredGroup),
        );
      } catch (_) {
        item = null;
      }
      resolved.add((
        start: window.start,
        end: window.end,
        item: item ?? fallbackItem,
      ));
    }

    final totalMinutes = raw.fold<int>(
      0,
      (sum, w) => sum + w.end.difference(w.start).inMinutes,
    );
    if (totalMinutes <= 0) return const [];

    final effectiveHours = totalHours > 0 ? totalHours : totalMinutes / 60.0;

    var allocated = 0.0;
    final result = <NdisBandWindow>[];
    for (var i = 0; i < resolved.length; i++) {
      final w = resolved[i];
      final minutes = w.end.difference(w.start).inMinutes;
      double hours;
      if (i == resolved.length - 1) {
        // Give the last window the remainder so the sum is exact after
        // rounding; never go negative.
        hours = double.parse((effectiveHours - allocated).toStringAsFixed(2));
        if (hours < 0) hours = 0;
      } else {
        hours = double.parse(
          (effectiveHours * (minutes / totalMinutes)).toStringAsFixed(2),
        );
        allocated += hours;
      }
      result.add(
        NdisBandWindow(start: w.start, end: w.end, hours: hours, item: w.item),
      );
    }

    // Guard against rounding pushing the total over the actual worked hours.
    final sum = result.fold<double>(0, (s, w) => s + w.hours);
    if (sum > effectiveHours + 0.001 && result.isNotEmpty) {
      final excess = double.parse((sum - effectiveHours).toStringAsFixed(2));
      final last = result.removeLast();
      result.add(
        NdisBandWindow(
          start: last.start,
          end: last.end,
          hours: double.parse((last.hours - excess).toStringAsFixed(2)),
          item: last.item,
        ),
      );
    }

    return result;
  }

  static String? _nonEmpty(String? value) =>
      (value == null || value.isEmpty) ? null : value;
}
