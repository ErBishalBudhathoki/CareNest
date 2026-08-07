import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_module.freezed.dart';
part 'training_module.g.dart';

@freezed
abstract class TrainingModule with _$TrainingModule {
  const factory TrainingModule({
    @JsonKey(name: '_id') String? id,
    required String title,
    required String description,
    required String contentType,
    String? contentUrl,
    String? contentText,
    required int durationMinutes,
    @Default(true) bool isPublished,
    required String createdBy,
    required DateTime createdAt,
    required DateTime updatedAt,
    @JsonKey(includeFromJson: false) TrainingProgress? userProgress,
  }) = _TrainingModule;

  factory TrainingModule.fromJson(Map<String, dynamic> json) =>
      _$TrainingModuleFromJson(json);
}

@freezed
abstract class TrainingProgress with _$TrainingProgress {
  const factory TrainingProgress({
    @JsonKey(name: '_id') String? id,
    required String userId,
    required String moduleId,
    required String status,
    required int progressPercentage,
    DateTime? completedAt,
  }) = _TrainingProgress;

  factory TrainingProgress.fromJson(Map<String, dynamic> json) =>
      _$TrainingProgressFromJson(json);
}
