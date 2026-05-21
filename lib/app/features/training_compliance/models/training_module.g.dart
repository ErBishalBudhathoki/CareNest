// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingModule _$TrainingModuleFromJson(Map<String, dynamic> json) =>
    _TrainingModule(
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

Map<String, dynamic> _$TrainingModuleToJson(_TrainingModule instance) =>
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

_TrainingProgress _$TrainingProgressFromJson(Map<String, dynamic> json) =>
    _TrainingProgress(
      id: json['_id'] as String?,
      userId: json['userId'] as String,
      moduleId: json['moduleId'] as String,
      status: json['status'] as String,
      progressPercentage: (json['progressPercentage'] as num).toInt(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$TrainingProgressToJson(_TrainingProgress instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'moduleId': instance.moduleId,
      'status': instance.status,
      'progressPercentage': instance.progressPercentage,
      'completedAt': instance.completedAt?.toIso8601String(),
    };
