List<Map<String, dynamic>> buildEmployeeInvoiceSelectionPayload({
  required String organizationId,
  required String employeeEmail,
  required String employeeName,
  required String employeeId,
  required bool allClientsMode,
  required String selectedClientEmail,
  required List<Map<String, dynamic>> clients,
}) {
  final selectedClients = allClientsMode
      ? clients
      : clients
            .where(
              (c) =>
                  (c['clientEmail']?.toString() ?? '') == selectedClientEmail,
            )
            .toList();

  return [
    {
      'employee': {
        'id': employeeId,
        'email': employeeEmail,
        'name': employeeName,
        'organizationId': organizationId,
      },
      'clients': selectedClients
          .map(
            (c) => {
              'id': c['clientId']?.toString() ?? '',
              'email': c['clientEmail']?.toString() ?? '',
              'name':
                  c['clientName']?.toString() ??
                  c['clientEmail']?.toString() ??
                  '',
              'organizationId': organizationId,
            },
          )
          .where((c) => (c['email'] ?? '').toString().isNotEmpty)
          .toList(),
      'organizationId': organizationId,
    },
  ];
}

class EmployeeInvoiceEmployeePayloadInput {
  final String employeeEmail;
  final String employeeName;
  final String employeeId;
  final bool allClientsMode;
  final String selectedClientEmail;
  final List<Map<String, dynamic>> clients;

  const EmployeeInvoiceEmployeePayloadInput({
    required this.employeeEmail,
    required this.employeeName,
    required this.employeeId,
    required this.allClientsMode,
    required this.selectedClientEmail,
    required this.clients,
  });
}

List<Map<String, dynamic>> buildEmployeeInvoiceSelectionsPayload({
  required String organizationId,
  required List<EmployeeInvoiceEmployeePayloadInput> employees,
}) {
  final List<Map<String, dynamic>> payload = [];

  for (final e in employees) {
    final selectedClients = e.allClientsMode
        ? e.clients
        : e.clients
              .where(
                (c) =>
                    (c['clientEmail']?.toString() ?? '') ==
                    e.selectedClientEmail,
              )
              .toList();

    payload.add({
      'employee': {
        'id': e.employeeId,
        'email': e.employeeEmail,
        'name': e.employeeName,
        'organizationId': organizationId,
      },
      'clients': selectedClients
          .map(
            (c) => {
              'id': c['clientId']?.toString() ?? '',
              'email': c['clientEmail']?.toString() ?? '',
              'name':
                  c['clientName']?.toString() ??
                  c['clientEmail']?.toString() ??
                  '',
              'organizationId': organizationId,
            },
          )
          .where((c) => (c['email'] ?? '').toString().isNotEmpty)
          .toList(),
      'organizationId': organizationId,
    });
  }

  return payload;
}
