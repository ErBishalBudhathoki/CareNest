// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_checklist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComplianceChecklist {
  @JsonKey(name: '_id')
  String? get id;
  String get title;
  String get description;
  List<ChecklistItem> get items;
  List<String>? get targetRoles;
  @JsonKey(includeFromJson: false)
  UserChecklistStatus? get userStatus;

  /// Create a copy of ComplianceChecklist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComplianceChecklistCopyWith<ComplianceChecklist> get copyWith =>
      _$ComplianceChecklistCopyWithImpl<ComplianceChecklist>(
          this as ComplianceChecklist, _$identity);

  /// Serializes this ComplianceChecklist to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComplianceChecklist &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            const DeepCollectionEquality()
                .equals(other.targetRoles, targetRoles) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(items),
      const DeepCollectionEquality().hash(targetRoles),
      userStatus);

  @override
  String toString() {
    return 'ComplianceChecklist(id: $id, title: $title, description: $description, items: $items, targetRoles: $targetRoles, userStatus: $userStatus)';
  }
}

/// @nodoc
abstract mixin class $ComplianceChecklistCopyWith<$Res> {
  factory $ComplianceChecklistCopyWith(
          ComplianceChecklist value, $Res Function(ComplianceChecklist) _then) =
      _$ComplianceChecklistCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String title,
      String description,
      List<ChecklistItem> items,
      List<String>? targetRoles,
      @JsonKey(includeFromJson: false) UserChecklistStatus? userStatus});

  $UserChecklistStatusCopyWith<$Res>? get userStatus;
}

