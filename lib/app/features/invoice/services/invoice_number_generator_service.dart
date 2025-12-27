import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// Comprehensive Invoice Number Generation Service
/// Provides unique, traceable invoice numbers with watermarking capabilities
class InvoiceNumberGeneratorService {
  static const String _sequenceKey = 'invoice_sequence_counter';
  static const String _watermarkKey = 'invoice_watermark_secret';
  static const String _invoiceHistoryKey = 'invoice_number_history';

  /// Generate a unique invoice number with the format:
  /// ORGYMNNCC
  /// Where:
  /// - ORG: Organization code (3 chars)
  /// - Y: Year (1 digit - last digit)
  /// - M: Month (1 digit)
  /// - NN: Sequential number (2 digits)
  /// - CC: Client code (2 chars)
  static Future<String> generateInvoiceNumber({
    required String organizationId,
    required String organizationCode,
    required String clientId,
    required String clientName,
    required String employeeId,
    required String employeeName,
    DateTime? issueDate,
  }) async {
    try {
      final date = issueDate ?? DateTime.now();
      final year = date.year.toString();
      final month = date.month.toString().padLeft(2, '0');

      // Generate organization code (first 3 chars of org code, uppercase)
      final orgCode = _generateCode(organizationCode, 3);

      // Generate sequential number
      final sequence =
          await _getNextSequenceNumber(organizationId, year, month);
      final sequenceStr = sequence.toString().padLeft(4, '0');

      // Generate client code (3 chars from client name/ID)
      final clientCode = _generateCode('$clientName$clientId', 3);

      // Generate employee code (3 chars from employee name/ID)
      final employeeCode = _generateCode('$employeeName$employeeId', 3);

      // Construct the invoice number with INV prefix (clean format)
      // Format: INV + ORGYMNNCC (INV + ORG + Y + M + NN + CC) - Ultra compact with prefix
      final shortYear = year.substring(3); // Use 1-digit year (last digit)
      final shortMonth =
          month.length == 2 ? month.substring(1) : month; // Use 1-digit month
      final shortSequence =
          sequence.toString().padLeft(2, '0'); // Use 2-digit sequence
      final shortClientCode =
          _generateCode('$clientName$clientId', 2); // Use 2 chars for client
      final invoiceNumber =
          'INV$orgCode$shortYear$shortMonth$shortSequence$shortClientCode';

      // Store in history for tracking
      await _storeInvoiceNumberHistory(invoiceNumber, {
        'organizationId': organizationId,
        'clientId': clientId,
        'clientName': clientName,
        'employeeId': employeeId,
        'employeeName': employeeName,
        'issueDate': date.toIso8601String(),
        'timestamp': DateTime.now().toIso8601String(),
      });

      debugPrint('Generated invoice number: $invoiceNumber');
      return invoiceNumber;
    } catch (e) {
      debugPrint('Error generating invoice number: $e');
      // Fallback to timestamp-based number
      return _generateFallbackInvoiceNumber(organizationCode);
    }
  }

  /// Generate a 3-character code from input string
  static String _generateCode(String input, int length) {
    if (input.isEmpty) return 'XXX'.substring(0, length);

    // Remove spaces and special characters, convert to uppercase
    final cleaned = input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();

    if (cleaned.length >= length) {
      return cleaned.substring(0, length);
    } else {
      // Pad with hash of the input if too short
      final hash = sha256.convert(utf8.encode(input)).toString();
      final padding = hash.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
      return (cleaned + padding).substring(0, length);
    }
  }

