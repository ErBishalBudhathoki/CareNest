// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advanced_payroll_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PayrollCalculation {

 String get userId; String get period; double get baseHours; double get baseRate; double get baseAmount; PenaltyRates get penalties; Allowances get allowances; LeaveAccrual get leaveAccrual; TaxAndSuper get taxAndSuper; double get grossPay; double get netPay;
/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayrollCalculationCopyWith<PayrollCalculation> get copyWith => _$PayrollCalculationCopyWithImpl<PayrollCalculation>(this as PayrollCalculation, _$identity);

  /// Serializes this PayrollCalculation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayrollCalculation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.period, period) || other.period == period)&&(identical(other.baseHours, baseHours) || other.baseHours == baseHours)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.baseAmount, baseAmount) || other.baseAmount == baseAmount)&&(identical(other.penalties, penalties) || other.penalties == penalties)&&(identical(other.allowances, allowances) || other.allowances == allowances)&&(identical(other.leaveAccrual, leaveAccrual) || other.leaveAccrual == leaveAccrual)&&(identical(other.taxAndSuper, taxAndSuper) || other.taxAndSuper == taxAndSuper)&&(identical(other.grossPay, grossPay) || other.grossPay == grossPay)&&(identical(other.netPay, netPay) || other.netPay == netPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,period,baseHours,baseRate,baseAmount,penalties,allowances,leaveAccrual,taxAndSuper,grossPay,netPay);

@override
String toString() {
  return 'PayrollCalculation(userId: $userId, period: $period, baseHours: $baseHours, baseRate: $baseRate, baseAmount: $baseAmount, penalties: $penalties, allowances: $allowances, leaveAccrual: $leaveAccrual, taxAndSuper: $taxAndSuper, grossPay: $grossPay, netPay: $netPay)';
}


}

/// @nodoc
abstract mixin class $PayrollCalculationCopyWith<$Res>  {
  factory $PayrollCalculationCopyWith(PayrollCalculation value, $Res Function(PayrollCalculation) _then) = _$PayrollCalculationCopyWithImpl;
@useResult
$Res call({
 String userId, String period, double baseHours, double baseRate, double baseAmount, PenaltyRates penalties, Allowances allowances, LeaveAccrual leaveAccrual, TaxAndSuper taxAndSuper, double grossPay, double netPay
});


$PenaltyRatesCopyWith<$Res> get penalties;$AllowancesCopyWith<$Res> get allowances;$LeaveAccrualCopyWith<$Res> get leaveAccrual;$TaxAndSuperCopyWith<$Res> get taxAndSuper;

}
/// @nodoc
class _$PayrollCalculationCopyWithImpl<$Res>
    implements $PayrollCalculationCopyWith<$Res> {
  _$PayrollCalculationCopyWithImpl(this._self, this._then);

  final PayrollCalculation _self;
  final $Res Function(PayrollCalculation) _then;

/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? period = null,Object? baseHours = null,Object? baseRate = null,Object? baseAmount = null,Object? penalties = null,Object? allowances = null,Object? leaveAccrual = null,Object? taxAndSuper = null,Object? grossPay = null,Object? netPay = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,baseHours: null == baseHours ? _self.baseHours : baseHours // ignore: cast_nullable_to_non_nullable
as double,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,baseAmount: null == baseAmount ? _self.baseAmount : baseAmount // ignore: cast_nullable_to_non_nullable
as double,penalties: null == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as PenaltyRates,allowances: null == allowances ? _self.allowances : allowances // ignore: cast_nullable_to_non_nullable
as Allowances,leaveAccrual: null == leaveAccrual ? _self.leaveAccrual : leaveAccrual // ignore: cast_nullable_to_non_nullable
as LeaveAccrual,taxAndSuper: null == taxAndSuper ? _self.taxAndSuper : taxAndSuper // ignore: cast_nullable_to_non_nullable
as TaxAndSuper,grossPay: null == grossPay ? _self.grossPay : grossPay // ignore: cast_nullable_to_non_nullable
as double,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRatesCopyWith<$Res> get penalties {
  
  return $PenaltyRatesCopyWith<$Res>(_self.penalties, (value) {
    return _then(_self.copyWith(penalties: value));
  });
}/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AllowancesCopyWith<$Res> get allowances {
  
  return $AllowancesCopyWith<$Res>(_self.allowances, (value) {
    return _then(_self.copyWith(allowances: value));
  });
}/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveAccrualCopyWith<$Res> get leaveAccrual {
  
  return $LeaveAccrualCopyWith<$Res>(_self.leaveAccrual, (value) {
    return _then(_self.copyWith(leaveAccrual: value));
  });
}/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaxAndSuperCopyWith<$Res> get taxAndSuper {
  
  return $TaxAndSuperCopyWith<$Res>(_self.taxAndSuper, (value) {
    return _then(_self.copyWith(taxAndSuper: value));
  });
}
}


