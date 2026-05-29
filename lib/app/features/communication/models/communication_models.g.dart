// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  messageId: json['messageId'] as String,
  senderId: json['senderId'] as String,
  recipientId: json['recipientId'] as String,
  message: json['message'] as String,
  channel: json['channel'] as String,
  sentAt: json['sentAt'] as String,
  status: json['status'] as String,
  readAt: json['readAt'] as String?,
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'messageId': instance.messageId,
  'senderId': instance.senderId,
  'recipientId': instance.recipientId,
  'message': instance.message,
  'channel': instance.channel,
  'sentAt': instance.sentAt,
  'status': instance.status,
  'readAt': instance.readAt,
};

_Conversation _$ConversationFromJson(Map<String, dynamic> json) =>
    _Conversation(
      conversationId: json['conversationId'] as String,
      participantName: json['participantName'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: json['lastMessageTime'] as String,
      unreadCount: (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$ConversationToJson(_Conversation instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'participantName': instance.participantName,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'unreadCount': instance.unreadCount,
    };

_BroadcastMessage _$BroadcastMessageFromJson(Map<String, dynamic> json) =>
    _BroadcastMessage(
      broadcastId: json['broadcastId'] as String,
      recipientCount: (json['recipientCount'] as num).toInt(),
      sentAt: json['sentAt'] as String,
    );

Map<String, dynamic> _$BroadcastMessageToJson(_BroadcastMessage instance) =>
    <String, dynamic>{
      'broadcastId': instance.broadcastId,
      'recipientCount': instance.recipientCount,
      'sentAt': instance.sentAt,
    };

_ScheduledMessage _$ScheduledMessageFromJson(Map<String, dynamic> json) =>
    _ScheduledMessage(
      scheduleId: json['scheduleId'] as String,
      message: json['message'] as String,
      scheduledFor: json['scheduledFor'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ScheduledMessageToJson(_ScheduledMessage instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'message': instance.message,
      'scheduledFor': instance.scheduledFor,
      'status': instance.status,
    };

_MessageTemplate _$MessageTemplateFromJson(Map<String, dynamic> json) =>
    _MessageTemplate(
      templateId: json['templateId'] as String,
      name: json['name'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$MessageTemplateToJson(_MessageTemplate instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'name': instance.name,
      'content': instance.content,
      'category': instance.category,
    };

_MessageStatus _$MessageStatusFromJson(Map<String, dynamic> json) =>
    _MessageStatus(
      messageId: json['messageId'] as String,
      status: json['status'] as String,
      deliveredAt: json['deliveredAt'] as String?,
      readAt: json['readAt'] as String?,
    );

Map<String, dynamic> _$MessageStatusToJson(_MessageStatus instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'status': instance.status,
      'deliveredAt': instance.deliveredAt,
      'readAt': instance.readAt,
    };
