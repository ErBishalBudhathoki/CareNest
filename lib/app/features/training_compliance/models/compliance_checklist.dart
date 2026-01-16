import 'package:freezed_annotation/freezed_annotation.dart';

part 'compliance_checklist.freezed.dart';
part 'compliance_checklist.g.dart';

@freezed
class ComplianceChecklist with _$ComplianceChecklist {
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
class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String text,
    @Default(true) bool isRequired,
    @JsonKey(name: '_id') String? id,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => _$ChecklistItemFromJson(json);
}

@freezed
class UserChecklistStatus with _$UserChecklistStatus {
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
