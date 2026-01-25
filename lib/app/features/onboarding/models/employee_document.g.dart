// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeDocumentImpl _$$EmployeeDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeDocumentImpl(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      organizationId: json['organizationId'] as String,
      type: json['type'] as String,
      documentNumber: json['documentNumber'] as String?,
      fileUrl: json['fileUrl'] as String,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      status: json['status'] as String,
      rejectionReason: json['rejectionReason'] as String?,
      uploadedAt: json['uploadedAt'] == null
          ? null
          : DateTime.parse(json['uploadedAt'] as String),
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
      verifiedBy: json['verifiedBy'] as String?,
    );

Map<String, dynamic> _$$EmployeeDocumentImplToJson(
        _$EmployeeDocumentImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'organizationId': instance.organizationId,
      'type': instance.type,
      'documentNumber': instance.documentNumber,
      'fileUrl': instance.fileUrl,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'status': instance.status,
      'rejectionReason': instance.rejectionReason,
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'verifiedBy': instance.verifiedBy,
    };
