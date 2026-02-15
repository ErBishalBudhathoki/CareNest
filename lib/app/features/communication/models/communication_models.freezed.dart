// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get messageId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get recipientId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get sentAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get readAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String messageId,
      String senderId,
      String recipientId,
      String message,
      String channel,
      String sentAt,
      String status,
      String? readAt});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? senderId = null,
    Object? recipientId = null,
    Object? message = null,
    Object? channel = null,
    Object? sentAt = null,
    Object? status = null,
    Object? readAt = freezed,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String messageId,
      String senderId,
      String recipientId,
      String message,
      String channel,
      String sentAt,
      String status,
      String? readAt});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? senderId = null,
    Object? recipientId = null,
    Object? message = null,
    Object? channel = null,
    Object? sentAt = null,
    Object? status = null,
    Object? readAt = freezed,
  }) {
    return _then(_$MessageImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _value.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.messageId,
      required this.senderId,
      required this.recipientId,
      required this.message,
      required this.channel,
      required this.sentAt,
      required this.status,
      this.readAt});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String messageId;
  @override
  final String senderId;
  @override
  final String recipientId;
  @override
  final String message;
  @override
  final String channel;
  @override
  final String sentAt;
  @override
  final String status;
  @override
  final String? readAt;

  @override
  String toString() {
    return 'Message(messageId: $messageId, senderId: $senderId, recipientId: $recipientId, message: $message, channel: $channel, sentAt: $sentAt, status: $status, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.recipientId, recipientId) ||
                other.recipientId == recipientId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, senderId, recipientId,
      message, channel, sentAt, status, readAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String messageId,
      required final String senderId,
      required final String recipientId,
      required final String message,
      required final String channel,
      required final String sentAt,
      required final String status,
      final String? readAt}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get messageId;
  @override
  String get senderId;
  @override
  String get recipientId;
  @override
  String get message;
  @override
  String get channel;
  @override
  String get sentAt;
  @override
  String get status;
  @override
  String? get readAt;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get conversationId => throw _privateConstructorUsedError;
  String get participantName => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  String get lastMessageTime => throw _privateConstructorUsedError;
  int get unreadCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {String conversationId,
      String participantName,
      String lastMessage,
      String lastMessageTime,
      int unreadCount});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? participantName = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
  }) {
    return _then(_value.copyWith(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      participantName: null == participantName
          ? _value.participantName
          : participantName // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String conversationId,
      String participantName,
      String lastMessage,
      String lastMessageTime,
      int unreadCount});
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? participantName = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
  }) {
    return _then(_$ConversationImpl(
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      participantName: null == participantName
          ? _value.participantName
          : participantName // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {required this.conversationId,
      required this.participantName,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.unreadCount});

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String conversationId;
  @override
  final String participantName;
  @override
  final String lastMessage;
  @override
  final String lastMessageTime;
  @override
  final int unreadCount;

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, participantName: $participantName, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.participantName, participantName) ||
                other.participantName == participantName) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, conversationId, participantName,
      lastMessage, lastMessageTime, unreadCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {required final String conversationId,
      required final String participantName,
      required final String lastMessage,
      required final String lastMessageTime,
      required final int unreadCount}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get conversationId;
  @override
  String get participantName;
  @override
  String get lastMessage;
  @override
  String get lastMessageTime;
  @override
  int get unreadCount;
  @override
  @JsonKey(ignore: true)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BroadcastMessage _$BroadcastMessageFromJson(Map<String, dynamic> json) {
  return _BroadcastMessage.fromJson(json);
}

