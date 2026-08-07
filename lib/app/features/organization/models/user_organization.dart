import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_organization.freezed.dart';
part 'user_organization.g.dart';

@freezed
abstract class UserOrganization with _$UserOrganization {
  const factory UserOrganization({
    required String id,
    required String userId,
    required String organizationId,
    required String role,
    @Default([]) List<String> permissions,
    @Default(true) bool isActive,
    required DateTime joinedAt,
    DateTime? lastAccessedAt,

    // Flattened organization details for UI convenience
    String? organizationName,
    String? organizationCode,
    String? organizationLogoUrl,
  }) = _UserOrganization;

  factory UserOrganization.fromJson(Map<String, dynamic> json) =>
      _$UserOrganizationFromJson(json);
}
