// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingRecord {

 String get userId; String get organizationId; String get status; int get currentStep; OnboardingSteps get steps; ProbationDetails get probation; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingRecordCopyWith<OnboardingRecord> get copyWith => _$OnboardingRecordCopyWithImpl<OnboardingRecord>(this as OnboardingRecord, _$identity);

  /// Serializes this OnboardingRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingRecord&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.probation, probation) || other.probation == probation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,organizationId,status,currentStep,steps,probation,createdAt,updatedAt);

@override
String toString() {
  return 'OnboardingRecord(userId: $userId, organizationId: $organizationId, status: $status, currentStep: $currentStep, steps: $steps, probation: $probation, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $OnboardingRecordCopyWith<$Res>  {
  factory $OnboardingRecordCopyWith(OnboardingRecord value, $Res Function(OnboardingRecord) _then) = _$OnboardingRecordCopyWithImpl;
@useResult
$Res call({
 String userId, String organizationId, String status, int currentStep, OnboardingSteps steps, ProbationDetails probation, DateTime? createdAt, DateTime? updatedAt
});


$OnboardingStepsCopyWith<$Res> get steps;$ProbationDetailsCopyWith<$Res> get probation;

}
/// @nodoc
class _$OnboardingRecordCopyWithImpl<$Res>
    implements $OnboardingRecordCopyWith<$Res> {
  _$OnboardingRecordCopyWithImpl(this._self, this._then);

  final OnboardingRecord _self;
  final $Res Function(OnboardingRecord) _then;

/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? organizationId = null,Object? status = null,Object? currentStep = null,Object? steps = null,Object? probation = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as OnboardingSteps,probation: null == probation ? _self.probation : probation // ignore: cast_nullable_to_non_nullable
as ProbationDetails,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingStepsCopyWith<$Res> get steps {
  
  return $OnboardingStepsCopyWith<$Res>(_self.steps, (value) {
    return _then(_self.copyWith(steps: value));
  });
}/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProbationDetailsCopyWith<$Res> get probation {
  
  return $ProbationDetailsCopyWith<$Res>(_self.probation, (value) {
    return _then(_self.copyWith(probation: value));
  });
}
}


