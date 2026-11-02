// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClientPlanCategory {

 String get categoryNumber; String get name; double get budget;
/// Create a copy of ClientPlanCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientPlanCategoryCopyWith<ClientPlanCategory> get copyWith => _$ClientPlanCategoryCopyWithImpl<ClientPlanCategory>(this as ClientPlanCategory, _$identity);

  /// Serializes this ClientPlanCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientPlanCategory&&(identical(other.categoryNumber, categoryNumber) || other.categoryNumber == categoryNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.budget, budget) || other.budget == budget));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryNumber,name,budget);

@override
String toString() {
  return 'ClientPlanCategory(categoryNumber: $categoryNumber, name: $name, budget: $budget)';
}


}

/// @nodoc
abstract mixin class $ClientPlanCategoryCopyWith<$Res>  {
  factory $ClientPlanCategoryCopyWith(ClientPlanCategory value, $Res Function(ClientPlanCategory) _then) = _$ClientPlanCategoryCopyWithImpl;
@useResult
$Res call({
 String categoryNumber, String name, double budget
});




}
/// @nodoc
class _$ClientPlanCategoryCopyWithImpl<$Res>
    implements $ClientPlanCategoryCopyWith<$Res> {
  _$ClientPlanCategoryCopyWithImpl(this._self, this._then);

  final ClientPlanCategory _self;
  final $Res Function(ClientPlanCategory) _then;

/// Create a copy of ClientPlanCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryNumber = null,Object? name = null,Object? budget = null,}) {
  return _then(_self.copyWith(
categoryNumber: null == categoryNumber ? _self.categoryNumber : categoryNumber // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientPlanCategory].
extension ClientPlanCategoryPatterns on ClientPlanCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientPlanCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientPlanCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientPlanCategory value)  $default,){
final _that = this;
switch (_that) {
case _ClientPlanCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientPlanCategory value)?  $default,){
final _that = this;
switch (_that) {
case _ClientPlanCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryNumber,  String name,  double budget)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientPlanCategory() when $default != null:
return $default(_that.categoryNumber,_that.name,_that.budget);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryNumber,  String name,  double budget)  $default,) {final _that = this;
switch (_that) {
case _ClientPlanCategory():
return $default(_that.categoryNumber,_that.name,_that.budget);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryNumber,  String name,  double budget)?  $default,) {final _that = this;
switch (_that) {
case _ClientPlanCategory() when $default != null:
return $default(_that.categoryNumber,_that.name,_that.budget);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientPlanCategory implements ClientPlanCategory {
  const _ClientPlanCategory({required this.categoryNumber, this.name = '', this.budget = 0.0});
  factory _ClientPlanCategory.fromJson(Map<String, dynamic> json) => _$ClientPlanCategoryFromJson(json);

@override final  String categoryNumber;
@override@JsonKey() final  String name;
@override@JsonKey() final  double budget;

/// Create a copy of ClientPlanCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientPlanCategoryCopyWith<_ClientPlanCategory> get copyWith => __$ClientPlanCategoryCopyWithImpl<_ClientPlanCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientPlanCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientPlanCategory&&(identical(other.categoryNumber, categoryNumber) || other.categoryNumber == categoryNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.budget, budget) || other.budget == budget));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryNumber,name,budget);

@override
String toString() {
  return 'ClientPlanCategory(categoryNumber: $categoryNumber, name: $name, budget: $budget)';
}


}

/// @nodoc
abstract mixin class _$ClientPlanCategoryCopyWith<$Res> implements $ClientPlanCategoryCopyWith<$Res> {
  factory _$ClientPlanCategoryCopyWith(_ClientPlanCategory value, $Res Function(_ClientPlanCategory) _then) = __$ClientPlanCategoryCopyWithImpl;
@override @useResult
$Res call({
 String categoryNumber, String name, double budget
});




}
/// @nodoc
class __$ClientPlanCategoryCopyWithImpl<$Res>
    implements _$ClientPlanCategoryCopyWith<$Res> {
  __$ClientPlanCategoryCopyWithImpl(this._self, this._then);

  final _ClientPlanCategory _self;
  final $Res Function(_ClientPlanCategory) _then;

/// Create a copy of ClientPlanCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryNumber = null,Object? name = null,Object? budget = null,}) {
  return _then(_ClientPlanCategory(
categoryNumber: null == categoryNumber ? _self.categoryNumber : categoryNumber // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ClientPlan {

 DateTime? get startDate; DateTime? get endDate; double get totalBudget; List<ClientPlanCategory> get categories; String get status; String get source; String? get documentUrl; String? get documentName; String? get notes; DateTime? get updatedAt; String? get updatedBy;
/// Create a copy of ClientPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientPlanCopyWith<ClientPlan> get copyWith => _$ClientPlanCopyWithImpl<ClientPlan>(this as ClientPlan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientPlan&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalBudget, totalBudget) || other.totalBudget == totalBudget)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.documentUrl, documentUrl) || other.documentUrl == documentUrl)&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,totalBudget,const DeepCollectionEquality().hash(categories),status,source,documentUrl,documentName,notes,updatedAt,updatedBy);

@override
String toString() {
  return 'ClientPlan(startDate: $startDate, endDate: $endDate, totalBudget: $totalBudget, categories: $categories, status: $status, source: $source, documentUrl: $documentUrl, documentName: $documentName, notes: $notes, updatedAt: $updatedAt, updatedBy: $updatedBy)';
}


}

/// @nodoc
abstract mixin class $ClientPlanCopyWith<$Res>  {
  factory $ClientPlanCopyWith(ClientPlan value, $Res Function(ClientPlan) _then) = _$ClientPlanCopyWithImpl;
@useResult
$Res call({
 DateTime? startDate, DateTime? endDate, double totalBudget, List<ClientPlanCategory> categories, String status, String source, String? documentUrl, String? documentName, String? notes, DateTime? updatedAt, String? updatedBy
});




}
/// @nodoc
class _$ClientPlanCopyWithImpl<$Res>
    implements $ClientPlanCopyWith<$Res> {
  _$ClientPlanCopyWithImpl(this._self, this._then);

  final ClientPlan _self;
  final $Res Function(ClientPlan) _then;

/// Create a copy of ClientPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = freezed,Object? endDate = freezed,Object? totalBudget = null,Object? categories = null,Object? status = null,Object? source = null,Object? documentUrl = freezed,Object? documentName = freezed,Object? notes = freezed,Object? updatedAt = freezed,Object? updatedBy = freezed,}) {
  return _then(_self.copyWith(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalBudget: null == totalBudget ? _self.totalBudget : totalBudget // ignore: cast_nullable_to_non_nullable
as double,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<ClientPlanCategory>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,documentUrl: freezed == documentUrl ? _self.documentUrl : documentUrl // ignore: cast_nullable_to_non_nullable
as String?,documentName: freezed == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientPlan].
extension ClientPlanPatterns on ClientPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientPlan value)  $default,){
final _that = this;
switch (_that) {
case _ClientPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientPlan value)?  $default,){
final _that = this;
switch (_that) {
case _ClientPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? startDate,  DateTime? endDate,  double totalBudget,  List<ClientPlanCategory> categories,  String status,  String source,  String? documentUrl,  String? documentName,  String? notes,  DateTime? updatedAt,  String? updatedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientPlan() when $default != null:
return $default(_that.startDate,_that.endDate,_that.totalBudget,_that.categories,_that.status,_that.source,_that.documentUrl,_that.documentName,_that.notes,_that.updatedAt,_that.updatedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? startDate,  DateTime? endDate,  double totalBudget,  List<ClientPlanCategory> categories,  String status,  String source,  String? documentUrl,  String? documentName,  String? notes,  DateTime? updatedAt,  String? updatedBy)  $default,) {final _that = this;
switch (_that) {
case _ClientPlan():
return $default(_that.startDate,_that.endDate,_that.totalBudget,_that.categories,_that.status,_that.source,_that.documentUrl,_that.documentName,_that.notes,_that.updatedAt,_that.updatedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? startDate,  DateTime? endDate,  double totalBudget,  List<ClientPlanCategory> categories,  String status,  String source,  String? documentUrl,  String? documentName,  String? notes,  DateTime? updatedAt,  String? updatedBy)?  $default,) {final _that = this;
switch (_that) {
case _ClientPlan() when $default != null:
return $default(_that.startDate,_that.endDate,_that.totalBudget,_that.categories,_that.status,_that.source,_that.documentUrl,_that.documentName,_that.notes,_that.updatedAt,_that.updatedBy);case _:
  return null;

}
}

}

/// @nodoc


class _ClientPlan implements ClientPlan {
  const _ClientPlan({this.startDate, this.endDate, this.totalBudget = 0.0, final  List<ClientPlanCategory> categories = const <ClientPlanCategory>[], this.status = 'not_configured', this.source = 'manual', this.documentUrl, this.documentName, this.notes, this.updatedAt, this.updatedBy}): _categories = categories;
  

@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  double totalBudget;
 final  List<ClientPlanCategory> _categories;
@override@JsonKey() List<ClientPlanCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  String status;
@override@JsonKey() final  String source;
@override final  String? documentUrl;
@override final  String? documentName;
@override final  String? notes;
@override final  DateTime? updatedAt;
@override final  String? updatedBy;

/// Create a copy of ClientPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientPlanCopyWith<_ClientPlan> get copyWith => __$ClientPlanCopyWithImpl<_ClientPlan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientPlan&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.totalBudget, totalBudget) || other.totalBudget == totalBudget)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.status, status) || other.status == status)&&(identical(other.source, source) || other.source == source)&&(identical(other.documentUrl, documentUrl) || other.documentUrl == documentUrl)&&(identical(other.documentName, documentName) || other.documentName == documentName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,totalBudget,const DeepCollectionEquality().hash(_categories),status,source,documentUrl,documentName,notes,updatedAt,updatedBy);

@override
String toString() {
  return 'ClientPlan(startDate: $startDate, endDate: $endDate, totalBudget: $totalBudget, categories: $categories, status: $status, source: $source, documentUrl: $documentUrl, documentName: $documentName, notes: $notes, updatedAt: $updatedAt, updatedBy: $updatedBy)';
}


}

/// @nodoc
abstract mixin class _$ClientPlanCopyWith<$Res> implements $ClientPlanCopyWith<$Res> {
  factory _$ClientPlanCopyWith(_ClientPlan value, $Res Function(_ClientPlan) _then) = __$ClientPlanCopyWithImpl;
@override @useResult
$Res call({
 DateTime? startDate, DateTime? endDate, double totalBudget, List<ClientPlanCategory> categories, String status, String source, String? documentUrl, String? documentName, String? notes, DateTime? updatedAt, String? updatedBy
});




}
/// @nodoc
class __$ClientPlanCopyWithImpl<$Res>
    implements _$ClientPlanCopyWith<$Res> {
  __$ClientPlanCopyWithImpl(this._self, this._then);

  final _ClientPlan _self;
  final $Res Function(_ClientPlan) _then;

/// Create a copy of ClientPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = freezed,Object? endDate = freezed,Object? totalBudget = null,Object? categories = null,Object? status = null,Object? source = null,Object? documentUrl = freezed,Object? documentName = freezed,Object? notes = freezed,Object? updatedAt = freezed,Object? updatedBy = freezed,}) {
  return _then(_ClientPlan(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,totalBudget: null == totalBudget ? _self.totalBudget : totalBudget // ignore: cast_nullable_to_non_nullable
as double,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<ClientPlanCategory>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,documentUrl: freezed == documentUrl ? _self.documentUrl : documentUrl // ignore: cast_nullable_to_non_nullable
as String?,documentName: freezed == documentName ? _self.documentName : documentName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedBy: freezed == updatedBy ? _self.updatedBy : updatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClientSilRef {

 String? get propertyId; String? get roomId; String? get rosterOfCareId;
/// Create a copy of ClientSilRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientSilRefCopyWith<ClientSilRef> get copyWith => _$ClientSilRefCopyWithImpl<ClientSilRef>(this as ClientSilRef, _$identity);

  /// Serializes this ClientSilRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientSilRef&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.rosterOfCareId, rosterOfCareId) || other.rosterOfCareId == rosterOfCareId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,propertyId,roomId,rosterOfCareId);

@override
String toString() {
  return 'ClientSilRef(propertyId: $propertyId, roomId: $roomId, rosterOfCareId: $rosterOfCareId)';
}


}

/// @nodoc
abstract mixin class $ClientSilRefCopyWith<$Res>  {
  factory $ClientSilRefCopyWith(ClientSilRef value, $Res Function(ClientSilRef) _then) = _$ClientSilRefCopyWithImpl;
@useResult
$Res call({
 String? propertyId, String? roomId, String? rosterOfCareId
});




}
/// @nodoc
class _$ClientSilRefCopyWithImpl<$Res>
    implements $ClientSilRefCopyWith<$Res> {
  _$ClientSilRefCopyWithImpl(this._self, this._then);

  final ClientSilRef _self;
  final $Res Function(ClientSilRef) _then;

/// Create a copy of ClientSilRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? propertyId = freezed,Object? roomId = freezed,Object? rosterOfCareId = freezed,}) {
  return _then(_self.copyWith(
propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,rosterOfCareId: freezed == rosterOfCareId ? _self.rosterOfCareId : rosterOfCareId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientSilRef].
extension ClientSilRefPatterns on ClientSilRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientSilRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientSilRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientSilRef value)  $default,){
final _that = this;
switch (_that) {
case _ClientSilRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientSilRef value)?  $default,){
final _that = this;
switch (_that) {
case _ClientSilRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? propertyId,  String? roomId,  String? rosterOfCareId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientSilRef() when $default != null:
return $default(_that.propertyId,_that.roomId,_that.rosterOfCareId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? propertyId,  String? roomId,  String? rosterOfCareId)  $default,) {final _that = this;
switch (_that) {
case _ClientSilRef():
return $default(_that.propertyId,_that.roomId,_that.rosterOfCareId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? propertyId,  String? roomId,  String? rosterOfCareId)?  $default,) {final _that = this;
switch (_that) {
case _ClientSilRef() when $default != null:
return $default(_that.propertyId,_that.roomId,_that.rosterOfCareId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientSilRef implements ClientSilRef {
  const _ClientSilRef({this.propertyId, this.roomId, this.rosterOfCareId});
  factory _ClientSilRef.fromJson(Map<String, dynamic> json) => _$ClientSilRefFromJson(json);

@override final  String? propertyId;
@override final  String? roomId;
@override final  String? rosterOfCareId;

/// Create a copy of ClientSilRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientSilRefCopyWith<_ClientSilRef> get copyWith => __$ClientSilRefCopyWithImpl<_ClientSilRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientSilRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientSilRef&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.rosterOfCareId, rosterOfCareId) || other.rosterOfCareId == rosterOfCareId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,propertyId,roomId,rosterOfCareId);

@override
String toString() {
  return 'ClientSilRef(propertyId: $propertyId, roomId: $roomId, rosterOfCareId: $rosterOfCareId)';
}


}

/// @nodoc
abstract mixin class _$ClientSilRefCopyWith<$Res> implements $ClientSilRefCopyWith<$Res> {
  factory _$ClientSilRefCopyWith(_ClientSilRef value, $Res Function(_ClientSilRef) _then) = __$ClientSilRefCopyWithImpl;
@override @useResult
$Res call({
 String? propertyId, String? roomId, String? rosterOfCareId
});




}
/// @nodoc
class __$ClientSilRefCopyWithImpl<$Res>
    implements _$ClientSilRefCopyWith<$Res> {
  __$ClientSilRefCopyWithImpl(this._self, this._then);

  final _ClientSilRef _self;
  final $Res Function(_ClientSilRef) _then;

/// Create a copy of ClientSilRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? propertyId = freezed,Object? roomId = freezed,Object? rosterOfCareId = freezed,}) {
  return _then(_ClientSilRef(
propertyId: freezed == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as String?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,rosterOfCareId: freezed == rosterOfCareId ? _self.rosterOfCareId : rosterOfCareId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ClientStakeholderRef {

 String? get stakeholderId; String get role; bool get isPrimary;
/// Create a copy of ClientStakeholderRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientStakeholderRefCopyWith<ClientStakeholderRef> get copyWith => _$ClientStakeholderRefCopyWithImpl<ClientStakeholderRef>(this as ClientStakeholderRef, _$identity);

  /// Serializes this ClientStakeholderRef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientStakeholderRef&&(identical(other.stakeholderId, stakeholderId) || other.stakeholderId == stakeholderId)&&(identical(other.role, role) || other.role == role)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stakeholderId,role,isPrimary);

@override
String toString() {
  return 'ClientStakeholderRef(stakeholderId: $stakeholderId, role: $role, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class $ClientStakeholderRefCopyWith<$Res>  {
  factory $ClientStakeholderRefCopyWith(ClientStakeholderRef value, $Res Function(ClientStakeholderRef) _then) = _$ClientStakeholderRefCopyWithImpl;
@useResult
$Res call({
 String? stakeholderId, String role, bool isPrimary
});




}
/// @nodoc
class _$ClientStakeholderRefCopyWithImpl<$Res>
    implements $ClientStakeholderRefCopyWith<$Res> {
  _$ClientStakeholderRefCopyWithImpl(this._self, this._then);

  final ClientStakeholderRef _self;
  final $Res Function(ClientStakeholderRef) _then;

/// Create a copy of ClientStakeholderRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stakeholderId = freezed,Object? role = null,Object? isPrimary = null,}) {
  return _then(_self.copyWith(
stakeholderId: freezed == stakeholderId ? _self.stakeholderId : stakeholderId // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientStakeholderRef].
extension ClientStakeholderRefPatterns on ClientStakeholderRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientStakeholderRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientStakeholderRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientStakeholderRef value)  $default,){
final _that = this;
switch (_that) {
case _ClientStakeholderRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientStakeholderRef value)?  $default,){
final _that = this;
switch (_that) {
case _ClientStakeholderRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? stakeholderId,  String role,  bool isPrimary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientStakeholderRef() when $default != null:
return $default(_that.stakeholderId,_that.role,_that.isPrimary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? stakeholderId,  String role,  bool isPrimary)  $default,) {final _that = this;
switch (_that) {
case _ClientStakeholderRef():
return $default(_that.stakeholderId,_that.role,_that.isPrimary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? stakeholderId,  String role,  bool isPrimary)?  $default,) {final _that = this;
switch (_that) {
case _ClientStakeholderRef() when $default != null:
return $default(_that.stakeholderId,_that.role,_that.isPrimary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClientStakeholderRef implements ClientStakeholderRef {
  const _ClientStakeholderRef({this.stakeholderId, this.role = 'other', this.isPrimary = false});
  factory _ClientStakeholderRef.fromJson(Map<String, dynamic> json) => _$ClientStakeholderRefFromJson(json);

@override final  String? stakeholderId;
@override@JsonKey() final  String role;
@override@JsonKey() final  bool isPrimary;

/// Create a copy of ClientStakeholderRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientStakeholderRefCopyWith<_ClientStakeholderRef> get copyWith => __$ClientStakeholderRefCopyWithImpl<_ClientStakeholderRef>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientStakeholderRefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientStakeholderRef&&(identical(other.stakeholderId, stakeholderId) || other.stakeholderId == stakeholderId)&&(identical(other.role, role) || other.role == role)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,stakeholderId,role,isPrimary);

@override
String toString() {
  return 'ClientStakeholderRef(stakeholderId: $stakeholderId, role: $role, isPrimary: $isPrimary)';
}


}

/// @nodoc
abstract mixin class _$ClientStakeholderRefCopyWith<$Res> implements $ClientStakeholderRefCopyWith<$Res> {
  factory _$ClientStakeholderRefCopyWith(_ClientStakeholderRef value, $Res Function(_ClientStakeholderRef) _then) = __$ClientStakeholderRefCopyWithImpl;
@override @useResult
$Res call({
 String? stakeholderId, String role, bool isPrimary
});




}
/// @nodoc
class __$ClientStakeholderRefCopyWithImpl<$Res>
    implements _$ClientStakeholderRefCopyWith<$Res> {
  __$ClientStakeholderRefCopyWithImpl(this._self, this._then);

  final _ClientStakeholderRef _self;
  final $Res Function(_ClientStakeholderRef) _then;

/// Create a copy of ClientStakeholderRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stakeholderId = freezed,Object? role = null,Object? isPrimary = null,}) {
  return _then(_ClientStakeholderRef(
stakeholderId: freezed == stakeholderId ? _self.stakeholderId : stakeholderId // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ClientModel {

@JsonKey(name: '_id') String? get id;// MongoDB ObjectId from backend
 String? get clientFirstName; String? get clientLastName; String get clientEmail; String? get clientPhone; String? get clientAddress; String? get clientCity; String? get clientState; String? get clientZip; String? get businessName; String? get clientName;// Added for cases where only clientName is provided
 String? get careNotes; Map<String, dynamic>? get preferences; bool get isActive; bool get isActivated; bool get activationPending; DateTime? get deletedAt; DateTime? get purgeAfter;/// NDIS participant number (Phase 6) — required for bulk claiming.
 String? get ndisNumber;/// Funding route (Phase 5/6): ndia_managed | plan_managed | self_managed | combination.
 String? get fundingType;/// Linked NDIS Plan envelope (Milestone 2.2 parity).
 ClientPlan? get plan;/// Linked Supported Independent Living context (Milestone 2.2 parity).
 ClientSilRef? get sil;/// Linked Care Network stakeholders (Milestone 2.2 parity).
 List<ClientStakeholderRef> get stakeholders;/// Emergency contacts and assessments from backend.
 Map<String, dynamic>? get emergencyContact; List<String> get medicalConditions; Map<String, dynamic>? get riskAssessment; String? get organizationId;
/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientModelCopyWith<ClientModel> get copyWith => _$ClientModelCopyWithImpl<ClientModel>(this as ClientModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientFirstName, clientFirstName) || other.clientFirstName == clientFirstName)&&(identical(other.clientLastName, clientLastName) || other.clientLastName == clientLastName)&&(identical(other.clientEmail, clientEmail) || other.clientEmail == clientEmail)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.clientCity, clientCity) || other.clientCity == clientCity)&&(identical(other.clientState, clientState) || other.clientState == clientState)&&(identical(other.clientZip, clientZip) || other.clientZip == clientZip)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.careNotes, careNotes) || other.careNotes == careNotes)&&const DeepCollectionEquality().equals(other.preferences, preferences)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isActivated, isActivated) || other.isActivated == isActivated)&&(identical(other.activationPending, activationPending) || other.activationPending == activationPending)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.purgeAfter, purgeAfter) || other.purgeAfter == purgeAfter)&&(identical(other.ndisNumber, ndisNumber) || other.ndisNumber == ndisNumber)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.sil, sil) || other.sil == sil)&&const DeepCollectionEquality().equals(other.stakeholders, stakeholders)&&const DeepCollectionEquality().equals(other.emergencyContact, emergencyContact)&&const DeepCollectionEquality().equals(other.medicalConditions, medicalConditions)&&const DeepCollectionEquality().equals(other.riskAssessment, riskAssessment)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,clientFirstName,clientLastName,clientEmail,clientPhone,clientAddress,clientCity,clientState,clientZip,businessName,clientName,careNotes,const DeepCollectionEquality().hash(preferences),isActive,isActivated,activationPending,deletedAt,purgeAfter,ndisNumber,fundingType,plan,sil,const DeepCollectionEquality().hash(stakeholders),const DeepCollectionEquality().hash(emergencyContact),const DeepCollectionEquality().hash(medicalConditions),const DeepCollectionEquality().hash(riskAssessment),organizationId]);

@override
String toString() {
  return 'ClientModel(id: $id, clientFirstName: $clientFirstName, clientLastName: $clientLastName, clientEmail: $clientEmail, clientPhone: $clientPhone, clientAddress: $clientAddress, clientCity: $clientCity, clientState: $clientState, clientZip: $clientZip, businessName: $businessName, clientName: $clientName, careNotes: $careNotes, preferences: $preferences, isActive: $isActive, isActivated: $isActivated, activationPending: $activationPending, deletedAt: $deletedAt, purgeAfter: $purgeAfter, ndisNumber: $ndisNumber, fundingType: $fundingType, plan: $plan, sil: $sil, stakeholders: $stakeholders, emergencyContact: $emergencyContact, medicalConditions: $medicalConditions, riskAssessment: $riskAssessment, organizationId: $organizationId)';
}


}

/// @nodoc
abstract mixin class $ClientModelCopyWith<$Res>  {
  factory $ClientModelCopyWith(ClientModel value, $Res Function(ClientModel) _then) = _$ClientModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String? id, String? clientFirstName, String? clientLastName, String clientEmail, String? clientPhone, String? clientAddress, String? clientCity, String? clientState, String? clientZip, String? businessName, String? clientName, String? careNotes, Map<String, dynamic>? preferences, bool isActive, bool isActivated, bool activationPending, DateTime? deletedAt, DateTime? purgeAfter, String? ndisNumber, String? fundingType, ClientPlan? plan, ClientSilRef? sil, List<ClientStakeholderRef> stakeholders, Map<String, dynamic>? emergencyContact, List<String> medicalConditions, Map<String, dynamic>? riskAssessment, String? organizationId
});


$ClientPlanCopyWith<$Res>? get plan;$ClientSilRefCopyWith<$Res>? get sil;

}
/// @nodoc
class _$ClientModelCopyWithImpl<$Res>
    implements $ClientModelCopyWith<$Res> {
  _$ClientModelCopyWithImpl(this._self, this._then);

  final ClientModel _self;
  final $Res Function(ClientModel) _then;

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? clientFirstName = freezed,Object? clientLastName = freezed,Object? clientEmail = null,Object? clientPhone = freezed,Object? clientAddress = freezed,Object? clientCity = freezed,Object? clientState = freezed,Object? clientZip = freezed,Object? businessName = freezed,Object? clientName = freezed,Object? careNotes = freezed,Object? preferences = freezed,Object? isActive = null,Object? isActivated = null,Object? activationPending = null,Object? deletedAt = freezed,Object? purgeAfter = freezed,Object? ndisNumber = freezed,Object? fundingType = freezed,Object? plan = freezed,Object? sil = freezed,Object? stakeholders = null,Object? emergencyContact = freezed,Object? medicalConditions = null,Object? riskAssessment = freezed,Object? organizationId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,clientFirstName: freezed == clientFirstName ? _self.clientFirstName : clientFirstName // ignore: cast_nullable_to_non_nullable
as String?,clientLastName: freezed == clientLastName ? _self.clientLastName : clientLastName // ignore: cast_nullable_to_non_nullable
as String?,clientEmail: null == clientEmail ? _self.clientEmail : clientEmail // ignore: cast_nullable_to_non_nullable
as String,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,clientAddress: freezed == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String?,clientCity: freezed == clientCity ? _self.clientCity : clientCity // ignore: cast_nullable_to_non_nullable
as String?,clientState: freezed == clientState ? _self.clientState : clientState // ignore: cast_nullable_to_non_nullable
as String?,clientZip: freezed == clientZip ? _self.clientZip : clientZip // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,careNotes: freezed == careNotes ? _self.careNotes : careNotes // ignore: cast_nullable_to_non_nullable
as String?,preferences: freezed == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isActivated: null == isActivated ? _self.isActivated : isActivated // ignore: cast_nullable_to_non_nullable
as bool,activationPending: null == activationPending ? _self.activationPending : activationPending // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,purgeAfter: freezed == purgeAfter ? _self.purgeAfter : purgeAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,ndisNumber: freezed == ndisNumber ? _self.ndisNumber : ndisNumber // ignore: cast_nullable_to_non_nullable
as String?,fundingType: freezed == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as ClientPlan?,sil: freezed == sil ? _self.sil : sil // ignore: cast_nullable_to_non_nullable
as ClientSilRef?,stakeholders: null == stakeholders ? _self.stakeholders : stakeholders // ignore: cast_nullable_to_non_nullable
as List<ClientStakeholderRef>,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,medicalConditions: null == medicalConditions ? _self.medicalConditions : medicalConditions // ignore: cast_nullable_to_non_nullable
as List<String>,riskAssessment: freezed == riskAssessment ? _self.riskAssessment : riskAssessment // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $ClientPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientSilRefCopyWith<$Res>? get sil {
    if (_self.sil == null) {
    return null;
  }

  return $ClientSilRefCopyWith<$Res>(_self.sil!, (value) {
    return _then(_self.copyWith(sil: value));
  });
}
}


/// Adds pattern-matching-related methods to [ClientModel].
extension ClientModelPatterns on ClientModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClientModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClientModel value)  $default,){
final _that = this;
switch (_that) {
case _ClientModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClientModel value)?  $default,){
final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String? clientFirstName,  String? clientLastName,  String clientEmail,  String? clientPhone,  String? clientAddress,  String? clientCity,  String? clientState,  String? clientZip,  String? businessName,  String? clientName,  String? careNotes,  Map<String, dynamic>? preferences,  bool isActive,  bool isActivated,  bool activationPending,  DateTime? deletedAt,  DateTime? purgeAfter,  String? ndisNumber,  String? fundingType,  ClientPlan? plan,  ClientSilRef? sil,  List<ClientStakeholderRef> stakeholders,  Map<String, dynamic>? emergencyContact,  List<String> medicalConditions,  Map<String, dynamic>? riskAssessment,  String? organizationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
return $default(_that.id,_that.clientFirstName,_that.clientLastName,_that.clientEmail,_that.clientPhone,_that.clientAddress,_that.clientCity,_that.clientState,_that.clientZip,_that.businessName,_that.clientName,_that.careNotes,_that.preferences,_that.isActive,_that.isActivated,_that.activationPending,_that.deletedAt,_that.purgeAfter,_that.ndisNumber,_that.fundingType,_that.plan,_that.sil,_that.stakeholders,_that.emergencyContact,_that.medicalConditions,_that.riskAssessment,_that.organizationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String? id,  String? clientFirstName,  String? clientLastName,  String clientEmail,  String? clientPhone,  String? clientAddress,  String? clientCity,  String? clientState,  String? clientZip,  String? businessName,  String? clientName,  String? careNotes,  Map<String, dynamic>? preferences,  bool isActive,  bool isActivated,  bool activationPending,  DateTime? deletedAt,  DateTime? purgeAfter,  String? ndisNumber,  String? fundingType,  ClientPlan? plan,  ClientSilRef? sil,  List<ClientStakeholderRef> stakeholders,  Map<String, dynamic>? emergencyContact,  List<String> medicalConditions,  Map<String, dynamic>? riskAssessment,  String? organizationId)  $default,) {final _that = this;
switch (_that) {
case _ClientModel():
return $default(_that.id,_that.clientFirstName,_that.clientLastName,_that.clientEmail,_that.clientPhone,_that.clientAddress,_that.clientCity,_that.clientState,_that.clientZip,_that.businessName,_that.clientName,_that.careNotes,_that.preferences,_that.isActive,_that.isActivated,_that.activationPending,_that.deletedAt,_that.purgeAfter,_that.ndisNumber,_that.fundingType,_that.plan,_that.sil,_that.stakeholders,_that.emergencyContact,_that.medicalConditions,_that.riskAssessment,_that.organizationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String? id,  String? clientFirstName,  String? clientLastName,  String clientEmail,  String? clientPhone,  String? clientAddress,  String? clientCity,  String? clientState,  String? clientZip,  String? businessName,  String? clientName,  String? careNotes,  Map<String, dynamic>? preferences,  bool isActive,  bool isActivated,  bool activationPending,  DateTime? deletedAt,  DateTime? purgeAfter,  String? ndisNumber,  String? fundingType,  ClientPlan? plan,  ClientSilRef? sil,  List<ClientStakeholderRef> stakeholders,  Map<String, dynamic>? emergencyContact,  List<String> medicalConditions,  Map<String, dynamic>? riskAssessment,  String? organizationId)?  $default,) {final _that = this;
switch (_that) {
case _ClientModel() when $default != null:
return $default(_that.id,_that.clientFirstName,_that.clientLastName,_that.clientEmail,_that.clientPhone,_that.clientAddress,_that.clientCity,_that.clientState,_that.clientZip,_that.businessName,_that.clientName,_that.careNotes,_that.preferences,_that.isActive,_that.isActivated,_that.activationPending,_that.deletedAt,_that.purgeAfter,_that.ndisNumber,_that.fundingType,_that.plan,_that.sil,_that.stakeholders,_that.emergencyContact,_that.medicalConditions,_that.riskAssessment,_that.organizationId);case _:
  return null;

}
}

}

/// @nodoc


class _ClientModel extends ClientModel {
  const _ClientModel({@JsonKey(name: '_id') this.id, this.clientFirstName, this.clientLastName, this.clientEmail = '', this.clientPhone, this.clientAddress, this.clientCity, this.clientState, this.clientZip, this.businessName, this.clientName, this.careNotes, final  Map<String, dynamic>? preferences, this.isActive = true, this.isActivated = false, this.activationPending = false, this.deletedAt, this.purgeAfter, this.ndisNumber, this.fundingType = 'plan_managed', this.plan, this.sil, final  List<ClientStakeholderRef> stakeholders = const <ClientStakeholderRef>[], final  Map<String, dynamic>? emergencyContact, final  List<String> medicalConditions = const <String>[], final  Map<String, dynamic>? riskAssessment, this.organizationId}): _preferences = preferences,_stakeholders = stakeholders,_emergencyContact = emergencyContact,_medicalConditions = medicalConditions,_riskAssessment = riskAssessment,super._();
  

@override@JsonKey(name: '_id') final  String? id;
// MongoDB ObjectId from backend
@override final  String? clientFirstName;
@override final  String? clientLastName;
@override@JsonKey() final  String clientEmail;
@override final  String? clientPhone;
@override final  String? clientAddress;
@override final  String? clientCity;
@override final  String? clientState;
@override final  String? clientZip;
@override final  String? businessName;
@override final  String? clientName;
// Added for cases where only clientName is provided
@override final  String? careNotes;
 final  Map<String, dynamic>? _preferences;
@override Map<String, dynamic>? get preferences {
  final value = _preferences;
  if (value == null) return null;
  if (_preferences is EqualUnmodifiableMapView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isActivated;
@override@JsonKey() final  bool activationPending;
@override final  DateTime? deletedAt;
@override final  DateTime? purgeAfter;
/// NDIS participant number (Phase 6) — required for bulk claiming.
@override final  String? ndisNumber;
/// Funding route (Phase 5/6): ndia_managed | plan_managed | self_managed | combination.
@override@JsonKey() final  String? fundingType;
/// Linked NDIS Plan envelope (Milestone 2.2 parity).
@override final  ClientPlan? plan;
/// Linked Supported Independent Living context (Milestone 2.2 parity).
@override final  ClientSilRef? sil;
/// Linked Care Network stakeholders (Milestone 2.2 parity).
 final  List<ClientStakeholderRef> _stakeholders;
/// Linked Care Network stakeholders (Milestone 2.2 parity).
@override@JsonKey() List<ClientStakeholderRef> get stakeholders {
  if (_stakeholders is EqualUnmodifiableListView) return _stakeholders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stakeholders);
}

/// Emergency contacts and assessments from backend.
 final  Map<String, dynamic>? _emergencyContact;
/// Emergency contacts and assessments from backend.
@override Map<String, dynamic>? get emergencyContact {
  final value = _emergencyContact;
  if (value == null) return null;
  if (_emergencyContact is EqualUnmodifiableMapView) return _emergencyContact;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String> _medicalConditions;
@override@JsonKey() List<String> get medicalConditions {
  if (_medicalConditions is EqualUnmodifiableListView) return _medicalConditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medicalConditions);
}

 final  Map<String, dynamic>? _riskAssessment;
@override Map<String, dynamic>? get riskAssessment {
  final value = _riskAssessment;
  if (value == null) return null;
  if (_riskAssessment is EqualUnmodifiableMapView) return _riskAssessment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? organizationId;

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClientModelCopyWith<_ClientModel> get copyWith => __$ClientModelCopyWithImpl<_ClientModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClientModel&&(identical(other.id, id) || other.id == id)&&(identical(other.clientFirstName, clientFirstName) || other.clientFirstName == clientFirstName)&&(identical(other.clientLastName, clientLastName) || other.clientLastName == clientLastName)&&(identical(other.clientEmail, clientEmail) || other.clientEmail == clientEmail)&&(identical(other.clientPhone, clientPhone) || other.clientPhone == clientPhone)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.clientCity, clientCity) || other.clientCity == clientCity)&&(identical(other.clientState, clientState) || other.clientState == clientState)&&(identical(other.clientZip, clientZip) || other.clientZip == clientZip)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.careNotes, careNotes) || other.careNotes == careNotes)&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isActivated, isActivated) || other.isActivated == isActivated)&&(identical(other.activationPending, activationPending) || other.activationPending == activationPending)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.purgeAfter, purgeAfter) || other.purgeAfter == purgeAfter)&&(identical(other.ndisNumber, ndisNumber) || other.ndisNumber == ndisNumber)&&(identical(other.fundingType, fundingType) || other.fundingType == fundingType)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.sil, sil) || other.sil == sil)&&const DeepCollectionEquality().equals(other._stakeholders, _stakeholders)&&const DeepCollectionEquality().equals(other._emergencyContact, _emergencyContact)&&const DeepCollectionEquality().equals(other._medicalConditions, _medicalConditions)&&const DeepCollectionEquality().equals(other._riskAssessment, _riskAssessment)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,clientFirstName,clientLastName,clientEmail,clientPhone,clientAddress,clientCity,clientState,clientZip,businessName,clientName,careNotes,const DeepCollectionEquality().hash(_preferences),isActive,isActivated,activationPending,deletedAt,purgeAfter,ndisNumber,fundingType,plan,sil,const DeepCollectionEquality().hash(_stakeholders),const DeepCollectionEquality().hash(_emergencyContact),const DeepCollectionEquality().hash(_medicalConditions),const DeepCollectionEquality().hash(_riskAssessment),organizationId]);

