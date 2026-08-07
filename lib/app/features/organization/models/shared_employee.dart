import 'package:freezed_annotation/freezed_annotation.dart';

part 'shared_employee.freezed.dart';
part 'shared_employee.g.dart';

@freezed
abstract class SharedEmployeeAssignment with _$SharedEmployeeAssignment {
  const factory SharedEmployeeAssignment({
    required String id,
    required String employeeId,
    required String organizationId,
    required String assignmentType,
    @Default(100) double costAllocation,
    @Default(0) double hourlyRate,
    required DateTime startDate,
    DateTime? endDate,
    @Default('active') String status,
    String? notes,
  }) = _SharedEmployeeAssignment;

  factory SharedEmployeeAssignment.fromJson(Map<String, dynamic> json) =>
      _$SharedEmployeeAssignmentFromJson(json);

  factory SharedEmployeeAssignment.fromBackend(Map<String, dynamic> json) {
    return SharedEmployeeAssignment(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      employeeId: json['employeeId']?.toString() ?? '',
      organizationId: json['organizationId']?.toString() ?? '',
      assignmentType: json['assignmentType']?.toString() ?? '',
      costAllocation: (json['costAllocation'] as num?)?.toDouble() ?? 100,
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 0,
      startDate:
          DateTime.tryParse(json['startDate']?.toString() ?? '') ??
          DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'].toString())
          : null,
      status: json['status']?.toString() ?? 'active',
      notes: json['notes']?.toString(),
    );
  }
}
