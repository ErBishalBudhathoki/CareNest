class LeaveTypeModel {
  final String id;
  final String organizationId;
  final String name;
  final String? description;

  LeaveTypeModel({
    required this.id,
    required this.organizationId,
    required this.name,
    this.description,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      id: json['_id'] ?? '',
      organizationId: json['organizationId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
    );
  }
}
