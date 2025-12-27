/// DatePeriod model representing an inclusive start and end date.
///
/// - Fields are immutable and final.
/// - Includes JSON serialization, copyWith, and equality.
class DatePeriod {
  /// Inclusive start date (normalized to remove time component).
  final DateTime start;

  /// Inclusive end date (normalized to remove time component).
  final DateTime end;

  /// Creates a new DatePeriod.
  ///
  /// Both `start` and `end` are required and should be in local time.
  const DatePeriod({required this.start, required this.end});

  /// Factory to construct from a JSON map with ISO-8601 strings.
  factory DatePeriod.fromJson(Map<String, dynamic> json) {
    final s = DateTime.parse(json['start'] as String);
    final e = DateTime.parse(json['end'] as String);
    return DatePeriod(
      start: DateTime(s.year, s.month, s.day),
      end: DateTime(e.year, e.month, e.day),
    );
  }

  /// Converts to a JSON map using ISO-8601 strings.
  Map<String, dynamic> toJson() => {
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
      };

  /// Returns a copy with optional new `start` or `end` dates.
  DatePeriod copyWith({DateTime? start, DateTime? end}) => DatePeriod(
        start: DateTime(
            (start ?? this.start).year, (start ?? this.start).month, (start ?? this.start).day),
        end: DateTime((end ?? this.end).year, (end ?? this.end).month, (end ?? this.end).day),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DatePeriod &&
        other.start.year == start.year &&
        other.start.month == start.month &&
        other.start.day == start.day &&
        other.end.year == end.year &&
        other.end.month == end.month &&
        other.end.day == end.day;
  }

  @override
  int get hashCode => Object.hash(
        start.year,
        start.month,
        start.day,
        end.year,
        end.month,
        end.day,
      );
}
