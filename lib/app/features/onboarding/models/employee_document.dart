import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_document.freezed.dart';
part 'employee_document.g.dart';

@freezed
class EmployeeDocument with _$EmployeeDocument {
  const factory EmployeeDocument({
    @JsonKey(name: '_id') String? id,
    required String userId,
    required String organizationId,
    required String type,
    String? documentNumber,
    required String fileUrl,
    DateTime? expiryDate,
    required String status,
    String? rejectionReason,
    DateTime? uploadedAt,
    DateTime? verifiedAt,
    String? verifiedBy,
  }) = _EmployeeDocument;

  factory EmployeeDocument.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDocumentFromJson(json);
}
