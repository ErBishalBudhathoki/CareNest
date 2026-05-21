// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisitHistoryModel _$VisitHistoryModelFromJson(Map<String, dynamic> json) =>
    _VisitHistoryModel(
      id: json['id'] as String,
      shiftDate: json['shiftDate'] as String,
      shiftStartTime: json['shiftStartTime'] as String,
      shiftEndTime: json['shiftEndTime'] as String,
      timeWorked: (json['timeWorked'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$VisitHistoryModelToJson(_VisitHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shiftDate': instance.shiftDate,
      'shiftStartTime': instance.shiftStartTime,
      'shiftEndTime': instance.shiftEndTime,
      'timeWorked': instance.timeWorked,
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
