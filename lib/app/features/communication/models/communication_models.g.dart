// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      messageId: json['messageId'] as String,
      senderId: json['senderId'] as String,
      recipientId: json['recipientId'] as String,
      message: json['message'] as String,
      channel: json['channel'] as String,
      sentAt: json['sentAt'] as String,
      status: json['status'] as String,
      readAt: json['readAt'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'recipientId': instance.recipientId,
      'message': instance.message,
      'channel': instance.channel,
      'sentAt': instance.sentAt,
      'status': instance.status,
      'readAt': instance.readAt,
    };

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      conversationId: json['conversationId'] as String,
      participantName: json['participantName'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTime: json['lastMessageTime'] as String,
      unreadCount: (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'participantName': instance.participantName,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime,
      'unreadCount': instance.unreadCount,
    };

_$BroadcastMessageImpl _$$BroadcastMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$BroadcastMessageImpl(
      broadcastId: json['broadcastId'] as String,
      recipientCount: (json['recipientCount'] as num).toInt(),
      sentAt: json['sentAt'] as String,
    );

Map<String, dynamic> _$$BroadcastMessageImplToJson(
        _$BroadcastMessageImpl instance) =>
    <String, dynamic>{
      'broadcastId': instance.broadcastId,
      'recipientCount': instance.recipientCount,
      'sentAt': instance.sentAt,
    };

_$ScheduledMessageImpl _$$ScheduledMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduledMessageImpl(
      scheduleId: json['scheduleId'] as String,
      message: json['message'] as String,
      scheduledFor: json['scheduledFor'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$ScheduledMessageImplToJson(
        _$ScheduledMessageImpl instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'message': instance.message,
      'scheduledFor': instance.scheduledFor,
      'status': instance.status,
    };

_$MessageTemplateImpl _$$MessageTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageTemplateImpl(
      templateId: json['templateId'] as String,
      name: json['name'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$$MessageTemplateImplToJson(
        _$MessageTemplateImpl instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'name': instance.name,
      'content': instance.content,
      'category': instance.category,
    };

_$MessageStatusImpl _$$MessageStatusImplFromJson(Map<String, dynamic> json) =>
    _$MessageStatusImpl(
      messageId: json['messageId'] as String,
      status: json['status'] as String,
      deliveredAt: json['deliveredAt'] as String?,
      readAt: json['readAt'] as String?,
    );

Map<String, dynamic> _$$MessageStatusImplToJson(_$MessageStatusImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'status': instance.status,
      'deliveredAt': instance.deliveredAt,
      'readAt': instance.readAt,
    };
