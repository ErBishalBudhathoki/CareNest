// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_checklist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ComplianceChecklist _$ComplianceChecklistFromJson(Map<String, dynamic> json) {
  return _ComplianceChecklist.fromJson(json);
}

/// @nodoc
mixin _$ComplianceChecklist {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<ChecklistItem> get items => throw _privateConstructorUsedError;
  List<String>? get targetRoles => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false)
  UserChecklistStatus? get userStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComplianceChecklistCopyWith<ComplianceChecklist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComplianceChecklistCopyWith<$Res> {
  factory $ComplianceChecklistCopyWith(
          ComplianceChecklist value, $Res Function(ComplianceChecklist) then) =
      _$ComplianceChecklistCopyWithImpl<$Res, ComplianceChecklist>;
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
class _$ComplianceChecklistCopyWithImpl<$Res, $Val extends ComplianceChecklist>
    implements $ComplianceChecklistCopyWith<$Res> {
  _$ComplianceChecklistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      targetRoles: freezed == targetRoles
          ? _value.targetRoles
          : targetRoles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userStatus: freezed == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserChecklistStatus?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserChecklistStatusCopyWith<$Res>? get userStatus {
    if (_value.userStatus == null) {
      return null;
    }

    return $UserChecklistStatusCopyWith<$Res>(_value.userStatus!, (value) {
      return _then(_value.copyWith(userStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComplianceChecklistImplCopyWith<$Res>
    implements $ComplianceChecklistCopyWith<$Res> {
  factory _$$ComplianceChecklistImplCopyWith(_$ComplianceChecklistImpl value,
          $Res Function(_$ComplianceChecklistImpl) then) =
      __$$ComplianceChecklistImplCopyWithImpl<$Res>;
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
class __$$ComplianceChecklistImplCopyWithImpl<$Res>
    extends _$ComplianceChecklistCopyWithImpl<$Res, _$ComplianceChecklistImpl>
    implements _$$ComplianceChecklistImplCopyWith<$Res> {
  __$$ComplianceChecklistImplCopyWithImpl(_$ComplianceChecklistImpl _value,
      $Res Function(_$ComplianceChecklistImpl) _then)
      : super(_value, _then);

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
    return _then(_$ComplianceChecklistImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChecklistItem>,
      targetRoles: freezed == targetRoles
          ? _value._targetRoles
          : targetRoles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      userStatus: freezed == userStatus
          ? _value.userStatus
          : userStatus // ignore: cast_nullable_to_non_nullable
              as UserChecklistStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComplianceChecklistImpl implements _ComplianceChecklist {
  const _$ComplianceChecklistImpl(
      {@JsonKey(name: '_id') this.id,
      required this.title,
      required this.description,
      required final List<ChecklistItem> items,
      final List<String>? targetRoles,
      @JsonKey(includeFromJson: false) this.userStatus})
      : _items = items,
        _targetRoles = targetRoles;

  factory _$ComplianceChecklistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComplianceChecklistImplFromJson(json);

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

  @override
  String toString() {
    return 'ComplianceChecklist(id: $id, title: $title, description: $description, items: $items, targetRoles: $targetRoles, userStatus: $userStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComplianceChecklistImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_targetRoles),
      userStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComplianceChecklistImplCopyWith<_$ComplianceChecklistImpl> get copyWith =>
      __$$ComplianceChecklistImplCopyWithImpl<_$ComplianceChecklistImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComplianceChecklistImplToJson(
      this,
    );
  }
}

abstract class _ComplianceChecklist implements ComplianceChecklist {
  const factory _ComplianceChecklist(
      {@JsonKey(name: '_id') final String? id,
      required final String title,
      required final String description,
      required final List<ChecklistItem> items,
      final List<String>? targetRoles,
      @JsonKey(includeFromJson: false)
      final UserChecklistStatus? userStatus}) = _$ComplianceChecklistImpl;

  factory _ComplianceChecklist.fromJson(Map<String, dynamic> json) =
      _$ComplianceChecklistImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<ChecklistItem> get items;
  @override
  List<String>? get targetRoles;
  @override
  @JsonKey(includeFromJson: false)
  UserChecklistStatus? get userStatus;
  @override
  @JsonKey(ignore: true)
  _$$ComplianceChecklistImplCopyWith<_$ComplianceChecklistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChecklistItem _$ChecklistItemFromJson(Map<String, dynamic> json) {
  return _ChecklistItem.fromJson(json);
}

/// @nodoc
mixin _$ChecklistItem {
  String get text => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChecklistItemCopyWith<ChecklistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistItemCopyWith<$Res> {
  factory $ChecklistItemCopyWith(
          ChecklistItem value, $Res Function(ChecklistItem) then) =
      _$ChecklistItemCopyWithImpl<$Res, ChecklistItem>;
  @useResult
  $Res call({String text, bool isRequired, @JsonKey(name: '_id') String? id});
}

/// @nodoc
class _$ChecklistItemCopyWithImpl<$Res, $Val extends ChecklistItem>
    implements $ChecklistItemCopyWith<$Res> {
  _$ChecklistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isRequired = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChecklistItemImplCopyWith<$Res>
    implements $ChecklistItemCopyWith<$Res> {
  factory _$$ChecklistItemImplCopyWith(
          _$ChecklistItemImpl value, $Res Function(_$ChecklistItemImpl) then) =
      __$$ChecklistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, bool isRequired, @JsonKey(name: '_id') String? id});
}

/// @nodoc
class __$$ChecklistItemImplCopyWithImpl<$Res>
    extends _$ChecklistItemCopyWithImpl<$Res, _$ChecklistItemImpl>
    implements _$$ChecklistItemImplCopyWith<$Res> {
  __$$ChecklistItemImplCopyWithImpl(
      _$ChecklistItemImpl _value, $Res Function(_$ChecklistItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? isRequired = null,
    Object? id = freezed,
  }) {
    return _then(_$ChecklistItemImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistItemImpl implements _ChecklistItem {
  const _$ChecklistItemImpl(
      {required this.text,
      this.isRequired = true,
      @JsonKey(name: '_id') this.id});

  factory _$ChecklistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistItemImplFromJson(json);

  @override
  final String text;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey(name: '_id')
  final String? id;

  @override
  String toString() {
    return 'ChecklistItem(text: $text, isRequired: $isRequired, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistItemImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, isRequired, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      __$$ChecklistItemImplCopyWithImpl<_$ChecklistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChecklistItemImplToJson(
      this,
    );
  }
}

abstract class _ChecklistItem implements ChecklistItem {
  const factory _ChecklistItem(
      {required final String text,
      final bool isRequired,
      @JsonKey(name: '_id') final String? id}) = _$ChecklistItemImpl;

  factory _ChecklistItem.fromJson(Map<String, dynamic> json) =
      _$ChecklistItemImpl.fromJson;

  @override
  String get text;
  @override
  bool get isRequired;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$ChecklistItemImplCopyWith<_$ChecklistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserChecklistStatus _$UserChecklistStatusFromJson(Map<String, dynamic> json) {
  return _UserChecklistStatus.fromJson(json);
}

/// @nodoc
mixin _$UserChecklistStatus {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get checklistId => throw _privateConstructorUsedError;
  Map<String, bool> get itemsStatus => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserChecklistStatusCopyWith<UserChecklistStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChecklistStatusCopyWith<$Res> {
  factory $UserChecklistStatusCopyWith(
          UserChecklistStatus value, $Res Function(UserChecklistStatus) then) =
      _$UserChecklistStatusCopyWithImpl<$Res, UserChecklistStatus>;
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
class _$UserChecklistStatusCopyWithImpl<$Res, $Val extends UserChecklistStatus>
    implements $UserChecklistStatusCopyWith<$Res> {
  _$UserChecklistStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      checklistId: null == checklistId
          ? _value.checklistId
          : checklistId // ignore: cast_nullable_to_non_nullable
              as String,
      itemsStatus: null == itemsStatus
          ? _value.itemsStatus
          : itemsStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserChecklistStatusImplCopyWith<$Res>
    implements $UserChecklistStatusCopyWith<$Res> {
  factory _$$UserChecklistStatusImplCopyWith(_$UserChecklistStatusImpl value,
          $Res Function(_$UserChecklistStatusImpl) then) =
      __$$UserChecklistStatusImplCopyWithImpl<$Res>;
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
class __$$UserChecklistStatusImplCopyWithImpl<$Res>
    extends _$UserChecklistStatusCopyWithImpl<$Res, _$UserChecklistStatusImpl>
    implements _$$UserChecklistStatusImplCopyWith<$Res> {
  __$$UserChecklistStatusImplCopyWithImpl(_$UserChecklistStatusImpl _value,
      $Res Function(_$UserChecklistStatusImpl) _then)
      : super(_value, _then);

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
    return _then(_$UserChecklistStatusImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      checklistId: null == checklistId
          ? _value.checklistId
          : checklistId // ignore: cast_nullable_to_non_nullable
              as String,
      itemsStatus: null == itemsStatus
          ? _value._itemsStatus
          : itemsStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChecklistStatusImpl implements _UserChecklistStatus {
  const _$UserChecklistStatusImpl(
      {@JsonKey(name: '_id') this.id,
      required this.userId,
      required this.checklistId,
      required final Map<String, bool> itemsStatus,
      required this.isCompleted,
      required this.lastUpdated})
      : _itemsStatus = itemsStatus;

  factory _$UserChecklistStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserChecklistStatusImplFromJson(json);

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

  @override
  String toString() {
    return 'UserChecklistStatus(id: $id, userId: $userId, checklistId: $checklistId, itemsStatus: $itemsStatus, isCompleted: $isCompleted, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChecklistStatusImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      checklistId,
      const DeepCollectionEquality().hash(_itemsStatus),
      isCompleted,
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChecklistStatusImplCopyWith<_$UserChecklistStatusImpl> get copyWith =>
      __$$UserChecklistStatusImplCopyWithImpl<_$UserChecklistStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChecklistStatusImplToJson(
      this,
    );
  }
}

abstract class _UserChecklistStatus implements UserChecklistStatus {
  const factory _UserChecklistStatus(
      {@JsonKey(name: '_id') final String? id,
      required final String userId,
      required final String checklistId,
      required final Map<String, bool> itemsStatus,
      required final bool isCompleted,
      required final DateTime lastUpdated}) = _$UserChecklistStatusImpl;

  factory _UserChecklistStatus.fromJson(Map<String, dynamic> json) =
      _$UserChecklistStatusImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get userId;
  @override
  String get checklistId;
  @override
  Map<String, bool> get itemsStatus;
  @override
  bool get isCompleted;
  @override
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$UserChecklistStatusImplCopyWith<_$UserChecklistStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
