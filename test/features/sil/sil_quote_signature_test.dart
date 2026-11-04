import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Milestone 6.1: Verify SILQuote and SILQuoteSignature model serialization and deserialization
void main() {
  group('SILQuoteSignature & SILQuote Model Tests', () {
    test('parses SILQuote with nested signature correctly', () {
      final json = {
        'id': 'quote_m6_01',
        'clientId': 'client_sarah',
        'propertyId': 'prop_bondi',
        'status': 'accepted',
        'fundingType': 'plan_managed',
        'validUntil': '2026-12-31T00:00:00.000Z',
        'totals': {
          'weeklyHours': 14.0,
          'weeklyAmount': 916.58,
          'annualAmount': 47662.16,
        },
        'lines': [
          {
            'supportNumber': '01_801_0115_1_1',
            'supportName': 'SIL Standard Weekday',
            'shiftType': 'day',
            'hoursPerWeek': 14.0,
            'unitPrice': 65.47,
            'amount': 916.58,
          },
        ],
        'signature': {
          'signedBy': 'Sarah Connor',
          'signatoryRole': 'guardian',
          'signatureData': 'data:image/png;base64,signatureBytes123',
          'signedAt': '2026-11-03T10:30:00.000Z',
          'ipAddress': '192.168.1.50',
        },
      };

      final quote = SILQuote.fromJson(json);

      expect(quote.id, 'quote_m6_01');
      expect(quote.clientId, 'client_sarah');
      expect(quote.propertyId, 'prop_bondi');
      expect(quote.status, 'accepted');
      expect(quote.totals.weeklyHours, 14.0);
      expect(quote.totals.weeklyAmount, 916.58);
      expect(quote.lines.length, 1);
      expect(quote.lines.first.supportNumber, '01_801_0115_1_1');

      // Signature verification
      expect(quote.signature, isNotNull);
      expect(quote.signature!.signedBy, 'Sarah Connor');
      expect(quote.signature!.signatoryRole, 'guardian');
      expect(quote.signature!.signatureData, 'data:image/png;base64,signatureBytes123');
      expect(quote.signature!.signedAt, '2026-11-03T10:30:00.000Z');
      expect(quote.signature!.ipAddress, '192.168.1.50');
    });

    test('parses SILQuote without signature gracefully (draft/sent status)', () {
      final json = {
        'id': 'quote_m6_02',
        'clientId': 'client_bob',
        'status': 'sent',
      };

      final quote = SILQuote.fromJson(json);

      expect(quote.id, 'quote_m6_02');
      expect(quote.clientId, 'client_bob');
      expect(quote.status, 'sent');
      expect(quote.signature, isNull);
    });
  });
}

