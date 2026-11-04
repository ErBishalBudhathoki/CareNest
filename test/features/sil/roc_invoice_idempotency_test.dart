import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/sil/utils/roc_invoice_idempotency.dart';

void main() {
  group('buildRocInvoiceIdempotencyKey', () {
    test('is deterministic for the same roster and period', () {
      final from = DateTime(2026, 10, 1);
      final to = DateTime(2026, 10, 31);
      final a = buildRocInvoiceIdempotencyKey(rocId: 'roc_abc', from: from, to: to);
      final b = buildRocInvoiceIdempotencyKey(rocId: 'roc_abc', from: from, to: to);
      expect(a, equals(b));
    });

    test('normalizes date parts to ISO YYYY-MM-DD and zero-pads', () {
      final key = buildRocInvoiceIdempotencyKey(
        rocId: '6acfbe67',
        from: DateTime(2026, 4, 1),
        to: DateTime(2026, 4, 7),
      );
      expect(key, equals('roc_6acfbe67_2026-04-01_2026-04-07'));
    });

    test('differs by roster id and by period', () {
      final from = DateTime(2026, 10, 1);
      final to = DateTime(2026, 10, 7);
      final base = buildRocInvoiceIdempotencyKey(rocId: 'roc_a', from: from, to: to);
      final otherRoc =
          buildRocInvoiceIdempotencyKey(rocId: 'roc_b', from: from, to: to);
      final otherPeriod =
          buildRocInvoiceIdempotencyKey(rocId: 'roc_a', from: from, to: DateTime(2026, 10, 8));
      expect(base, isNot(equals(otherRoc)));
      expect(base, isNot(equals(otherPeriod)));
    });

    test('silIsoDate zero-pads single-digit months and days', () {
      expect(silIsoDate(DateTime(2026, 1, 5)), equals('2026-01-05'));
      expect(silIsoDate(DateTime(2026, 12, 25)), equals('2026-12-25'));
    });
  });
}