/// @nodoc
mixin _$BroadcastMessage {
  String get broadcastId => throw _privateConstructorUsedError;
  int get recipientCount => throw _privateConstructorUsedError;
  String get sentAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BroadcastMessageCopyWith<BroadcastMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BroadcastMessageCopyWith<$Res> {
  factory $BroadcastMessageCopyWith(
          BroadcastMessage value, $Res Function(BroadcastMessage) then) =
      _$BroadcastMessageCopyWithImpl<$Res, BroadcastMessage>;
  @useResult
  $Res call({String broadcastId, int recipientCount, String sentAt});
}

/// @nodoc
class _$BroadcastMessageCopyWithImpl<$Res, $Val extends BroadcastMessage>
    implements $BroadcastMessageCopyWith<$Res> {
  _$BroadcastMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? broadcastId = null,
    Object? recipientCount = null,
    Object? sentAt = null,
  }) {
    return _then(_value.copyWith(
      broadcastId: null == broadcastId
          ? _value.broadcastId
          : broadcastId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientCount: null == recipientCount
          ? _value.recipientCount
          : recipientCount // ignore: cast_nullable_to_non_nullable
              as int,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BroadcastMessageImplCopyWith<$Res>
    implements $BroadcastMessageCopyWith<$Res> {
  factory _$$BroadcastMessageImplCopyWith(_$BroadcastMessageImpl value,
          $Res Function(_$BroadcastMessageImpl) then) =
      __$$BroadcastMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String broadcastId, int recipientCount, String sentAt});
}

/// @nodoc
class __$$BroadcastMessageImplCopyWithImpl<$Res>
    extends _$BroadcastMessageCopyWithImpl<$Res, _$BroadcastMessageImpl>
    implements _$$BroadcastMessageImplCopyWith<$Res> {
  __$$BroadcastMessageImplCopyWithImpl(_$BroadcastMessageImpl _value,
      $Res Function(_$BroadcastMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? broadcastId = null,
    Object? recipientCount = null,
    Object? sentAt = null,
  }) {
    return _then(_$BroadcastMessageImpl(
      broadcastId: null == broadcastId
          ? _value.broadcastId
          : broadcastId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientCount: null == recipientCount
          ? _value.recipientCount
          : recipientCount // ignore: cast_nullable_to_non_nullable
              as int,
      sentAt: null == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BroadcastMessageImpl implements _BroadcastMessage {
  const _$BroadcastMessageImpl(
      {required this.broadcastId,
      required this.recipientCount,
      required this.sentAt});

  factory _$BroadcastMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$BroadcastMessageImplFromJson(json);

  @override
  final String broadcastId;
  @override
  final int recipientCount;
  @override
  final String sentAt;

  @override
  String toString() {
    return 'BroadcastMessage(broadcastId: $broadcastId, recipientCount: $recipientCount, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BroadcastMessageImpl &&
            (identical(other.broadcastId, broadcastId) ||
                other.broadcastId == broadcastId) &&
            (identical(other.recipientCount, recipientCount) ||
                other.recipientCount == recipientCount) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, broadcastId, recipientCount, sentAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BroadcastMessageImplCopyWith<_$BroadcastMessageImpl> get copyWith =>
      __$$BroadcastMessageImplCopyWithImpl<_$BroadcastMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BroadcastMessageImplToJson(
      this,
    );
  }
}

abstract class _BroadcastMessage implements BroadcastMessage {
  const factory _BroadcastMessage(
      {required final String broadcastId,
      required final int recipientCount,
      required final String sentAt}) = _$BroadcastMessageImpl;

  factory _BroadcastMessage.fromJson(Map<String, dynamic> json) =
      _$BroadcastMessageImpl.fromJson;

  @override
  String get broadcastId;
  @override
  int get recipientCount;
  @override
  String get sentAt;
  @override
  @JsonKey(ignore: true)
  _$$BroadcastMessageImplCopyWith<_$BroadcastMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduledMessage _$ScheduledMessageFromJson(Map<String, dynamic> json) {
  return _ScheduledMessage.fromJson(json);
}

/// @nodoc
mixin _$ScheduledMessage {
  String get scheduleId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get scheduledFor => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduledMessageCopyWith<ScheduledMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledMessageCopyWith<$Res> {
  factory $ScheduledMessageCopyWith(
          ScheduledMessage value, $Res Function(ScheduledMessage) then) =
      _$ScheduledMessageCopyWithImpl<$Res, ScheduledMessage>;
  @useResult
  $Res call(
      {String scheduleId, String message, String scheduledFor, String status});
}

/// @nodoc
class _$ScheduledMessageCopyWithImpl<$Res, $Val extends ScheduledMessage>
    implements $ScheduledMessageCopyWith<$Res> {
  _$ScheduledMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleId = null,
    Object? message = null,
    Object? scheduledFor = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledFor: null == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduledMessageImplCopyWith<$Res>
    implements $ScheduledMessageCopyWith<$Res> {
  factory _$$ScheduledMessageImplCopyWith(_$ScheduledMessageImpl value,
          $Res Function(_$ScheduledMessageImpl) then) =
      __$$ScheduledMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String scheduleId, String message, String scheduledFor, String status});
}

/// @nodoc
class __$$ScheduledMessageImplCopyWithImpl<$Res>
    extends _$ScheduledMessageCopyWithImpl<$Res, _$ScheduledMessageImpl>
    implements _$$ScheduledMessageImplCopyWith<$Res> {
  __$$ScheduledMessageImplCopyWithImpl(_$ScheduledMessageImpl _value,
      $Res Function(_$ScheduledMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleId = null,
    Object? message = null,
    Object? scheduledFor = null,
    Object? status = null,
  }) {
    return _then(_$ScheduledMessageImpl(
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledFor: null == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduledMessageImpl implements _ScheduledMessage {
  const _$ScheduledMessageImpl(
      {required this.scheduleId,
      required this.message,
      required this.scheduledFor,
      required this.status});

  factory _$ScheduledMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduledMessageImplFromJson(json);

  @override
  final String scheduleId;
  @override
  final String message;
  @override
  final String scheduledFor;
  @override
  final String status;

  @override
  String toString() {
    return 'ScheduledMessage(scheduleId: $scheduleId, message: $message, scheduledFor: $scheduledFor, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledMessageImpl &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, scheduleId, message, scheduledFor, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledMessageImplCopyWith<_$ScheduledMessageImpl> get copyWith =>
      __$$ScheduledMessageImplCopyWithImpl<_$ScheduledMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduledMessageImplToJson(
      this,
    );
  }
}

abstract class _ScheduledMessage implements ScheduledMessage {
  const factory _ScheduledMessage(
      {required final String scheduleId,
      required final String message,
      required final String scheduledFor,
      required final String status}) = _$ScheduledMessageImpl;

  factory _ScheduledMessage.fromJson(Map<String, dynamic> json) =
      _$ScheduledMessageImpl.fromJson;

  @override
  String get scheduleId;
  @override
  String get message;
  @override
  String get scheduledFor;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$ScheduledMessageImplCopyWith<_$ScheduledMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageTemplate _$MessageTemplateFromJson(Map<String, dynamic> json) {
  return _MessageTemplate.fromJson(json);
}

/// @nodoc
mixin _$MessageTemplate {
  String get templateId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageTemplateCopyWith<MessageTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageTemplateCopyWith<$Res> {
  factory $MessageTemplateCopyWith(
          MessageTemplate value, $Res Function(MessageTemplate) then) =
      _$MessageTemplateCopyWithImpl<$Res, MessageTemplate>;
  @useResult
  $Res call({String templateId, String name, String content, String category});
}

/// @nodoc
class _$MessageTemplateCopyWithImpl<$Res, $Val extends MessageTemplate>
    implements $MessageTemplateCopyWith<$Res> {
  _$MessageTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? name = null,
    Object? content = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageTemplateImplCopyWith<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  factory _$$MessageTemplateImplCopyWith(_$MessageTemplateImpl value,
          $Res Function(_$MessageTemplateImpl) then) =
      __$$MessageTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String templateId, String name, String content, String category});
}

/// @nodoc
class __$$MessageTemplateImplCopyWithImpl<$Res>
    extends _$MessageTemplateCopyWithImpl<$Res, _$MessageTemplateImpl>
    implements _$$MessageTemplateImplCopyWith<$Res> {
  __$$MessageTemplateImplCopyWithImpl(
      _$MessageTemplateImpl _value, $Res Function(_$MessageTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? name = null,
    Object? content = null,
    Object? category = null,
  }) {
    return _then(_$MessageTemplateImpl(
      templateId: null == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageTemplateImpl implements _MessageTemplate {
  const _$MessageTemplateImpl(
      {required this.templateId,
      required this.name,
      required this.content,
      required this.category});

  factory _$MessageTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageTemplateImplFromJson(json);

  @override
  final String templateId;
  @override
  final String name;
  @override
  final String content;
  @override
  final String category;

  @override
  String toString() {
    return 'MessageTemplate(templateId: $templateId, name: $name, content: $content, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageTemplateImpl &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, templateId, name, content, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageTemplateImplCopyWith<_$MessageTemplateImpl> get copyWith =>
      __$$MessageTemplateImplCopyWithImpl<_$MessageTemplateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageTemplateImplToJson(
      this,
    );
  }
}

abstract class _MessageTemplate implements MessageTemplate {
  const factory _MessageTemplate(
      {required final String templateId,
      required final String name,
      required final String content,
      required final String category}) = _$MessageTemplateImpl;

  factory _MessageTemplate.fromJson(Map<String, dynamic> json) =
      _$MessageTemplateImpl.fromJson;

  @override
  String get templateId;
  @override
  String get name;
  @override
  String get content;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$MessageTemplateImplCopyWith<_$MessageTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageStatus _$MessageStatusFromJson(Map<String, dynamic> json) {
  return _MessageStatus.fromJson(json);
}

/// @nodoc
mixin _$MessageStatus {
  String get messageId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get deliveredAt => throw _privateConstructorUsedError;
  String? get readAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageStatusCopyWith<MessageStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageStatusCopyWith<$Res> {
  factory $MessageStatusCopyWith(
          MessageStatus value, $Res Function(MessageStatus) then) =
      _$MessageStatusCopyWithImpl<$Res, MessageStatus>;
  @useResult
  $Res call(
      {String messageId, String status, String? deliveredAt, String? readAt});
}

/// @nodoc
class _$MessageStatusCopyWithImpl<$Res, $Val extends MessageStatus>
    implements $MessageStatusCopyWith<$Res> {
  _$MessageStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? status = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageStatusImplCopyWith<$Res>
    implements $MessageStatusCopyWith<$Res> {
  factory _$$MessageStatusImplCopyWith(
          _$MessageStatusImpl value, $Res Function(_$MessageStatusImpl) then) =
      __$$MessageStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String messageId, String status, String? deliveredAt, String? readAt});
}

/// @nodoc
class __$$MessageStatusImplCopyWithImpl<$Res>
    extends _$MessageStatusCopyWithImpl<$Res, _$MessageStatusImpl>
    implements _$$MessageStatusImplCopyWith<$Res> {
  __$$MessageStatusImplCopyWithImpl(
      _$MessageStatusImpl _value, $Res Function(_$MessageStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? status = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_$MessageStatusImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageStatusImpl implements _MessageStatus {
  const _$MessageStatusImpl(
      {required this.messageId,
      required this.status,
      this.deliveredAt,
      this.readAt});

  factory _$MessageStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageStatusImplFromJson(json);

  @override
  final String messageId;
  @override
  final String status;
  @override
  final String? deliveredAt;
  @override
  final String? readAt;

  @override
  String toString() {
    return 'MessageStatus(messageId: $messageId, status: $status, deliveredAt: $deliveredAt, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageStatusImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, messageId, status, deliveredAt, readAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageStatusImplCopyWith<_$MessageStatusImpl> get copyWith =>
      __$$MessageStatusImplCopyWithImpl<_$MessageStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageStatusImplToJson(
      this,
    );
  }
}

abstract class _MessageStatus implements MessageStatus {
  const factory _MessageStatus(
      {required final String messageId,
      required final String status,
      final String? deliveredAt,
      final String? readAt}) = _$MessageStatusImpl;

  factory _MessageStatus.fromJson(Map<String, dynamic> json) =
      _$MessageStatusImpl.fromJson;

  @override
  String get messageId;
  @override
  String get status;
  @override
  String? get deliveredAt;
  @override
  String? get readAt;
  @override
  @JsonKey(ignore: true)
  _$$MessageStatusImplCopyWith<_$MessageStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
