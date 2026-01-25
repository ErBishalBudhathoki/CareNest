class ClientUser {
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String clientId;

  ClientUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.clientId,
  });

  factory ClientUser.fromJson(Map<String, dynamic> json) {
    return ClientUser(
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'] ?? '',
      clientId: json['clientId'] ?? '',
    );
  }
}

class ClientInvoice {
  final String id;
  final String invoiceNumber;
  final String organizationId;
  final Map<String, dynamic> financialSummary;
  final Map<String, dynamic> workflow;
  final Map<String, dynamic> payment;
  final List<Map<String, dynamic>> lineItems;
  final DateTime createdAt;

  ClientInvoice({
    required this.id,
    required this.invoiceNumber,
    required this.organizationId,
    required this.financialSummary,
    required this.workflow,
    required this.payment,
    required this.lineItems,
    required this.createdAt,
  });

  factory ClientInvoice.fromJson(Map<String, dynamic> json) {
    return ClientInvoice(
      id: json['_id'] ?? '',
      invoiceNumber: json['invoiceNumber'] ?? '',
      organizationId: json['organizationId'] ?? '',
      financialSummary: Map<String, dynamic>.from(json['financialSummary'] ?? {}),
      workflow: Map<String, dynamic>.from(json['workflow'] ?? {}),
      payment: Map<String, dynamic>.from(json['payment'] ?? {}),
      lineItems: List<Map<String, dynamic>>.from(json['lineItems'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class ClientAppointment {
  final String assignmentId;
  final String date;
  final String startTime;
  final String endTime;
  final String? userEmail;

  ClientAppointment({
    required this.assignmentId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.userEmail,
  });

  factory ClientAppointment.fromJson(Map<String, dynamic> json) {
    return ClientAppointment(
      assignmentId: json['assignmentId'] ?? '',
      date: json['date'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      userEmail: json['userEmail'],
    );
  }
}
