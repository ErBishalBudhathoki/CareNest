// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_checklist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComplianceChecklist _$ComplianceChecklistFromJson(Map<String, dynamic> json) =>
    _ComplianceChecklist(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ChecklistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetRoles: (json['targetRoles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ComplianceChecklistToJson(
  _ComplianceChecklist instance,
) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'items': instance.items,
  'targetRoles': instance.targetRoles,
};

_ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) =>
    _ChecklistItem(
      text: json['text'] as String,
      isRequired: json['isRequired'] as bool? ?? true,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ChecklistItemToJson(_ChecklistItem instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isRequired': instance.isRequired,
      '_id': instance.id,
    };

_UserChecklistStatus _$UserChecklistStatusFromJson(Map<String, dynamic> json) =>
    _UserChecklistStatus(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      checklistId: json['checklistId'] as String,
      itemsStatus: Map<String, bool>.from(json['itemsStatus'] as Map),
      isCompleted: json['isCompleted'] as bool,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$UserChecklistStatusToJson(
  _UserChecklistStatus instance,
) => <String, dynamic>{
  '_id': instance.id,
  'userId': instance.userId,
  'checklistId': instance.checklistId,
  'itemsStatus': instance.itemsStatus,
  'isCompleted': instance.isCompleted,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
};