/// @nodoc
class _$ComplianceChecklistCopyWithImpl<$Res>
    implements $ComplianceChecklistCopyWith<$Res> {
  _$ComplianceChecklistCopyWithImpl(this._self, this._then);

  final ComplianceChecklist _self;
  final $Res Function(ComplianceChecklist) _then;

  /// Create a copy of ComplianceChecklist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? items = null,
    Object? targetRoles = freezed,
    Object? userStatus = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      targetRoles: freezed == targetRoles
          ? _self.targetRoles
          : targetRoles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userStatus: freezed == userStatus
          ? _self.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserChecklistStatus?,
    ));
  }

  /// Create a copy of ComplianceChecklist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserChecklistStatusCopyWith<$Res>? get userStatus {
    if (_self.userStatus == null) {
      return null;
    }

    return $UserChecklistStatusCopyWith<$Res>(_self.userStatus!, (value) {
      return _then(_self.copyWith(userStatus: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ComplianceChecklist].
extension ComplianceChecklistPatterns on ComplianceChecklist {
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
    TResult Function(_ComplianceChecklist value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceChecklist() when $default != null:
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
    TResult Function(_ComplianceChecklist value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceChecklist():
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
    TResult? Function(_ComplianceChecklist value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceChecklist() when $default != null:
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
            @JsonKey(name: '_id') String? id,
            String title,
            String description,
            List<ChecklistItem> items,
            List<String>? targetRoles,
            @JsonKey(includeFromJson: false) UserChecklistStatus? userStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ComplianceChecklist() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.items,
            _that.targetRoles, _that.userStatus);
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
            @JsonKey(name: '_id') String? id,
            String title,
            String description,
            List<ChecklistItem> items,
            List<String>? targetRoles,
            @JsonKey(includeFromJson: false) UserChecklistStatus? userStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceChecklist():
        return $default(_that.id, _that.title, _that.description, _that.items,
            _that.targetRoles, _that.userStatus);
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
            @JsonKey(name: '_id') String? id,
            String title,
            String description,
            List<ChecklistItem> items,
            List<String>? targetRoles,
            @JsonKey(includeFromJson: false) UserChecklistStatus? userStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ComplianceChecklist() when $default != null:
        return $default(_that.id, _that.title, _that.description, _that.items,
            _that.targetRoles, _that.userStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ComplianceChecklist implements ComplianceChecklist {
  const _ComplianceChecklist(
      {@JsonKey(name: '_id') this.id,
      required this.title,
      required this.description,
      required final List<ChecklistItem> items,
      final List<String>? targetRoles,
      @JsonKey(includeFromJson: false) this.userStatus})
      : _items = items,
        _targetRoles = targetRoles;
  factory _ComplianceChecklist.fromJson(Map<String, dynamic> json) =>
      _$ComplianceChecklistFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String title;
  @override
  final String description;
  final List<ChecklistItem> _items;
  @override
  List<ChecklistItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String>? _targetRoles;
  @override
  List<String>? get targetRoles {
    final value = _targetRoles;
    if (value == null) return null;
    if (_targetRoles is EqualUnmodifiableListView) return _targetRoles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(includeFromJson: false)
  final UserChecklistStatus? userStatus;

  /// Create a copy of ComplianceChecklist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComplianceChecklistCopyWith<_ComplianceChecklist> get copyWith =>
      __$ComplianceChecklistCopyWithImpl<_ComplianceChecklist>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComplianceChecklistToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComplianceChecklist &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality()
                .equals(other._targetRoles, _targetRoles) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_targetRoles),
      userStatus);

  @override
  String toString() {
    return 'ComplianceChecklist(id: $id, title: $title, description: $description, items: $items, targetRoles: $targetRoles, userStatus: $userStatus)';
  }
}

/// @nodoc
abstract mixin class _$ComplianceChecklistCopyWith<$Res>
    implements $ComplianceChecklistCopyWith<$Res> {
  factory _$ComplianceChecklistCopyWith(_ComplianceChecklist value,
          $Res Function(_ComplianceChecklist) _then) =
      __$ComplianceChecklistCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String title,
      String description,
      List<ChecklistItem> items,
      List<String>? targetRoles,
      @JsonKey(includeFromJson: false) UserChecklistStatus? userStatus});

  @override
  $UserChecklistStatusCopyWith<$Res>? get userStatus;
}

/// @nodoc
class __$ComplianceChecklistCopyWithImpl<$Res>
    implements _$ComplianceChecklistCopyWith<$Res> {
  __$ComplianceChecklistCopyWithImpl(this._self, this._then);

  final _ComplianceChecklist _self;
  final $Res Function(_ComplianceChecklist) _then;

  /// Create a copy of ComplianceChecklist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? items = null,
    Object? targetRoles = freezed,
    Object? userStatus = freezed,
  }) {
    return _then(_ComplianceChecklist(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      targetRoles: freezed == targetRoles
          ? _self._targetRoles
          : targetRoles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userStatus: freezed == userStatus
          ? _self.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserChecklistStatus?,
    ));
  }

  /// Create a copy of ComplianceChecklist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserChecklistStatusCopyWith<$Res>? get userStatus {
    if (_self.userStatus == null) {
      return null;
    }

    return $UserChecklistStatusCopyWith<$Res>(_self.userStatus!, (value) {
      return _then(_self.copyWith(userStatus: value));
    });
  }
}

/// @nodoc
mixin _$ChecklistItem {
  String get text;
  bool get isRequired;
  @JsonKey(name: '_id')
  String? get id;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChecklistItemCopyWith<ChecklistItem> get copyWith =>
      _$ChecklistItemCopyWithImpl<ChecklistItem>(
          this as ChecklistItem, _$identity);

  /// Serializes this ChecklistItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChecklistItem &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, isRequired, id);

  @override
  String toString() {
    return 'ChecklistItem(text: $text, isRequired: $isRequired, id: $id)';
  }
}

/// @nodoc
abstract mixin class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
          ChecklistItem value, $Res Function(ChecklistItem) _then) =
      _$ChecklistItemCopyWithImpl;
  @useResult
  $Res call({String text, bool isRequired, @JsonKey(name: '_id') String? id});
}

/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._self, this._then);

  final ChecklistItem _self;
  final $Res Function(ChecklistItem) _then;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isRequired = null,
    Object? id = freezed,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChecklistItem].
