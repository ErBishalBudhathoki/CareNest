import 'package:freezed_annotation/freezed_annotation.dart';

part 'mileage_settings_state.freezed.dart';
part 'mileage_settings_state.g.dart';

@freezed
abstract class MileageSettingsState with _$MileageSettingsState {
  const factory MileageSettingsState({
    @Default(false) bool isLoading,
    @Default(0.99) double reimbursementRate,
    String? error,
  }) = _MileageSettingsState;

  factory MileageSettingsState.fromJson(Map<String, dynamic> json) =>
      _$MileageSettingsStateFromJson(json);
}
