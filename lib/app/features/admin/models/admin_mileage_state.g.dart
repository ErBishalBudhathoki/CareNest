// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_mileage_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminMileageState _$AdminMileageStateFromJson(Map<String, dynamic> json) =>
    _AdminMileageState(
      trips:
          (json['trips'] as List<dynamic>?)
              ?.map((e) => Trip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rawTripsById:
          (json['rawTripsById'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as Map<String, dynamic>),
          ) ??
          const {},
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
      filterStatus: json['filterStatus'] as String? ?? 'PENDING',
    );

Map<String, dynamic> _$AdminMileageStateToJson(_AdminMileageState instance) =>
    <String, dynamic>{
      'trips': instance.trips,
      'rawTripsById': instance.rawTripsById,
      'isLoading': instance.isLoading,
      'error': instance.error,
      'filterStatus': instance.filterStatus,
    };