@override
String toString() {
  return 'ClientModel(id: $id, clientFirstName: $clientFirstName, clientLastName: $clientLastName, clientEmail: $clientEmail, clientPhone: $clientPhone, clientAddress: $clientAddress, clientCity: $clientCity, clientState: $clientState, clientZip: $clientZip, businessName: $businessName, clientName: $clientName, careNotes: $careNotes, preferences: $preferences, isActive: $isActive, isActivated: $isActivated, activationPending: $activationPending, deletedAt: $deletedAt, purgeAfter: $purgeAfter, ndisNumber: $ndisNumber, fundingType: $fundingType, plan: $plan, sil: $sil, stakeholders: $stakeholders, emergencyContact: $emergencyContact, medicalConditions: $medicalConditions, riskAssessment: $riskAssessment, organizationId: $organizationId)';
}


}

/// @nodoc
abstract mixin class _$ClientModelCopyWith<$Res> implements $ClientModelCopyWith<$Res> {
  factory _$ClientModelCopyWith(_ClientModel value, $Res Function(_ClientModel) _then) = __$ClientModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String? id, String? clientFirstName, String? clientLastName, String clientEmail, String? clientPhone, String? clientAddress, String? clientCity, String? clientState, String? clientZip, String? businessName, String? clientName, String? careNotes, Map<String, dynamic>? preferences, bool isActive, bool isActivated, bool activationPending, DateTime? deletedAt, DateTime? purgeAfter, String? ndisNumber, String? fundingType, ClientPlan? plan, ClientSilRef? sil, List<ClientStakeholderRef> stakeholders, Map<String, dynamic>? emergencyContact, List<String> medicalConditions, Map<String, dynamic>? riskAssessment, String? organizationId
});


