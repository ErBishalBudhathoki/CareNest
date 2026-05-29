// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_module.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingModule {

@JsonKey(name: '_id') String? get id; String get title; String get description; String get contentType; String? get contentUrl; String? get contentText; int get durationMinutes; bool get isPublished; String get createdBy; DateTime get createdAt; DateTime get updatedAt;@JsonKey(includeFromJson: false) TrainingProgress? get userProgress;
/// Create a copy of TrainingModule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingModuleCopyWith<TrainingModule> get copyWith => _$TrainingModuleCopyWithImpl<TrainingModule>(this as TrainingModule, _$identity);

  /// Serializes this TrainingModule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingModule&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.contentText, contentText) || other.contentText == contentText)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userProgress, userProgress) || other.userProgress == userProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,contentType,contentUrl,contentText,durationMinutes,isPublished,createdBy,createdAt,updatedAt,userProgress);

@override
String toString() {
  return 'TrainingModule(id: $id, title: $title, description: $description, contentType: $contentType, contentUrl: $contentUrl, contentText: $contentText, durationMinutes: $durationMinutes, isPublished: $isPublished, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, userProgress: $userProgress)';
}


}

/// @nodoc
abstract mixin class $TrainingModuleCopyWith<$Res>  {
  factory $TrainingModuleCopyWith(TrainingModule value, $Res Function(TrainingModule) _then) = _$TrainingModuleCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id, String title, String description, String contentType, String? contentUrl, String? contentText, int durationMinutes, bool isPublished, String createdBy, DateTime createdAt, DateTime updatedAt,@JsonKey(includeFromJson: false) TrainingProgress? userProgress
});


