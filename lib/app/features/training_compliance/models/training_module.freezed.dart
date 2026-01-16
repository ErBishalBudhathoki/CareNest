// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_module.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrainingModule _$TrainingModuleFromJson(Map<String, dynamic> json) {
  return _TrainingModule.fromJson(json);
}

/// @nodoc
mixin _$TrainingModule {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  String? get contentUrl => throw _privateConstructorUsedError;
  String? get contentText => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  bool get isPublished => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false)
  TrainingProgress? get userProgress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingModuleCopyWith<TrainingModule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingModuleCopyWith<$Res> {
  factory $TrainingModuleCopyWith(
          TrainingModule value, $Res Function(TrainingModule) then) =
      _$TrainingModuleCopyWithImpl<$Res, TrainingModule>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String title,
      String description,
      String contentType,
      String? contentUrl,
      String? contentText,
      int durationMinutes,
      bool isPublished,
      String createdBy,
      DateTime createdAt,
      DateTime updatedAt,
      @JsonKey(includeFromJson: false) TrainingProgress? userProgress});

  $TrainingProgressCopyWith<$Res>? get userProgress;
}

/// @nodoc
class _$TrainingModuleCopyWithImpl<$Res, $Val extends TrainingModule>
    implements $TrainingModuleCopyWith<$Res> {
  _$TrainingModuleCopyWithImpl(this._value, this._then);

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
    Object? contentType = null,
    Object? contentUrl = freezed,
    Object? contentText = freezed,
    Object? durationMinutes = null,
    Object? isPublished = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userProgress = freezed,
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
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      contentUrl: freezed == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentText: freezed == contentText
          ? _value.contentText
          : contentText // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userProgress: freezed == userProgress
          ? _value.userProgress
          : userProgress // ignore: cast_nullable_to_non_nullable
              as TrainingProgress?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrainingProgressCopyWith<$Res>? get userProgress {
    if (_value.userProgress == null) {
      return null;
    }

    return $TrainingProgressCopyWith<$Res>(_value.userProgress!, (value) {
      return _then(_value.copyWith(userProgress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrainingModuleImplCopyWith<$Res>
    implements $TrainingModuleCopyWith<$Res> {
  factory _$$TrainingModuleImplCopyWith(_$TrainingModuleImpl value,
          $Res Function(_$TrainingModuleImpl) then) =
      __$$TrainingModuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String title,
      String description,
      String contentType,
      String? contentUrl,
      String? contentText,
      int durationMinutes,
      bool isPublished,
      String createdBy,
      DateTime createdAt,
      DateTime updatedAt,
      @JsonKey(includeFromJson: false) TrainingProgress? userProgress});

  @override
  $TrainingProgressCopyWith<$Res>? get userProgress;
}

/// @nodoc
class __$$TrainingModuleImplCopyWithImpl<$Res>
    extends _$TrainingModuleCopyWithImpl<$Res, _$TrainingModuleImpl>
    implements _$$TrainingModuleImplCopyWith<$Res> {
  __$$TrainingModuleImplCopyWithImpl(
      _$TrainingModuleImpl _value, $Res Function(_$TrainingModuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? contentType = null,
    Object? contentUrl = freezed,
    Object? contentText = freezed,
    Object? durationMinutes = null,
    Object? isPublished = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userProgress = freezed,
  }) {
    return _then(_$TrainingModuleImpl(
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
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      contentUrl: freezed == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentText: freezed == contentText
          ? _value.contentText
          : contentText // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMinutes: null == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userProgress: freezed == userProgress
          ? _value.userProgress
          : userProgress // ignore: cast_nullable_to_non_nullable
              as TrainingProgress?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingModuleImpl implements _TrainingModule {
  const _$TrainingModuleImpl(
      {@JsonKey(name: '_id') this.id,
      required this.title,
      required this.description,
      required this.contentType,
      this.contentUrl,
      this.contentText,
      required this.durationMinutes,
      this.isPublished = true,
      required this.createdBy,
      required this.createdAt,
      required this.updatedAt,
      @JsonKey(includeFromJson: false) this.userProgress});

  factory _$TrainingModuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingModuleImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String contentType;
  @override
  final String? contentUrl;
  @override
  final String? contentText;
  @override
  final int durationMinutes;
  @override
  @JsonKey()
  final bool isPublished;
  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey(includeFromJson: false)
  final TrainingProgress? userProgress;

  @override
  String toString() {
    return 'TrainingModule(id: $id, title: $title, description: $description, contentType: $contentType, contentUrl: $contentUrl, contentText: $contentText, durationMinutes: $durationMinutes, isPublished: $isPublished, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, userProgress: $userProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingModuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.contentUrl, contentUrl) ||
                other.contentUrl == contentUrl) &&
            (identical(other.contentText, contentText) ||
                other.contentText == contentText) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userProgress, userProgress) ||
                other.userProgress == userProgress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      contentType,
      contentUrl,
      contentText,
      durationMinutes,
      isPublished,
      createdBy,
      createdAt,
      updatedAt,
      userProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingModuleImplCopyWith<_$TrainingModuleImpl> get copyWith =>
      __$$TrainingModuleImplCopyWithImpl<_$TrainingModuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingModuleImplToJson(
      this,
    );
  }
}

abstract class _TrainingModule implements TrainingModule {
  const factory _TrainingModule(
      {@JsonKey(name: '_id') final String? id,
      required final String title,
      required final String description,
      required final String contentType,
      final String? contentUrl,
      final String? contentText,
      required final int durationMinutes,
      final bool isPublished,
      required final String createdBy,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      @JsonKey(includeFromJson: false)
      final TrainingProgress? userProgress}) = _$TrainingModuleImpl;

  factory _TrainingModule.fromJson(Map<String, dynamic> json) =
      _$TrainingModuleImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get contentType;
  @override
  String? get contentUrl;
  @override
  String? get contentText;
  @override
  int get durationMinutes;
  @override
  bool get isPublished;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(includeFromJson: false)
  TrainingProgress? get userProgress;
  @override
  @JsonKey(ignore: true)
  _$$TrainingModuleImplCopyWith<_$TrainingModuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrainingProgress _$TrainingProgressFromJson(Map<String, dynamic> json) {
  return _TrainingProgress.fromJson(json);
}

/// @nodoc
mixin _$TrainingProgress {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get moduleId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get progressPercentage => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingProgressCopyWith<TrainingProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingProgressCopyWith<$Res> {
  factory $TrainingProgressCopyWith(
          TrainingProgress value, $Res Function(TrainingProgress) then) =
      _$TrainingProgressCopyWithImpl<$Res, TrainingProgress>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String moduleId,
      String status,
      int progressPercentage,
      DateTime? completedAt});
}

/// @nodoc
class _$TrainingProgressCopyWithImpl<$Res, $Val extends TrainingProgress>
    implements $TrainingProgressCopyWith<$Res> {
  _$TrainingProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? moduleId = null,
    Object? status = null,
    Object? progressPercentage = null,
    Object? completedAt = freezed,
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
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingProgressImplCopyWith<$Res>
    implements $TrainingProgressCopyWith<$Res> {
  factory _$$TrainingProgressImplCopyWith(_$TrainingProgressImpl value,
          $Res Function(_$TrainingProgressImpl) then) =
      __$$TrainingProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String userId,
      String moduleId,
      String status,
      int progressPercentage,
      DateTime? completedAt});
}

/// @nodoc
class __$$TrainingProgressImplCopyWithImpl<$Res>
    extends _$TrainingProgressCopyWithImpl<$Res, _$TrainingProgressImpl>
    implements _$$TrainingProgressImplCopyWith<$Res> {
  __$$TrainingProgressImplCopyWithImpl(_$TrainingProgressImpl _value,
      $Res Function(_$TrainingProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? moduleId = null,
    Object? status = null,
    Object? progressPercentage = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$TrainingProgressImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingProgressImpl implements _TrainingProgress {
  const _$TrainingProgressImpl(
      {@JsonKey(name: '_id') this.id,
      required this.userId,
      required this.moduleId,
      required this.status,
      required this.progressPercentage,
      this.completedAt});

  factory _$TrainingProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingProgressImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String userId;
  @override
  final String moduleId;
  @override
  final String status;
  @override
  final int progressPercentage;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'TrainingProgress(id: $id, userId: $userId, moduleId: $moduleId, status: $status, progressPercentage: $progressPercentage, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingProgressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, moduleId, status,
      progressPercentage, completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingProgressImplCopyWith<_$TrainingProgressImpl> get copyWith =>
      __$$TrainingProgressImplCopyWithImpl<_$TrainingProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingProgressImplToJson(
      this,
    );
  }
}

abstract class _TrainingProgress implements TrainingProgress {
  const factory _TrainingProgress(
      {@JsonKey(name: '_id') final String? id,
      required final String userId,
      required final String moduleId,
      required final String status,
      required final int progressPercentage,
      final DateTime? completedAt}) = _$TrainingProgressImpl;

  factory _TrainingProgress.fromJson(Map<String, dynamic> json) =
      _$TrainingProgressImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get userId;
  @override
  String get moduleId;
  @override
  String get status;
  @override
  int get progressPercentage;
  @override
  DateTime? get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$TrainingProgressImplCopyWith<_$TrainingProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
