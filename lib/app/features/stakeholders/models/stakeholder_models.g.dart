// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stakeholder_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StakeholderPermissions _$StakeholderPermissionsFromJson(
  Map<String, dynamic> json,
) => _StakeholderPermissions(
  viewAppointments: json['viewAppointments'] as bool? ?? false,
  viewDocuments: json['viewDocuments'] as bool? ?? false,
  viewInvoices: json['viewInvoices'] as bool? ?? false,
  editProfile: json['editProfile'] as bool? ?? false,
  approveServices: json['approveServices'] as bool? ?? false,
  manageStakeholders: json['manageStakeholders'] as bool? ?? false,
  viewMessages: json['viewMessages'] as bool? ?? false,
  sendMessages: json['sendMessages'] as bool? ?? false,
  viewServiceHistory: json['viewServiceHistory'] as bool? ?? false,
  receiveNotifications: json['receiveNotifications'] as bool? ?? false,
);

Map<String, dynamic> _$StakeholderPermissionsToJson(
  _StakeholderPermissions instance,
) => <String, dynamic>{
  'viewAppointments': instance.viewAppointments,
  'viewDocuments': instance.viewDocuments,
  'viewInvoices': instance.viewInvoices,
  'editProfile': instance.editProfile,
  'approveServices': instance.approveServices,
  'manageStakeholders': instance.manageStakeholders,
  'viewMessages': instance.viewMessages,
  'sendMessages': instance.sendMessages,
  'viewServiceHistory': instance.viewServiceHistory,
  'receiveNotifications': instance.receiveNotifications,
};

_Stakeholder _$StakeholderFromJson(Map<String, dynamic> json) => _Stakeholder(
  id: json['id'] as String,
  type: json['type'] as String? ?? 'other',
  name: json['name'] as String,
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  company: json['company'] as String? ?? '',
  abn: json['abn'] as String? ?? '',
  linkedUserEmail: json['linkedUserEmail'] as String? ?? '',
  notes: json['notes'] as String? ?? '',
  isActive: json['isActive'] as bool? ?? true,
  permissions: json['permissions'] == null
      ? const StakeholderPermissions()
      : StakeholderPermissions.fromJson(
          json['permissions'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$StakeholderToJson(_Stakeholder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'company': instance.company,
      'abn': instance.abn,
      'linkedUserEmail': instance.linkedUserEmail,
      'notes': instance.notes,
      'isActive': instance.isActive,
      'permissions': instance.permissions,
    };

_CareTeamEntry _$CareTeamEntryFromJson(Map<String, dynamic> json) =>
    _CareTeamEntry(
      linkRole: json['linkRole'] as String? ?? 'other',
      isPrimary: json['isPrimary'] as bool? ?? false,
      stakeholder: Stakeholder.fromJson(
        json['stakeholder'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CareTeamEntryToJson(_CareTeamEntry instance) =>
    <String, dynamic>{
      'linkRole': instance.linkRole,
      'isPrimary': instance.isPrimary,
      'stakeholder': instance.stakeholder,
    };

_ClientCareTeam _$ClientCareTeamFromJson(Map<String, dynamic> json) =>
    _ClientCareTeam(
      clientId: json['clientId'] as String,
      fundingType: json['fundingType'] as String? ?? 'plan_managed',
      careTeam:
          (json['careTeam'] as List<dynamic>?)
              ?.map((e) => CareTeamEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CareTeamEntry>[],
    );

Map<String, dynamic> _$ClientCareTeamToJson(_ClientCareTeam instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'fundingType': instance.fundingType,
      'careTeam': instance.careTeam,
    };