/// Adds pattern-matching-related methods to [PayrollCalculation].
extension PayrollCalculationPatterns on PayrollCalculation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayrollCalculation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayrollCalculation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayrollCalculation value)  $default,){
final _that = this;
switch (_that) {
case _PayrollCalculation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayrollCalculation value)?  $default,){
final _that = this;
switch (_that) {
case _PayrollCalculation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String period,  double baseHours,  double baseRate,  double baseAmount,  PenaltyRates penalties,  Allowances allowances,  LeaveAccrual leaveAccrual,  TaxAndSuper taxAndSuper,  double grossPay,  double netPay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayrollCalculation() when $default != null:
return $default(_that.userId,_that.period,_that.baseHours,_that.baseRate,_that.baseAmount,_that.penalties,_that.allowances,_that.leaveAccrual,_that.taxAndSuper,_that.grossPay,_that.netPay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String period,  double baseHours,  double baseRate,  double baseAmount,  PenaltyRates penalties,  Allowances allowances,  LeaveAccrual leaveAccrual,  TaxAndSuper taxAndSuper,  double grossPay,  double netPay)  $default,) {final _that = this;
switch (_that) {
case _PayrollCalculation():
return $default(_that.userId,_that.period,_that.baseHours,_that.baseRate,_that.baseAmount,_that.penalties,_that.allowances,_that.leaveAccrual,_that.taxAndSuper,_that.grossPay,_that.netPay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String period,  double baseHours,  double baseRate,  double baseAmount,  PenaltyRates penalties,  Allowances allowances,  LeaveAccrual leaveAccrual,  TaxAndSuper taxAndSuper,  double grossPay,  double netPay)?  $default,) {final _that = this;
switch (_that) {
case _PayrollCalculation() when $default != null:
return $default(_that.userId,_that.period,_that.baseHours,_that.baseRate,_that.baseAmount,_that.penalties,_that.allowances,_that.leaveAccrual,_that.taxAndSuper,_that.grossPay,_that.netPay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayrollCalculation implements PayrollCalculation {
  const _PayrollCalculation({required this.userId, required this.period, required this.baseHours, required this.baseRate, required this.baseAmount, required this.penalties, required this.allowances, required this.leaveAccrual, required this.taxAndSuper, required this.grossPay, required this.netPay});
  factory _PayrollCalculation.fromJson(Map<String, dynamic> json) => _$PayrollCalculationFromJson(json);

@override final  String userId;
@override final  String period;
@override final  double baseHours;
@override final  double baseRate;
@override final  double baseAmount;
@override final  PenaltyRates penalties;
@override final  Allowances allowances;
@override final  LeaveAccrual leaveAccrual;
@override final  TaxAndSuper taxAndSuper;
@override final  double grossPay;
@override final  double netPay;

/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayrollCalculationCopyWith<_PayrollCalculation> get copyWith => __$PayrollCalculationCopyWithImpl<_PayrollCalculation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayrollCalculationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayrollCalculation&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.period, period) || other.period == period)&&(identical(other.baseHours, baseHours) || other.baseHours == baseHours)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.baseAmount, baseAmount) || other.baseAmount == baseAmount)&&(identical(other.penalties, penalties) || other.penalties == penalties)&&(identical(other.allowances, allowances) || other.allowances == allowances)&&(identical(other.leaveAccrual, leaveAccrual) || other.leaveAccrual == leaveAccrual)&&(identical(other.taxAndSuper, taxAndSuper) || other.taxAndSuper == taxAndSuper)&&(identical(other.grossPay, grossPay) || other.grossPay == grossPay)&&(identical(other.netPay, netPay) || other.netPay == netPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,period,baseHours,baseRate,baseAmount,penalties,allowances,leaveAccrual,taxAndSuper,grossPay,netPay);

@override
String toString() {
  return 'PayrollCalculation(userId: $userId, period: $period, baseHours: $baseHours, baseRate: $baseRate, baseAmount: $baseAmount, penalties: $penalties, allowances: $allowances, leaveAccrual: $leaveAccrual, taxAndSuper: $taxAndSuper, grossPay: $grossPay, netPay: $netPay)';
}


}

/// @nodoc
abstract mixin class _$PayrollCalculationCopyWith<$Res> implements $PayrollCalculationCopyWith<$Res> {
  factory _$PayrollCalculationCopyWith(_PayrollCalculation value, $Res Function(_PayrollCalculation) _then) = __$PayrollCalculationCopyWithImpl;
@override @useResult
$Res call({
 String userId, String period, double baseHours, double baseRate, double baseAmount, PenaltyRates penalties, Allowances allowances, LeaveAccrual leaveAccrual, TaxAndSuper taxAndSuper, double grossPay, double netPay
});


@override $PenaltyRatesCopyWith<$Res> get penalties;@override $AllowancesCopyWith<$Res> get allowances;@override $LeaveAccrualCopyWith<$Res> get leaveAccrual;@override $TaxAndSuperCopyWith<$Res> get taxAndSuper;

}
/// @nodoc
class __$PayrollCalculationCopyWithImpl<$Res>
    implements _$PayrollCalculationCopyWith<$Res> {
  __$PayrollCalculationCopyWithImpl(this._self, this._then);

  final _PayrollCalculation _self;
  final $Res Function(_PayrollCalculation) _then;

/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? period = null,Object? baseHours = null,Object? baseRate = null,Object? baseAmount = null,Object? penalties = null,Object? allowances = null,Object? leaveAccrual = null,Object? taxAndSuper = null,Object? grossPay = null,Object? netPay = null,}) {
  return _then(_PayrollCalculation(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,baseHours: null == baseHours ? _self.baseHours : baseHours // ignore: cast_nullable_to_non_nullable
as double,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,baseAmount: null == baseAmount ? _self.baseAmount : baseAmount // ignore: cast_nullable_to_non_nullable
as double,penalties: null == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as PenaltyRates,allowances: null == allowances ? _self.allowances : allowances // ignore: cast_nullable_to_non_nullable
as Allowances,leaveAccrual: null == leaveAccrual ? _self.leaveAccrual : leaveAccrual // ignore: cast_nullable_to_non_nullable
as LeaveAccrual,taxAndSuper: null == taxAndSuper ? _self.taxAndSuper : taxAndSuper // ignore: cast_nullable_to_non_nullable
as TaxAndSuper,grossPay: null == grossPay ? _self.grossPay : grossPay // ignore: cast_nullable_to_non_nullable
as double,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRatesCopyWith<$Res> get penalties {
  
  return $PenaltyRatesCopyWith<$Res>(_self.penalties, (value) {
    return _then(_self.copyWith(penalties: value));
  });
}/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AllowancesCopyWith<$Res> get allowances {
  
  return $AllowancesCopyWith<$Res>(_self.allowances, (value) {
    return _then(_self.copyWith(allowances: value));
  });
}/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveAccrualCopyWith<$Res> get leaveAccrual {
  
  return $LeaveAccrualCopyWith<$Res>(_self.leaveAccrual, (value) {
    return _then(_self.copyWith(leaveAccrual: value));
  });
}/// Create a copy of PayrollCalculation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaxAndSuperCopyWith<$Res> get taxAndSuper {
  
  return $TaxAndSuperCopyWith<$Res>(_self.taxAndSuper, (value) {
    return _then(_self.copyWith(taxAndSuper: value));
  });
}
}


/// @nodoc
mixin _$PenaltyRates {

 PenaltyRate get saturday; PenaltyRate get sunday; PenaltyRate get publicHoliday; PenaltyRate get overtime; double get total;
/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenaltyRatesCopyWith<PenaltyRates> get copyWith => _$PenaltyRatesCopyWithImpl<PenaltyRates>(this as PenaltyRates, _$identity);

  /// Serializes this PenaltyRates to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenaltyRates&&(identical(other.saturday, saturday) || other.saturday == saturday)&&(identical(other.sunday, sunday) || other.sunday == sunday)&&(identical(other.publicHoliday, publicHoliday) || other.publicHoliday == publicHoliday)&&(identical(other.overtime, overtime) || other.overtime == overtime)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,saturday,sunday,publicHoliday,overtime,total);

@override
String toString() {
  return 'PenaltyRates(saturday: $saturday, sunday: $sunday, publicHoliday: $publicHoliday, overtime: $overtime, total: $total)';
}


}

/// @nodoc
abstract mixin class $PenaltyRatesCopyWith<$Res>  {
  factory $PenaltyRatesCopyWith(PenaltyRates value, $Res Function(PenaltyRates) _then) = _$PenaltyRatesCopyWithImpl;
@useResult
$Res call({
 PenaltyRate saturday, PenaltyRate sunday, PenaltyRate publicHoliday, PenaltyRate overtime, double total
});


$PenaltyRateCopyWith<$Res> get saturday;$PenaltyRateCopyWith<$Res> get sunday;$PenaltyRateCopyWith<$Res> get publicHoliday;$PenaltyRateCopyWith<$Res> get overtime;

}
/// @nodoc
class _$PenaltyRatesCopyWithImpl<$Res>
    implements $PenaltyRatesCopyWith<$Res> {
  _$PenaltyRatesCopyWithImpl(this._self, this._then);

  final PenaltyRates _self;
  final $Res Function(PenaltyRates) _then;

/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saturday = null,Object? sunday = null,Object? publicHoliday = null,Object? overtime = null,Object? total = null,}) {
  return _then(_self.copyWith(
saturday: null == saturday ? _self.saturday : saturday // ignore: cast_nullable_to_non_nullable
as PenaltyRate,sunday: null == sunday ? _self.sunday : sunday // ignore: cast_nullable_to_non_nullable
as PenaltyRate,publicHoliday: null == publicHoliday ? _self.publicHoliday : publicHoliday // ignore: cast_nullable_to_non_nullable
as PenaltyRate,overtime: null == overtime ? _self.overtime : overtime // ignore: cast_nullable_to_non_nullable
as PenaltyRate,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get saturday {
  
  return $PenaltyRateCopyWith<$Res>(_self.saturday, (value) {
    return _then(_self.copyWith(saturday: value));
  });
}/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get sunday {
  
  return $PenaltyRateCopyWith<$Res>(_self.sunday, (value) {
    return _then(_self.copyWith(sunday: value));
  });
}/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get publicHoliday {
  
  return $PenaltyRateCopyWith<$Res>(_self.publicHoliday, (value) {
    return _then(_self.copyWith(publicHoliday: value));
  });
}/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get overtime {
  
  return $PenaltyRateCopyWith<$Res>(_self.overtime, (value) {
    return _then(_self.copyWith(overtime: value));
  });
}
}


/// Adds pattern-matching-related methods to [PenaltyRates].
extension PenaltyRatesPatterns on PenaltyRates {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PenaltyRates value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PenaltyRates() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PenaltyRates value)  $default,){
final _that = this;
switch (_that) {
case _PenaltyRates():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PenaltyRates value)?  $default,){
final _that = this;
switch (_that) {
case _PenaltyRates() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PenaltyRate saturday,  PenaltyRate sunday,  PenaltyRate publicHoliday,  PenaltyRate overtime,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PenaltyRates() when $default != null:
return $default(_that.saturday,_that.sunday,_that.publicHoliday,_that.overtime,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PenaltyRate saturday,  PenaltyRate sunday,  PenaltyRate publicHoliday,  PenaltyRate overtime,  double total)  $default,) {final _that = this;
switch (_that) {
case _PenaltyRates():
return $default(_that.saturday,_that.sunday,_that.publicHoliday,_that.overtime,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PenaltyRate saturday,  PenaltyRate sunday,  PenaltyRate publicHoliday,  PenaltyRate overtime,  double total)?  $default,) {final _that = this;
switch (_that) {
case _PenaltyRates() when $default != null:
return $default(_that.saturday,_that.sunday,_that.publicHoliday,_that.overtime,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PenaltyRates implements PenaltyRates {
  const _PenaltyRates({required this.saturday, required this.sunday, required this.publicHoliday, required this.overtime, required this.total});
  factory _PenaltyRates.fromJson(Map<String, dynamic> json) => _$PenaltyRatesFromJson(json);

@override final  PenaltyRate saturday;
@override final  PenaltyRate sunday;
@override final  PenaltyRate publicHoliday;
@override final  PenaltyRate overtime;
@override final  double total;

/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PenaltyRatesCopyWith<_PenaltyRates> get copyWith => __$PenaltyRatesCopyWithImpl<_PenaltyRates>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenaltyRatesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PenaltyRates&&(identical(other.saturday, saturday) || other.saturday == saturday)&&(identical(other.sunday, sunday) || other.sunday == sunday)&&(identical(other.publicHoliday, publicHoliday) || other.publicHoliday == publicHoliday)&&(identical(other.overtime, overtime) || other.overtime == overtime)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,saturday,sunday,publicHoliday,overtime,total);

@override
String toString() {
  return 'PenaltyRates(saturday: $saturday, sunday: $sunday, publicHoliday: $publicHoliday, overtime: $overtime, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PenaltyRatesCopyWith<$Res> implements $PenaltyRatesCopyWith<$Res> {
  factory _$PenaltyRatesCopyWith(_PenaltyRates value, $Res Function(_PenaltyRates) _then) = __$PenaltyRatesCopyWithImpl;
@override @useResult
$Res call({
 PenaltyRate saturday, PenaltyRate sunday, PenaltyRate publicHoliday, PenaltyRate overtime, double total
});


@override $PenaltyRateCopyWith<$Res> get saturday;@override $PenaltyRateCopyWith<$Res> get sunday;@override $PenaltyRateCopyWith<$Res> get publicHoliday;@override $PenaltyRateCopyWith<$Res> get overtime;

}
/// @nodoc
class __$PenaltyRatesCopyWithImpl<$Res>
    implements _$PenaltyRatesCopyWith<$Res> {
  __$PenaltyRatesCopyWithImpl(this._self, this._then);

  final _PenaltyRates _self;
  final $Res Function(_PenaltyRates) _then;

/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saturday = null,Object? sunday = null,Object? publicHoliday = null,Object? overtime = null,Object? total = null,}) {
  return _then(_PenaltyRates(
saturday: null == saturday ? _self.saturday : saturday // ignore: cast_nullable_to_non_nullable
as PenaltyRate,sunday: null == sunday ? _self.sunday : sunday // ignore: cast_nullable_to_non_nullable
as PenaltyRate,publicHoliday: null == publicHoliday ? _self.publicHoliday : publicHoliday // ignore: cast_nullable_to_non_nullable
as PenaltyRate,overtime: null == overtime ? _self.overtime : overtime // ignore: cast_nullable_to_non_nullable
as PenaltyRate,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get saturday {
  
  return $PenaltyRateCopyWith<$Res>(_self.saturday, (value) {
    return _then(_self.copyWith(saturday: value));
  });
}/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get sunday {
  
  return $PenaltyRateCopyWith<$Res>(_self.sunday, (value) {
    return _then(_self.copyWith(sunday: value));
  });
}/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get publicHoliday {
  
  return $PenaltyRateCopyWith<$Res>(_self.publicHoliday, (value) {
    return _then(_self.copyWith(publicHoliday: value));
  });
}/// Create a copy of PenaltyRates
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<$Res> get overtime {
  
  return $PenaltyRateCopyWith<$Res>(_self.overtime, (value) {
    return _then(_self.copyWith(overtime: value));
  });
}
}


/// @nodoc
mixin _$PenaltyRate {

 double get hours; double get rate; double get amount;
/// Create a copy of PenaltyRate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenaltyRateCopyWith<PenaltyRate> get copyWith => _$PenaltyRateCopyWithImpl<PenaltyRate>(this as PenaltyRate, _$identity);

  /// Serializes this PenaltyRate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenaltyRate&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hours,rate,amount);

@override
String toString() {
  return 'PenaltyRate(hours: $hours, rate: $rate, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PenaltyRateCopyWith<$Res>  {
  factory $PenaltyRateCopyWith(PenaltyRate value, $Res Function(PenaltyRate) _then) = _$PenaltyRateCopyWithImpl;
@useResult
$Res call({
 double hours, double rate, double amount
});




}
/// @nodoc
class _$PenaltyRateCopyWithImpl<$Res>
    implements $PenaltyRateCopyWith<$Res> {
  _$PenaltyRateCopyWithImpl(this._self, this._then);

  final PenaltyRate _self;
  final $Res Function(PenaltyRate) _then;

/// Create a copy of PenaltyRate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hours = null,Object? rate = null,Object? amount = null,}) {
  return _then(_self.copyWith(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PenaltyRate].
extension PenaltyRatePatterns on PenaltyRate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PenaltyRate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PenaltyRate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PenaltyRate value)  $default,){
final _that = this;
switch (_that) {
case _PenaltyRate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PenaltyRate value)?  $default,){
final _that = this;
switch (_that) {
case _PenaltyRate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double hours,  double rate,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PenaltyRate() when $default != null:
return $default(_that.hours,_that.rate,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double hours,  double rate,  double amount)  $default,) {final _that = this;
switch (_that) {
case _PenaltyRate():
return $default(_that.hours,_that.rate,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double hours,  double rate,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _PenaltyRate() when $default != null:
return $default(_that.hours,_that.rate,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PenaltyRate implements PenaltyRate {
  const _PenaltyRate({required this.hours, required this.rate, required this.amount});
  factory _PenaltyRate.fromJson(Map<String, dynamic> json) => _$PenaltyRateFromJson(json);

@override final  double hours;
@override final  double rate;
@override final  double amount;

/// Create a copy of PenaltyRate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PenaltyRateCopyWith<_PenaltyRate> get copyWith => __$PenaltyRateCopyWithImpl<_PenaltyRate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenaltyRateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PenaltyRate&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hours,rate,amount);

@override
String toString() {
  return 'PenaltyRate(hours: $hours, rate: $rate, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$PenaltyRateCopyWith<$Res> implements $PenaltyRateCopyWith<$Res> {
  factory _$PenaltyRateCopyWith(_PenaltyRate value, $Res Function(_PenaltyRate) _then) = __$PenaltyRateCopyWithImpl;
@override @useResult
$Res call({
 double hours, double rate, double amount
});




}
/// @nodoc
class __$PenaltyRateCopyWithImpl<$Res>
    implements _$PenaltyRateCopyWith<$Res> {
  __$PenaltyRateCopyWithImpl(this._self, this._then);

  final _PenaltyRate _self;
  final $Res Function(_PenaltyRate) _then;

/// Create a copy of PenaltyRate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hours = null,Object? rate = null,Object? amount = null,}) {
  return _then(_PenaltyRate(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Allowances {

 double get travel; double get meal; double get sleepover; double get firstAid; double get total;
/// Create a copy of Allowances
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllowancesCopyWith<Allowances> get copyWith => _$AllowancesCopyWithImpl<Allowances>(this as Allowances, _$identity);

  /// Serializes this Allowances to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Allowances&&(identical(other.travel, travel) || other.travel == travel)&&(identical(other.meal, meal) || other.meal == meal)&&(identical(other.sleepover, sleepover) || other.sleepover == sleepover)&&(identical(other.firstAid, firstAid) || other.firstAid == firstAid)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,travel,meal,sleepover,firstAid,total);

@override
String toString() {
  return 'Allowances(travel: $travel, meal: $meal, sleepover: $sleepover, firstAid: $firstAid, total: $total)';
}


}

/// @nodoc
abstract mixin class $AllowancesCopyWith<$Res>  {
  factory $AllowancesCopyWith(Allowances value, $Res Function(Allowances) _then) = _$AllowancesCopyWithImpl;
@useResult
$Res call({
 double travel, double meal, double sleepover, double firstAid, double total
});




}
/// @nodoc
class _$AllowancesCopyWithImpl<$Res>
    implements $AllowancesCopyWith<$Res> {
  _$AllowancesCopyWithImpl(this._self, this._then);

  final Allowances _self;
  final $Res Function(Allowances) _then;

/// Create a copy of Allowances
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? travel = null,Object? meal = null,Object? sleepover = null,Object? firstAid = null,Object? total = null,}) {
  return _then(_self.copyWith(
travel: null == travel ? _self.travel : travel // ignore: cast_nullable_to_non_nullable
as double,meal: null == meal ? _self.meal : meal // ignore: cast_nullable_to_non_nullable
as double,sleepover: null == sleepover ? _self.sleepover : sleepover // ignore: cast_nullable_to_non_nullable
as double,firstAid: null == firstAid ? _self.firstAid : firstAid // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Allowances].
extension AllowancesPatterns on Allowances {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Allowances value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Allowances() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Allowances value)  $default,){
final _that = this;
switch (_that) {
case _Allowances():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Allowances value)?  $default,){
final _that = this;
switch (_that) {
case _Allowances() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double travel,  double meal,  double sleepover,  double firstAid,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Allowances() when $default != null:
return $default(_that.travel,_that.meal,_that.sleepover,_that.firstAid,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double travel,  double meal,  double sleepover,  double firstAid,  double total)  $default,) {final _that = this;
switch (_that) {
case _Allowances():
return $default(_that.travel,_that.meal,_that.sleepover,_that.firstAid,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double travel,  double meal,  double sleepover,  double firstAid,  double total)?  $default,) {final _that = this;
switch (_that) {
case _Allowances() when $default != null:
return $default(_that.travel,_that.meal,_that.sleepover,_that.firstAid,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Allowances implements Allowances {
  const _Allowances({required this.travel, required this.meal, required this.sleepover, required this.firstAid, required this.total});
  factory _Allowances.fromJson(Map<String, dynamic> json) => _$AllowancesFromJson(json);

@override final  double travel;
@override final  double meal;
@override final  double sleepover;
@override final  double firstAid;
@override final  double total;

/// Create a copy of Allowances
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllowancesCopyWith<_Allowances> get copyWith => __$AllowancesCopyWithImpl<_Allowances>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllowancesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Allowances&&(identical(other.travel, travel) || other.travel == travel)&&(identical(other.meal, meal) || other.meal == meal)&&(identical(other.sleepover, sleepover) || other.sleepover == sleepover)&&(identical(other.firstAid, firstAid) || other.firstAid == firstAid)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,travel,meal,sleepover,firstAid,total);

@override
String toString() {
  return 'Allowances(travel: $travel, meal: $meal, sleepover: $sleepover, firstAid: $firstAid, total: $total)';
}


}

/// @nodoc
abstract mixin class _$AllowancesCopyWith<$Res> implements $AllowancesCopyWith<$Res> {
  factory _$AllowancesCopyWith(_Allowances value, $Res Function(_Allowances) _then) = __$AllowancesCopyWithImpl;
@override @useResult
$Res call({
 double travel, double meal, double sleepover, double firstAid, double total
});




}
/// @nodoc
class __$AllowancesCopyWithImpl<$Res>
    implements _$AllowancesCopyWith<$Res> {
  __$AllowancesCopyWithImpl(this._self, this._then);

  final _Allowances _self;
  final $Res Function(_Allowances) _then;

/// Create a copy of Allowances
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? travel = null,Object? meal = null,Object? sleepover = null,Object? firstAid = null,Object? total = null,}) {
  return _then(_Allowances(
travel: null == travel ? _self.travel : travel // ignore: cast_nullable_to_non_nullable
as double,meal: null == meal ? _self.meal : meal // ignore: cast_nullable_to_non_nullable
as double,sleepover: null == sleepover ? _self.sleepover : sleepover // ignore: cast_nullable_to_non_nullable
as double,firstAid: null == firstAid ? _self.firstAid : firstAid // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$LeaveAccrual {

 LeaveAccrualDetail get annualLeave; LeaveAccrualDetail get sickLeave;
/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveAccrualCopyWith<LeaveAccrual> get copyWith => _$LeaveAccrualCopyWithImpl<LeaveAccrual>(this as LeaveAccrual, _$identity);

  /// Serializes this LeaveAccrual to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveAccrual&&(identical(other.annualLeave, annualLeave) || other.annualLeave == annualLeave)&&(identical(other.sickLeave, sickLeave) || other.sickLeave == sickLeave));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,annualLeave,sickLeave);

@override
String toString() {
  return 'LeaveAccrual(annualLeave: $annualLeave, sickLeave: $sickLeave)';
}


}

/// @nodoc
abstract mixin class $LeaveAccrualCopyWith<$Res>  {
  factory $LeaveAccrualCopyWith(LeaveAccrual value, $Res Function(LeaveAccrual) _then) = _$LeaveAccrualCopyWithImpl;
@useResult
$Res call({
 LeaveAccrualDetail annualLeave, LeaveAccrualDetail sickLeave
});


$LeaveAccrualDetailCopyWith<$Res> get annualLeave;$LeaveAccrualDetailCopyWith<$Res> get sickLeave;

}
/// @nodoc
class _$LeaveAccrualCopyWithImpl<$Res>
    implements $LeaveAccrualCopyWith<$Res> {
  _$LeaveAccrualCopyWithImpl(this._self, this._then);

  final LeaveAccrual _self;
  final $Res Function(LeaveAccrual) _then;

/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? annualLeave = null,Object? sickLeave = null,}) {
  return _then(_self.copyWith(
annualLeave: null == annualLeave ? _self.annualLeave : annualLeave // ignore: cast_nullable_to_non_nullable
as LeaveAccrualDetail,sickLeave: null == sickLeave ? _self.sickLeave : sickLeave // ignore: cast_nullable_to_non_nullable
as LeaveAccrualDetail,
  ));
}
/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveAccrualDetailCopyWith<$Res> get annualLeave {
  
  return $LeaveAccrualDetailCopyWith<$Res>(_self.annualLeave, (value) {
    return _then(_self.copyWith(annualLeave: value));
  });
}/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveAccrualDetailCopyWith<$Res> get sickLeave {
  
  return $LeaveAccrualDetailCopyWith<$Res>(_self.sickLeave, (value) {
    return _then(_self.copyWith(sickLeave: value));
  });
}
}


/// Adds pattern-matching-related methods to [LeaveAccrual].
extension LeaveAccrualPatterns on LeaveAccrual {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveAccrual value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveAccrual() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveAccrual value)  $default,){
final _that = this;
switch (_that) {
case _LeaveAccrual():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveAccrual value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveAccrual() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LeaveAccrualDetail annualLeave,  LeaveAccrualDetail sickLeave)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveAccrual() when $default != null:
return $default(_that.annualLeave,_that.sickLeave);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LeaveAccrualDetail annualLeave,  LeaveAccrualDetail sickLeave)  $default,) {final _that = this;
switch (_that) {
case _LeaveAccrual():
return $default(_that.annualLeave,_that.sickLeave);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LeaveAccrualDetail annualLeave,  LeaveAccrualDetail sickLeave)?  $default,) {final _that = this;
switch (_that) {
case _LeaveAccrual() when $default != null:
return $default(_that.annualLeave,_that.sickLeave);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveAccrual implements LeaveAccrual {
  const _LeaveAccrual({required this.annualLeave, required this.sickLeave});
  factory _LeaveAccrual.fromJson(Map<String, dynamic> json) => _$LeaveAccrualFromJson(json);

@override final  LeaveAccrualDetail annualLeave;
@override final  LeaveAccrualDetail sickLeave;

/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveAccrualCopyWith<_LeaveAccrual> get copyWith => __$LeaveAccrualCopyWithImpl<_LeaveAccrual>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveAccrualToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveAccrual&&(identical(other.annualLeave, annualLeave) || other.annualLeave == annualLeave)&&(identical(other.sickLeave, sickLeave) || other.sickLeave == sickLeave));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,annualLeave,sickLeave);

@override
String toString() {
  return 'LeaveAccrual(annualLeave: $annualLeave, sickLeave: $sickLeave)';
}


}

/// @nodoc
abstract mixin class _$LeaveAccrualCopyWith<$Res> implements $LeaveAccrualCopyWith<$Res> {
  factory _$LeaveAccrualCopyWith(_LeaveAccrual value, $Res Function(_LeaveAccrual) _then) = __$LeaveAccrualCopyWithImpl;
@override @useResult
$Res call({
 LeaveAccrualDetail annualLeave, LeaveAccrualDetail sickLeave
});


@override $LeaveAccrualDetailCopyWith<$Res> get annualLeave;@override $LeaveAccrualDetailCopyWith<$Res> get sickLeave;

}
/// @nodoc
class __$LeaveAccrualCopyWithImpl<$Res>
    implements _$LeaveAccrualCopyWith<$Res> {
  __$LeaveAccrualCopyWithImpl(this._self, this._then);

  final _LeaveAccrual _self;
  final $Res Function(_LeaveAccrual) _then;

/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? annualLeave = null,Object? sickLeave = null,}) {
  return _then(_LeaveAccrual(
annualLeave: null == annualLeave ? _self.annualLeave : annualLeave // ignore: cast_nullable_to_non_nullable
as LeaveAccrualDetail,sickLeave: null == sickLeave ? _self.sickLeave : sickLeave // ignore: cast_nullable_to_non_nullable
as LeaveAccrualDetail,
  ));
}

/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveAccrualDetailCopyWith<$Res> get annualLeave {
  
  return $LeaveAccrualDetailCopyWith<$Res>(_self.annualLeave, (value) {
    return _then(_self.copyWith(annualLeave: value));
  });
}/// Create a copy of LeaveAccrual
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LeaveAccrualDetailCopyWith<$Res> get sickLeave {
  
  return $LeaveAccrualDetailCopyWith<$Res>(_self.sickLeave, (value) {
    return _then(_self.copyWith(sickLeave: value));
  });
}
}


/// @nodoc
mixin _$LeaveAccrualDetail {

 double get hours; double get amount;
/// Create a copy of LeaveAccrualDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaveAccrualDetailCopyWith<LeaveAccrualDetail> get copyWith => _$LeaveAccrualDetailCopyWithImpl<LeaveAccrualDetail>(this as LeaveAccrualDetail, _$identity);

  /// Serializes this LeaveAccrualDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaveAccrualDetail&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hours,amount);

@override
String toString() {
  return 'LeaveAccrualDetail(hours: $hours, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $LeaveAccrualDetailCopyWith<$Res>  {
  factory $LeaveAccrualDetailCopyWith(LeaveAccrualDetail value, $Res Function(LeaveAccrualDetail) _then) = _$LeaveAccrualDetailCopyWithImpl;
@useResult
$Res call({
 double hours, double amount
});




}
/// @nodoc
class _$LeaveAccrualDetailCopyWithImpl<$Res>
    implements $LeaveAccrualDetailCopyWith<$Res> {
  _$LeaveAccrualDetailCopyWithImpl(this._self, this._then);

  final LeaveAccrualDetail _self;
  final $Res Function(LeaveAccrualDetail) _then;

/// Create a copy of LeaveAccrualDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hours = null,Object? amount = null,}) {
  return _then(_self.copyWith(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaveAccrualDetail].
extension LeaveAccrualDetailPatterns on LeaveAccrualDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaveAccrualDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaveAccrualDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaveAccrualDetail value)  $default,){
final _that = this;
switch (_that) {
case _LeaveAccrualDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaveAccrualDetail value)?  $default,){
final _that = this;
switch (_that) {
case _LeaveAccrualDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double hours,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaveAccrualDetail() when $default != null:
return $default(_that.hours,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double hours,  double amount)  $default,) {final _that = this;
switch (_that) {
case _LeaveAccrualDetail():
return $default(_that.hours,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double hours,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _LeaveAccrualDetail() when $default != null:
return $default(_that.hours,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LeaveAccrualDetail implements LeaveAccrualDetail {
  const _LeaveAccrualDetail({required this.hours, required this.amount});
  factory _LeaveAccrualDetail.fromJson(Map<String, dynamic> json) => _$LeaveAccrualDetailFromJson(json);

@override final  double hours;
@override final  double amount;

/// Create a copy of LeaveAccrualDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaveAccrualDetailCopyWith<_LeaveAccrualDetail> get copyWith => __$LeaveAccrualDetailCopyWithImpl<_LeaveAccrualDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LeaveAccrualDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaveAccrualDetail&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hours,amount);

@override
String toString() {
  return 'LeaveAccrualDetail(hours: $hours, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$LeaveAccrualDetailCopyWith<$Res> implements $LeaveAccrualDetailCopyWith<$Res> {
  factory _$LeaveAccrualDetailCopyWith(_LeaveAccrualDetail value, $Res Function(_LeaveAccrualDetail) _then) = __$LeaveAccrualDetailCopyWithImpl;
@override @useResult
$Res call({
 double hours, double amount
});




}
/// @nodoc
class __$LeaveAccrualDetailCopyWithImpl<$Res>
    implements _$LeaveAccrualDetailCopyWith<$Res> {
  __$LeaveAccrualDetailCopyWithImpl(this._self, this._then);

  final _LeaveAccrualDetail _self;
  final $Res Function(_LeaveAccrualDetail) _then;

/// Create a copy of LeaveAccrualDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hours = null,Object? amount = null,}) {
  return _then(_LeaveAccrualDetail(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TaxAndSuper {

 double get tax;@JsonKey(name: 'super') double get superAmount; double get taxRate; double get superRate;
/// Create a copy of TaxAndSuper
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaxAndSuperCopyWith<TaxAndSuper> get copyWith => _$TaxAndSuperCopyWithImpl<TaxAndSuper>(this as TaxAndSuper, _$identity);

  /// Serializes this TaxAndSuper to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaxAndSuper&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.superAmount, superAmount) || other.superAmount == superAmount)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.superRate, superRate) || other.superRate == superRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tax,superAmount,taxRate,superRate);

@override
String toString() {
  return 'TaxAndSuper(tax: $tax, superAmount: $superAmount, taxRate: $taxRate, superRate: $superRate)';
}


}

/// @nodoc
abstract mixin class $TaxAndSuperCopyWith<$Res>  {
  factory $TaxAndSuperCopyWith(TaxAndSuper value, $Res Function(TaxAndSuper) _then) = _$TaxAndSuperCopyWithImpl;
@useResult
$Res call({
 double tax,@JsonKey(name: 'super') double superAmount, double taxRate, double superRate
});




}
/// @nodoc
class _$TaxAndSuperCopyWithImpl<$Res>
    implements $TaxAndSuperCopyWith<$Res> {
  _$TaxAndSuperCopyWithImpl(this._self, this._then);

  final TaxAndSuper _self;
  final $Res Function(TaxAndSuper) _then;

/// Create a copy of TaxAndSuper
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tax = null,Object? superAmount = null,Object? taxRate = null,Object? superRate = null,}) {
  return _then(_self.copyWith(
tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,superAmount: null == superAmount ? _self.superAmount : superAmount // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,superRate: null == superRate ? _self.superRate : superRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TaxAndSuper].
extension TaxAndSuperPatterns on TaxAndSuper {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaxAndSuper value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaxAndSuper() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaxAndSuper value)  $default,){
final _that = this;
switch (_that) {
case _TaxAndSuper():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaxAndSuper value)?  $default,){
final _that = this;
switch (_that) {
case _TaxAndSuper() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double tax, @JsonKey(name: 'super')  double superAmount,  double taxRate,  double superRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaxAndSuper() when $default != null:
return $default(_that.tax,_that.superAmount,_that.taxRate,_that.superRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double tax, @JsonKey(name: 'super')  double superAmount,  double taxRate,  double superRate)  $default,) {final _that = this;
switch (_that) {
case _TaxAndSuper():
return $default(_that.tax,_that.superAmount,_that.taxRate,_that.superRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double tax, @JsonKey(name: 'super')  double superAmount,  double taxRate,  double superRate)?  $default,) {final _that = this;
switch (_that) {
case _TaxAndSuper() when $default != null:
return $default(_that.tax,_that.superAmount,_that.taxRate,_that.superRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaxAndSuper implements TaxAndSuper {
  const _TaxAndSuper({required this.tax, @JsonKey(name: 'super') required this.superAmount, required this.taxRate, required this.superRate});
  factory _TaxAndSuper.fromJson(Map<String, dynamic> json) => _$TaxAndSuperFromJson(json);

@override final  double tax;
@override@JsonKey(name: 'super') final  double superAmount;
@override final  double taxRate;
@override final  double superRate;

/// Create a copy of TaxAndSuper
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaxAndSuperCopyWith<_TaxAndSuper> get copyWith => __$TaxAndSuperCopyWithImpl<_TaxAndSuper>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaxAndSuperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaxAndSuper&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.superAmount, superAmount) || other.superAmount == superAmount)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate)&&(identical(other.superRate, superRate) || other.superRate == superRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tax,superAmount,taxRate,superRate);

@override
String toString() {
  return 'TaxAndSuper(tax: $tax, superAmount: $superAmount, taxRate: $taxRate, superRate: $superRate)';
}


}

/// @nodoc
abstract mixin class _$TaxAndSuperCopyWith<$Res> implements $TaxAndSuperCopyWith<$Res> {
  factory _$TaxAndSuperCopyWith(_TaxAndSuper value, $Res Function(_TaxAndSuper) _then) = __$TaxAndSuperCopyWithImpl;
@override @useResult
$Res call({
 double tax,@JsonKey(name: 'super') double superAmount, double taxRate, double superRate
});




}
/// @nodoc
class __$TaxAndSuperCopyWithImpl<$Res>
    implements _$TaxAndSuperCopyWith<$Res> {
  __$TaxAndSuperCopyWithImpl(this._self, this._then);

  final _TaxAndSuper _self;
  final $Res Function(_TaxAndSuper) _then;

/// Create a copy of TaxAndSuper
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tax = null,Object? superAmount = null,Object? taxRate = null,Object? superRate = null,}) {
  return _then(_TaxAndSuper(
tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,superAmount: null == superAmount ? _self.superAmount : superAmount // ignore: cast_nullable_to_non_nullable
as double,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,superRate: null == superRate ? _self.superRate : superRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Payslip {

 String get payslipId; String get userId; String get period; String get generatedDate; PayslipEarnings get earnings; PayslipDeductions get deductions; double get netPay; PayslipYTD get ytd;
/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayslipCopyWith<Payslip> get copyWith => _$PayslipCopyWithImpl<Payslip>(this as Payslip, _$identity);

  /// Serializes this Payslip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payslip&&(identical(other.payslipId, payslipId) || other.payslipId == payslipId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedDate, generatedDate) || other.generatedDate == generatedDate)&&(identical(other.earnings, earnings) || other.earnings == earnings)&&(identical(other.deductions, deductions) || other.deductions == deductions)&&(identical(other.netPay, netPay) || other.netPay == netPay)&&(identical(other.ytd, ytd) || other.ytd == ytd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payslipId,userId,period,generatedDate,earnings,deductions,netPay,ytd);

@override
String toString() {
  return 'Payslip(payslipId: $payslipId, userId: $userId, period: $period, generatedDate: $generatedDate, earnings: $earnings, deductions: $deductions, netPay: $netPay, ytd: $ytd)';
}


}

/// @nodoc
abstract mixin class $PayslipCopyWith<$Res>  {
  factory $PayslipCopyWith(Payslip value, $Res Function(Payslip) _then) = _$PayslipCopyWithImpl;
@useResult
$Res call({
 String payslipId, String userId, String period, String generatedDate, PayslipEarnings earnings, PayslipDeductions deductions, double netPay, PayslipYTD ytd
});


$PayslipEarningsCopyWith<$Res> get earnings;$PayslipDeductionsCopyWith<$Res> get deductions;$PayslipYTDCopyWith<$Res> get ytd;

}
/// @nodoc
class _$PayslipCopyWithImpl<$Res>
    implements $PayslipCopyWith<$Res> {
  _$PayslipCopyWithImpl(this._self, this._then);

  final Payslip _self;
  final $Res Function(Payslip) _then;

/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payslipId = null,Object? userId = null,Object? period = null,Object? generatedDate = null,Object? earnings = null,Object? deductions = null,Object? netPay = null,Object? ytd = null,}) {
  return _then(_self.copyWith(
payslipId: null == payslipId ? _self.payslipId : payslipId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedDate: null == generatedDate ? _self.generatedDate : generatedDate // ignore: cast_nullable_to_non_nullable
as String,earnings: null == earnings ? _self.earnings : earnings // ignore: cast_nullable_to_non_nullable
as PayslipEarnings,deductions: null == deductions ? _self.deductions : deductions // ignore: cast_nullable_to_non_nullable
as PayslipDeductions,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,ytd: null == ytd ? _self.ytd : ytd // ignore: cast_nullable_to_non_nullable
as PayslipYTD,
  ));
}
/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayslipEarningsCopyWith<$Res> get earnings {
  
  return $PayslipEarningsCopyWith<$Res>(_self.earnings, (value) {
    return _then(_self.copyWith(earnings: value));
  });
}/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayslipDeductionsCopyWith<$Res> get deductions {
  
  return $PayslipDeductionsCopyWith<$Res>(_self.deductions, (value) {
    return _then(_self.copyWith(deductions: value));
  });
}/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayslipYTDCopyWith<$Res> get ytd {
  
  return $PayslipYTDCopyWith<$Res>(_self.ytd, (value) {
    return _then(_self.copyWith(ytd: value));
  });
}
}


/// Adds pattern-matching-related methods to [Payslip].
extension PayslipPatterns on Payslip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payslip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payslip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payslip value)  $default,){
final _that = this;
switch (_that) {
case _Payslip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payslip value)?  $default,){
final _that = this;
switch (_that) {
case _Payslip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String payslipId,  String userId,  String period,  String generatedDate,  PayslipEarnings earnings,  PayslipDeductions deductions,  double netPay,  PayslipYTD ytd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payslip() when $default != null:
return $default(_that.payslipId,_that.userId,_that.period,_that.generatedDate,_that.earnings,_that.deductions,_that.netPay,_that.ytd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String payslipId,  String userId,  String period,  String generatedDate,  PayslipEarnings earnings,  PayslipDeductions deductions,  double netPay,  PayslipYTD ytd)  $default,) {final _that = this;
switch (_that) {
case _Payslip():
return $default(_that.payslipId,_that.userId,_that.period,_that.generatedDate,_that.earnings,_that.deductions,_that.netPay,_that.ytd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String payslipId,  String userId,  String period,  String generatedDate,  PayslipEarnings earnings,  PayslipDeductions deductions,  double netPay,  PayslipYTD ytd)?  $default,) {final _that = this;
switch (_that) {
case _Payslip() when $default != null:
return $default(_that.payslipId,_that.userId,_that.period,_that.generatedDate,_that.earnings,_that.deductions,_that.netPay,_that.ytd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payslip implements Payslip {
  const _Payslip({required this.payslipId, required this.userId, required this.period, required this.generatedDate, required this.earnings, required this.deductions, required this.netPay, required this.ytd});
  factory _Payslip.fromJson(Map<String, dynamic> json) => _$PayslipFromJson(json);

@override final  String payslipId;
@override final  String userId;
@override final  String period;
@override final  String generatedDate;
@override final  PayslipEarnings earnings;
@override final  PayslipDeductions deductions;
@override final  double netPay;
@override final  PayslipYTD ytd;

/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayslipCopyWith<_Payslip> get copyWith => __$PayslipCopyWithImpl<_Payslip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayslipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payslip&&(identical(other.payslipId, payslipId) || other.payslipId == payslipId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.period, period) || other.period == period)&&(identical(other.generatedDate, generatedDate) || other.generatedDate == generatedDate)&&(identical(other.earnings, earnings) || other.earnings == earnings)&&(identical(other.deductions, deductions) || other.deductions == deductions)&&(identical(other.netPay, netPay) || other.netPay == netPay)&&(identical(other.ytd, ytd) || other.ytd == ytd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,payslipId,userId,period,generatedDate,earnings,deductions,netPay,ytd);

@override
String toString() {
  return 'Payslip(payslipId: $payslipId, userId: $userId, period: $period, generatedDate: $generatedDate, earnings: $earnings, deductions: $deductions, netPay: $netPay, ytd: $ytd)';
}


}

/// @nodoc
abstract mixin class _$PayslipCopyWith<$Res> implements $PayslipCopyWith<$Res> {
  factory _$PayslipCopyWith(_Payslip value, $Res Function(_Payslip) _then) = __$PayslipCopyWithImpl;
@override @useResult
$Res call({
 String payslipId, String userId, String period, String generatedDate, PayslipEarnings earnings, PayslipDeductions deductions, double netPay, PayslipYTD ytd
});


@override $PayslipEarningsCopyWith<$Res> get earnings;@override $PayslipDeductionsCopyWith<$Res> get deductions;@override $PayslipYTDCopyWith<$Res> get ytd;

}
/// @nodoc
class __$PayslipCopyWithImpl<$Res>
    implements _$PayslipCopyWith<$Res> {
  __$PayslipCopyWithImpl(this._self, this._then);

  final _Payslip _self;
  final $Res Function(_Payslip) _then;

/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payslipId = null,Object? userId = null,Object? period = null,Object? generatedDate = null,Object? earnings = null,Object? deductions = null,Object? netPay = null,Object? ytd = null,}) {
  return _then(_Payslip(
payslipId: null == payslipId ? _self.payslipId : payslipId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,generatedDate: null == generatedDate ? _self.generatedDate : generatedDate // ignore: cast_nullable_to_non_nullable
as String,earnings: null == earnings ? _self.earnings : earnings // ignore: cast_nullable_to_non_nullable
as PayslipEarnings,deductions: null == deductions ? _self.deductions : deductions // ignore: cast_nullable_to_non_nullable
as PayslipDeductions,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,ytd: null == ytd ? _self.ytd : ytd // ignore: cast_nullable_to_non_nullable
as PayslipYTD,
  ));
}

/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayslipEarningsCopyWith<$Res> get earnings {
  
  return $PayslipEarningsCopyWith<$Res>(_self.earnings, (value) {
    return _then(_self.copyWith(earnings: value));
  });
}/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayslipDeductionsCopyWith<$Res> get deductions {
  
  return $PayslipDeductionsCopyWith<$Res>(_self.deductions, (value) {
    return _then(_self.copyWith(deductions: value));
  });
}/// Create a copy of Payslip
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayslipYTDCopyWith<$Res> get ytd {
  
  return $PayslipYTDCopyWith<$Res>(_self.ytd, (value) {
    return _then(_self.copyWith(ytd: value));
  });
}
}


/// @nodoc
mixin _$PayslipEarnings {

 double get baseHours; double get baseRate; double get baseAmount; double get penalties; double get allowances; double get total;
/// Create a copy of PayslipEarnings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayslipEarningsCopyWith<PayslipEarnings> get copyWith => _$PayslipEarningsCopyWithImpl<PayslipEarnings>(this as PayslipEarnings, _$identity);

  /// Serializes this PayslipEarnings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayslipEarnings&&(identical(other.baseHours, baseHours) || other.baseHours == baseHours)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.baseAmount, baseAmount) || other.baseAmount == baseAmount)&&(identical(other.penalties, penalties) || other.penalties == penalties)&&(identical(other.allowances, allowances) || other.allowances == allowances)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseHours,baseRate,baseAmount,penalties,allowances,total);

@override
String toString() {
  return 'PayslipEarnings(baseHours: $baseHours, baseRate: $baseRate, baseAmount: $baseAmount, penalties: $penalties, allowances: $allowances, total: $total)';
}


}

/// @nodoc
abstract mixin class $PayslipEarningsCopyWith<$Res>  {
  factory $PayslipEarningsCopyWith(PayslipEarnings value, $Res Function(PayslipEarnings) _then) = _$PayslipEarningsCopyWithImpl;
@useResult
$Res call({
 double baseHours, double baseRate, double baseAmount, double penalties, double allowances, double total
});




}
/// @nodoc
class _$PayslipEarningsCopyWithImpl<$Res>
    implements $PayslipEarningsCopyWith<$Res> {
  _$PayslipEarningsCopyWithImpl(this._self, this._then);

  final PayslipEarnings _self;
  final $Res Function(PayslipEarnings) _then;

/// Create a copy of PayslipEarnings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseHours = null,Object? baseRate = null,Object? baseAmount = null,Object? penalties = null,Object? allowances = null,Object? total = null,}) {
  return _then(_self.copyWith(
baseHours: null == baseHours ? _self.baseHours : baseHours // ignore: cast_nullable_to_non_nullable
as double,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,baseAmount: null == baseAmount ? _self.baseAmount : baseAmount // ignore: cast_nullable_to_non_nullable
as double,penalties: null == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as double,allowances: null == allowances ? _self.allowances : allowances // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PayslipEarnings].
extension PayslipEarningsPatterns on PayslipEarnings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayslipEarnings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayslipEarnings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayslipEarnings value)  $default,){
final _that = this;
switch (_that) {
case _PayslipEarnings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayslipEarnings value)?  $default,){
final _that = this;
switch (_that) {
case _PayslipEarnings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double baseHours,  double baseRate,  double baseAmount,  double penalties,  double allowances,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayslipEarnings() when $default != null:
return $default(_that.baseHours,_that.baseRate,_that.baseAmount,_that.penalties,_that.allowances,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double baseHours,  double baseRate,  double baseAmount,  double penalties,  double allowances,  double total)  $default,) {final _that = this;
switch (_that) {
case _PayslipEarnings():
return $default(_that.baseHours,_that.baseRate,_that.baseAmount,_that.penalties,_that.allowances,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double baseHours,  double baseRate,  double baseAmount,  double penalties,  double allowances,  double total)?  $default,) {final _that = this;
switch (_that) {
case _PayslipEarnings() when $default != null:
return $default(_that.baseHours,_that.baseRate,_that.baseAmount,_that.penalties,_that.allowances,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayslipEarnings implements PayslipEarnings {
  const _PayslipEarnings({required this.baseHours, required this.baseRate, required this.baseAmount, required this.penalties, required this.allowances, required this.total});
  factory _PayslipEarnings.fromJson(Map<String, dynamic> json) => _$PayslipEarningsFromJson(json);

@override final  double baseHours;
@override final  double baseRate;
@override final  double baseAmount;
@override final  double penalties;
@override final  double allowances;
@override final  double total;

/// Create a copy of PayslipEarnings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayslipEarningsCopyWith<_PayslipEarnings> get copyWith => __$PayslipEarningsCopyWithImpl<_PayslipEarnings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayslipEarningsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayslipEarnings&&(identical(other.baseHours, baseHours) || other.baseHours == baseHours)&&(identical(other.baseRate, baseRate) || other.baseRate == baseRate)&&(identical(other.baseAmount, baseAmount) || other.baseAmount == baseAmount)&&(identical(other.penalties, penalties) || other.penalties == penalties)&&(identical(other.allowances, allowances) || other.allowances == allowances)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseHours,baseRate,baseAmount,penalties,allowances,total);

@override
String toString() {
  return 'PayslipEarnings(baseHours: $baseHours, baseRate: $baseRate, baseAmount: $baseAmount, penalties: $penalties, allowances: $allowances, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PayslipEarningsCopyWith<$Res> implements $PayslipEarningsCopyWith<$Res> {
  factory _$PayslipEarningsCopyWith(_PayslipEarnings value, $Res Function(_PayslipEarnings) _then) = __$PayslipEarningsCopyWithImpl;
@override @useResult
$Res call({
 double baseHours, double baseRate, double baseAmount, double penalties, double allowances, double total
});




}
/// @nodoc
class __$PayslipEarningsCopyWithImpl<$Res>
    implements _$PayslipEarningsCopyWith<$Res> {
  __$PayslipEarningsCopyWithImpl(this._self, this._then);

  final _PayslipEarnings _self;
  final $Res Function(_PayslipEarnings) _then;

/// Create a copy of PayslipEarnings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseHours = null,Object? baseRate = null,Object? baseAmount = null,Object? penalties = null,Object? allowances = null,Object? total = null,}) {
  return _then(_PayslipEarnings(
baseHours: null == baseHours ? _self.baseHours : baseHours // ignore: cast_nullable_to_non_nullable
as double,baseRate: null == baseRate ? _self.baseRate : baseRate // ignore: cast_nullable_to_non_nullable
as double,baseAmount: null == baseAmount ? _self.baseAmount : baseAmount // ignore: cast_nullable_to_non_nullable
as double,penalties: null == penalties ? _self.penalties : penalties // ignore: cast_nullable_to_non_nullable
as double,allowances: null == allowances ? _self.allowances : allowances // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PayslipDeductions {

 double get tax;@JsonKey(name: 'super') double get superAmount; double get total;
/// Create a copy of PayslipDeductions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayslipDeductionsCopyWith<PayslipDeductions> get copyWith => _$PayslipDeductionsCopyWithImpl<PayslipDeductions>(this as PayslipDeductions, _$identity);

  /// Serializes this PayslipDeductions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayslipDeductions&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.superAmount, superAmount) || other.superAmount == superAmount)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tax,superAmount,total);

@override
String toString() {
  return 'PayslipDeductions(tax: $tax, superAmount: $superAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class $PayslipDeductionsCopyWith<$Res>  {
  factory $PayslipDeductionsCopyWith(PayslipDeductions value, $Res Function(PayslipDeductions) _then) = _$PayslipDeductionsCopyWithImpl;
@useResult
$Res call({
 double tax,@JsonKey(name: 'super') double superAmount, double total
});




}
/// @nodoc
class _$PayslipDeductionsCopyWithImpl<$Res>
    implements $PayslipDeductionsCopyWith<$Res> {
  _$PayslipDeductionsCopyWithImpl(this._self, this._then);

  final PayslipDeductions _self;
  final $Res Function(PayslipDeductions) _then;

/// Create a copy of PayslipDeductions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tax = null,Object? superAmount = null,Object? total = null,}) {
  return _then(_self.copyWith(
tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,superAmount: null == superAmount ? _self.superAmount : superAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PayslipDeductions].
extension PayslipDeductionsPatterns on PayslipDeductions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayslipDeductions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayslipDeductions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayslipDeductions value)  $default,){
final _that = this;
switch (_that) {
case _PayslipDeductions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayslipDeductions value)?  $default,){
final _that = this;
switch (_that) {
case _PayslipDeductions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double tax, @JsonKey(name: 'super')  double superAmount,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayslipDeductions() when $default != null:
return $default(_that.tax,_that.superAmount,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double tax, @JsonKey(name: 'super')  double superAmount,  double total)  $default,) {final _that = this;
switch (_that) {
case _PayslipDeductions():
return $default(_that.tax,_that.superAmount,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double tax, @JsonKey(name: 'super')  double superAmount,  double total)?  $default,) {final _that = this;
switch (_that) {
case _PayslipDeductions() when $default != null:
return $default(_that.tax,_that.superAmount,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayslipDeductions implements PayslipDeductions {
  const _PayslipDeductions({required this.tax, @JsonKey(name: 'super') required this.superAmount, required this.total});
  factory _PayslipDeductions.fromJson(Map<String, dynamic> json) => _$PayslipDeductionsFromJson(json);

@override final  double tax;
@override@JsonKey(name: 'super') final  double superAmount;
@override final  double total;

/// Create a copy of PayslipDeductions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayslipDeductionsCopyWith<_PayslipDeductions> get copyWith => __$PayslipDeductionsCopyWithImpl<_PayslipDeductions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayslipDeductionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayslipDeductions&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.superAmount, superAmount) || other.superAmount == superAmount)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tax,superAmount,total);

@override
String toString() {
  return 'PayslipDeductions(tax: $tax, superAmount: $superAmount, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PayslipDeductionsCopyWith<$Res> implements $PayslipDeductionsCopyWith<$Res> {
  factory _$PayslipDeductionsCopyWith(_PayslipDeductions value, $Res Function(_PayslipDeductions) _then) = __$PayslipDeductionsCopyWithImpl;
@override @useResult
$Res call({
 double tax,@JsonKey(name: 'super') double superAmount, double total
});




}
/// @nodoc
class __$PayslipDeductionsCopyWithImpl<$Res>
    implements _$PayslipDeductionsCopyWith<$Res> {
  __$PayslipDeductionsCopyWithImpl(this._self, this._then);

  final _PayslipDeductions _self;
  final $Res Function(_PayslipDeductions) _then;

/// Create a copy of PayslipDeductions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tax = null,Object? superAmount = null,Object? total = null,}) {
  return _then(_PayslipDeductions(
tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,superAmount: null == superAmount ? _self.superAmount : superAmount // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PayslipYTD {

 double get grossPay; double get tax;@JsonKey(name: 'super') double get superAmount; double get netPay;
/// Create a copy of PayslipYTD
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayslipYTDCopyWith<PayslipYTD> get copyWith => _$PayslipYTDCopyWithImpl<PayslipYTD>(this as PayslipYTD, _$identity);

  /// Serializes this PayslipYTD to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayslipYTD&&(identical(other.grossPay, grossPay) || other.grossPay == grossPay)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.superAmount, superAmount) || other.superAmount == superAmount)&&(identical(other.netPay, netPay) || other.netPay == netPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grossPay,tax,superAmount,netPay);

@override
String toString() {
  return 'PayslipYTD(grossPay: $grossPay, tax: $tax, superAmount: $superAmount, netPay: $netPay)';
}


}

/// @nodoc
abstract mixin class $PayslipYTDCopyWith<$Res>  {
  factory $PayslipYTDCopyWith(PayslipYTD value, $Res Function(PayslipYTD) _then) = _$PayslipYTDCopyWithImpl;
@useResult
$Res call({
 double grossPay, double tax,@JsonKey(name: 'super') double superAmount, double netPay
});




}
/// @nodoc
class _$PayslipYTDCopyWithImpl<$Res>
    implements $PayslipYTDCopyWith<$Res> {
  _$PayslipYTDCopyWithImpl(this._self, this._then);

  final PayslipYTD _self;
  final $Res Function(PayslipYTD) _then;

/// Create a copy of PayslipYTD
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grossPay = null,Object? tax = null,Object? superAmount = null,Object? netPay = null,}) {
  return _then(_self.copyWith(
grossPay: null == grossPay ? _self.grossPay : grossPay // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,superAmount: null == superAmount ? _self.superAmount : superAmount // ignore: cast_nullable_to_non_nullable
as double,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PayslipYTD].
extension PayslipYTDPatterns on PayslipYTD {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayslipYTD value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayslipYTD() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayslipYTD value)  $default,){
final _that = this;
switch (_that) {
case _PayslipYTD():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayslipYTD value)?  $default,){
final _that = this;
switch (_that) {
case _PayslipYTD() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double grossPay,  double tax, @JsonKey(name: 'super')  double superAmount,  double netPay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayslipYTD() when $default != null:
return $default(_that.grossPay,_that.tax,_that.superAmount,_that.netPay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double grossPay,  double tax, @JsonKey(name: 'super')  double superAmount,  double netPay)  $default,) {final _that = this;
switch (_that) {
case _PayslipYTD():
return $default(_that.grossPay,_that.tax,_that.superAmount,_that.netPay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double grossPay,  double tax, @JsonKey(name: 'super')  double superAmount,  double netPay)?  $default,) {final _that = this;
switch (_that) {
case _PayslipYTD() when $default != null:
return $default(_that.grossPay,_that.tax,_that.superAmount,_that.netPay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayslipYTD implements PayslipYTD {
  const _PayslipYTD({required this.grossPay, required this.tax, @JsonKey(name: 'super') required this.superAmount, required this.netPay});
  factory _PayslipYTD.fromJson(Map<String, dynamic> json) => _$PayslipYTDFromJson(json);

@override final  double grossPay;
@override final  double tax;
@override@JsonKey(name: 'super') final  double superAmount;
@override final  double netPay;

/// Create a copy of PayslipYTD
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayslipYTDCopyWith<_PayslipYTD> get copyWith => __$PayslipYTDCopyWithImpl<_PayslipYTD>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayslipYTDToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayslipYTD&&(identical(other.grossPay, grossPay) || other.grossPay == grossPay)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.superAmount, superAmount) || other.superAmount == superAmount)&&(identical(other.netPay, netPay) || other.netPay == netPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grossPay,tax,superAmount,netPay);

@override
String toString() {
  return 'PayslipYTD(grossPay: $grossPay, tax: $tax, superAmount: $superAmount, netPay: $netPay)';
}


}

/// @nodoc
abstract mixin class _$PayslipYTDCopyWith<$Res> implements $PayslipYTDCopyWith<$Res> {
  factory _$PayslipYTDCopyWith(_PayslipYTD value, $Res Function(_PayslipYTD) _then) = __$PayslipYTDCopyWithImpl;
@override @useResult
$Res call({
 double grossPay, double tax,@JsonKey(name: 'super') double superAmount, double netPay
});




}
/// @nodoc
class __$PayslipYTDCopyWithImpl<$Res>
    implements _$PayslipYTDCopyWith<$Res> {
  __$PayslipYTDCopyWithImpl(this._self, this._then);

  final _PayslipYTD _self;
  final $Res Function(_PayslipYTD) _then;

/// Create a copy of PayslipYTD
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grossPay = null,Object? tax = null,Object? superAmount = null,Object? netPay = null,}) {
  return _then(_PayslipYTD(
grossPay: null == grossPay ? _self.grossPay : grossPay // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,superAmount: null == superAmount ? _self.superAmount : superAmount // ignore: cast_nullable_to_non_nullable
as double,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PayrollSummary {

 String get organizationId; String get period; int get totalEmployees; double get totalGrossPay; double get totalTax; double get totalSuper; double get totalNetPay; List<EmployeePayrollSummary> get employees;
/// Create a copy of PayrollSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayrollSummaryCopyWith<PayrollSummary> get copyWith => _$PayrollSummaryCopyWithImpl<PayrollSummary>(this as PayrollSummary, _$identity);

  /// Serializes this PayrollSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayrollSummary&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalEmployees, totalEmployees) || other.totalEmployees == totalEmployees)&&(identical(other.totalGrossPay, totalGrossPay) || other.totalGrossPay == totalGrossPay)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.totalSuper, totalSuper) || other.totalSuper == totalSuper)&&(identical(other.totalNetPay, totalNetPay) || other.totalNetPay == totalNetPay)&&const DeepCollectionEquality().equals(other.employees, employees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,totalEmployees,totalGrossPay,totalTax,totalSuper,totalNetPay,const DeepCollectionEquality().hash(employees));

@override
String toString() {
  return 'PayrollSummary(organizationId: $organizationId, period: $period, totalEmployees: $totalEmployees, totalGrossPay: $totalGrossPay, totalTax: $totalTax, totalSuper: $totalSuper, totalNetPay: $totalNetPay, employees: $employees)';
}


}

/// @nodoc
abstract mixin class $PayrollSummaryCopyWith<$Res>  {
  factory $PayrollSummaryCopyWith(PayrollSummary value, $Res Function(PayrollSummary) _then) = _$PayrollSummaryCopyWithImpl;
@useResult
$Res call({
 String organizationId, String period, int totalEmployees, double totalGrossPay, double totalTax, double totalSuper, double totalNetPay, List<EmployeePayrollSummary> employees
});




}
/// @nodoc
class _$PayrollSummaryCopyWithImpl<$Res>
    implements $PayrollSummaryCopyWith<$Res> {
  _$PayrollSummaryCopyWithImpl(this._self, this._then);

  final PayrollSummary _self;
  final $Res Function(PayrollSummary) _then;

/// Create a copy of PayrollSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? period = null,Object? totalEmployees = null,Object? totalGrossPay = null,Object? totalTax = null,Object? totalSuper = null,Object? totalNetPay = null,Object? employees = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,totalEmployees: null == totalEmployees ? _self.totalEmployees : totalEmployees // ignore: cast_nullable_to_non_nullable
as int,totalGrossPay: null == totalGrossPay ? _self.totalGrossPay : totalGrossPay // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,totalSuper: null == totalSuper ? _self.totalSuper : totalSuper // ignore: cast_nullable_to_non_nullable
as double,totalNetPay: null == totalNetPay ? _self.totalNetPay : totalNetPay // ignore: cast_nullable_to_non_nullable
as double,employees: null == employees ? _self.employees : employees // ignore: cast_nullable_to_non_nullable
as List<EmployeePayrollSummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [PayrollSummary].
extension PayrollSummaryPatterns on PayrollSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayrollSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayrollSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayrollSummary value)  $default,){
final _that = this;
switch (_that) {
case _PayrollSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayrollSummary value)?  $default,){
final _that = this;
switch (_that) {
case _PayrollSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String organizationId,  String period,  int totalEmployees,  double totalGrossPay,  double totalTax,  double totalSuper,  double totalNetPay,  List<EmployeePayrollSummary> employees)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayrollSummary() when $default != null:
return $default(_that.organizationId,_that.period,_that.totalEmployees,_that.totalGrossPay,_that.totalTax,_that.totalSuper,_that.totalNetPay,_that.employees);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String organizationId,  String period,  int totalEmployees,  double totalGrossPay,  double totalTax,  double totalSuper,  double totalNetPay,  List<EmployeePayrollSummary> employees)  $default,) {final _that = this;
switch (_that) {
case _PayrollSummary():
return $default(_that.organizationId,_that.period,_that.totalEmployees,_that.totalGrossPay,_that.totalTax,_that.totalSuper,_that.totalNetPay,_that.employees);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String organizationId,  String period,  int totalEmployees,  double totalGrossPay,  double totalTax,  double totalSuper,  double totalNetPay,  List<EmployeePayrollSummary> employees)?  $default,) {final _that = this;
switch (_that) {
case _PayrollSummary() when $default != null:
return $default(_that.organizationId,_that.period,_that.totalEmployees,_that.totalGrossPay,_that.totalTax,_that.totalSuper,_that.totalNetPay,_that.employees);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayrollSummary implements PayrollSummary {
  const _PayrollSummary({required this.organizationId, required this.period, required this.totalEmployees, required this.totalGrossPay, required this.totalTax, required this.totalSuper, required this.totalNetPay, required final  List<EmployeePayrollSummary> employees}): _employees = employees;
  factory _PayrollSummary.fromJson(Map<String, dynamic> json) => _$PayrollSummaryFromJson(json);

@override final  String organizationId;
@override final  String period;
@override final  int totalEmployees;
@override final  double totalGrossPay;
@override final  double totalTax;
@override final  double totalSuper;
@override final  double totalNetPay;
 final  List<EmployeePayrollSummary> _employees;
@override List<EmployeePayrollSummary> get employees {
  if (_employees is EqualUnmodifiableListView) return _employees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employees);
}


/// Create a copy of PayrollSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayrollSummaryCopyWith<_PayrollSummary> get copyWith => __$PayrollSummaryCopyWithImpl<_PayrollSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayrollSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayrollSummary&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.period, period) || other.period == period)&&(identical(other.totalEmployees, totalEmployees) || other.totalEmployees == totalEmployees)&&(identical(other.totalGrossPay, totalGrossPay) || other.totalGrossPay == totalGrossPay)&&(identical(other.totalTax, totalTax) || other.totalTax == totalTax)&&(identical(other.totalSuper, totalSuper) || other.totalSuper == totalSuper)&&(identical(other.totalNetPay, totalNetPay) || other.totalNetPay == totalNetPay)&&const DeepCollectionEquality().equals(other._employees, _employees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,period,totalEmployees,totalGrossPay,totalTax,totalSuper,totalNetPay,const DeepCollectionEquality().hash(_employees));

@override
String toString() {
  return 'PayrollSummary(organizationId: $organizationId, period: $period, totalEmployees: $totalEmployees, totalGrossPay: $totalGrossPay, totalTax: $totalTax, totalSuper: $totalSuper, totalNetPay: $totalNetPay, employees: $employees)';
}


}

/// @nodoc
abstract mixin class _$PayrollSummaryCopyWith<$Res> implements $PayrollSummaryCopyWith<$Res> {
  factory _$PayrollSummaryCopyWith(_PayrollSummary value, $Res Function(_PayrollSummary) _then) = __$PayrollSummaryCopyWithImpl;
@override @useResult
$Res call({
 String organizationId, String period, int totalEmployees, double totalGrossPay, double totalTax, double totalSuper, double totalNetPay, List<EmployeePayrollSummary> employees
});




}
/// @nodoc
class __$PayrollSummaryCopyWithImpl<$Res>
    implements _$PayrollSummaryCopyWith<$Res> {
  __$PayrollSummaryCopyWithImpl(this._self, this._then);

  final _PayrollSummary _self;
  final $Res Function(_PayrollSummary) _then;

/// Create a copy of PayrollSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? period = null,Object? totalEmployees = null,Object? totalGrossPay = null,Object? totalTax = null,Object? totalSuper = null,Object? totalNetPay = null,Object? employees = null,}) {
  return _then(_PayrollSummary(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,totalEmployees: null == totalEmployees ? _self.totalEmployees : totalEmployees // ignore: cast_nullable_to_non_nullable
as int,totalGrossPay: null == totalGrossPay ? _self.totalGrossPay : totalGrossPay // ignore: cast_nullable_to_non_nullable
as double,totalTax: null == totalTax ? _self.totalTax : totalTax // ignore: cast_nullable_to_non_nullable
as double,totalSuper: null == totalSuper ? _self.totalSuper : totalSuper // ignore: cast_nullable_to_non_nullable
as double,totalNetPay: null == totalNetPay ? _self.totalNetPay : totalNetPay // ignore: cast_nullable_to_non_nullable
as double,employees: null == employees ? _self._employees : employees // ignore: cast_nullable_to_non_nullable
as List<EmployeePayrollSummary>,
  ));
}


}


/// @nodoc
mixin _$EmployeePayrollSummary {

 String get userId; String get userName; double get grossPay; double get netPay;
/// Create a copy of EmployeePayrollSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeePayrollSummaryCopyWith<EmployeePayrollSummary> get copyWith => _$EmployeePayrollSummaryCopyWithImpl<EmployeePayrollSummary>(this as EmployeePayrollSummary, _$identity);

  /// Serializes this EmployeePayrollSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeePayrollSummary&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.grossPay, grossPay) || other.grossPay == grossPay)&&(identical(other.netPay, netPay) || other.netPay == netPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,grossPay,netPay);

@override
String toString() {
  return 'EmployeePayrollSummary(userId: $userId, userName: $userName, grossPay: $grossPay, netPay: $netPay)';
}


}

/// @nodoc
abstract mixin class $EmployeePayrollSummaryCopyWith<$Res>  {
  factory $EmployeePayrollSummaryCopyWith(EmployeePayrollSummary value, $Res Function(EmployeePayrollSummary) _then) = _$EmployeePayrollSummaryCopyWithImpl;
@useResult
$Res call({
 String userId, String userName, double grossPay, double netPay
});




}
/// @nodoc
class _$EmployeePayrollSummaryCopyWithImpl<$Res>
    implements $EmployeePayrollSummaryCopyWith<$Res> {
  _$EmployeePayrollSummaryCopyWithImpl(this._self, this._then);

  final EmployeePayrollSummary _self;
  final $Res Function(EmployeePayrollSummary) _then;

/// Create a copy of EmployeePayrollSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? userName = null,Object? grossPay = null,Object? netPay = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,grossPay: null == grossPay ? _self.grossPay : grossPay // ignore: cast_nullable_to_non_nullable
as double,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeePayrollSummary].
extension EmployeePayrollSummaryPatterns on EmployeePayrollSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeePayrollSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeePayrollSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeePayrollSummary value)  $default,){
final _that = this;
switch (_that) {
case _EmployeePayrollSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeePayrollSummary value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeePayrollSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String userName,  double grossPay,  double netPay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeePayrollSummary() when $default != null:
return $default(_that.userId,_that.userName,_that.grossPay,_that.netPay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String userName,  double grossPay,  double netPay)  $default,) {final _that = this;
switch (_that) {
case _EmployeePayrollSummary():
return $default(_that.userId,_that.userName,_that.grossPay,_that.netPay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String userName,  double grossPay,  double netPay)?  $default,) {final _that = this;
switch (_that) {
case _EmployeePayrollSummary() when $default != null:
return $default(_that.userId,_that.userName,_that.grossPay,_that.netPay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeePayrollSummary implements EmployeePayrollSummary {
  const _EmployeePayrollSummary({required this.userId, required this.userName, required this.grossPay, required this.netPay});
  factory _EmployeePayrollSummary.fromJson(Map<String, dynamic> json) => _$EmployeePayrollSummaryFromJson(json);

@override final  String userId;
@override final  String userName;
@override final  double grossPay;
@override final  double netPay;

/// Create a copy of EmployeePayrollSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeePayrollSummaryCopyWith<_EmployeePayrollSummary> get copyWith => __$EmployeePayrollSummaryCopyWithImpl<_EmployeePayrollSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeePayrollSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeePayrollSummary&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.grossPay, grossPay) || other.grossPay == grossPay)&&(identical(other.netPay, netPay) || other.netPay == netPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,userName,grossPay,netPay);

@override
String toString() {
  return 'EmployeePayrollSummary(userId: $userId, userName: $userName, grossPay: $grossPay, netPay: $netPay)';
}


}

/// @nodoc
abstract mixin class _$EmployeePayrollSummaryCopyWith<$Res> implements $EmployeePayrollSummaryCopyWith<$Res> {
  factory _$EmployeePayrollSummaryCopyWith(_EmployeePayrollSummary value, $Res Function(_EmployeePayrollSummary) _then) = __$EmployeePayrollSummaryCopyWithImpl;
@override @useResult
$Res call({
 String userId, String userName, double grossPay, double netPay
});




}
/// @nodoc
class __$EmployeePayrollSummaryCopyWithImpl<$Res>
    implements _$EmployeePayrollSummaryCopyWith<$Res> {
  __$EmployeePayrollSummaryCopyWithImpl(this._self, this._then);

  final _EmployeePayrollSummary _self;
  final $Res Function(_EmployeePayrollSummary) _then;

/// Create a copy of EmployeePayrollSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? userName = null,Object? grossPay = null,Object? netPay = null,}) {
  return _then(_EmployeePayrollSummary(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,grossPay: null == grossPay ? _self.grossPay : grossPay // ignore: cast_nullable_to_non_nullable
as double,netPay: null == netPay ? _self.netPay : netPay // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
