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
  });
}