/// Adds pattern-matching-related methods to [OnboardingRecord].
extension OnboardingRecordPatterns on OnboardingRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingRecord value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingRecord value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String organizationId,  String status,  int currentStep,  OnboardingSteps steps,  ProbationDetails probation,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingRecord() when $default != null:
return $default(_that.userId,_that.organizationId,_that.status,_that.currentStep,_that.steps,_that.probation,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String organizationId,  String status,  int currentStep,  OnboardingSteps steps,  ProbationDetails probation,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _OnboardingRecord():
return $default(_that.userId,_that.organizationId,_that.status,_that.currentStep,_that.steps,_that.probation,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String organizationId,  String status,  int currentStep,  OnboardingSteps steps,  ProbationDetails probation,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingRecord() when $default != null:
return $default(_that.userId,_that.organizationId,_that.status,_that.currentStep,_that.steps,_that.probation,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingRecord implements OnboardingRecord {
  const _OnboardingRecord({required this.userId, required this.organizationId, required this.status, required this.currentStep, required this.steps, required this.probation, this.createdAt, this.updatedAt});
  factory _OnboardingRecord.fromJson(Map<String, dynamic> json) => _$OnboardingRecordFromJson(json);

@override final  String userId;
@override final  String organizationId;
@override final  String status;
@override final  int currentStep;
@override final  OnboardingSteps steps;
@override final  ProbationDetails probation;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingRecordCopyWith<_OnboardingRecord> get copyWith => __$OnboardingRecordCopyWithImpl<_OnboardingRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingRecord&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.steps, steps) || other.steps == steps)&&(identical(other.probation, probation) || other.probation == probation)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,organizationId,status,currentStep,steps,probation,createdAt,updatedAt);

@override
String toString() {
  return 'OnboardingRecord(userId: $userId, organizationId: $organizationId, status: $status, currentStep: $currentStep, steps: $steps, probation: $probation, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$OnboardingRecordCopyWith<$Res> implements $OnboardingRecordCopyWith<$Res> {
  factory _$OnboardingRecordCopyWith(_OnboardingRecord value, $Res Function(_OnboardingRecord) _then) = __$OnboardingRecordCopyWithImpl;
@override @useResult
$Res call({
 String userId, String organizationId, String status, int currentStep, OnboardingSteps steps, ProbationDetails probation, DateTime? createdAt, DateTime? updatedAt
});


@override $OnboardingStepsCopyWith<$Res> get steps;@override $ProbationDetailsCopyWith<$Res> get probation;

}
/// @nodoc
class __$OnboardingRecordCopyWithImpl<$Res>
    implements _$OnboardingRecordCopyWith<$Res> {
  __$OnboardingRecordCopyWithImpl(this._self, this._then);

  final _OnboardingRecord _self;
  final $Res Function(_OnboardingRecord) _then;

/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? organizationId = null,Object? status = null,Object? currentStep = null,Object? steps = null,Object? probation = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_OnboardingRecord(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as OnboardingSteps,probation: null == probation ? _self.probation : probation // ignore: cast_nullable_to_non_nullable
as ProbationDetails,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingStepsCopyWith<$Res> get steps {
  
  return $OnboardingStepsCopyWith<$Res>(_self.steps, (value) {
    return _then(_self.copyWith(steps: value));
  });
}/// Create a copy of OnboardingRecord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProbationDetailsCopyWith<$Res> get probation {
  
  return $ProbationDetailsCopyWith<$Res>(_self.probation, (value) {
    return _then(_self.copyWith(probation: value));
  });
}
}


/// @nodoc
mixin _$OnboardingSteps {

 StepDetail get personalDetails; BankDetailsStep get bankDetails; TaxDetailsStep get taxDetails; SuperannuationStep get superannuation; DocumentStep get documents;
/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStepsCopyWith<OnboardingSteps> get copyWith => _$OnboardingStepsCopyWithImpl<OnboardingSteps>(this as OnboardingSteps, _$identity);

  /// Serializes this OnboardingSteps to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSteps&&(identical(other.personalDetails, personalDetails) || other.personalDetails == personalDetails)&&(identical(other.bankDetails, bankDetails) || other.bankDetails == bankDetails)&&(identical(other.taxDetails, taxDetails) || other.taxDetails == taxDetails)&&(identical(other.superannuation, superannuation) || other.superannuation == superannuation)&&(identical(other.documents, documents) || other.documents == documents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personalDetails,bankDetails,taxDetails,superannuation,documents);

@override
String toString() {
  return 'OnboardingSteps(personalDetails: $personalDetails, bankDetails: $bankDetails, taxDetails: $taxDetails, superannuation: $superannuation, documents: $documents)';
}


}

/// @nodoc
abstract mixin class $OnboardingStepsCopyWith<$Res>  {
  factory $OnboardingStepsCopyWith(OnboardingSteps value, $Res Function(OnboardingSteps) _then) = _$OnboardingStepsCopyWithImpl;
@useResult
$Res call({
 StepDetail personalDetails, BankDetailsStep bankDetails, TaxDetailsStep taxDetails, SuperannuationStep superannuation, DocumentStep documents
});


$StepDetailCopyWith<$Res> get personalDetails;$BankDetailsStepCopyWith<$Res> get bankDetails;$TaxDetailsStepCopyWith<$Res> get taxDetails;$SuperannuationStepCopyWith<$Res> get superannuation;$DocumentStepCopyWith<$Res> get documents;

}
/// @nodoc
class _$OnboardingStepsCopyWithImpl<$Res>
    implements $OnboardingStepsCopyWith<$Res> {
  _$OnboardingStepsCopyWithImpl(this._self, this._then);

  final OnboardingSteps _self;
  final $Res Function(OnboardingSteps) _then;

/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personalDetails = null,Object? bankDetails = null,Object? taxDetails = null,Object? superannuation = null,Object? documents = null,}) {
  return _then(_self.copyWith(
personalDetails: null == personalDetails ? _self.personalDetails : personalDetails // ignore: cast_nullable_to_non_nullable
as StepDetail,bankDetails: null == bankDetails ? _self.bankDetails : bankDetails // ignore: cast_nullable_to_non_nullable
as BankDetailsStep,taxDetails: null == taxDetails ? _self.taxDetails : taxDetails // ignore: cast_nullable_to_non_nullable
as TaxDetailsStep,superannuation: null == superannuation ? _self.superannuation : superannuation // ignore: cast_nullable_to_non_nullable
as SuperannuationStep,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as DocumentStep,
  ));
}
/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StepDetailCopyWith<$Res> get personalDetails {
  
  return $StepDetailCopyWith<$Res>(_self.personalDetails, (value) {
    return _then(_self.copyWith(personalDetails: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BankDetailsStepCopyWith<$Res> get bankDetails {
  
  return $BankDetailsStepCopyWith<$Res>(_self.bankDetails, (value) {
    return _then(_self.copyWith(bankDetails: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaxDetailsStepCopyWith<$Res> get taxDetails {
  
  return $TaxDetailsStepCopyWith<$Res>(_self.taxDetails, (value) {
    return _then(_self.copyWith(taxDetails: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuperannuationStepCopyWith<$Res> get superannuation {
  
  return $SuperannuationStepCopyWith<$Res>(_self.superannuation, (value) {
    return _then(_self.copyWith(superannuation: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStepCopyWith<$Res> get documents {
  
  return $DocumentStepCopyWith<$Res>(_self.documents, (value) {
    return _then(_self.copyWith(documents: value));
  });
}
}


/// Adds pattern-matching-related methods to [OnboardingSteps].
extension OnboardingStepsPatterns on OnboardingSteps {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingSteps value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingSteps() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingSteps value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingSteps():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingSteps value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingSteps() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StepDetail personalDetails,  BankDetailsStep bankDetails,  TaxDetailsStep taxDetails,  SuperannuationStep superannuation,  DocumentStep documents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingSteps() when $default != null:
return $default(_that.personalDetails,_that.bankDetails,_that.taxDetails,_that.superannuation,_that.documents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StepDetail personalDetails,  BankDetailsStep bankDetails,  TaxDetailsStep taxDetails,  SuperannuationStep superannuation,  DocumentStep documents)  $default,) {final _that = this;
switch (_that) {
case _OnboardingSteps():
return $default(_that.personalDetails,_that.bankDetails,_that.taxDetails,_that.superannuation,_that.documents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StepDetail personalDetails,  BankDetailsStep bankDetails,  TaxDetailsStep taxDetails,  SuperannuationStep superannuation,  DocumentStep documents)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingSteps() when $default != null:
return $default(_that.personalDetails,_that.bankDetails,_that.taxDetails,_that.superannuation,_that.documents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingSteps implements OnboardingSteps {
  const _OnboardingSteps({required this.personalDetails, required this.bankDetails, required this.taxDetails, required this.superannuation, required this.documents});
  factory _OnboardingSteps.fromJson(Map<String, dynamic> json) => _$OnboardingStepsFromJson(json);

@override final  StepDetail personalDetails;
@override final  BankDetailsStep bankDetails;
@override final  TaxDetailsStep taxDetails;
@override final  SuperannuationStep superannuation;
@override final  DocumentStep documents;

/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStepsCopyWith<_OnboardingSteps> get copyWith => __$OnboardingStepsCopyWithImpl<_OnboardingSteps>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingStepsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingSteps&&(identical(other.personalDetails, personalDetails) || other.personalDetails == personalDetails)&&(identical(other.bankDetails, bankDetails) || other.bankDetails == bankDetails)&&(identical(other.taxDetails, taxDetails) || other.taxDetails == taxDetails)&&(identical(other.superannuation, superannuation) || other.superannuation == superannuation)&&(identical(other.documents, documents) || other.documents == documents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personalDetails,bankDetails,taxDetails,superannuation,documents);

@override
String toString() {
  return 'OnboardingSteps(personalDetails: $personalDetails, bankDetails: $bankDetails, taxDetails: $taxDetails, superannuation: $superannuation, documents: $documents)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStepsCopyWith<$Res> implements $OnboardingStepsCopyWith<$Res> {
  factory _$OnboardingStepsCopyWith(_OnboardingSteps value, $Res Function(_OnboardingSteps) _then) = __$OnboardingStepsCopyWithImpl;
@override @useResult
$Res call({
 StepDetail personalDetails, BankDetailsStep bankDetails, TaxDetailsStep taxDetails, SuperannuationStep superannuation, DocumentStep documents
});


@override $StepDetailCopyWith<$Res> get personalDetails;@override $BankDetailsStepCopyWith<$Res> get bankDetails;@override $TaxDetailsStepCopyWith<$Res> get taxDetails;@override $SuperannuationStepCopyWith<$Res> get superannuation;@override $DocumentStepCopyWith<$Res> get documents;

}
/// @nodoc
class __$OnboardingStepsCopyWithImpl<$Res>
    implements _$OnboardingStepsCopyWith<$Res> {
  __$OnboardingStepsCopyWithImpl(this._self, this._then);

  final _OnboardingSteps _self;
  final $Res Function(_OnboardingSteps) _then;

/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personalDetails = null,Object? bankDetails = null,Object? taxDetails = null,Object? superannuation = null,Object? documents = null,}) {
  return _then(_OnboardingSteps(
personalDetails: null == personalDetails ? _self.personalDetails : personalDetails // ignore: cast_nullable_to_non_nullable
as StepDetail,bankDetails: null == bankDetails ? _self.bankDetails : bankDetails // ignore: cast_nullable_to_non_nullable
as BankDetailsStep,taxDetails: null == taxDetails ? _self.taxDetails : taxDetails // ignore: cast_nullable_to_non_nullable
as TaxDetailsStep,superannuation: null == superannuation ? _self.superannuation : superannuation // ignore: cast_nullable_to_non_nullable
as SuperannuationStep,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as DocumentStep,
  ));
}

/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StepDetailCopyWith<$Res> get personalDetails {
  
  return $StepDetailCopyWith<$Res>(_self.personalDetails, (value) {
    return _then(_self.copyWith(personalDetails: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BankDetailsStepCopyWith<$Res> get bankDetails {
  
  return $BankDetailsStepCopyWith<$Res>(_self.bankDetails, (value) {
    return _then(_self.copyWith(bankDetails: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaxDetailsStepCopyWith<$Res> get taxDetails {
  
  return $TaxDetailsStepCopyWith<$Res>(_self.taxDetails, (value) {
    return _then(_self.copyWith(taxDetails: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SuperannuationStepCopyWith<$Res> get superannuation {
  
  return $SuperannuationStepCopyWith<$Res>(_self.superannuation, (value) {
    return _then(_self.copyWith(superannuation: value));
  });
}/// Create a copy of OnboardingSteps
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DocumentStepCopyWith<$Res> get documents {
  
  return $DocumentStepCopyWith<$Res>(_self.documents, (value) {
    return _then(_self.copyWith(documents: value));
  });
}
}


/// @nodoc
mixin _$BankDetailsStep {

 String get status; String? get bankName; String? get accountName; String? get bsb; String? get accountNumber; DateTime? get updatedAt;
/// Create a copy of BankDetailsStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankDetailsStepCopyWith<BankDetailsStep> get copyWith => _$BankDetailsStepCopyWithImpl<BankDetailsStep>(this as BankDetailsStep, _$identity);

  /// Serializes this BankDetailsStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankDetailsStep&&(identical(other.status, status) || other.status == status)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bsb, bsb) || other.bsb == bsb)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,bankName,accountName,bsb,accountNumber,updatedAt);

@override
String toString() {
  return 'BankDetailsStep(status: $status, bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BankDetailsStepCopyWith<$Res>  {
  factory $BankDetailsStepCopyWith(BankDetailsStep value, $Res Function(BankDetailsStep) _then) = _$BankDetailsStepCopyWithImpl;
@useResult
$Res call({
 String status, String? bankName, String? accountName, String? bsb, String? accountNumber, DateTime? updatedAt
});




}
/// @nodoc
class _$BankDetailsStepCopyWithImpl<$Res>
    implements $BankDetailsStepCopyWith<$Res> {
  _$BankDetailsStepCopyWithImpl(this._self, this._then);

  final BankDetailsStep _self;
  final $Res Function(BankDetailsStep) _then;

/// Create a copy of BankDetailsStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? bankName = freezed,Object? accountName = freezed,Object? bsb = freezed,Object? accountNumber = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,bsb: freezed == bsb ? _self.bsb : bsb // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BankDetailsStep].
extension BankDetailsStepPatterns on BankDetailsStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankDetailsStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankDetailsStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankDetailsStep value)  $default,){
final _that = this;
switch (_that) {
case _BankDetailsStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankDetailsStep value)?  $default,){
final _that = this;
switch (_that) {
case _BankDetailsStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? bankName,  String? accountName,  String? bsb,  String? accountNumber,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankDetailsStep() when $default != null:
return $default(_that.status,_that.bankName,_that.accountName,_that.bsb,_that.accountNumber,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? bankName,  String? accountName,  String? bsb,  String? accountNumber,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BankDetailsStep():
return $default(_that.status,_that.bankName,_that.accountName,_that.bsb,_that.accountNumber,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? bankName,  String? accountName,  String? bsb,  String? accountNumber,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BankDetailsStep() when $default != null:
return $default(_that.status,_that.bankName,_that.accountName,_that.bsb,_that.accountNumber,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BankDetailsStep implements BankDetailsStep {
  const _BankDetailsStep({required this.status, this.bankName, this.accountName, this.bsb, this.accountNumber, this.updatedAt});
  factory _BankDetailsStep.fromJson(Map<String, dynamic> json) => _$BankDetailsStepFromJson(json);

@override final  String status;
@override final  String? bankName;
@override final  String? accountName;
@override final  String? bsb;
@override final  String? accountNumber;
@override final  DateTime? updatedAt;

/// Create a copy of BankDetailsStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankDetailsStepCopyWith<_BankDetailsStep> get copyWith => __$BankDetailsStepCopyWithImpl<_BankDetailsStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankDetailsStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankDetailsStep&&(identical(other.status, status) || other.status == status)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bsb, bsb) || other.bsb == bsb)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,bankName,accountName,bsb,accountNumber,updatedAt);

@override
String toString() {
  return 'BankDetailsStep(status: $status, bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BankDetailsStepCopyWith<$Res> implements $BankDetailsStepCopyWith<$Res> {
  factory _$BankDetailsStepCopyWith(_BankDetailsStep value, $Res Function(_BankDetailsStep) _then) = __$BankDetailsStepCopyWithImpl;
@override @useResult
$Res call({
 String status, String? bankName, String? accountName, String? bsb, String? accountNumber, DateTime? updatedAt
});




}
/// @nodoc
class __$BankDetailsStepCopyWithImpl<$Res>
    implements _$BankDetailsStepCopyWith<$Res> {
  __$BankDetailsStepCopyWithImpl(this._self, this._then);

  final _BankDetailsStep _self;
  final $Res Function(_BankDetailsStep) _then;

/// Create a copy of BankDetailsStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? bankName = freezed,Object? accountName = freezed,Object? bsb = freezed,Object? accountNumber = freezed,Object? updatedAt = freezed,}) {
  return _then(_BankDetailsStep(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,accountName: freezed == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String?,bsb: freezed == bsb ? _self.bsb : bsb // ignore: cast_nullable_to_non_nullable
as String?,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$StepDetail {

 String get status; DateTime? get updatedAt;
/// Create a copy of StepDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepDetailCopyWith<StepDetail> get copyWith => _$StepDetailCopyWithImpl<StepDetail>(this as StepDetail, _$identity);

  /// Serializes this StepDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepDetail&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,updatedAt);

@override
String toString() {
  return 'StepDetail(status: $status, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $StepDetailCopyWith<$Res>  {
  factory $StepDetailCopyWith(StepDetail value, $Res Function(StepDetail) _then) = _$StepDetailCopyWithImpl;
@useResult
$Res call({
 String status, DateTime? updatedAt
});




}
/// @nodoc
class _$StepDetailCopyWithImpl<$Res>
    implements $StepDetailCopyWith<$Res> {
  _$StepDetailCopyWithImpl(this._self, this._then);

  final StepDetail _self;
  final $Res Function(StepDetail) _then;

/// Create a copy of StepDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StepDetail].
extension StepDetailPatterns on StepDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepDetail value)  $default,){
final _that = this;
switch (_that) {
case _StepDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepDetail value)?  $default,){
final _that = this;
switch (_that) {
case _StepDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepDetail() when $default != null:
return $default(_that.status,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _StepDetail():
return $default(_that.status,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _StepDetail() when $default != null:
return $default(_that.status,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepDetail implements StepDetail {
  const _StepDetail({required this.status, this.updatedAt});
  factory _StepDetail.fromJson(Map<String, dynamic> json) => _$StepDetailFromJson(json);

@override final  String status;
@override final  DateTime? updatedAt;

/// Create a copy of StepDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepDetailCopyWith<_StepDetail> get copyWith => __$StepDetailCopyWithImpl<_StepDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepDetail&&(identical(other.status, status) || other.status == status)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,updatedAt);

@override
String toString() {
  return 'StepDetail(status: $status, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$StepDetailCopyWith<$Res> implements $StepDetailCopyWith<$Res> {
  factory _$StepDetailCopyWith(_StepDetail value, $Res Function(_StepDetail) _then) = __$StepDetailCopyWithImpl;
@override @useResult
$Res call({
 String status, DateTime? updatedAt
});




}
/// @nodoc
class __$StepDetailCopyWithImpl<$Res>
    implements _$StepDetailCopyWith<$Res> {
  __$StepDetailCopyWithImpl(this._self, this._then);

  final _StepDetail _self;
  final $Res Function(_StepDetail) _then;

/// Create a copy of StepDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? updatedAt = freezed,}) {
  return _then(_StepDetail(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TaxDetailsStep {

 String get status; String? get tfn; String? get taxScale; DateTime? get updatedAt;
/// Create a copy of TaxDetailsStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxDetailsStepCopyWith<TaxDetailsStep> get copyWith => _$TaxDetailsStepCopyWithImpl<TaxDetailsStep>(this as TaxDetailsStep, _$identity);

  /// Serializes this TaxDetailsStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxDetailsStep&&(identical(other.status, status) || other.status == status)&&(identical(other.tfn, tfn) || other.tfn == tfn)&&(identical(other.taxScale, taxScale) || other.taxScale == taxScale)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,tfn,taxScale,updatedAt);

@override
String toString() {
  return 'TaxDetailsStep(status: $status, tfn: $tfn, taxScale: $taxScale, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaxDetailsStepCopyWith<$Res>  {
  factory $TaxDetailsStepCopyWith(TaxDetailsStep value, $Res Function(TaxDetailsStep) _then) = _$TaxDetailsStepCopyWithImpl;
@useResult
$Res call({
 String status, String? tfn, String? taxScale, DateTime? updatedAt
});




}
/// @nodoc
class _$TaxDetailsStepCopyWithImpl<$Res>
    implements $TaxDetailsStepCopyWith<$Res> {
  _$TaxDetailsStepCopyWithImpl(this._self, this._then);

  final TaxDetailsStep _self;
  final $Res Function(TaxDetailsStep) _then;

/// Create a copy of TaxDetailsStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? tfn = freezed,Object? taxScale = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,tfn: freezed == tfn ? _self.tfn : tfn // ignore: cast_nullable_to_non_nullable
as String?,taxScale: freezed == taxScale ? _self.taxScale : taxScale // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxDetailsStep].
extension TaxDetailsStepPatterns on TaxDetailsStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxDetailsStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxDetailsStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxDetailsStep value)  $default,){
final _that = this;
switch (_that) {
case _TaxDetailsStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxDetailsStep value)?  $default,){
final _that = this;
switch (_that) {
case _TaxDetailsStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? tfn,  String? taxScale,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxDetailsStep() when $default != null:
return $default(_that.status,_that.tfn,_that.taxScale,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? tfn,  String? taxScale,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TaxDetailsStep():
return $default(_that.status,_that.tfn,_that.taxScale,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? tfn,  String? taxScale,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TaxDetailsStep() when $default != null:
return $default(_that.status,_that.tfn,_that.taxScale,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaxDetailsStep implements TaxDetailsStep {
  const _TaxDetailsStep({required this.status, this.tfn, this.taxScale, this.updatedAt});
  factory _TaxDetailsStep.fromJson(Map<String, dynamic> json) => _$TaxDetailsStepFromJson(json);

@override final  String status;
@override final  String? tfn;
@override final  String? taxScale;
@override final  DateTime? updatedAt;

/// Create a copy of TaxDetailsStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxDetailsStepCopyWith<_TaxDetailsStep> get copyWith => __$TaxDetailsStepCopyWithImpl<_TaxDetailsStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaxDetailsStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxDetailsStep&&(identical(other.status, status) || other.status == status)&&(identical(other.tfn, tfn) || other.tfn == tfn)&&(identical(other.taxScale, taxScale) || other.taxScale == taxScale)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,tfn,taxScale,updatedAt);

@override
String toString() {
  return 'TaxDetailsStep(status: $status, tfn: $tfn, taxScale: $taxScale, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaxDetailsStepCopyWith<$Res> implements $TaxDetailsStepCopyWith<$Res> {
  factory _$TaxDetailsStepCopyWith(_TaxDetailsStep value, $Res Function(_TaxDetailsStep) _then) = __$TaxDetailsStepCopyWithImpl;
@override @useResult
$Res call({
 String status, String? tfn, String? taxScale, DateTime? updatedAt
});




}
/// @nodoc
class __$TaxDetailsStepCopyWithImpl<$Res>
    implements _$TaxDetailsStepCopyWith<$Res> {
  __$TaxDetailsStepCopyWithImpl(this._self, this._then);

  final _TaxDetailsStep _self;
  final $Res Function(_TaxDetailsStep) _then;

/// Create a copy of TaxDetailsStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? tfn = freezed,Object? taxScale = freezed,Object? updatedAt = freezed,}) {
  return _then(_TaxDetailsStep(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,tfn: freezed == tfn ? _self.tfn : tfn // ignore: cast_nullable_to_non_nullable
as String?,taxScale: freezed == taxScale ? _self.taxScale : taxScale // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SuperannuationStep {

 String get status; String? get fundName; String? get memberNumber; String? get usi; DateTime? get updatedAt;
/// Create a copy of SuperannuationStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuperannuationStepCopyWith<SuperannuationStep> get copyWith => _$SuperannuationStepCopyWithImpl<SuperannuationStep>(this as SuperannuationStep, _$identity);

  /// Serializes this SuperannuationStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuperannuationStep&&(identical(other.status, status) || other.status == status)&&(identical(other.fundName, fundName) || other.fundName == fundName)&&(identical(other.memberNumber, memberNumber) || other.memberNumber == memberNumber)&&(identical(other.usi, usi) || other.usi == usi)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,fundName,memberNumber,usi,updatedAt);

@override
String toString() {
  return 'SuperannuationStep(status: $status, fundName: $fundName, memberNumber: $memberNumber, usi: $usi, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SuperannuationStepCopyWith<$Res>  {
  factory $SuperannuationStepCopyWith(SuperannuationStep value, $Res Function(SuperannuationStep) _then) = _$SuperannuationStepCopyWithImpl;
@useResult
$Res call({
 String status, String? fundName, String? memberNumber, String? usi, DateTime? updatedAt
});




}
/// @nodoc
class _$SuperannuationStepCopyWithImpl<$Res>
    implements $SuperannuationStepCopyWith<$Res> {
  _$SuperannuationStepCopyWithImpl(this._self, this._then);

  final SuperannuationStep _self;
  final $Res Function(SuperannuationStep) _then;

/// Create a copy of SuperannuationStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? fundName = freezed,Object? memberNumber = freezed,Object? usi = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundName: freezed == fundName ? _self.fundName : fundName // ignore: cast_nullable_to_non_nullable
as String?,memberNumber: freezed == memberNumber ? _self.memberNumber : memberNumber // ignore: cast_nullable_to_non_nullable
as String?,usi: freezed == usi ? _self.usi : usi // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SuperannuationStep].
extension SuperannuationStepPatterns on SuperannuationStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SuperannuationStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SuperannuationStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SuperannuationStep value)  $default,){
final _that = this;
switch (_that) {
case _SuperannuationStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SuperannuationStep value)?  $default,){
final _that = this;
switch (_that) {
case _SuperannuationStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? fundName,  String? memberNumber,  String? usi,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SuperannuationStep() when $default != null:
return $default(_that.status,_that.fundName,_that.memberNumber,_that.usi,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? fundName,  String? memberNumber,  String? usi,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SuperannuationStep():
return $default(_that.status,_that.fundName,_that.memberNumber,_that.usi,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? fundName,  String? memberNumber,  String? usi,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SuperannuationStep() when $default != null:
return $default(_that.status,_that.fundName,_that.memberNumber,_that.usi,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SuperannuationStep implements SuperannuationStep {
  const _SuperannuationStep({required this.status, this.fundName, this.memberNumber, this.usi, this.updatedAt});
  factory _SuperannuationStep.fromJson(Map<String, dynamic> json) => _$SuperannuationStepFromJson(json);

@override final  String status;
@override final  String? fundName;
@override final  String? memberNumber;
@override final  String? usi;
@override final  DateTime? updatedAt;

/// Create a copy of SuperannuationStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuperannuationStepCopyWith<_SuperannuationStep> get copyWith => __$SuperannuationStepCopyWithImpl<_SuperannuationStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SuperannuationStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SuperannuationStep&&(identical(other.status, status) || other.status == status)&&(identical(other.fundName, fundName) || other.fundName == fundName)&&(identical(other.memberNumber, memberNumber) || other.memberNumber == memberNumber)&&(identical(other.usi, usi) || other.usi == usi)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,fundName,memberNumber,usi,updatedAt);

@override
String toString() {
  return 'SuperannuationStep(status: $status, fundName: $fundName, memberNumber: $memberNumber, usi: $usi, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SuperannuationStepCopyWith<$Res> implements $SuperannuationStepCopyWith<$Res> {
  factory _$SuperannuationStepCopyWith(_SuperannuationStep value, $Res Function(_SuperannuationStep) _then) = __$SuperannuationStepCopyWithImpl;
@override @useResult
$Res call({
 String status, String? fundName, String? memberNumber, String? usi, DateTime? updatedAt
});




}
/// @nodoc
class __$SuperannuationStepCopyWithImpl<$Res>
    implements _$SuperannuationStepCopyWith<$Res> {
  __$SuperannuationStepCopyWithImpl(this._self, this._then);

  final _SuperannuationStep _self;
  final $Res Function(_SuperannuationStep) _then;

/// Create a copy of SuperannuationStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? fundName = freezed,Object? memberNumber = freezed,Object? usi = freezed,Object? updatedAt = freezed,}) {
  return _then(_SuperannuationStep(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,fundName: freezed == fundName ? _self.fundName : fundName // ignore: cast_nullable_to_non_nullable
as String?,memberNumber: freezed == memberNumber ? _self.memberNumber : memberNumber // ignore: cast_nullable_to_non_nullable
as String?,usi: freezed == usi ? _self.usi : usi // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DocumentStep {

 String get status; int get count; DateTime? get updatedAt;
/// Create a copy of DocumentStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentStepCopyWith<DocumentStep> get copyWith => _$DocumentStepCopyWithImpl<DocumentStep>(this as DocumentStep, _$identity);

  /// Serializes this DocumentStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentStep&&(identical(other.status, status) || other.status == status)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,count,updatedAt);

@override
String toString() {
  return 'DocumentStep(status: $status, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DocumentStepCopyWith<$Res>  {
  factory $DocumentStepCopyWith(DocumentStep value, $Res Function(DocumentStep) _then) = _$DocumentStepCopyWithImpl;
@useResult
$Res call({
 String status, int count, DateTime? updatedAt
});




}
/// @nodoc
class _$DocumentStepCopyWithImpl<$Res>
    implements $DocumentStepCopyWith<$Res> {
  _$DocumentStepCopyWithImpl(this._self, this._then);

  final DocumentStep _self;
  final $Res Function(DocumentStep) _then;

/// Create a copy of DocumentStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? count = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocumentStep].
extension DocumentStepPatterns on DocumentStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocumentStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocumentStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocumentStep value)  $default,){
final _that = this;
switch (_that) {
case _DocumentStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocumentStep value)?  $default,){
final _that = this;
switch (_that) {
case _DocumentStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  int count,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocumentStep() when $default != null:
return $default(_that.status,_that.count,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  int count,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DocumentStep():
return $default(_that.status,_that.count,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  int count,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DocumentStep() when $default != null:
return $default(_that.status,_that.count,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocumentStep implements DocumentStep {
  const _DocumentStep({required this.status, this.count = 0, this.updatedAt});
  factory _DocumentStep.fromJson(Map<String, dynamic> json) => _$DocumentStepFromJson(json);

@override final  String status;
@override@JsonKey() final  int count;
@override final  DateTime? updatedAt;

/// Create a copy of DocumentStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentStepCopyWith<_DocumentStep> get copyWith => __$DocumentStepCopyWithImpl<_DocumentStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentStep&&(identical(other.status, status) || other.status == status)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,count,updatedAt);

@override
String toString() {
  return 'DocumentStep(status: $status, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DocumentStepCopyWith<$Res> implements $DocumentStepCopyWith<$Res> {
  factory _$DocumentStepCopyWith(_DocumentStep value, $Res Function(_DocumentStep) _then) = __$DocumentStepCopyWithImpl;
@override @useResult
$Res call({
 String status, int count, DateTime? updatedAt
});




}
/// @nodoc
class __$DocumentStepCopyWithImpl<$Res>
    implements _$DocumentStepCopyWith<$Res> {
  __$DocumentStepCopyWithImpl(this._self, this._then);

  final _DocumentStep _self;
  final $Res Function(_DocumentStep) _then;

/// Create a copy of DocumentStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? count = null,Object? updatedAt = freezed,}) {
  return _then(_DocumentStep(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ProbationDetails {

 DateTime? get startDate; DateTime? get endDate; DateTime? get reviewDate; String get status;
/// Create a copy of ProbationDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProbationDetailsCopyWith<ProbationDetails> get copyWith => _$ProbationDetailsCopyWithImpl<ProbationDetails>(this as ProbationDetails, _$identity);

  /// Serializes this ProbationDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProbationDetails&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reviewDate, reviewDate) || other.reviewDate == reviewDate)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,reviewDate,status);

@override
String toString() {
  return 'ProbationDetails(startDate: $startDate, endDate: $endDate, reviewDate: $reviewDate, status: $status)';
}


}

/// @nodoc
abstract mixin class $ProbationDetailsCopyWith<$Res>  {
  factory $ProbationDetailsCopyWith(ProbationDetails value, $Res Function(ProbationDetails) _then) = _$ProbationDetailsCopyWithImpl;
@useResult
$Res call({
 DateTime? startDate, DateTime? endDate, DateTime? reviewDate, String status
});




}
/// @nodoc
class _$ProbationDetailsCopyWithImpl<$Res>
    implements $ProbationDetailsCopyWith<$Res> {
  _$ProbationDetailsCopyWithImpl(this._self, this._then);

  final ProbationDetails _self;
  final $Res Function(ProbationDetails) _then;

/// Create a copy of ProbationDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = freezed,Object? endDate = freezed,Object? reviewDate = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewDate: freezed == reviewDate ? _self.reviewDate : reviewDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProbationDetails].
extension ProbationDetailsPatterns on ProbationDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProbationDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProbationDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProbationDetails value)  $default,){
final _that = this;
switch (_that) {
case _ProbationDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProbationDetails value)?  $default,){
final _that = this;
switch (_that) {
case _ProbationDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? startDate,  DateTime? endDate,  DateTime? reviewDate,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProbationDetails() when $default != null:
return $default(_that.startDate,_that.endDate,_that.reviewDate,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? startDate,  DateTime? endDate,  DateTime? reviewDate,  String status)  $default,) {final _that = this;
switch (_that) {
case _ProbationDetails():
return $default(_that.startDate,_that.endDate,_that.reviewDate,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? startDate,  DateTime? endDate,  DateTime? reviewDate,  String status)?  $default,) {final _that = this;
switch (_that) {
case _ProbationDetails() when $default != null:
return $default(_that.startDate,_that.endDate,_that.reviewDate,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProbationDetails implements ProbationDetails {
  const _ProbationDetails({this.startDate, this.endDate, this.reviewDate, required this.status});
  factory _ProbationDetails.fromJson(Map<String, dynamic> json) => _$ProbationDetailsFromJson(json);

@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  DateTime? reviewDate;
@override final  String status;

/// Create a copy of ProbationDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProbationDetailsCopyWith<_ProbationDetails> get copyWith => __$ProbationDetailsCopyWithImpl<_ProbationDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProbationDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProbationDetails&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reviewDate, reviewDate) || other.reviewDate == reviewDate)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,reviewDate,status);

@override
String toString() {
  return 'ProbationDetails(startDate: $startDate, endDate: $endDate, reviewDate: $reviewDate, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ProbationDetailsCopyWith<$Res> implements $ProbationDetailsCopyWith<$Res> {
  factory _$ProbationDetailsCopyWith(_ProbationDetails value, $Res Function(_ProbationDetails) _then) = __$ProbationDetailsCopyWithImpl;
@override @useResult
$Res call({
 DateTime? startDate, DateTime? endDate, DateTime? reviewDate, String status
});




}
/// @nodoc
class __$ProbationDetailsCopyWithImpl<$Res>
    implements _$ProbationDetailsCopyWith<$Res> {
  __$ProbationDetailsCopyWithImpl(this._self, this._then);

  final _ProbationDetails _self;
  final $Res Function(_ProbationDetails) _then;

/// Create a copy of ProbationDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = freezed,Object? endDate = freezed,Object? reviewDate = freezed,Object? status = null,}) {
  return _then(_ProbationDetails(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewDate: freezed == reviewDate ? _self.reviewDate : reviewDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
