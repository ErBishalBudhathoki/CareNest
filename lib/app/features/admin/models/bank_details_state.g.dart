// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BankDetailsState _$BankDetailsStateFromJson(Map<String, dynamic> json) =>
    _BankDetailsState(
      bankName: json['bankName'] as String? ?? '',
      accountName: json['accountName'] as String? ?? '',
      bsb: json['bsb'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      isLoading: json['isLoading'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$BankDetailsStateToJson(_BankDetailsState instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountName': instance.accountName,
      'bsb': instance.bsb,
      'accountNumber': instance.accountNumber,
      'isLoading': instance.isLoading,
      'errorMessage': instance.errorMessage,
    };
