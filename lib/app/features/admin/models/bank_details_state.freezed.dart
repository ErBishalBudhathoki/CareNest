// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BankDetailsState {

 String get bankName; String get accountName; String get bsb; String get accountNumber; bool get isLoading; String? get errorMessage;
/// Create a copy of BankDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankDetailsStateCopyWith<BankDetailsState> get copyWith => _$BankDetailsStateCopyWithImpl<BankDetailsState>(this as BankDetailsState, _$identity);

  /// Serializes this BankDetailsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankDetailsState&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bsb, bsb) || other.bsb == bsb)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankName,accountName,bsb,accountNumber,isLoading,errorMessage);

@override
String toString() {
  return 'BankDetailsState(bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $BankDetailsStateCopyWith<$Res>  {
  factory $BankDetailsStateCopyWith(BankDetailsState value, $Res Function(BankDetailsState) _then) = _$BankDetailsStateCopyWithImpl;
@useResult
$Res call({
 String bankName, String accountName, String bsb, String accountNumber, bool isLoading, String? errorMessage
});




}
/// @nodoc
class _$BankDetailsStateCopyWithImpl<$Res>
    implements $BankDetailsStateCopyWith<$Res> {
  _$BankDetailsStateCopyWithImpl(this._self, this._then);

  final BankDetailsState _self;
  final $Res Function(BankDetailsState) _then;

/// Create a copy of BankDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bankName = null,Object? accountName = null,Object? bsb = null,Object? accountNumber = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,bsb: null == bsb ? _self.bsb : bsb // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BankDetailsState].
extension BankDetailsStatePatterns on BankDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _BankDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _BankDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bankName,  String accountName,  String bsb,  String accountNumber,  bool isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankDetailsState() when $default != null:
return $default(_that.bankName,_that.accountName,_that.bsb,_that.accountNumber,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bankName,  String accountName,  String bsb,  String accountNumber,  bool isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BankDetailsState():
return $default(_that.bankName,_that.accountName,_that.bsb,_that.accountNumber,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bankName,  String accountName,  String bsb,  String accountNumber,  bool isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BankDetailsState() when $default != null:
return $default(_that.bankName,_that.accountName,_that.bsb,_that.accountNumber,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BankDetailsState implements BankDetailsState {
  const _BankDetailsState({this.bankName = '', this.accountName = '', this.bsb = '', this.accountNumber = '', this.isLoading = false, this.errorMessage});
  factory _BankDetailsState.fromJson(Map<String, dynamic> json) => _$BankDetailsStateFromJson(json);

@override@JsonKey() final  String bankName;
@override@JsonKey() final  String accountName;
@override@JsonKey() final  String bsb;
@override@JsonKey() final  String accountNumber;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;

/// Create a copy of BankDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankDetailsStateCopyWith<_BankDetailsState> get copyWith => __$BankDetailsStateCopyWithImpl<_BankDetailsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankDetailsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankDetailsState&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.bsb, bsb) || other.bsb == bsb)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankName,accountName,bsb,accountNumber,isLoading,errorMessage);

@override
String toString() {
  return 'BankDetailsState(bankName: $bankName, accountName: $accountName, bsb: $bsb, accountNumber: $accountNumber, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BankDetailsStateCopyWith<$Res> implements $BankDetailsStateCopyWith<$Res> {
  factory _$BankDetailsStateCopyWith(_BankDetailsState value, $Res Function(_BankDetailsState) _then) = __$BankDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 String bankName, String accountName, String bsb, String accountNumber, bool isLoading, String? errorMessage
});




}
/// @nodoc
class __$BankDetailsStateCopyWithImpl<$Res>
    implements _$BankDetailsStateCopyWith<$Res> {
  __$BankDetailsStateCopyWithImpl(this._self, this._then);

  final _BankDetailsState _self;
  final $Res Function(_BankDetailsState) _then;

/// Create a copy of BankDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bankName = null,Object? accountName = null,Object? bsb = null,Object? accountNumber = null,Object? isLoading = null,Object? errorMessage = freezed,}) {
  return _then(_BankDetailsState(
bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,bsb: null == bsb ? _self.bsb : bsb // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
