import 'package:freezed_annotation/freezed_annotation.dart';

part 'communication_models.freezed.dart';
part 'communication_models.g.dart';

@freezed
abstract class Message with _$Message {
  const factory Message({
    required String messageId,
    required String senderId,
    required String recipientId,
    required String message,
    required String channel,
    required String sentAt,
    required String status,
    String? readAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required String conversationId,
    required String participantName,
    required String lastMessage,
    required String lastMessageTime,
    required int unreadCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
abstract class BroadcastMessage with _$BroadcastMessage {
  const factory BroadcastMessage({
    required String broadcastId,
    required int recipientCount,
    required String sentAt,
  }) = _BroadcastMessage;

  factory BroadcastMessage.fromJson(Map<String, dynamic> json) =>
      _$BroadcastMessageFromJson(json);
}

@freezed
abstract class ScheduledMessage with _$ScheduledMessage {
  const factory ScheduledMessage({
    required String scheduleId,
    required String message,
    required String scheduledFor,
    required String status,
  }) = _ScheduledMessage;

  factory ScheduledMessage.fromJson(Map<String, dynamic> json) =>
      _$ScheduledMessageFromJson(json);
}

@freezed
abstract class MessageTemplate with _$MessageTemplate {
  const factory MessageTemplate({
    required String templateId,
    required String name,
    required String content,
    required String category,
  }) = _MessageTemplate;

  factory MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateFromJson(json);
}

@freezed
abstract class MessageStatus with _$MessageStatus {
  const factory MessageStatus({
    required String messageId,
    required String status,
    String? deliveredAt,
    String? readAt,
  }) = _MessageStatus;

  factory MessageStatus.fromJson(Map<String, dynamic> json) =>
      _$MessageStatusFromJson(json);
}
