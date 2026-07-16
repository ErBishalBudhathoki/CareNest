import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_details_state.freezed.dart';
part 'bank_details_state.g.dart';

@freezed
abstract class BankDetailsState with _$BankDetailsState {
  const factory BankDetailsState({
    @Default('') String bankName,
    @Default('') String accountName,
    @Default('') String bsb,
    @Default('') String accountNumber,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _BankDetailsState;

  factory BankDetailsState.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsStateFromJson(json);
}
