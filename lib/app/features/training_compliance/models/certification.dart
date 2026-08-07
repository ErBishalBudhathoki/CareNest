import 'package:freezed_annotation/freezed_annotation.dart';

part 'certification.freezed.dart';
part 'certification.g.dart';

@freezed
abstract class Certification with _$Certification {
  const factory Certification({
    @JsonKey(name: '_id') String? id,
    required String userId,
    required String name,
    required String issuer,
    String? certificationNumber,
    String? requirementId,
    required String fileUrl,
    @Default('Pending') String status,
    required DateTime expiryDate,
    required DateTime uploadedAt,
    String? auditedBy,
    DateTime? auditDate,
    String? notes,
  }) = _Certification;

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}
