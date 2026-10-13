import 'package:freezed_annotation/freezed_annotation.dart';

part 'stakeholder_models.freezed.dart';
part 'stakeholder_models.g.dart';

@freezed
abstract class StakeholderPermissions with _$StakeholderPermissions {
  const factory StakeholderPermissions({
    @Default(false) bool viewAppointments,
    @Default(false) bool viewDocuments,
    @Default(false) bool viewInvoices,
    @Default(false) bool editProfile,
    @Default(false) bool approveServices,
    @Default(false) bool manageStakeholders,
    @Default(false) bool viewMessages,
    @Default(false) bool sendMessages,
    @Default(false) bool viewServiceHistory,
    @Default(false) bool receiveNotifications,
  }) = _StakeholderPermissions;

  factory StakeholderPermissions.fromJson(Map<String, dynamic> json) =>
      _$StakeholderPermissionsFromJson(json);
}

@freezed
abstract class Stakeholder with _$Stakeholder {
  const factory Stakeholder({
    required String id,
    @Default('other') String type,
    required String name,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String company,
    @Default('') String abn,
    @Default('') String linkedUserEmail,
    @Default('') String notes,
    @Default(true) bool isActive,
    @Default(StakeholderPermissions()) StakeholderPermissions permissions,
  }) = _Stakeholder;

  factory Stakeholder.fromJson(Map<String, dynamic> json) =>
      _$StakeholderFromJson(json);
}

@freezed
abstract class CareTeamEntry with _$CareTeamEntry {
  const factory CareTeamEntry({
    @Default('other') String linkRole,
    @Default(false) bool isPrimary,
    required Stakeholder stakeholder,
  }) = _CareTeamEntry;

  factory CareTeamEntry.fromJson(Map<String, dynamic> json) =>
      _$CareTeamEntryFromJson(json);
}

@freezed
abstract class ClientCareTeam with _$ClientCareTeam {
  const factory ClientCareTeam({
    required String clientId,
    @Default('plan_managed') String fundingType,
    @Default(<CareTeamEntry>[]) List<CareTeamEntry> careTeam,
  }) = _ClientCareTeam;

  factory ClientCareTeam.fromJson(Map<String, dynamic> json) =>
      _$ClientCareTeamFromJson(json);
}
