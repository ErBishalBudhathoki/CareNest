import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/admin/utils/employee_invoice_validation.dart';

void main() {
  group('validateMultiEmployeeInvoiceConfig', () {
    test('requires at least one employee', () {
      final res = validateMultiEmployeeInvoiceConfig(
        employees: const [],
        dateRange: DateTimeRange(
          start: DateTime(2026, 1, 1),
          end: DateTime(2026, 1, 2),
        ),
        includeTax: false,
        taxRate: 0.0,
      );
      expect(res.isValid, false);
    });

    test('requires client in specific-client mode', () {
      final res = validateMultiEmployeeInvoiceConfig(
        employees: const [
          EmployeeInvoiceEmployeeSelection(
            employeeEmail: 'e@example.com',
            employeeName: 'Emp',
            allClientsMode: false,
            selectedClientEmail: '',
            hasClients: true,
            bankDetailsComplete: true,
          ),
        ],
        dateRange: DateTimeRange(
          start: DateTime(2026, 1, 1),
          end: DateTime(2026, 1, 2),
        ),
        includeTax: false,
        taxRate: 0.0,
      );
      expect(res.isValid, false);
    });

    test('requires client list per employee', () {
      final res = validateMultiEmployeeInvoiceConfig(
        employees: const [
          EmployeeInvoiceEmployeeSelection(
            employeeEmail: 'e@example.com',
            employeeName: 'Emp',
            allClientsMode: true,
            selectedClientEmail: '',
            hasClients: false,
            bankDetailsComplete: true,
          ),
        ],
        dateRange: DateTimeRange(
          start: DateTime(2026, 1, 1),
          end: DateTime(2026, 1, 2),
        ),
        includeTax: false,
        taxRate: 0.0,
      );
      expect(res.isValid, false);
    });

    test('validates tax rate bounds when tax enabled', () {
      final res = validateMultiEmployeeInvoiceConfig(
        employees: const [
          EmployeeInvoiceEmployeeSelection(
            employeeEmail: 'e@example.com',
            employeeName: 'Emp',
            allClientsMode: true,
            selectedClientEmail: '',
            hasClients: true,
            bankDetailsComplete: true,
          ),
        ],
        dateRange: DateTimeRange(
          start: DateTime(2026, 1, 1),
          end: DateTime(2026, 1, 2),
        ),
        includeTax: true,
        taxRate: 1.5,
      );
      expect(res.isValid, false);
    });

    test('requires complete bank details per employee', () {
      final res = validateMultiEmployeeInvoiceConfig(
        employees: const [
          EmployeeInvoiceEmployeeSelection(
            employeeEmail: 'e@example.com',
            employeeName: 'Emp',
            allClientsMode: true,
            selectedClientEmail: '',
            hasClients: true,
            bankDetailsComplete: false,
          ),
        ],
        dateRange: DateTimeRange(
          start: DateTime(2026, 1, 1),
          end: DateTime(2026, 1, 2),
        ),
        includeTax: false,
        taxRate: 0.0,
      );
      expect(res.isValid, false);
    });

    test('passes for multiple valid employees', () {
      final res = validateMultiEmployeeInvoiceConfig(
        employees: const [
          EmployeeInvoiceEmployeeSelection(
            employeeEmail: 'e1@example.com',
            employeeName: 'Emp 1',
            allClientsMode: true,
            selectedClientEmail: '',
            hasClients: true,
            bankDetailsComplete: true,
          ),
          EmployeeInvoiceEmployeeSelection(
            employeeEmail: 'e2@example.com',
            employeeName: 'Emp 2',
            allClientsMode: false,
            selectedClientEmail: 'c@example.com',
            hasClients: true,
            bankDetailsComplete: true,
          ),
        ],
        dateRange: DateTimeRange(
          start: DateTime(2026, 1, 1),
          end: DateTime(2026, 1, 2),
        ),
        includeTax: true,
        taxRate: 0.1,
      );
      expect(res.isValid, true);
    });
  });
}
