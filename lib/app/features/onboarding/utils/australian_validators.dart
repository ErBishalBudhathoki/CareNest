/// Validates an ABN using the modulo-89 algorithm.
///
/// Strips non-digit chars, then: subtract 1 from first digit,
/// multiply by weights [10,1,3,5,7,9,11,13,15,17,19], sum must be % 89 == 0.
bool isValidAbn(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.length != 11) return false;

  final firstDigit = int.parse(digits[0]);
  if (firstDigit == 0) return false;

  final adjusted = '${firstDigit - 1}${digits.substring(1)}';

  const weights = [10, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
  var sum = 0;
  for (var i = 0; i < 11; i++) {
    sum += int.parse(adjusted[i]) * weights[i];
  }

  return sum % 89 == 0;
}

/// Validates a TFN using the 11-weight checksum.
///
/// Multiplies each of the 9 digits by weights [1,4,3,7,5,8,6,9,10].
/// Sum must be divisible by 11.
bool isValidTfn(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.length != 9) return false;

  const weights = [1, 4, 3, 7, 5, 8, 6, 9, 10];
  var sum = 0;
  for (var i = 0; i < 9; i++) {
    sum += int.parse(digits[i]) * weights[i];
  }

  return sum % 11 == 0;
}

/// Formats an 11-digit string as "XX XXX XXX XXX".
String formatAbn(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.length != 11) return raw;
  return '${digits.substring(0, 2)} '
      '${digits.substring(2, 5)} '
      '${digits.substring(5, 8)} '
      '${digits.substring(8, 11)}';
}

/// Strips non-alphanumeric chars. Used for USI / ESA fields.
String stripNonAlphaNumeric(String raw) {
  return raw.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
}
