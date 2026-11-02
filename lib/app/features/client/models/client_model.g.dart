// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClientPlanCategory _$ClientPlanCategoryFromJson(Map<String, dynamic> json) =>
    _ClientPlanCategory(
      categoryNumber: json['categoryNumber'] as String,
      name: json['name'] as String? ?? '',
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ClientPlanCategoryToJson(_ClientPlanCategory instance) =>
    <String, dynamic>{
      'categoryNumber': instance.categoryNumber,
      'name': instance.name,
      'budget': instance.budget,
    };

_ClientSilRef _$ClientSilRefFromJson(Map<String, dynamic> json) =>
    _ClientSilRef(
      propertyId: json['propertyId'] as String?,
      roomId: json['roomId'] as String?,
      rosterOfCareId: json['rosterOfCareId'] as String?,
    );

Map<String, dynamic> _$ClientSilRefToJson(_ClientSilRef instance) =>
    <String, dynamic>{
      'propertyId': instance.propertyId,
      'roomId': instance.roomId,
      'rosterOfCareId': instance.rosterOfCareId,
    };

_ClientStakeholderRef _$ClientStakeholderRefFromJson(
  Map<String, dynamic> json,
) => _ClientStakeholderRef(
  stakeholderId: json['stakeholderId'] as String?,
  role: json['role'] as String? ?? 'other',
  isPrimary: json['isPrimary'] as bool? ?? false,
);

Map<String, dynamic> _$ClientStakeholderRefToJson(
  _ClientStakeholderRef instance,
) => <String, dynamic>{
  'stakeholderId': instance.stakeholderId,
  'role': instance.role,
  'isPrimary': instance.isPrimary,
};