  /// Get the next sequence number for the given organization, year, and month
  static Future<int> _getNextSequenceNumber(
      String organizationId, String year, String month) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_sequenceKey}_${organizationId}_${year}_$month';
      final currentSequence = prefs.getInt(key) ?? 0;
      final nextSequence = currentSequence + 1;

      await prefs.setInt(key, nextSequence);
      return nextSequence;
    } catch (e) {
      debugPrint('Error getting sequence number: $e');
      // Fallback to random number
      return Random().nextInt(9999) + 1;
    }
  }

  /// Store invoice number history for tracking and duplicate prevention
  static Future<void> _storeInvoiceNumberHistory(
      String invoiceNumber, Map<String, dynamic> metadata) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_invoiceHistoryKey) ?? '{}';
      final history = Map<String, dynamic>.from(json.decode(historyJson));

      history[invoiceNumber] = metadata;

      // Keep only last 1000 entries to prevent storage bloat
      if (history.length > 1000) {
        final sortedEntries = history.entries.toList()
          ..sort((a, b) => (b.value['timestamp'] as String)
              .compareTo(a.value['timestamp'] as String));

        final trimmedHistory =
            Map<String, dynamic>.fromEntries(sortedEntries.take(1000));

        await prefs.setString(_invoiceHistoryKey, json.encode(trimmedHistory));
      } else {
        await prefs.setString(_invoiceHistoryKey, json.encode(history));
      }
    } catch (e) {
      debugPrint('Error storing invoice number history: $e');
    }
  }

  /// Generate fallback invoice number when main generation fails
  static String _generateFallbackInvoiceNumber(String organizationCode) {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch.toString();
    final orgCode = _generateCode(organizationCode, 3);
    final shortYear = now.year.toString().substring(3); // Last digit of year
    final shortMonth = now.month.toString().length == 2
        ? now.month.toString().substring(1)
        : now.month.toString(); // Single digit month
    return 'INV$orgCode$shortYear$shortMonth${timestamp.substring(timestamp.length - 2)}FB';
  }

  /// Check if an invoice number already exists
  static Future<bool> invoiceNumberExists(String invoiceNumber) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_invoiceHistoryKey) ?? '{}';
      final history = Map<String, dynamic>.from(json.decode(historyJson));
      return history.containsKey(invoiceNumber);
    } catch (e) {
      debugPrint('Error checking invoice number existence: $e');
      return false;
    }
  }

  /// Get invoice metadata by invoice number
  static Future<Map<String, dynamic>?> getInvoiceMetadata(
      String invoiceNumber) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_invoiceHistoryKey) ?? '{}';
      final history = Map<String, dynamic>.from(json.decode(historyJson));
      return history[invoiceNumber] as Map<String, dynamic>?;
    } catch (e) {
      debugPrint('Error getting invoice metadata: $e');
      return null;
    }
  }

  /// Generate invisible watermark for invoice detection
  static Future<String> generateWatermark(String invoiceNumber) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String secret = prefs.getString(_watermarkKey) ?? '';

      // Generate secret if it doesn't exist
      if (secret.isEmpty) {
        secret = _generateWatermarkSecret();
        await prefs.setString(_watermarkKey, secret);
      }

      // Create watermark using HMAC
      final key = utf8.encode(secret);
      final bytes = utf8.encode(invoiceNumber);
      final hmac = Hmac(sha256, key);
      final digest = hmac.convert(bytes);

      // Convert to a format suitable for invisible watermarking
      // Using zero-width characters for invisibility
      final watermark = _encodeToZeroWidth(digest.toString());

      debugPrint('Generated watermark for invoice: $invoiceNumber');
      return watermark;
    } catch (e) {
      debugPrint('Error generating watermark: $e');
      return '';
    }
  }

  /// Verify watermark authenticity
  static Future<bool> verifyWatermark(
      String invoiceNumber, String watermark) async {
    try {
      final expectedWatermark = await generateWatermark(invoiceNumber);
      return watermark == expectedWatermark;
    } catch (e) {
      debugPrint('Error verifying watermark: $e');
      return false;
    }
  }

  /// Extract invoice number from watermark (if possible)
  static Future<String?> extractInvoiceNumberFromWatermark(
      String watermark) async {
    try {
      // This would require reverse engineering the watermark
      // For now, we'll check against known watermarks in history
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_invoiceHistoryKey) ?? '{}';
      final history = Map<String, dynamic>.from(json.decode(historyJson));

      for (final invoiceNumber in history.keys) {
        final expectedWatermark = await generateWatermark(invoiceNumber);
        if (expectedWatermark == watermark) {
          return invoiceNumber;
        }
      }

      return null;
    } catch (e) {
      debugPrint('Error extracting invoice number from watermark: $e');
      return null;
    }
  }

  /// Generate a cryptographically secure secret for watermarking
  static String _generateWatermarkSecret() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (i) => random.nextInt(256));
    return base64.encode(bytes);
  }

  /// Encode string to zero-width characters for invisible watermarking
  static String _encodeToZeroWidth(String input) {
    const zeroWidthChars = [
      '\u200B', // Zero Width Space
      '\u200C', // Zero Width Non-Joiner
      '\u200D', // Zero Width Joiner
      '\uFEFF', // Zero Width No-Break Space
    ];

    final result = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      final charCode = input.codeUnitAt(i);
      final encoded = charCode.toRadixString(4).padLeft(4, '0');

      for (final digit in encoded.split('')) {
        result.write(zeroWidthChars[int.parse(digit)]);
      }
    }

    return result.toString();
  }

  /// Decode zero-width characters back to string
  static String _decodeFromZeroWidth(String input) {
    const zeroWidthChars = [
      '\u200B', // Zero Width Space = 0
      '\u200C', // Zero Width Non-Joiner = 1
      '\u200D', // Zero Width Joiner = 2
      '\uFEFF', // Zero Width No-Break Space = 3
    ];

    final result = StringBuffer();
    final chars = input.split('');

    for (int i = 0; i < chars.length; i += 4) {
      if (i + 3 < chars.length) {
        final digits = chars
            .sublist(i, i + 4)
            .map((char) => zeroWidthChars.indexOf(char).toString())
            .join('');

        final charCode = int.parse(digits, radix: 4);
        result.writeCharCode(charCode);
      }
    }

    return result.toString();
  }

  /// Generate filename using invoice number
  static String generateFileName(String invoiceNumber,
      {String extension = 'pdf'}) {
    // Replace special characters with underscores for filename safety
    final safeInvoiceNumber =
        invoiceNumber.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '_');
    return 'Invoice_$safeInvoiceNumber.$extension';
  }

  /// Parse invoice number to extract components
  /// Format: ORGYMNNCC (3+1+1+2+2 = 9 chars)
  static Map<String, String> parseInvoiceNumber(String invoiceNumber) {
    try {
      if (invoiceNumber.length >= 9) {
        final yearDigit = invoiceNumber.substring(3, 4);
        final currentYear = DateTime.now().year;
        final decade = (currentYear ~/ 10) * 10;
        final fullYear = decade + int.parse(yearDigit);

        return {
          'organizationCode': invoiceNumber.substring(0, 3),
          'year': fullYear.toString(),
          'month': invoiceNumber.substring(4, 5).padLeft(2, '0'),
          'sequence': invoiceNumber.substring(5, 7),
          'clientCode': invoiceNumber.substring(7, 9),
          'employeeCode': '', // Not used in new format
        };
      }
    } catch (e) {
      debugPrint('Error parsing invoice number: $e');
    }

    return {
      'organizationCode': '',
      'year': '',
      'month': '',
      'sequence': '',
      'clientCode': '',
      'employeeCode': '',
    };
  }

  /// Reset sequence counter (for testing or year rollover)
  static Future<void> resetSequenceCounter(
      String organizationId, String year, String month) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_sequenceKey}_${organizationId}_${year}_$month';
      await prefs.remove(key);
      debugPrint('Reset sequence counter for $organizationId-$year-$month');
    } catch (e) {
      debugPrint('Error resetting sequence counter: $e');
    }
  }

  /// Get invoice statistics
  static Future<Map<String, dynamic>> getInvoiceStats(
      String organizationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_invoiceHistoryKey) ?? '{}';
      final history = Map<String, dynamic>.from(json.decode(historyJson));

      final orgInvoices = history.entries
          .where((entry) => entry.value['organizationId'] == organizationId)
          .toList();

      final currentYear = DateTime.now().year.toString();
      final currentMonth = DateTime.now().month.toString().padLeft(2, '0');

      final thisYearInvoices = orgInvoices
          .where((entry) => entry.key.contains('-$currentYear-'))
          .length;

      final thisMonthInvoices = orgInvoices
          .where((entry) => entry.key.contains('-$currentYear-$currentMonth-'))
          .length;

      return {
        'totalInvoices': orgInvoices.length,
        'thisYearInvoices': thisYearInvoices,
        'thisMonthInvoices': thisMonthInvoices,
        'lastInvoiceNumber':
            orgInvoices.isNotEmpty ? orgInvoices.last.key : null,
      };
    } catch (e) {
      debugPrint('Error getting invoice stats: $e');
      return {
        'totalInvoices': 0,
        'thisYearInvoices': 0,
        'thisMonthInvoices': 0,
        'lastInvoiceNumber': null,
      };
    }
  }
}
