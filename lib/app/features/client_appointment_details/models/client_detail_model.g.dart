// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClientDetailModel _$ClientDetailModelFromJson(Map<String, dynamic> json) =>
    _ClientDetailModel(
      id: json['id'] as String,
      clientFirstName: json['clientFirstName'] as String,
      clientLastName: json['clientLastName'] as String,
      clientEmail: json['clientEmail'] as String,
      clientPhone: json['clientPhone'] as String?,
      clientAddress: json['clientAddress'] as String?,
      clientCity: json['clientCity'] as String?,
      clientState: json['clientState'] as String?,
      clientZip: json['clientZip'] as String?,
      careNotes: json['careNotes'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>?,
      emergencyContact: json['emergencyContact'] as Map<String, dynamic>?,
      medicalConditions: (json['medicalConditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      riskAssessment: json['riskAssessment'] as Map<String, dynamic>?,
      isActivated: json['isActivated'] as bool? ?? false,
    );

Map<String, dynamic> _$ClientDetailModelToJson(_ClientDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientFirstName': instance.clientFirstName,
      'clientLastName': instance.clientLastName,
      'clientEmail': instance.clientEmail,
      'clientPhone': instance.clientPhone,
      'clientAddress': instance.clientAddress,
      'clientCity': instance.clientCity,
      'clientState': instance.clientState,
      'clientZip': instance.clientZip,
      'careNotes': instance.careNotes,
      'preferences': instance.preferences,
      'emergencyContact': instance.emergencyContact,
      'medicalConditions': instance.medicalConditions,
      'riskAssessment': instance.riskAssessment,
      'isActivated': instance.isActivated,
    };
