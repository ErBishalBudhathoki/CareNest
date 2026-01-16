// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingModuleImpl _$$TrainingModuleImplFromJson(Map<String, dynamic> json) =>
    _$TrainingModuleImpl(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      contentType: json['contentType'] as String,
      contentUrl: json['contentUrl'] as String?,
      contentText: json['contentText'] as String?,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      isPublished: json['isPublished'] as bool? ?? true,
      createdBy: json['createdBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TrainingModuleImplToJson(
        _$TrainingModuleImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'contentType': instance.contentType,
      'contentUrl': instance.contentUrl,
      'contentText': instance.contentText,
      'durationMinutes': instance.durationMinutes,
      'isPublished': instance.isPublished,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$TrainingProgressImpl _$$TrainingProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$TrainingProgressImpl(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      moduleId: json['moduleId'] as String,
      status: json['status'] as String,
      progressPercentage: (json['progressPercentage'] as num).toInt(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$TrainingProgressImplToJson(
        _$TrainingProgressImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'moduleId': instance.moduleId,
      'status': instance.status,
      'progressPercentage': instance.progressPercentage,
      'completedAt': instance.completedAt?.toIso8601String(),
    };
