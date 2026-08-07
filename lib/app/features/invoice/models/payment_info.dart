class PaymentInfo {
  final String status; // 'pending', 'partial', 'paid', 'overdue'
  final double paidAmount;
  final double balanceDue;
  final List<PaymentTransaction> transactions;

  PaymentInfo({
    required this.status,
    required this.paidAmount,
    required this.balanceDue,
    required this.transactions,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      status: json['status'] ?? 'pending',
      paidAmount: (json['paidAmount'] ?? 0.0).toDouble(),
      balanceDue: (json['balanceDue'] ?? 0.0).toDouble(),
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((e) => PaymentTransaction.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'paidAmount': paidAmount,
      'balanceDue': balanceDue,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }
}

class PaymentTransaction {
  final DateTime date;
  final double amount;
  final String method;
  final String? reference;

  PaymentTransaction({
    required this.date,
    required this.amount,
    required this.method,
    this.reference,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      date: DateTime.parse(json['date']),
      amount: (json['amount'] ?? 0.0).toDouble(),
      method: json['method'] ?? '',
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
      'method': method,
      'reference': reference,
    };
  }
}
