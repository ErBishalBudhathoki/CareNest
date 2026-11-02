import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Patient (Client) Model Tests', () {
    test('fromJson should parse standard patient correctly', () {
      final json = {
        'id': 'client_123',
        'clientFirstName': 'Jane',
        'clientLastName': 'Doe',
        'clientEmail': 'jane@example.com',
        'clientPhone': '1234567890',
        'clientAddress': '123 Main St',
        'isActivated': true,
      };

      final patient = Patient.fromJson(json);

      expect(patient.id, 'client_123');
      expect(patient.clientFirstName, 'Jane');
      expect(patient.clientLastName, 'Doe');
      expect(patient.clientEmail, 'jane@example.com');
      expect(patient.clientPhone, '1234567890');
      expect(patient.clientAddress, '123 Main St');
      expect(patient.isActivated, true);
    });

    test('fromJson should handle _id variant', () {
      final json = {'_id': 'client_123', 'clientEmail': 'jane@example.com'};

      final patient = Patient.fromJson(json);

      expect(patient.id, 'client_123');
    });

    test('fromJson should handle null optional fields', () {
      final json = {'id': 'client_123', 'clientEmail': 'jane@example.com'};

      final patient = Patient.fromJson(json);

      expect(patient.clientFirstName, isNull);
      expect(patient.clientLastName, isNull);
      expect(patient.clientPhone, isNull);
      expect(patient.isActivated, false); // Default false
    });

    test('displayName should return correct name combinations', () {
      // First + Last
      var p = Patient(
        clientEmail: 'e',
        clientFirstName: 'John',
        clientLastName: 'Doe',
      );
      expect(p.displayName, 'John Doe');

      // First only
      p = Patient(clientEmail: 'e', clientFirstName: 'John');
      expect(p.displayName, 'John');

      // Last only
      p = Patient(clientEmail: 'e', clientLastName: 'Doe');
      expect(p.displayName, 'Doe');

      // clientName fallback
      p = Patient(clientEmail: 'e', clientName: 'Full Name');
      expect(p.displayName, 'Full Name');

      // Email fallback
      p = Patient(clientEmail: 'john@example.com');
      expect(p.displayName, 'john@example.com');
    });

    test('M2.2 Verification: fromJson parses nested NDIS plan and categories', () {
      final json = {
        'id': 'c1',
        'clientEmail': 'ndia@test.com',
        'ndisNumber': '430123456',
        'fundingType': 'ndia_managed',
        'plan': {
          'startDate': '2026-07-01T00:00:00.000Z',
          'endDate': '2027-06-30T00:00:00.000Z',
          'totalBudget': 150000.0,
          'status': 'active',
          'categories': [
            {
              'categoryNumber': '01',
              'name': 'Core - Daily Living',
              'budget': 100000.0,
            },
            {
              'categoryNumber': '15',
              'name': 'Capacity Building - Daily Activities',
              'budget': 50000.0,
            },
          ],
        },
      };

      final client = ClientModel.fromJson(json);

      expect(client.ndisNumber, '430123456');
      expect(client.fundingType, 'ndia_managed');
      expect(client.plan, isNotNull);
      expect(client.plan!.totalBudget, 150000.0);
      expect(client.plan!.status, 'active');
      expect(client.plan!.categories, hasLength(2));
      expect(client.plan!.categories[0].categoryNumber, '01');
      expect(client.plan!.categories[0].budget, 100000.0);
      expect(client.plan!.categories[1].name, 'Capacity Building - Daily Activities');
    });

    test('M2.2 Verification: fromJson parses nested SIL and Stakeholders', () {
      final json = {
        'id': 'c2',
        'clientEmail': 'sil@test.com',
        'sil': {
          'propertyId': 'prop_99',
          'roomId': 'room_1',
          'rosterOfCareId': 'roc_55',
        },
        'stakeholders': [
          {
            'stakeholderId': 'stk_1',
            'role': 'plan_manager',
            'isPrimary': true,
          },
        ],
      };

      final client = Patient.fromJson(json);

      expect(client.sil, isNotNull);
      expect(client.sil!.propertyId, 'prop_99');
      expect(client.sil!.roomId, 'room_1');
      expect(client.sil!.rosterOfCareId, 'roc_55');

      expect(client.stakeholders, hasLength(1));
      expect(client.stakeholders[0].role, 'plan_manager');
      expect(client.stakeholders[0].isPrimary, true);
    });
  });
}