$TrainingProgressCopyWith<$Res>? get userProgress;

}
/// @nodoc
class _$TrainingModuleCopyWithImpl<$Res>
    implements $TrainingModuleCopyWith<$Res> {
  _$TrainingModuleCopyWithImpl(this._self, this._then);

  final TrainingModule _self;
  final $Res Function(TrainingModule) _then;

/// Create a copy of TrainingModule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? contentType = null,Object? contentUrl = freezed,Object? contentText = freezed,Object? durationMinutes = null,Object? isPublished = null,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = null,Object? userProgress = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,contentText: freezed == contentText ? _self.contentText : contentText // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userProgress: freezed == userProgress ? _self.userProgress : userProgress // ignore: cast_nullable_to_non_nullable
as TrainingProgress?,
  ));
}
/// Create a copy of TrainingModule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingProgressCopyWith<$Res>? get userProgress {
    if (_self.userProgress == null) {
    return null;
  }

  return $TrainingProgressCopyWith<$Res>(_self.userProgress!, (value) {
    return _then(_self.copyWith(userProgress: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrainingModule].
extension TrainingModulePatterns on TrainingModule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingModule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingModule() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingModule value)  $default,){
final _that = this;
switch (_that) {
case _TrainingModule():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingModule value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingModule() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String title,  String description,  String contentType,  String? contentUrl,  String? contentText,  int durationMinutes,  bool isPublished,  String createdBy,  DateTime createdAt,  DateTime updatedAt, @JsonKey(includeFromJson: false)  TrainingProgress? userProgress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingModule() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.contentType,_that.contentUrl,_that.contentText,_that.durationMinutes,_that.isPublished,_that.createdBy,_that.createdAt,_that.updatedAt,_that.userProgress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String title,  String description,  String contentType,  String? contentUrl,  String? contentText,  int durationMinutes,  bool isPublished,  String createdBy,  DateTime createdAt,  DateTime updatedAt, @JsonKey(includeFromJson: false)  TrainingProgress? userProgress)  $default,) {final _that = this;
switch (_that) {
case _TrainingModule():
return $default(_that.id,_that.title,_that.description,_that.contentType,_that.contentUrl,_that.contentText,_that.durationMinutes,_that.isPublished,_that.createdBy,_that.createdAt,_that.updatedAt,_that.userProgress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? id,  String title,  String description,  String contentType,  String? contentUrl,  String? contentText,  int durationMinutes,  bool isPublished,  String createdBy,  DateTime createdAt,  DateTime updatedAt, @JsonKey(includeFromJson: false)  TrainingProgress? userProgress)?  $default,) {final _that = this;
switch (_that) {
case _TrainingModule() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.contentType,_that.contentUrl,_that.contentText,_that.durationMinutes,_that.isPublished,_that.createdBy,_that.createdAt,_that.updatedAt,_that.userProgress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingModule implements TrainingModule {
  const _TrainingModule({@JsonKey(name: '_id') this.id, required this.title, required this.description, required this.contentType, this.contentUrl, this.contentText, required this.durationMinutes, this.isPublished = true, required this.createdBy, required this.createdAt, required this.updatedAt, @JsonKey(includeFromJson: false) this.userProgress});
  factory _TrainingModule.fromJson(Map<String, dynamic> json) => _$TrainingModuleFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override final  String title;
@override final  String description;
@override final  String contentType;
@override final  String? contentUrl;
@override final  String? contentText;
@override final  int durationMinutes;
@override@JsonKey() final  bool isPublished;
@override final  String createdBy;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey(includeFromJson: false) final  TrainingProgress? userProgress;

/// Create a copy of TrainingModule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingModuleCopyWith<_TrainingModule> get copyWith => __$TrainingModuleCopyWithImpl<_TrainingModule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingModuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingModule&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.contentUrl, contentUrl) || other.contentUrl == contentUrl)&&(identical(other.contentText, contentText) || other.contentText == contentText)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.userProgress, userProgress) || other.userProgress == userProgress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,contentType,contentUrl,contentText,durationMinutes,isPublished,createdBy,createdAt,updatedAt,userProgress);

@override
String toString() {
  return 'TrainingModule(id: $id, title: $title, description: $description, contentType: $contentType, contentUrl: $contentUrl, contentText: $contentText, durationMinutes: $durationMinutes, isPublished: $isPublished, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, userProgress: $userProgress)';
}


}

/// @nodoc
abstract mixin class _$TrainingModuleCopyWith<$Res> implements $TrainingModuleCopyWith<$Res> {
  factory _$TrainingModuleCopyWith(_TrainingModule value, $Res Function(_TrainingModule) _then) = __$TrainingModuleCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id, String title, String description, String contentType, String? contentUrl, String? contentText, int durationMinutes, bool isPublished, String createdBy, DateTime createdAt, DateTime updatedAt,@JsonKey(includeFromJson: false) TrainingProgress? userProgress
});


@override $TrainingProgressCopyWith<$Res>? get userProgress;

}
/// @nodoc
class __$TrainingModuleCopyWithImpl<$Res>
    implements _$TrainingModuleCopyWith<$Res> {
  __$TrainingModuleCopyWithImpl(this._self, this._then);

  final _TrainingModule _self;
  final $Res Function(_TrainingModule) _then;

/// Create a copy of TrainingModule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? contentType = null,Object? contentUrl = freezed,Object? contentText = freezed,Object? durationMinutes = null,Object? isPublished = null,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = null,Object? userProgress = freezed,}) {
  return _then(_TrainingModule(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,contentUrl: freezed == contentUrl ? _self.contentUrl : contentUrl // ignore: cast_nullable_to_non_nullable
as String?,contentText: freezed == contentText ? _self.contentText : contentText // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,userProgress: freezed == userProgress ? _self.userProgress : userProgress // ignore: cast_nullable_to_non_nullable
as TrainingProgress?,
  ));
}

/// Create a copy of TrainingModule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingProgressCopyWith<$Res>? get userProgress {
    if (_self.userProgress == null) {
    return null;
  }

  return $TrainingProgressCopyWith<$Res>(_self.userProgress!, (value) {
    return _then(_self.copyWith(userProgress: value));
  });
}
}


