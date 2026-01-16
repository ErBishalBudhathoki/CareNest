// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_checklist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComplianceChecklistImpl _$$ComplianceChecklistImplFromJson(
        Map<String, dynamic> json) =>
    _$ComplianceChecklistImpl(
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

Map<String, dynamic> _$$ComplianceChecklistImplToJson(
        _$ComplianceChecklistImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'items': instance.items,
      'targetRoles': instance.targetRoles,
    };

_$ChecklistItemImpl _$$ChecklistItemImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistItemImpl(
      text: json['text'] as String,
      isRequired: json['isRequired'] as bool? ?? true,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$$ChecklistItemImplToJson(_$ChecklistItemImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isRequired': instance.isRequired,
      '_id': instance.id,
    };

_$UserChecklistStatusImpl _$$UserChecklistStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$UserChecklistStatusImpl(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      checklistId: json['checklistId'] as String,
      itemsStatus: Map<String, bool>.from(json['itemsStatus'] as Map),
      isCompleted: json['isCompleted'] as bool,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$UserChecklistStatusImplToJson(
        _$UserChecklistStatusImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'checklistId': instance.checklistId,
      'itemsStatus': instance.itemsStatus,
      'isCompleted': instance.isCompleted,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
