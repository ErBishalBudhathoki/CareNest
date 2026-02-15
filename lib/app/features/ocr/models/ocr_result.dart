class OcrResult {
  final String merchant;
  final String date;
  final double totalAmount;
  final String currency;
  final List<dynamic> items;
  final String rawText;

  OcrResult({
    required this.merchant,
    required this.date,
    required this.totalAmount,
    required this.currency,
    required this.items,
    required this.rawText,
  });

  factory OcrResult.fromJson(Map<String, dynamic> json) {
    return OcrResult(
      merchant: json['merchant'] ?? '',
      date: json['date'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'USD',
      items: json['items'] ?? [],
      rawText: json['rawText'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchant': merchant,
      'date': date,
      'totalAmount': totalAmount,
      'currency': currency,
      'items': items,
      'rawText': rawText,
    };
  }
}
