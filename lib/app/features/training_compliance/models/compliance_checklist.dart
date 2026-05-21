import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_checklist.freezed.dart';
part 'compliance_checklist.g.dart';

@freezed
abstract class ComplianceChecklist with _$ComplianceChecklist {
  const factory ComplianceChecklist({
    @JsonKey(name: '_id') String? id,
    required String title,
    required String description,
    required List<ChecklistItem> items,
    List<String>? targetRoles,
    @JsonKey(includeFromJson: false) UserChecklistStatus? userStatus,
  }) = _ComplianceChecklist;

  factory ComplianceChecklist.fromJson(Map<String, dynamic> json) => _$ComplianceChecklistFromJson(json);
}

@freezed
abstract class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String text,
    @Default(true) bool isRequired,
    @JsonKey(name: '_id') String? id,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => _$ChecklistItemFromJson(json);
}

@freezed
abstract class UserChecklistStatus with _$UserChecklistStatus {
  const factory UserChecklistStatus({
    @JsonKey(name: '_id') String? id,
    required String userId,
    required String checklistId,
    required Map<String, bool> itemsStatus,
    required bool isCompleted,
    required DateTime lastUpdated,
  }) = _UserChecklistStatus;

  factory UserChecklistStatus.fromJson(Map<String, dynamic> json) => _$UserChecklistStatusFromJson(json);
}
