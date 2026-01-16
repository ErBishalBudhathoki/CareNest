import 'package:flutter/material.dart';

class EmployeeInvoiceValidationResult {
  final bool isValid;
  final String message;

  const EmployeeInvoiceValidationResult({
    required this.isValid,
    required this.message,
  });
}

class EmployeeInvoiceEmployeeSelection {
  final String employeeEmail;
  final String employeeName;
  final bool allClientsMode;
  final String selectedClientEmail;
  final bool hasClients;
  final bool bankDetailsComplete;

  const EmployeeInvoiceEmployeeSelection({
    required this.employeeEmail,
    required this.employeeName,
    required this.allClientsMode,
    required this.selectedClientEmail,
    required this.hasClients,
    required this.bankDetailsComplete,
  });
}

EmployeeInvoiceValidationResult validateEmployeeInvoiceConfig({
  required String employeeEmail,
  required bool allClientsMode,
  required String selectedClientEmail,
  required DateTimeRange? dateRange,
  required bool includeTax,
  required double taxRate,
  required bool bankDetailsComplete,
}) {
  if (employeeEmail.isEmpty) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Employee must be selected.',
    );
  }

  if (!allClientsMode && selectedClientEmail.isEmpty) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Client must be selected when using specific-client mode.',
    );
  }

  if (dateRange == null) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Date range must be selected.',
    );
  }

  if (includeTax && (taxRate <= 0 || taxRate > 1)) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Tax rate must be between 0 and 1.',
    );
  }

  if (!bankDetailsComplete) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Employee bank details must be complete.',
    );
  }

  return const EmployeeInvoiceValidationResult(isValid: true, message: '');
}

EmployeeInvoiceValidationResult validateMultiEmployeeInvoiceConfig({
  required List<EmployeeInvoiceEmployeeSelection> employees,
  required DateTimeRange? dateRange,
  required bool includeTax,
  required double taxRate,
}) {
  if (employees.isEmpty) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'At least one employee must be selected.',
    );
  }

  if (dateRange == null) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Date range must be selected.',
    );
  }

  if (includeTax && (taxRate <= 0 || taxRate > 1)) {
    return const EmployeeInvoiceValidationResult(
      isValid: false,
      message: 'Tax rate must be between 0 and 1.',
    );
  }

  for (final e in employees) {
    if (e.employeeEmail.isEmpty) {
      return const EmployeeInvoiceValidationResult(
        isValid: false,
        message: 'Employee must be selected.',
      );
    }

    if (!e.hasClients) {
      return EmployeeInvoiceValidationResult(
        isValid: false,
        message: 'No clients found for ${e.employeeName}.',
      );
    }

    if (!e.allClientsMode && e.selectedClientEmail.isEmpty) {
      return EmployeeInvoiceValidationResult(
        isValid: false,
        message:
            'Client must be selected for ${e.employeeName} when using specific-client mode.',
      );
    }

    if (!e.bankDetailsComplete) {
      return EmployeeInvoiceValidationResult(
        isValid: false,
        message: 'Employee bank details must be complete for ${e.employeeName}.',
      );
    }
  }

  return const EmployeeInvoiceValidationResult(isValid: true, message: '');
}
