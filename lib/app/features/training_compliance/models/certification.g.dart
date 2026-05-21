// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    _Certification(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      name: json['name'] as String,
      issuer: json['issuer'] as String,
      certificationNumber: json['certificationNumber'] as String?,
      requirementId: json['requirementId'] as String?,
      fileUrl: json['fileUrl'] as String,
      status: json['status'] as String? ?? 'Pending',
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      auditedBy: json['auditedBy'] as String?,
      auditDate: json['auditDate'] == null
          ? null
          : DateTime.parse(json['auditDate'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CertificationToJson(_Certification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'issuer': instance.issuer,
      'certificationNumber': instance.certificationNumber,
      'requirementId': instance.requirementId,
      'fileUrl': instance.fileUrl,
      'status': instance.status,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'auditedBy': instance.auditedBy,
      'auditDate': instance.auditDate?.toIso8601String(),
      'notes': instance.notes,
    };
