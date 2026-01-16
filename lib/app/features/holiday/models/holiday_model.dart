class Holiday {
  final String id;
  final String title;
  final DateTime date;
  final String jurisdiction;
  final bool isPublic;
  final bool isCustom;

  Holiday({
    required this.id,
    required this.title,
    required this.date,
    required this.jurisdiction,
    required this.isPublic,
    required this.isCustom,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      date: DateTime.parse(json['date']),
      jurisdiction: json['jurisdiction'] ?? 'national',
      isPublic: json['isPublic'] ?? true,
      isCustom: json['isCustom'] ?? false,
    );
  }
}
