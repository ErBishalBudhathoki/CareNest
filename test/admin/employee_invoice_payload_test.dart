import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/admin/utils/employee_invoice_payload.dart';

void main() {
  group('buildEmployeeInvoiceSelectionsPayload', () {
    test('builds payload for multiple employees', () {
      final payload = buildEmployeeInvoiceSelectionsPayload(
        organizationId: 'org1',
        employees: [
          EmployeeInvoiceEmployeePayloadInput(
            employeeEmail: 'e1@example.com',
            employeeName: 'Emp 1',
            employeeId: 'e1',
            allClientsMode: true,
            selectedClientEmail: '',
            clients: [
              {
                'clientId': 'c1',
                'clientEmail': 'c1@example.com',
                'clientName': 'Client 1',
              },
              {
                'clientId': 'c2',
                'clientEmail': 'c2@example.com',
                'clientName': 'Client 2',
              },
            ],
          ),
          EmployeeInvoiceEmployeePayloadInput(
            employeeEmail: 'e2@example.com',
            employeeName: 'Emp 2',
            employeeId: 'e2',
            allClientsMode: false,
            selectedClientEmail: 'c4@example.com',
            clients: [
              {
                'clientId': 'c3',
                'clientEmail': 'c3@example.com',
                'clientName': 'Client 3',
              },
              {
                'clientId': 'c4',
                'clientEmail': 'c4@example.com',
                'clientName': 'Client 4',
              },
            ],
          ),
        ],
      );

      expect(payload.length, 2);
      expect(payload[0]['employee']['email'], 'e1@example.com');
      expect((payload[0]['clients'] as List).length, 2);
      expect(payload[1]['employee']['email'], 'e2@example.com');
      expect((payload[1]['clients'] as List).length, 1);
      expect((payload[1]['clients'] as List).first['email'], 'c4@example.com');
    });
  });
}
