// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Message {
  String get messageId;
  String get senderId;
  String get recipientId;
  String get message;
  String get channel;
  String get sentAt;
  String get status;
  String? get readAt;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageCopyWith<Message> get copyWith =>
      _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Message &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, senderId, recipientId,
      message, channel, sentAt, status, readAt);

  @override
  String toString() {
    return 'Message(messageId: $messageId, senderId: $senderId, recipientId: $recipientId, message: $message, channel: $channel, sentAt: $sentAt, status: $status, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) =
      _$MessageCopyWithImpl;
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
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_self.copyWith(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _self.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _self.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Message value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Message() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Message value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Message():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Message value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Message() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String messageId,
            String senderId,
            String recipientId,
            String message,
            String channel,
            String sentAt,
            String status,
            String? readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Message() when $default != null:
        return $default(
            _that.messageId,
            _that.senderId,
            _that.recipientId,
            _that.message,
            _that.channel,
            _that.sentAt,
            _that.status,
            _that.readAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String messageId,
            String senderId,
            String recipientId,
            String message,
            String channel,
            String sentAt,
            String status,
            String? readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Message():
        return $default(
            _that.messageId,
            _that.senderId,
            _that.recipientId,
            _that.message,
            _that.channel,
            _that.sentAt,
            _that.status,
            _that.readAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String messageId,
            String senderId,
            String recipientId,
            String message,
            String channel,
            String sentAt,
            String status,
            String? readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Message() when $default != null:
        return $default(
            _that.messageId,
            _that.senderId,
            _that.recipientId,
            _that.message,
            _that.channel,
            _that.sentAt,
            _that.status,
            _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Message implements Message {
  const _Message(
      {required this.messageId,
      required this.senderId,
      required this.recipientId,
      required this.message,
      required this.channel,
      required this.sentAt,
      required this.status,
      this.readAt});
  factory _Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

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

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Message &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, senderId, recipientId,
      message, channel, sentAt, status, readAt);

  @override
  String toString() {
    return 'Message(messageId: $messageId, senderId: $senderId, recipientId: $recipientId, message: $message, channel: $channel, sentAt: $sentAt, status: $status, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) =
      __$MessageCopyWithImpl;
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
class __$MessageCopyWithImpl<$Res> implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Message(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientId: null == recipientId
          ? _self.recipientId
          : recipientId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _self.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      sentAt: null == sentAt
          ? _self.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Conversation {
  String get conversationId;
  String get participantName;
  String get lastMessage;
  String get lastMessageTime;
  int get unreadCount;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<Conversation> get copyWith =>
      _$ConversationCopyWithImpl<Conversation>(
          this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Conversation &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, conversationId, participantName,
      lastMessage, lastMessageTime, unreadCount);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, participantName: $participantName, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) _then) =
      _$ConversationCopyWithImpl;
  @useResult
  $Res call(
      {String conversationId,
      String participantName,
      String lastMessage,
      String lastMessageTime,
      int unreadCount});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? participantName = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
  }) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      participantName: null == participantName
          ? _self.participantName
          : participantName // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Conversation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Conversation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Conversation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String conversationId, String participantName,
            String lastMessage, String lastMessageTime, int unreadCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(_that.conversationId, _that.participantName,
            _that.lastMessage, _that.lastMessageTime, _that.unreadCount);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String conversationId, String participantName,
            String lastMessage, String lastMessageTime, int unreadCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation():
        return $default(_that.conversationId, _that.participantName,
            _that.lastMessage, _that.lastMessageTime, _that.unreadCount);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String conversationId, String participantName,
            String lastMessage, String lastMessageTime, int unreadCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(_that.conversationId, _that.participantName,
            _that.lastMessage, _that.lastMessageTime, _that.unreadCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Conversation implements Conversation {
  const _Conversation(
      {required this.conversationId,
      required this.participantName,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.unreadCount});
  factory _Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

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

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationCopyWith<_Conversation> get copyWith =>
      __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Conversation &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, conversationId, participantName,
      lastMessage, lastMessageTime, unreadCount);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, participantName: $participantName, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(
          _Conversation value, $Res Function(_Conversation) _then) =
      __$ConversationCopyWithImpl;
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
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? participantName = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
  }) {
    return _then(_Conversation(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      participantName: null == participantName
          ? _self.participantName
          : participantName // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$BroadcastMessage {
  String get broadcastId;
  int get recipientCount;
  String get sentAt;

  /// Create a copy of BroadcastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BroadcastMessageCopyWith<BroadcastMessage> get copyWith =>
      _$BroadcastMessageCopyWithImpl<BroadcastMessage>(
          this as BroadcastMessage, _$identity);

  /// Serializes this BroadcastMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BroadcastMessage &&
            (identical(other.broadcastId, broadcastId) ||
                other.broadcastId == broadcastId) &&
            (identical(other.recipientCount, recipientCount) ||
                other.recipientCount == recipientCount) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, broadcastId, recipientCount, sentAt);

  @override
  String toString() {
    return 'BroadcastMessage(broadcastId: $broadcastId, recipientCount: $recipientCount, sentAt: $sentAt)';
  }
}

/// @nodoc
abstract mixin class $BroadcastMessageCopyWith<$Res> {
  factory $BroadcastMessageCopyWith(
          BroadcastMessage value, $Res Function(BroadcastMessage) _then) =
      _$BroadcastMessageCopyWithImpl;
  @useResult
  $Res call({String broadcastId, int recipientCount, String sentAt});
}

/// @nodoc
class _$BroadcastMessageCopyWithImpl<$Res>
    implements $BroadcastMessageCopyWith<$Res> {
  _$BroadcastMessageCopyWithImpl(this._self, this._then);

  final BroadcastMessage _self;
  final $Res Function(BroadcastMessage) _then;

  /// Create a copy of BroadcastMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? broadcastId = null,
    Object? recipientCount = null,
    Object? sentAt = null,
  }) {
    return _then(_self.copyWith(
      broadcastId: null == broadcastId
          ? _self.broadcastId
          : broadcastId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientCount: null == recipientCount
          ? _self.recipientCount
          : recipientCount // ignore: cast_nullable_to_non_nullable
              as int,
      sentAt: null == sentAt
          ? _self.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BroadcastMessage].
extension BroadcastMessagePatterns on BroadcastMessage {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BroadcastMessage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BroadcastMessage() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BroadcastMessage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BroadcastMessage():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BroadcastMessage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BroadcastMessage() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String broadcastId, int recipientCount, String sentAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BroadcastMessage() when $default != null:
        return $default(_that.broadcastId, _that.recipientCount, _that.sentAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String broadcastId, int recipientCount, String sentAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BroadcastMessage():
        return $default(_that.broadcastId, _that.recipientCount, _that.sentAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String broadcastId, int recipientCount, String sentAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BroadcastMessage() when $default != null:
        return $default(_that.broadcastId, _that.recipientCount, _that.sentAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BroadcastMessage implements BroadcastMessage {
  const _BroadcastMessage(
      {required this.broadcastId,
      required this.recipientCount,
      required this.sentAt});
  factory _BroadcastMessage.fromJson(Map<String, dynamic> json) =>
      _$BroadcastMessageFromJson(json);

  @override
  final String broadcastId;
  @override
  final int recipientCount;
  @override
  final String sentAt;

  /// Create a copy of BroadcastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BroadcastMessageCopyWith<_BroadcastMessage> get copyWith =>
      __$BroadcastMessageCopyWithImpl<_BroadcastMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BroadcastMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BroadcastMessage &&
            (identical(other.broadcastId, broadcastId) ||
                other.broadcastId == broadcastId) &&
            (identical(other.recipientCount, recipientCount) ||
                other.recipientCount == recipientCount) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, broadcastId, recipientCount, sentAt);

  @override
  String toString() {
    return 'BroadcastMessage(broadcastId: $broadcastId, recipientCount: $recipientCount, sentAt: $sentAt)';
  }
}

/// @nodoc
abstract mixin class _$BroadcastMessageCopyWith<$Res>
    implements $BroadcastMessageCopyWith<$Res> {
  factory _$BroadcastMessageCopyWith(
          _BroadcastMessage value, $Res Function(_BroadcastMessage) _then) =
      __$BroadcastMessageCopyWithImpl;
  @override
  @useResult
  $Res call({String broadcastId, int recipientCount, String sentAt});
}

/// @nodoc
class __$BroadcastMessageCopyWithImpl<$Res>
    implements _$BroadcastMessageCopyWith<$Res> {
  __$BroadcastMessageCopyWithImpl(this._self, this._then);

  final _BroadcastMessage _self;
  final $Res Function(_BroadcastMessage) _then;

  /// Create a copy of BroadcastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? broadcastId = null,
    Object? recipientCount = null,
    Object? sentAt = null,
  }) {
    return _then(_BroadcastMessage(
      broadcastId: null == broadcastId
          ? _self.broadcastId
          : broadcastId // ignore: cast_nullable_to_non_nullable
              as String,
      recipientCount: null == recipientCount
          ? _self.recipientCount
          : recipientCount // ignore: cast_nullable_to_non_nullable
              as int,
      sentAt: null == sentAt
          ? _self.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ScheduledMessage {
  String get scheduleId;
  String get message;
  String get scheduledFor;
  String get status;

  /// Create a copy of ScheduledMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ScheduledMessageCopyWith<ScheduledMessage> get copyWith =>
      _$ScheduledMessageCopyWithImpl<ScheduledMessage>(
          this as ScheduledMessage, _$identity);

  /// Serializes this ScheduledMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScheduledMessage &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, scheduleId, message, scheduledFor, status);

  @override
  String toString() {
    return 'ScheduledMessage(scheduleId: $scheduleId, message: $message, scheduledFor: $scheduledFor, status: $status)';
  }
}

/// @nodoc
abstract mixin class $ScheduledMessageCopyWith<$Res> {
  factory $ScheduledMessageCopyWith(
          ScheduledMessage value, $Res Function(ScheduledMessage) _then) =
      _$ScheduledMessageCopyWithImpl;
  @useResult
  $Res call(
      {String scheduleId, String message, String scheduledFor, String status});
}

/// @nodoc
class _$ScheduledMessageCopyWithImpl<$Res>
    implements $ScheduledMessageCopyWith<$Res> {
  _$ScheduledMessageCopyWithImpl(this._self, this._then);

  final ScheduledMessage _self;
  final $Res Function(ScheduledMessage) _then;

  /// Create a copy of ScheduledMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleId = null,
    Object? message = null,
    Object? scheduledFor = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      scheduleId: null == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledFor: null == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ScheduledMessage].
extension ScheduledMessagePatterns on ScheduledMessage {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ScheduledMessage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScheduledMessage() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ScheduledMessage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduledMessage():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ScheduledMessage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduledMessage() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String scheduleId, String message, String scheduledFor,
            String status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ScheduledMessage() when $default != null:
        return $default(
            _that.scheduleId, _that.message, _that.scheduledFor, _that.status);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String scheduleId, String message, String scheduledFor,
            String status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduledMessage():
        return $default(
            _that.scheduleId, _that.message, _that.scheduledFor, _that.status);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String scheduleId, String message, String scheduledFor,
            String status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ScheduledMessage() when $default != null:
        return $default(
            _that.scheduleId, _that.message, _that.scheduledFor, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ScheduledMessage implements ScheduledMessage {
  const _ScheduledMessage(
      {required this.scheduleId,
      required this.message,
      required this.scheduledFor,
      required this.status});
  factory _ScheduledMessage.fromJson(Map<String, dynamic> json) =>
      _$ScheduledMessageFromJson(json);

  @override
  final String scheduleId;
  @override
  final String message;
  @override
  final String scheduledFor;
  @override
  final String status;

  /// Create a copy of ScheduledMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScheduledMessageCopyWith<_ScheduledMessage> get copyWith =>
      __$ScheduledMessageCopyWithImpl<_ScheduledMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ScheduledMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScheduledMessage &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, scheduleId, message, scheduledFor, status);

  @override
  String toString() {
    return 'ScheduledMessage(scheduleId: $scheduleId, message: $message, scheduledFor: $scheduledFor, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$ScheduledMessageCopyWith<$Res>
    implements $ScheduledMessageCopyWith<$Res> {
  factory _$ScheduledMessageCopyWith(
          _ScheduledMessage value, $Res Function(_ScheduledMessage) _then) =
      __$ScheduledMessageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String scheduleId, String message, String scheduledFor, String status});
}

/// @nodoc
class __$ScheduledMessageCopyWithImpl<$Res>
    implements _$ScheduledMessageCopyWith<$Res> {
  __$ScheduledMessageCopyWithImpl(this._self, this._then);

  final _ScheduledMessage _self;
  final $Res Function(_ScheduledMessage) _then;

  /// Create a copy of ScheduledMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? scheduleId = null,
    Object? message = null,
    Object? scheduledFor = null,
    Object? status = null,
  }) {
    return _then(_ScheduledMessage(
      scheduleId: null == scheduleId
          ? _self.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledFor: null == scheduledFor
          ? _self.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$MessageTemplate {
  String get templateId;
  String get name;
  String get content;
  String get category;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageTemplateCopyWith<MessageTemplate> get copyWith =>
      _$MessageTemplateCopyWithImpl<MessageTemplate>(
          this as MessageTemplate, _$identity);

  /// Serializes this MessageTemplate to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageTemplate &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, templateId, name, content, category);

  @override
  String toString() {
    return 'MessageTemplate(templateId: $templateId, name: $name, content: $content, category: $category)';
  }
}

/// @nodoc
abstract mixin class $MessageTemplateCopyWith<$Res> {
  factory $MessageTemplateCopyWith(
          MessageTemplate value, $Res Function(MessageTemplate) _then) =
      _$MessageTemplateCopyWithImpl;
  @useResult
  $Res call({String templateId, String name, String content, String category});
}

/// @nodoc
class _$MessageTemplateCopyWithImpl<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  _$MessageTemplateCopyWithImpl(this._self, this._then);

  final MessageTemplate _self;
  final $Res Function(MessageTemplate) _then;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? templateId = null,
    Object? name = null,
    Object? content = null,
    Object? category = null,
  }) {
    return _then(_self.copyWith(
      templateId: null == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageTemplate].
extension MessageTemplatePatterns on MessageTemplate {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageTemplate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageTemplate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MessageTemplate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String templateId, String name, String content, String category)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
        return $default(
            _that.templateId, _that.name, _that.content, _that.category);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String templateId, String name, String content, String category)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate():
        return $default(
            _that.templateId, _that.name, _that.content, _that.category);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String templateId, String name, String content, String category)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageTemplate() when $default != null:
        return $default(
            _that.templateId, _that.name, _that.content, _that.category);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageTemplate implements MessageTemplate {
  const _MessageTemplate(
      {required this.templateId,
      required this.name,
      required this.content,
      required this.category});
  factory _MessageTemplate.fromJson(Map<String, dynamic> json) =>
      _$MessageTemplateFromJson(json);

  @override
  final String templateId;
  @override
  final String name;
  @override
  final String content;
  @override
  final String category;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageTemplateCopyWith<_MessageTemplate> get copyWith =>
      __$MessageTemplateCopyWithImpl<_MessageTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageTemplateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageTemplate &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, templateId, name, content, category);

  @override
  String toString() {
    return 'MessageTemplate(templateId: $templateId, name: $name, content: $content, category: $category)';
  }
}

/// @nodoc
abstract mixin class _$MessageTemplateCopyWith<$Res>
    implements $MessageTemplateCopyWith<$Res> {
  factory _$MessageTemplateCopyWith(
          _MessageTemplate value, $Res Function(_MessageTemplate) _then) =
      __$MessageTemplateCopyWithImpl;
  @override
  @useResult
  $Res call({String templateId, String name, String content, String category});
}

/// @nodoc
class __$MessageTemplateCopyWithImpl<$Res>
    implements _$MessageTemplateCopyWith<$Res> {
  __$MessageTemplateCopyWithImpl(this._self, this._then);

  final _MessageTemplate _self;
  final $Res Function(_MessageTemplate) _then;

  /// Create a copy of MessageTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? templateId = null,
    Object? name = null,
    Object? content = null,
    Object? category = null,
  }) {
    return _then(_MessageTemplate(
      templateId: null == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$MessageStatus {
  String get messageId;
  String get status;
  String? get deliveredAt;
  String? get readAt;

  /// Create a copy of MessageStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageStatusCopyWith<MessageStatus> get copyWith =>
      _$MessageStatusCopyWithImpl<MessageStatus>(
          this as MessageStatus, _$identity);

  /// Serializes this MessageStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageStatus &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, messageId, status, deliveredAt, readAt);

  @override
  String toString() {
    return 'MessageStatus(messageId: $messageId, status: $status, deliveredAt: $deliveredAt, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageStatusCopyWith<$Res> {
  factory $MessageStatusCopyWith(
          MessageStatus value, $Res Function(MessageStatus) _then) =
      _$MessageStatusCopyWithImpl;
  @useResult
  $Res call(
      {String messageId, String status, String? deliveredAt, String? readAt});
}

/// @nodoc
class _$MessageStatusCopyWithImpl<$Res>
    implements $MessageStatusCopyWith<$Res> {
  _$MessageStatusCopyWithImpl(this._self, this._then);

  final MessageStatus _self;
  final $Res Function(MessageStatus) _then;

  /// Create a copy of MessageStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? status = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_self.copyWith(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deliveredAt: freezed == deliveredAt
          ? _self.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageStatus].
extension MessageStatusPatterns on MessageStatus {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageStatus() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageStatus():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MessageStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageStatus() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String messageId, String status, String? deliveredAt,
            String? readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageStatus() when $default != null:
        return $default(
            _that.messageId, _that.status, _that.deliveredAt, _that.readAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String messageId, String status, String? deliveredAt,
            String? readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageStatus():
        return $default(
            _that.messageId, _that.status, _that.deliveredAt, _that.readAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String messageId, String status, String? deliveredAt,
            String? readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageStatus() when $default != null:
        return $default(
            _that.messageId, _that.status, _that.deliveredAt, _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageStatus implements MessageStatus {
  const _MessageStatus(
      {required this.messageId,
      required this.status,
      this.deliveredAt,
      this.readAt});
  factory _MessageStatus.fromJson(Map<String, dynamic> json) =>
      _$MessageStatusFromJson(json);

  @override
  final String messageId;
  @override
  final String status;
  @override
  final String? deliveredAt;
  @override
  final String? readAt;

  /// Create a copy of MessageStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageStatusCopyWith<_MessageStatus> get copyWith =>
      __$MessageStatusCopyWithImpl<_MessageStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageStatus &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, messageId, status, deliveredAt, readAt);

  @override
  String toString() {
    return 'MessageStatus(messageId: $messageId, status: $status, deliveredAt: $deliveredAt, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageStatusCopyWith<$Res>
    implements $MessageStatusCopyWith<$Res> {
  factory _$MessageStatusCopyWith(
          _MessageStatus value, $Res Function(_MessageStatus) _then) =
      __$MessageStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String messageId, String status, String? deliveredAt, String? readAt});
}

/// @nodoc
class __$MessageStatusCopyWithImpl<$Res>
    implements _$MessageStatusCopyWith<$Res> {
  __$MessageStatusCopyWithImpl(this._self, this._then);

  final _MessageStatus _self;
  final $Res Function(_MessageStatus) _then;

  /// Create a copy of MessageStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messageId = null,
    Object? status = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
  }) {
    return _then(_MessageStatus(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      deliveredAt: freezed == deliveredAt
          ? _self.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
