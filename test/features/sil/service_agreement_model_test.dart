import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Milestone 4.2: Verify SILServiceAgreement parsing matches backend ServiceAgreement
/// schema and toJSON transform, including nested signedBy, participantContribution,
/// and MongoDB _id normalization.
void main() {
  group('SILServiceAgreement Model Tests', () {
    test('parses flattened JSON response correctly', () {
      final json = {
        'id': 'sa_101',
        'organizationId': 'org_test_1',
        'clientId': 'client_alice',
        'propertyId': 'prop_melbourne',
        'quoteId': 'quote_99',
        'rosterOfCareId': 'roc_55',
        'agreementNumber': 'SA-2026-001',
        'agreementType': 'sil',
        'status': 'active',
        'effectiveFrom': '2026-03-01T00:00:00.000Z',
        'effectiveTo': '2027-02-28T00:00:00.000Z',
        'signedAt': '2026-03-02T10:00:00.000Z',
        'signedByName': 'Jane Doe',
        'signedByRole': 'guardian',
        'boardAndLodgingWeekly': 275.50,
        'notes': 'Participant agreed to weekly room fee.',
      };

      final agreement = SILServiceAgreement.fromJson(json);

      expect(agreement.id, 'sa_101');
      expect(agreement.organizationId, 'org_test_1');
      expect(agreement.clientId, 'client_alice');
      expect(agreement.propertyId, 'prop_melbourne');
      expect(agreement.quoteId, 'quote_99');
      expect(agreement.rosterOfCareId, 'roc_55');
      expect(agreement.agreementNumber, 'SA-2026-001');
      expect(agreement.status, 'active');
      expect(agreement.signedByName, 'Jane Doe');
      expect(agreement.signedByRole, 'guardian');
      expect(agreement.boardAndLodgingWeekly, 275.50);
      expect(agreement.notes, 'Participant agreed to weekly room fee.');
    });

    test(
      'normalizes MongoDB _id and nested signedBy and participantContribution structures',
      () {
        final json = {
          '_id': 'mongo_obj_id_999',
          'organizationId': 'org_test_1',
          'clientId': {'_id': 'client_bob_nested', 'name': 'Bob'},
          'propertyId': {'_id': 'prop_sydney'},
          'quoteId': {'_id': 'quote_88'},
          'rosterOfCareId': {'_id': 'roc_77'},
          'agreementNumber': 'SA-2026-002',
          'status': 'signed',
          'effectiveFrom': '2026-04-01T00:00:00.000Z',
          'signedBy': {
            'name': 'Bob Nominee',
            'role': 'nominee',
            'signatureData': 'data:image/png;base64,mockSig',
            'ipAddress': '192.168.1.1',
          },
          'participantContribution': {
            'boardAndLodgingWeekly': 310.0,
            'paymentFrequency': 'fortnightly',
          },
        };

        final agreement = SILServiceAgreement.fromJson(json);

        expect(agreement.id, 'mongo_obj_id_999');
        expect(agreement.clientId, 'client_bob_nested');
        expect(agreement.propertyId, 'prop_sydney');
        expect(agreement.quoteId, 'quote_88');
        expect(agreement.rosterOfCareId, 'roc_77');
        expect(agreement.signedByName, 'Bob Nominee');
        expect(agreement.signedByRole, 'nominee');
        expect(agreement.boardAndLodgingWeekly, 310.0);
        expect(agreement.status, 'signed');
      },
    );

    test('applies sensible defaults when optional fields are omitted', () {
      final json = {
        'id': 'sa_defaults',
        'organizationId': 'org_1',
        'clientId': 'client_1',
        'agreementNumber': 'SA-2026-DEF',
        'effectiveFrom': '2026-01-01',
      };

      final agreement = SILServiceAgreement.fromJson(json);

      expect(agreement.agreementType, 'sil');
      expect(agreement.status, 'draft');
      expect(agreement.signedByName, '');
      expect(agreement.signedByRole, 'participant');
      expect(agreement.boardAndLodgingWeekly, 0.0);
      expect(agreement.notes, '');
      expect(agreement.effectiveTo, isNull);
      expect(agreement.signedAt, isNull);
    });
  });
}