extension ChecklistItemPatterns on ChecklistItem {
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
    TResult Function(_ChecklistItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
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
    TResult Function(_ChecklistItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem():
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
    TResult? Function(_ChecklistItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
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
            String text, bool isRequired, @JsonKey(name: '_id') String? id)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that.text, _that.isRequired, _that.id);
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
            String text, bool isRequired, @JsonKey(name: '_id') String? id)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem():
        return $default(_that.text, _that.isRequired, _that.id);
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
            String text, bool isRequired, @JsonKey(name: '_id') String? id)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChecklistItem() when $default != null:
        return $default(_that.text, _that.isRequired, _that.id);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChecklistItem implements ChecklistItem {
  const _ChecklistItem(
      {required this.text,
      this.isRequired = true,
      @JsonKey(name: '_id') this.id});
  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);

  @override
  final String text;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey(name: '_id')
  final String? id;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChecklistItemCopyWith<_ChecklistItem> get copyWith =>
      __$ChecklistItemCopyWithImpl<_ChecklistItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChecklistItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChecklistItem &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, isRequired, id);

  @override
  String toString() {
    return 'ChecklistItem(text: $text, isRequired: $isRequired, id: $id)';
  }
}

/// @nodoc
abstract mixin class _$ChecklistItemCopyWith<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  factory _$ChecklistItemCopyWith(
          _ChecklistItem value, $Res Function(_ChecklistItem) _then) =
      __$ChecklistItemCopyWithImpl;
  @override
  @useResult
  $Res call({String text, bool isRequired, @JsonKey(name: '_id') String? id});
}

/// @nodoc
class __$ChecklistItemCopyWithImpl<$Res>
    implements _$ChecklistItemCopyWith<$Res> {
  __$ChecklistItemCopyWithImpl(this._self, this._then);

  final _ChecklistItem _self;
  final $Res Function(_ChecklistItem) _then;

  /// Create a copy of ChecklistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? isRequired = null,
    Object? id = freezed,
  }) {
    return _then(_ChecklistItem(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$UserChecklistStatus {
  @JsonKey(name: '_id')
  String? get id;
  String get userId;
  String get checklistId;
  Map<String, bool> get itemsStatus;
  bool get isCompleted;
  DateTime get lastUpdated;

  /// Create a copy of UserChecklistStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserChecklistStatusCopyWith<UserChecklistStatus> get copyWith =>
      _$UserChecklistStatusCopyWithImpl<UserChecklistStatus>(
          this as UserChecklistStatus, _$identity);

  /// Serializes this UserChecklistStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserChecklistStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.checklistId, checklistId) ||
                other.checklistId == checklistId) &&
            const DeepCollectionEquality()
                .equals(other.itemsStatus, itemsStatus) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      checklistId,
      const DeepCollectionEquality().hash(itemsStatus),
      isCompleted,
      lastUpdated);

  @override
  String toString() {
    return 'UserChecklistStatus(id: $id, userId: $userId, checklistId: $checklistId, itemsStatus: $itemsStatus, isCompleted: $isCompleted, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class $UserChecklistStatusCopyWith<$Res> {
  factory $UserChecklistStatusCopyWith(
          UserChecklistStatus value, $Res Function(UserChecklistStatus) _then) =
      _$UserChecklistStatusCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String checklistId,
      Map<String, bool> itemsStatus,
      bool isCompleted,
      DateTime lastUpdated});
}

/// @nodoc
class _$UserChecklistStatusCopyWithImpl<$Res>
    implements $UserChecklistStatusCopyWith<$Res> {
  _$UserChecklistStatusCopyWithImpl(this._self, this._then);

  final UserChecklistStatus _self;
  final $Res Function(UserChecklistStatus) _then;

  /// Create a copy of UserChecklistStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? checklistId = null,
    Object? itemsStatus = null,
    Object? isCompleted = null,
    Object? lastUpdated = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      checklistId: null == checklistId
          ? _self.checklistId
          : checklistId // ignore: cast_nullable_to_non_nullable
              as String,
      itemsStatus: null == itemsStatus
          ? _self.itemsStatus
          : itemsStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserChecklistStatus].