/// @nodoc
mixin _$TrainingProgress {

@JsonKey(name: '_id') String? get id; String get userId; String get moduleId; String get status; int get progressPercentage; DateTime? get completedAt;
/// Create a copy of TrainingProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingProgressCopyWith<TrainingProgress> get copyWith => _$TrainingProgressCopyWithImpl<TrainingProgress>(this as TrainingProgress, _$identity);

  /// Serializes this TrainingProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingProgress&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,moduleId,status,progressPercentage,completedAt);

@override
String toString() {
  return 'TrainingProgress(id: $id, userId: $userId, moduleId: $moduleId, status: $status, progressPercentage: $progressPercentage, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $TrainingProgressCopyWith<$Res>  {
  factory $TrainingProgressCopyWith(TrainingProgress value, $Res Function(TrainingProgress) _then) = _$TrainingProgressCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id, String userId, String moduleId, String status, int progressPercentage, DateTime? completedAt
});




}
/// @nodoc
class _$TrainingProgressCopyWithImpl<$Res>
    implements $TrainingProgressCopyWith<$Res> {
  _$TrainingProgressCopyWithImpl(this._self, this._then);

  final TrainingProgress _self;
  final $Res Function(TrainingProgress) _then;

/// Create a copy of TrainingProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? moduleId = null,Object? status = null,Object? progressPercentage = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingProgress].
extension TrainingProgressPatterns on TrainingProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingProgress() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingProgress value)  $default,){
final _that = this;
switch (_that) {
case _TrainingProgress():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingProgress value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingProgress() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String userId,  String moduleId,  String status,  int progressPercentage,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingProgress() when $default != null:
return $default(_that.id,_that.userId,_that.moduleId,_that.status,_that.progressPercentage,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String userId,  String moduleId,  String status,  int progressPercentage,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingProgress():
return $default(_that.id,_that.userId,_that.moduleId,_that.status,_that.progressPercentage,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? id,  String userId,  String moduleId,  String status,  int progressPercentage,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingProgress() when $default != null:
return $default(_that.id,_that.userId,_that.moduleId,_that.status,_that.progressPercentage,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingProgress implements TrainingProgress {
  const _TrainingProgress({@JsonKey(name: '_id') this.id, required this.userId, required this.moduleId, required this.status, required this.progressPercentage, this.completedAt});
  factory _TrainingProgress.fromJson(Map<String, dynamic> json) => _$TrainingProgressFromJson(json);

@override@JsonKey(name: '_id') final  String? id;
@override final  String userId;
@override final  String moduleId;
@override final  String status;
@override final  int progressPercentage;
@override final  DateTime? completedAt;

/// Create a copy of TrainingProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingProgressCopyWith<_TrainingProgress> get copyWith => __$TrainingProgressCopyWithImpl<_TrainingProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingProgress&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.moduleId, moduleId) || other.moduleId == moduleId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progressPercentage, progressPercentage) || other.progressPercentage == progressPercentage)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,moduleId,status,progressPercentage,completedAt);

@override
String toString() {
  return 'TrainingProgress(id: $id, userId: $userId, moduleId: $moduleId, status: $status, progressPercentage: $progressPercentage, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingProgressCopyWith<$Res> implements $TrainingProgressCopyWith<$Res> {
  factory _$TrainingProgressCopyWith(_TrainingProgress value, $Res Function(_TrainingProgress) _then) = __$TrainingProgressCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id, String userId, String moduleId, String status, int progressPercentage, DateTime? completedAt
});




}
/// @nodoc
class __$TrainingProgressCopyWithImpl<$Res>
    implements _$TrainingProgressCopyWith<$Res> {
  __$TrainingProgressCopyWithImpl(this._self, this._then);

  final _TrainingProgress _self;
  final $Res Function(_TrainingProgress) _then;

/// Create a copy of TrainingProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? moduleId = null,Object? status = null,Object? progressPercentage = null,Object? completedAt = freezed,}) {
  return _then(_TrainingProgress(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,moduleId: null == moduleId ? _self.moduleId : moduleId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,progressPercentage: null == progressPercentage ? _self.progressPercentage : progressPercentage // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
