/// Utility for formatting decimal hours with controlled precision.
///
/// Provides consistent formatting for hours derived from seconds while
/// meeting UI requirements:
/// - Minimum 2 decimal places
/// - Maximum 4 decimal places
/// - Trims trailing zeros beyond the minimum
///
/// Example:
/// - 1.0 -> "1.00"
/// - 1.003611 -> "1.0036"
/// - 0.0008333 -> "0.0008"
class HoursFormatting {
  /// Formats a decimal `hours` value with [minDecimals] and [maxDecimals].
  ///
  /// - Ensures at least [minDecimals] decimals
  /// - Caps at [maxDecimals] decimals
  /// - Trims trailing zeros beyond [minDecimals]
  static String formatDecimalHours(
    double hours, {
    int minDecimals = 2,
    int maxDecimals = 4,
  }) {
    if (minDecimals < 0) minDecimals = 0;
    if (maxDecimals < minDecimals) maxDecimals = minDecimals;

    final fixed = hours.toStringAsFixed(maxDecimals);
    final parts = fixed.split('.');
    if (parts.length == 1) {
      return minDecimals > 0
          ? '${parts[0]}.${'0' * minDecimals}'
          : parts[0];
    }
    final whole = parts[0];
    var frac = parts[1];
    // Trim trailing zeros beyond the minimum
    frac = frac.replaceFirst(RegExp(r'0+$'), '');
    if (frac.length < minDecimals) {
      frac = frac.padRight(minDecimals, '0');
    }
    return frac.isNotEmpty ? '$whole.$frac' : whole;
  }
}