@override $ClientPlanCopyWith<$Res>? get plan;@override $ClientSilRefCopyWith<$Res>? get sil;

}
/// @nodoc
class __$ClientModelCopyWithImpl<$Res>
    implements _$ClientModelCopyWith<$Res> {
  __$ClientModelCopyWithImpl(this._self, this._then);

  final _ClientModel _self;
  final $Res Function(_ClientModel) _then;

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? clientFirstName = freezed,Object? clientLastName = freezed,Object? clientEmail = null,Object? clientPhone = freezed,Object? clientAddress = freezed,Object? clientCity = freezed,Object? clientState = freezed,Object? clientZip = freezed,Object? businessName = freezed,Object? clientName = freezed,Object? careNotes = freezed,Object? preferences = freezed,Object? isActive = null,Object? isActivated = null,Object? activationPending = null,Object? deletedAt = freezed,Object? purgeAfter = freezed,Object? ndisNumber = freezed,Object? fundingType = freezed,Object? plan = freezed,Object? sil = freezed,Object? stakeholders = null,Object? emergencyContact = freezed,Object? medicalConditions = null,Object? riskAssessment = freezed,Object? organizationId = freezed,}) {
  return _then(_ClientModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,clientFirstName: freezed == clientFirstName ? _self.clientFirstName : clientFirstName // ignore: cast_nullable_to_non_nullable
as String?,clientLastName: freezed == clientLastName ? _self.clientLastName : clientLastName // ignore: cast_nullable_to_non_nullable
as String?,clientEmail: null == clientEmail ? _self.clientEmail : clientEmail // ignore: cast_nullable_to_non_nullable
as String,clientPhone: freezed == clientPhone ? _self.clientPhone : clientPhone // ignore: cast_nullable_to_non_nullable
as String?,clientAddress: freezed == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String?,clientCity: freezed == clientCity ? _self.clientCity : clientCity // ignore: cast_nullable_to_non_nullable
as String?,clientState: freezed == clientState ? _self.clientState : clientState // ignore: cast_nullable_to_non_nullable
as String?,clientZip: freezed == clientZip ? _self.clientZip : clientZip // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,careNotes: freezed == careNotes ? _self.careNotes : careNotes // ignore: cast_nullable_to_non_nullable
as String?,preferences: freezed == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isActivated: null == isActivated ? _self.isActivated : isActivated // ignore: cast_nullable_to_non_nullable
as bool,activationPending: null == activationPending ? _self.activationPending : activationPending // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,purgeAfter: freezed == purgeAfter ? _self.purgeAfter : purgeAfter // ignore: cast_nullable_to_non_nullable
as DateTime?,ndisNumber: freezed == ndisNumber ? _self.ndisNumber : ndisNumber // ignore: cast_nullable_to_non_nullable
as String?,fundingType: freezed == fundingType ? _self.fundingType : fundingType // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as ClientPlan?,sil: freezed == sil ? _self.sil : sil // ignore: cast_nullable_to_non_nullable
as ClientSilRef?,stakeholders: null == stakeholders ? _self._stakeholders : stakeholders // ignore: cast_nullable_to_non_nullable
as List<ClientStakeholderRef>,emergencyContact: freezed == emergencyContact ? _self._emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,medicalConditions: null == medicalConditions ? _self._medicalConditions : medicalConditions // ignore: cast_nullable_to_non_nullable
as List<String>,riskAssessment: freezed == riskAssessment ? _self._riskAssessment : riskAssessment // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $ClientPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of ClientModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClientSilRefCopyWith<$Res>? get sil {
    if (_self.sil == null) {
    return null;
  }

  return $ClientSilRefCopyWith<$Res>(_self.sil!, (value) {
    return _then(_self.copyWith(sil: value));
  });
}
}

// dart format on
