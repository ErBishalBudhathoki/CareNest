// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mileage_settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MileageSettingsState _$MileageSettingsStateFromJson(
  Map<String, dynamic> json,
) => _MileageSettingsState(
  isLoading: json['isLoading'] as bool? ?? false,
  reimbursementRate: (json['reimbursementRate'] as num?)?.toDouble() ?? 0.99,
  error: json['error'] as String?,
);

Map<String, dynamic> _$MileageSettingsStateToJson(
  _MileageSettingsState instance,
) => <String, dynamic>{
  'isLoading': instance.isLoading,
  'reimbursementRate': instance.reimbursementRate,
  'error': instance.error,
};
