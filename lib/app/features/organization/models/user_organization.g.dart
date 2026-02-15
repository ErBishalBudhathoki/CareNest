// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserOrganizationImpl _$$UserOrganizationImplFromJson(
        Map<String, dynamic> json) =>
    _$UserOrganizationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      organizationId: json['organizationId'] as String,
      role: json['role'] as String,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      lastAccessedAt: json['lastAccessedAt'] == null
          ? null
          : DateTime.parse(json['lastAccessedAt'] as String),
      organizationName: json['organizationName'] as String?,
      organizationCode: json['organizationCode'] as String?,
      organizationLogoUrl: json['organizationLogoUrl'] as String?,
    );

Map<String, dynamic> _$$UserOrganizationImplToJson(
        _$UserOrganizationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'organizationId': instance.organizationId,
      'role': instance.role,
      'permissions': instance.permissions,
      'isActive': instance.isActive,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'lastAccessedAt': instance.lastAccessedAt?.toIso8601String(),
      'organizationName': instance.organizationName,
      'organizationCode': instance.organizationCode,
      'organizationLogoUrl': instance.organizationLogoUrl,
    };
