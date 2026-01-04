class JobRoleModel {
  final String id;
  final String organizationId;
  final String title;
  final String? description;

  JobRoleModel({
    required this.id,
    required this.organizationId,
    required this.title,
    this.description,
  });

  factory JobRoleModel.fromJson(Map<String, dynamic> json) {
    return JobRoleModel(
      id: json['_id'] ?? '',
      organizationId: json['organizationId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
    );
  }
}
