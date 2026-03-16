class CertificationRequirement {
  final String id;
  final String name;
  final String description;
  final bool isRequired;
  final bool isActive;
  final List<String> roles;

  CertificationRequirement({
    required this.id,
    required this.name,
    required this.description,
    required this.isRequired,
    required this.isActive,
    required this.roles,
  });

  factory CertificationRequirement.fromJson(Map<String, dynamic> json) {
    final rolesRaw = json['roles'];
    return CertificationRequirement(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      isRequired: json['isRequired'] == true,
      isActive: json['isActive'] != false,
      roles: rolesRaw is List
          ? rolesRaw.map((e) => e.toString()).toList()
          : const <String>[],
    );
  }
}
