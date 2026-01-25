import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit_history_model.freezed.dart';
part 'visit_history_model.g.dart';

@freezed
class VisitHistoryModel with _$VisitHistoryModel {
  const factory VisitHistoryModel({
    required String id,
    required String shiftDate,
    required String shiftStartTime,
    required String shiftEndTime,
    List<String>? timeWorked, // Assuming timeList is List<String>
    String? notes, // If we store per-visit notes
    DateTime? createdAt,
  }) = _VisitHistoryModel;

  factory VisitHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$VisitHistoryModelFromJson(json);
}
