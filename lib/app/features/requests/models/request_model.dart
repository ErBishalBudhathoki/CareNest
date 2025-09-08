import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

enum RequestStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('declined')
  declined
}

enum RequestType {
  @JsonValue('leave')
  leave,
  @JsonValue('timeoff')
  timeoff,
  @JsonValue('other')
  other
}

@freezed
class Request with _$Request {
  const factory Request({
    required String id,
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required RequestType type,
    required RequestStatus status,
    required String description,
    String? response,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Request;

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);
}
