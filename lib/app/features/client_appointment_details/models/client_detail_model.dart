import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_detail_model.freezed.dart';
part 'client_detail_model.g.dart';

@freezed
abstract class ClientDetailModel with _$ClientDetailModel {
  const factory ClientDetailModel({
    required String id,
    required String clientFirstName,
    required String clientLastName,
    required String clientEmail,
    String? clientPhone,
    String? clientAddress,
    String? clientCity,
    String? clientState,
    String? clientZip,
    String? careNotes,
    Map<String, dynamic>? preferences,
    Map<String, dynamic>? emergencyContact,
    List<String>? medicalConditions,
    Map<String, dynamic>? riskAssessment,
    @Default(false) bool isActivated,
  }) = _ClientDetailModel;

  factory ClientDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ClientDetailModelFromJson(json);

  static ClientDetailModel fromBackend(Map<String, dynamic> json) {
    return ClientDetailModel.fromJson(json);
  }
}

extension ClientDetailDisplay on ClientDetailModel {
  String get fullName => '$clientFirstName $clientLastName';
  String get fullAddress => [
    clientAddress,
    clientCity,
    clientState,
    clientZip,
  ].where((e) => e != null && e.isNotEmpty).join(', ');
}