extension UserChecklistStatusPatterns on UserChecklistStatus {
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
    TResult Function(_UserChecklistStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserChecklistStatus() when $default != null:
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
    TResult Function(_UserChecklistStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserChecklistStatus():
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
    TResult? Function(_UserChecklistStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserChecklistStatus() when $default != null:
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
            @JsonKey(name: '_id') String? id,
            String userId,
            String checklistId,
            Map<String, bool> itemsStatus,
            bool isCompleted,
            DateTime lastUpdated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserChecklistStatus() when $default != null:
        return $default(_that.id, _that.userId, _that.checklistId,
            _that.itemsStatus, _that.isCompleted, _that.lastUpdated);
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
            @JsonKey(name: '_id') String? id,
            String userId,
            String checklistId,
            Map<String, bool> itemsStatus,
            bool isCompleted,
            DateTime lastUpdated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserChecklistStatus():
        return $default(_that.id, _that.userId, _that.checklistId,
            _that.itemsStatus, _that.isCompleted, _that.lastUpdated);
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
            @JsonKey(name: '_id') String? id,
            String userId,
            String checklistId,
            Map<String, bool> itemsStatus,
            bool isCompleted,
            DateTime lastUpdated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserChecklistStatus() when $default != null:
        return $default(_that.id, _that.userId, _that.checklistId,
            _that.itemsStatus, _that.isCompleted, _that.lastUpdated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserChecklistStatus implements UserChecklistStatus {
  const _UserChecklistStatus(
      {@JsonKey(name: '_id') this.id,
      required this.userId,
      required this.checklistId,
      required final Map<String, bool> itemsStatus,
      required this.isCompleted,
      required this.lastUpdated})
      : _itemsStatus = itemsStatus;
  factory _UserChecklistStatus.fromJson(Map<String, dynamic> json) =>
      _$UserChecklistStatusFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String userId;
  @override
  final String checklistId;
  final Map<String, bool> _itemsStatus;
  @override
  Map<String, bool> get itemsStatus {
    if (_itemsStatus is EqualUnmodifiableMapView) return _itemsStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_itemsStatus);
  }

  @override
  final bool isCompleted;
  @override
  final DateTime lastUpdated;

  /// Create a copy of UserChecklistStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserChecklistStatusCopyWith<_UserChecklistStatus> get copyWith =>
      __$UserChecklistStatusCopyWithImpl<_UserChecklistStatus>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserChecklistStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserChecklistStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.checklistId, checklistId) ||
                other.checklistId == checklistId) &&
            const DeepCollectionEquality()
                .equals(other._itemsStatus, _itemsStatus) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      checklistId,
      const DeepCollectionEquality().hash(_itemsStatus),
      isCompleted,
      lastUpdated);

  @override
  String toString() {
    return 'UserChecklistStatus(id: $id, userId: $userId, checklistId: $checklistId, itemsStatus: $itemsStatus, isCompleted: $isCompleted, lastUpdated: $lastUpdated)';
  }
}

/// @nodoc
abstract mixin class _$UserChecklistStatusCopyWith<$Res>
    implements $UserChecklistStatusCopyWith<$Res> {
  factory _$UserChecklistStatusCopyWith(_UserChecklistStatus value,
          $Res Function(_UserChecklistStatus) _then) =
      __$UserChecklistStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String checklistId,
      Map<String, bool> itemsStatus,
      bool isCompleted,
      DateTime lastUpdated});
}

/// @nodoc
class __$UserChecklistStatusCopyWithImpl<$Res>
    implements _$UserChecklistStatusCopyWith<$Res> {
  __$UserChecklistStatusCopyWithImpl(this._self, this._then);

  final _UserChecklistStatus _self;
  final $Res Function(_UserChecklistStatus) _then;

  /// Create a copy of UserChecklistStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? checklistId = null,
    Object? itemsStatus = null,
    Object? isCompleted = null,
    Object? lastUpdated = null,
  }) {
    return _then(_UserChecklistStatus(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      checklistId: null == checklistId
          ? _self.checklistId
          : checklistId // ignore: cast_nullable_to_non_nullable
              as String,
      itemsStatus: null == itemsStatus
          ? _self._itemsStatus
          : itemsStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _self.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
