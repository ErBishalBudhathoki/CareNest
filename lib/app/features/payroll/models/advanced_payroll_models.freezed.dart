// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'advanced_payroll_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PayrollCalculation _$PayrollCalculationFromJson(Map<String, dynamic> json) {
  return _PayrollCalculation.fromJson(json);
}

/// @nodoc
mixin _$PayrollCalculation {
  String get userId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  double get baseHours => throw _privateConstructorUsedError;
  double get baseRate => throw _privateConstructorUsedError;
  double get baseAmount => throw _privateConstructorUsedError;
  PenaltyRates get penalties => throw _privateConstructorUsedError;
  Allowances get allowances => throw _privateConstructorUsedError;
  LeaveAccrual get leaveAccrual => throw _privateConstructorUsedError;
  TaxAndSuper get taxAndSuper => throw _privateConstructorUsedError;
  double get grossPay => throw _privateConstructorUsedError;
  double get netPay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollCalculationCopyWith<PayrollCalculation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollCalculationCopyWith<$Res> {
  factory $PayrollCalculationCopyWith(
          PayrollCalculation value, $Res Function(PayrollCalculation) then) =
      _$PayrollCalculationCopyWithImpl<$Res, PayrollCalculation>;
  @useResult
  $Res call(
      {String userId,
      String period,
      double baseHours,
      double baseRate,
      double baseAmount,
      PenaltyRates penalties,
      Allowances allowances,
      LeaveAccrual leaveAccrual,
      TaxAndSuper taxAndSuper,
      double grossPay,
      double netPay});

  $PenaltyRatesCopyWith<$Res> get penalties;
  $AllowancesCopyWith<$Res> get allowances;
  $LeaveAccrualCopyWith<$Res> get leaveAccrual;
  $TaxAndSuperCopyWith<$Res> get taxAndSuper;
}

/// @nodoc
class _$PayrollCalculationCopyWithImpl<$Res, $Val extends PayrollCalculation>
    implements $PayrollCalculationCopyWith<$Res> {
  _$PayrollCalculationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? period = null,
    Object? baseHours = null,
    Object? baseRate = null,
    Object? baseAmount = null,
    Object? penalties = null,
    Object? allowances = null,
    Object? leaveAccrual = null,
    Object? taxAndSuper = null,
    Object? grossPay = null,
    Object? netPay = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      baseHours: null == baseHours
          ? _value.baseHours
          : baseHours // ignore: cast_nullable_to_non_nullable
              as double,
      baseRate: null == baseRate
          ? _value.baseRate
          : baseRate // ignore: cast_nullable_to_non_nullable
              as double,
      baseAmount: null == baseAmount
          ? _value.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double,
      penalties: null == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as PenaltyRates,
      allowances: null == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as Allowances,
      leaveAccrual: null == leaveAccrual
          ? _value.leaveAccrual
          : leaveAccrual // ignore: cast_nullable_to_non_nullable
              as LeaveAccrual,
      taxAndSuper: null == taxAndSuper
          ? _value.taxAndSuper
          : taxAndSuper // ignore: cast_nullable_to_non_nullable
              as TaxAndSuper,
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRatesCopyWith<$Res> get penalties {
    return $PenaltyRatesCopyWith<$Res>(_value.penalties, (value) {
      return _then(_value.copyWith(penalties: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AllowancesCopyWith<$Res> get allowances {
    return $AllowancesCopyWith<$Res>(_value.allowances, (value) {
      return _then(_value.copyWith(allowances: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaveAccrualCopyWith<$Res> get leaveAccrual {
    return $LeaveAccrualCopyWith<$Res>(_value.leaveAccrual, (value) {
      return _then(_value.copyWith(leaveAccrual: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TaxAndSuperCopyWith<$Res> get taxAndSuper {
    return $TaxAndSuperCopyWith<$Res>(_value.taxAndSuper, (value) {
      return _then(_value.copyWith(taxAndSuper: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PayrollCalculationImplCopyWith<$Res>
    implements $PayrollCalculationCopyWith<$Res> {
  factory _$$PayrollCalculationImplCopyWith(_$PayrollCalculationImpl value,
          $Res Function(_$PayrollCalculationImpl) then) =
      __$$PayrollCalculationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String period,
      double baseHours,
      double baseRate,
      double baseAmount,
      PenaltyRates penalties,
      Allowances allowances,
      LeaveAccrual leaveAccrual,
      TaxAndSuper taxAndSuper,
      double grossPay,
      double netPay});

  @override
  $PenaltyRatesCopyWith<$Res> get penalties;
  @override
  $AllowancesCopyWith<$Res> get allowances;
  @override
  $LeaveAccrualCopyWith<$Res> get leaveAccrual;
  @override
  $TaxAndSuperCopyWith<$Res> get taxAndSuper;
}

/// @nodoc
class __$$PayrollCalculationImplCopyWithImpl<$Res>
    extends _$PayrollCalculationCopyWithImpl<$Res, _$PayrollCalculationImpl>
    implements _$$PayrollCalculationImplCopyWith<$Res> {
  __$$PayrollCalculationImplCopyWithImpl(_$PayrollCalculationImpl _value,
      $Res Function(_$PayrollCalculationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? period = null,
    Object? baseHours = null,
    Object? baseRate = null,
    Object? baseAmount = null,
    Object? penalties = null,
    Object? allowances = null,
    Object? leaveAccrual = null,
    Object? taxAndSuper = null,
    Object? grossPay = null,
    Object? netPay = null,
  }) {
    return _then(_$PayrollCalculationImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      baseHours: null == baseHours
          ? _value.baseHours
          : baseHours // ignore: cast_nullable_to_non_nullable
              as double,
      baseRate: null == baseRate
          ? _value.baseRate
          : baseRate // ignore: cast_nullable_to_non_nullable
              as double,
      baseAmount: null == baseAmount
          ? _value.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double,
      penalties: null == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as PenaltyRates,
      allowances: null == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as Allowances,
      leaveAccrual: null == leaveAccrual
          ? _value.leaveAccrual
          : leaveAccrual // ignore: cast_nullable_to_non_nullable
              as LeaveAccrual,
      taxAndSuper: null == taxAndSuper
          ? _value.taxAndSuper
          : taxAndSuper // ignore: cast_nullable_to_non_nullable
              as TaxAndSuper,
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollCalculationImpl implements _PayrollCalculation {
  const _$PayrollCalculationImpl(
      {required this.userId,
      required this.period,
      required this.baseHours,
      required this.baseRate,
      required this.baseAmount,
      required this.penalties,
      required this.allowances,
      required this.leaveAccrual,
      required this.taxAndSuper,
      required this.grossPay,
      required this.netPay});

  factory _$PayrollCalculationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollCalculationImplFromJson(json);

  @override
  final String userId;
  @override
  final String period;
  @override
  final double baseHours;
  @override
  final double baseRate;
  @override
  final double baseAmount;
  @override
  final PenaltyRates penalties;
  @override
  final Allowances allowances;
  @override
  final LeaveAccrual leaveAccrual;
  @override
  final TaxAndSuper taxAndSuper;
  @override
  final double grossPay;
  @override
  final double netPay;

  @override
  String toString() {
    return 'PayrollCalculation(userId: $userId, period: $period, baseHours: $baseHours, baseRate: $baseRate, baseAmount: $baseAmount, penalties: $penalties, allowances: $allowances, leaveAccrual: $leaveAccrual, taxAndSuper: $taxAndSuper, grossPay: $grossPay, netPay: $netPay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollCalculationImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.baseHours, baseHours) ||
                other.baseHours == baseHours) &&
            (identical(other.baseRate, baseRate) ||
                other.baseRate == baseRate) &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.penalties, penalties) ||
                other.penalties == penalties) &&
            (identical(other.allowances, allowances) ||
                other.allowances == allowances) &&
            (identical(other.leaveAccrual, leaveAccrual) ||
                other.leaveAccrual == leaveAccrual) &&
            (identical(other.taxAndSuper, taxAndSuper) ||
                other.taxAndSuper == taxAndSuper) &&
            (identical(other.grossPay, grossPay) ||
                other.grossPay == grossPay) &&
            (identical(other.netPay, netPay) || other.netPay == netPay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      period,
      baseHours,
      baseRate,
      baseAmount,
      penalties,
      allowances,
      leaveAccrual,
      taxAndSuper,
      grossPay,
      netPay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollCalculationImplCopyWith<_$PayrollCalculationImpl> get copyWith =>
      __$$PayrollCalculationImplCopyWithImpl<_$PayrollCalculationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollCalculationImplToJson(
      this,
    );
  }
}

abstract class _PayrollCalculation implements PayrollCalculation {
  const factory _PayrollCalculation(
      {required final String userId,
      required final String period,
      required final double baseHours,
      required final double baseRate,
      required final double baseAmount,
      required final PenaltyRates penalties,
      required final Allowances allowances,
      required final LeaveAccrual leaveAccrual,
      required final TaxAndSuper taxAndSuper,
      required final double grossPay,
      required final double netPay}) = _$PayrollCalculationImpl;

  factory _PayrollCalculation.fromJson(Map<String, dynamic> json) =
      _$PayrollCalculationImpl.fromJson;

  @override
  String get userId;
  @override
  String get period;
  @override
  double get baseHours;
  @override
  double get baseRate;
  @override
  double get baseAmount;
  @override
  PenaltyRates get penalties;
  @override
  Allowances get allowances;
  @override
  LeaveAccrual get leaveAccrual;
  @override
  TaxAndSuper get taxAndSuper;
  @override
  double get grossPay;
  @override
  double get netPay;
  @override
  @JsonKey(ignore: true)
  _$$PayrollCalculationImplCopyWith<_$PayrollCalculationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PenaltyRates _$PenaltyRatesFromJson(Map<String, dynamic> json) {
  return _PenaltyRates.fromJson(json);
}

/// @nodoc
mixin _$PenaltyRates {
  PenaltyRate get saturday => throw _privateConstructorUsedError;
  PenaltyRate get sunday => throw _privateConstructorUsedError;
  PenaltyRate get publicHoliday => throw _privateConstructorUsedError;
  PenaltyRate get overtime => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PenaltyRatesCopyWith<PenaltyRates> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PenaltyRatesCopyWith<$Res> {
  factory $PenaltyRatesCopyWith(
          PenaltyRates value, $Res Function(PenaltyRates) then) =
      _$PenaltyRatesCopyWithImpl<$Res, PenaltyRates>;
  @useResult
  $Res call(
      {PenaltyRate saturday,
      PenaltyRate sunday,
      PenaltyRate publicHoliday,
      PenaltyRate overtime,
      double total});

  $PenaltyRateCopyWith<$Res> get saturday;
  $PenaltyRateCopyWith<$Res> get sunday;
  $PenaltyRateCopyWith<$Res> get publicHoliday;
  $PenaltyRateCopyWith<$Res> get overtime;
}

/// @nodoc
class _$PenaltyRatesCopyWithImpl<$Res, $Val extends PenaltyRates>
    implements $PenaltyRatesCopyWith<$Res> {
  _$PenaltyRatesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saturday = null,
    Object? sunday = null,
    Object? publicHoliday = null,
    Object? overtime = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      saturday: null == saturday
          ? _value.saturday
          : saturday // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      sunday: null == sunday
          ? _value.sunday
          : sunday // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      publicHoliday: null == publicHoliday
          ? _value.publicHoliday
          : publicHoliday // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      overtime: null == overtime
          ? _value.overtime
          : overtime // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRateCopyWith<$Res> get saturday {
    return $PenaltyRateCopyWith<$Res>(_value.saturday, (value) {
      return _then(_value.copyWith(saturday: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRateCopyWith<$Res> get sunday {
    return $PenaltyRateCopyWith<$Res>(_value.sunday, (value) {
      return _then(_value.copyWith(sunday: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRateCopyWith<$Res> get publicHoliday {
    return $PenaltyRateCopyWith<$Res>(_value.publicHoliday, (value) {
      return _then(_value.copyWith(publicHoliday: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PenaltyRateCopyWith<$Res> get overtime {
    return $PenaltyRateCopyWith<$Res>(_value.overtime, (value) {
      return _then(_value.copyWith(overtime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PenaltyRatesImplCopyWith<$Res>
    implements $PenaltyRatesCopyWith<$Res> {
  factory _$$PenaltyRatesImplCopyWith(
          _$PenaltyRatesImpl value, $Res Function(_$PenaltyRatesImpl) then) =
      __$$PenaltyRatesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PenaltyRate saturday,
      PenaltyRate sunday,
      PenaltyRate publicHoliday,
      PenaltyRate overtime,
      double total});

  @override
  $PenaltyRateCopyWith<$Res> get saturday;
  @override
  $PenaltyRateCopyWith<$Res> get sunday;
  @override
  $PenaltyRateCopyWith<$Res> get publicHoliday;
  @override
  $PenaltyRateCopyWith<$Res> get overtime;
}

/// @nodoc
class __$$PenaltyRatesImplCopyWithImpl<$Res>
    extends _$PenaltyRatesCopyWithImpl<$Res, _$PenaltyRatesImpl>
    implements _$$PenaltyRatesImplCopyWith<$Res> {
  __$$PenaltyRatesImplCopyWithImpl(
      _$PenaltyRatesImpl _value, $Res Function(_$PenaltyRatesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saturday = null,
    Object? sunday = null,
    Object? publicHoliday = null,
    Object? overtime = null,
    Object? total = null,
  }) {
    return _then(_$PenaltyRatesImpl(
      saturday: null == saturday
          ? _value.saturday
          : saturday // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      sunday: null == sunday
          ? _value.sunday
          : sunday // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      publicHoliday: null == publicHoliday
          ? _value.publicHoliday
          : publicHoliday // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      overtime: null == overtime
          ? _value.overtime
          : overtime // ignore: cast_nullable_to_non_nullable
              as PenaltyRate,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenaltyRatesImpl implements _PenaltyRates {
  const _$PenaltyRatesImpl(
      {required this.saturday,
      required this.sunday,
      required this.publicHoliday,
      required this.overtime,
      required this.total});

  factory _$PenaltyRatesImpl.fromJson(Map<String, dynamic> json) =>
      _$$PenaltyRatesImplFromJson(json);

  @override
  final PenaltyRate saturday;
  @override
  final PenaltyRate sunday;
  @override
  final PenaltyRate publicHoliday;
  @override
  final PenaltyRate overtime;
  @override
  final double total;

  @override
  String toString() {
    return 'PenaltyRates(saturday: $saturday, sunday: $sunday, publicHoliday: $publicHoliday, overtime: $overtime, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenaltyRatesImpl &&
            (identical(other.saturday, saturday) ||
                other.saturday == saturday) &&
            (identical(other.sunday, sunday) || other.sunday == sunday) &&
            (identical(other.publicHoliday, publicHoliday) ||
                other.publicHoliday == publicHoliday) &&
            (identical(other.overtime, overtime) ||
                other.overtime == overtime) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, saturday, sunday, publicHoliday, overtime, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenaltyRatesImplCopyWith<_$PenaltyRatesImpl> get copyWith =>
      __$$PenaltyRatesImplCopyWithImpl<_$PenaltyRatesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PenaltyRatesImplToJson(
      this,
    );
  }
}

abstract class _PenaltyRates implements PenaltyRates {
  const factory _PenaltyRates(
      {required final PenaltyRate saturday,
      required final PenaltyRate sunday,
      required final PenaltyRate publicHoliday,
      required final PenaltyRate overtime,
      required final double total}) = _$PenaltyRatesImpl;

  factory _PenaltyRates.fromJson(Map<String, dynamic> json) =
      _$PenaltyRatesImpl.fromJson;

  @override
  PenaltyRate get saturday;
  @override
  PenaltyRate get sunday;
  @override
  PenaltyRate get publicHoliday;
  @override
  PenaltyRate get overtime;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$PenaltyRatesImplCopyWith<_$PenaltyRatesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PenaltyRate _$PenaltyRateFromJson(Map<String, dynamic> json) {
  return _PenaltyRate.fromJson(json);
}

/// @nodoc
mixin _$PenaltyRate {
  double get hours => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PenaltyRateCopyWith<PenaltyRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PenaltyRateCopyWith<$Res> {
  factory $PenaltyRateCopyWith(
          PenaltyRate value, $Res Function(PenaltyRate) then) =
      _$PenaltyRateCopyWithImpl<$Res, PenaltyRate>;
  @useResult
  $Res call({double hours, double rate, double amount});
}

/// @nodoc
class _$PenaltyRateCopyWithImpl<$Res, $Val extends PenaltyRate>
    implements $PenaltyRateCopyWith<$Res> {
  _$PenaltyRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hours = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PenaltyRateImplCopyWith<$Res>
    implements $PenaltyRateCopyWith<$Res> {
  factory _$$PenaltyRateImplCopyWith(
          _$PenaltyRateImpl value, $Res Function(_$PenaltyRateImpl) then) =
      __$$PenaltyRateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double hours, double rate, double amount});
}

/// @nodoc
class __$$PenaltyRateImplCopyWithImpl<$Res>
    extends _$PenaltyRateCopyWithImpl<$Res, _$PenaltyRateImpl>
    implements _$$PenaltyRateImplCopyWith<$Res> {
  __$$PenaltyRateImplCopyWithImpl(
      _$PenaltyRateImpl _value, $Res Function(_$PenaltyRateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hours = null,
    Object? rate = null,
    Object? amount = null,
  }) {
    return _then(_$PenaltyRateImpl(
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenaltyRateImpl implements _PenaltyRate {
  const _$PenaltyRateImpl(
      {required this.hours, required this.rate, required this.amount});

  factory _$PenaltyRateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PenaltyRateImplFromJson(json);

  @override
  final double hours;
  @override
  final double rate;
  @override
  final double amount;

  @override
  String toString() {
    return 'PenaltyRate(hours: $hours, rate: $rate, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenaltyRateImpl &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hours, rate, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenaltyRateImplCopyWith<_$PenaltyRateImpl> get copyWith =>
      __$$PenaltyRateImplCopyWithImpl<_$PenaltyRateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PenaltyRateImplToJson(
      this,
    );
  }
}

abstract class _PenaltyRate implements PenaltyRate {
  const factory _PenaltyRate(
      {required final double hours,
      required final double rate,
      required final double amount}) = _$PenaltyRateImpl;

  factory _PenaltyRate.fromJson(Map<String, dynamic> json) =
      _$PenaltyRateImpl.fromJson;

  @override
  double get hours;
  @override
  double get rate;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$PenaltyRateImplCopyWith<_$PenaltyRateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Allowances _$AllowancesFromJson(Map<String, dynamic> json) {
  return _Allowances.fromJson(json);
}

/// @nodoc
mixin _$Allowances {
  double get travel => throw _privateConstructorUsedError;
  double get meal => throw _privateConstructorUsedError;
  double get sleepover => throw _privateConstructorUsedError;
  double get firstAid => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllowancesCopyWith<Allowances> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllowancesCopyWith<$Res> {
  factory $AllowancesCopyWith(
          Allowances value, $Res Function(Allowances) then) =
      _$AllowancesCopyWithImpl<$Res, Allowances>;
  @useResult
  $Res call(
      {double travel,
      double meal,
      double sleepover,
      double firstAid,
      double total});
}

/// @nodoc
class _$AllowancesCopyWithImpl<$Res, $Val extends Allowances>
    implements $AllowancesCopyWith<$Res> {
  _$AllowancesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? travel = null,
    Object? meal = null,
    Object? sleepover = null,
    Object? firstAid = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      travel: null == travel
          ? _value.travel
          : travel // ignore: cast_nullable_to_non_nullable
              as double,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as double,
      sleepover: null == sleepover
          ? _value.sleepover
          : sleepover // ignore: cast_nullable_to_non_nullable
              as double,
      firstAid: null == firstAid
          ? _value.firstAid
          : firstAid // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllowancesImplCopyWith<$Res>
    implements $AllowancesCopyWith<$Res> {
  factory _$$AllowancesImplCopyWith(
          _$AllowancesImpl value, $Res Function(_$AllowancesImpl) then) =
      __$$AllowancesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double travel,
      double meal,
      double sleepover,
      double firstAid,
      double total});
}

/// @nodoc
class __$$AllowancesImplCopyWithImpl<$Res>
    extends _$AllowancesCopyWithImpl<$Res, _$AllowancesImpl>
    implements _$$AllowancesImplCopyWith<$Res> {
  __$$AllowancesImplCopyWithImpl(
      _$AllowancesImpl _value, $Res Function(_$AllowancesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? travel = null,
    Object? meal = null,
    Object? sleepover = null,
    Object? firstAid = null,
    Object? total = null,
  }) {
    return _then(_$AllowancesImpl(
      travel: null == travel
          ? _value.travel
          : travel // ignore: cast_nullable_to_non_nullable
              as double,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as double,
      sleepover: null == sleepover
          ? _value.sleepover
          : sleepover // ignore: cast_nullable_to_non_nullable
              as double,
      firstAid: null == firstAid
          ? _value.firstAid
          : firstAid // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllowancesImpl implements _Allowances {
  const _$AllowancesImpl(
      {required this.travel,
      required this.meal,
      required this.sleepover,
      required this.firstAid,
      required this.total});

  factory _$AllowancesImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllowancesImplFromJson(json);

  @override
  final double travel;
  @override
  final double meal;
  @override
  final double sleepover;
  @override
  final double firstAid;
  @override
  final double total;

  @override
  String toString() {
    return 'Allowances(travel: $travel, meal: $meal, sleepover: $sleepover, firstAid: $firstAid, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllowancesImpl &&
            (identical(other.travel, travel) || other.travel == travel) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.sleepover, sleepover) ||
                other.sleepover == sleepover) &&
            (identical(other.firstAid, firstAid) ||
                other.firstAid == firstAid) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, travel, meal, sleepover, firstAid, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllowancesImplCopyWith<_$AllowancesImpl> get copyWith =>
      __$$AllowancesImplCopyWithImpl<_$AllowancesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllowancesImplToJson(
      this,
    );
  }
}

abstract class _Allowances implements Allowances {
  const factory _Allowances(
      {required final double travel,
      required final double meal,
      required final double sleepover,
      required final double firstAid,
      required final double total}) = _$AllowancesImpl;

  factory _Allowances.fromJson(Map<String, dynamic> json) =
      _$AllowancesImpl.fromJson;

  @override
  double get travel;
  @override
  double get meal;
  @override
  double get sleepover;
  @override
  double get firstAid;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$AllowancesImplCopyWith<_$AllowancesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveAccrual _$LeaveAccrualFromJson(Map<String, dynamic> json) {
  return _LeaveAccrual.fromJson(json);
}

/// @nodoc
mixin _$LeaveAccrual {
  LeaveAccrualDetail get annualLeave => throw _privateConstructorUsedError;
  LeaveAccrualDetail get sickLeave => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveAccrualCopyWith<LeaveAccrual> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveAccrualCopyWith<$Res> {
  factory $LeaveAccrualCopyWith(
          LeaveAccrual value, $Res Function(LeaveAccrual) then) =
      _$LeaveAccrualCopyWithImpl<$Res, LeaveAccrual>;
  @useResult
  $Res call({LeaveAccrualDetail annualLeave, LeaveAccrualDetail sickLeave});

  $LeaveAccrualDetailCopyWith<$Res> get annualLeave;
  $LeaveAccrualDetailCopyWith<$Res> get sickLeave;
}

/// @nodoc
class _$LeaveAccrualCopyWithImpl<$Res, $Val extends LeaveAccrual>
    implements $LeaveAccrualCopyWith<$Res> {
  _$LeaveAccrualCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualLeave = null,
    Object? sickLeave = null,
  }) {
    return _then(_value.copyWith(
      annualLeave: null == annualLeave
          ? _value.annualLeave
          : annualLeave // ignore: cast_nullable_to_non_nullable
              as LeaveAccrualDetail,
      sickLeave: null == sickLeave
          ? _value.sickLeave
          : sickLeave // ignore: cast_nullable_to_non_nullable
              as LeaveAccrualDetail,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaveAccrualDetailCopyWith<$Res> get annualLeave {
    return $LeaveAccrualDetailCopyWith<$Res>(_value.annualLeave, (value) {
      return _then(_value.copyWith(annualLeave: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaveAccrualDetailCopyWith<$Res> get sickLeave {
    return $LeaveAccrualDetailCopyWith<$Res>(_value.sickLeave, (value) {
      return _then(_value.copyWith(sickLeave: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LeaveAccrualImplCopyWith<$Res>
    implements $LeaveAccrualCopyWith<$Res> {
  factory _$$LeaveAccrualImplCopyWith(
          _$LeaveAccrualImpl value, $Res Function(_$LeaveAccrualImpl) then) =
      __$$LeaveAccrualImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LeaveAccrualDetail annualLeave, LeaveAccrualDetail sickLeave});

  @override
  $LeaveAccrualDetailCopyWith<$Res> get annualLeave;
  @override
  $LeaveAccrualDetailCopyWith<$Res> get sickLeave;
}

/// @nodoc
class __$$LeaveAccrualImplCopyWithImpl<$Res>
    extends _$LeaveAccrualCopyWithImpl<$Res, _$LeaveAccrualImpl>
    implements _$$LeaveAccrualImplCopyWith<$Res> {
  __$$LeaveAccrualImplCopyWithImpl(
      _$LeaveAccrualImpl _value, $Res Function(_$LeaveAccrualImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualLeave = null,
    Object? sickLeave = null,
  }) {
    return _then(_$LeaveAccrualImpl(
      annualLeave: null == annualLeave
          ? _value.annualLeave
          : annualLeave // ignore: cast_nullable_to_non_nullable
              as LeaveAccrualDetail,
      sickLeave: null == sickLeave
          ? _value.sickLeave
          : sickLeave // ignore: cast_nullable_to_non_nullable
              as LeaveAccrualDetail,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveAccrualImpl implements _LeaveAccrual {
  const _$LeaveAccrualImpl(
      {required this.annualLeave, required this.sickLeave});

  factory _$LeaveAccrualImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveAccrualImplFromJson(json);

  @override
  final LeaveAccrualDetail annualLeave;
  @override
  final LeaveAccrualDetail sickLeave;

  @override
  String toString() {
    return 'LeaveAccrual(annualLeave: $annualLeave, sickLeave: $sickLeave)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveAccrualImpl &&
            (identical(other.annualLeave, annualLeave) ||
                other.annualLeave == annualLeave) &&
            (identical(other.sickLeave, sickLeave) ||
                other.sickLeave == sickLeave));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, annualLeave, sickLeave);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveAccrualImplCopyWith<_$LeaveAccrualImpl> get copyWith =>
      __$$LeaveAccrualImplCopyWithImpl<_$LeaveAccrualImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveAccrualImplToJson(
      this,
    );
  }
}

abstract class _LeaveAccrual implements LeaveAccrual {
  const factory _LeaveAccrual(
      {required final LeaveAccrualDetail annualLeave,
      required final LeaveAccrualDetail sickLeave}) = _$LeaveAccrualImpl;

  factory _LeaveAccrual.fromJson(Map<String, dynamic> json) =
      _$LeaveAccrualImpl.fromJson;

  @override
  LeaveAccrualDetail get annualLeave;
  @override
  LeaveAccrualDetail get sickLeave;
  @override
  @JsonKey(ignore: true)
  _$$LeaveAccrualImplCopyWith<_$LeaveAccrualImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaveAccrualDetail _$LeaveAccrualDetailFromJson(Map<String, dynamic> json) {
  return _LeaveAccrualDetail.fromJson(json);
}

/// @nodoc
mixin _$LeaveAccrualDetail {
  double get hours => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaveAccrualDetailCopyWith<LeaveAccrualDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveAccrualDetailCopyWith<$Res> {
  factory $LeaveAccrualDetailCopyWith(
          LeaveAccrualDetail value, $Res Function(LeaveAccrualDetail) then) =
      _$LeaveAccrualDetailCopyWithImpl<$Res, LeaveAccrualDetail>;
  @useResult
  $Res call({double hours, double amount});
}

/// @nodoc
class _$LeaveAccrualDetailCopyWithImpl<$Res, $Val extends LeaveAccrualDetail>
    implements $LeaveAccrualDetailCopyWith<$Res> {
  _$LeaveAccrualDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hours = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaveAccrualDetailImplCopyWith<$Res>
    implements $LeaveAccrualDetailCopyWith<$Res> {
  factory _$$LeaveAccrualDetailImplCopyWith(_$LeaveAccrualDetailImpl value,
          $Res Function(_$LeaveAccrualDetailImpl) then) =
      __$$LeaveAccrualDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double hours, double amount});
}

/// @nodoc
class __$$LeaveAccrualDetailImplCopyWithImpl<$Res>
    extends _$LeaveAccrualDetailCopyWithImpl<$Res, _$LeaveAccrualDetailImpl>
    implements _$$LeaveAccrualDetailImplCopyWith<$Res> {
  __$$LeaveAccrualDetailImplCopyWithImpl(_$LeaveAccrualDetailImpl _value,
      $Res Function(_$LeaveAccrualDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hours = null,
    Object? amount = null,
  }) {
    return _then(_$LeaveAccrualDetailImpl(
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveAccrualDetailImpl implements _LeaveAccrualDetail {
  const _$LeaveAccrualDetailImpl({required this.hours, required this.amount});

  factory _$LeaveAccrualDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveAccrualDetailImplFromJson(json);

  @override
  final double hours;
  @override
  final double amount;

  @override
  String toString() {
    return 'LeaveAccrualDetail(hours: $hours, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveAccrualDetailImpl &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hours, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveAccrualDetailImplCopyWith<_$LeaveAccrualDetailImpl> get copyWith =>
      __$$LeaveAccrualDetailImplCopyWithImpl<_$LeaveAccrualDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveAccrualDetailImplToJson(
      this,
    );
  }
}

abstract class _LeaveAccrualDetail implements LeaveAccrualDetail {
  const factory _LeaveAccrualDetail(
      {required final double hours,
      required final double amount}) = _$LeaveAccrualDetailImpl;

  factory _LeaveAccrualDetail.fromJson(Map<String, dynamic> json) =
      _$LeaveAccrualDetailImpl.fromJson;

  @override
  double get hours;
  @override
  double get amount;
  @override
  @JsonKey(ignore: true)
  _$$LeaveAccrualDetailImplCopyWith<_$LeaveAccrualDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaxAndSuper _$TaxAndSuperFromJson(Map<String, dynamic> json) {
  return _TaxAndSuper.fromJson(json);
}

/// @nodoc
mixin _$TaxAndSuper {
  double get tax => throw _privateConstructorUsedError;
  @JsonKey(name: 'super')
  double get superAmount => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  double get superRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaxAndSuperCopyWith<TaxAndSuper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaxAndSuperCopyWith<$Res> {
  factory $TaxAndSuperCopyWith(
          TaxAndSuper value, $Res Function(TaxAndSuper) then) =
      _$TaxAndSuperCopyWithImpl<$Res, TaxAndSuper>;
  @useResult
  $Res call(
      {double tax,
      @JsonKey(name: 'super') double superAmount,
      double taxRate,
      double superRate});
}

/// @nodoc
class _$TaxAndSuperCopyWithImpl<$Res, $Val extends TaxAndSuper>
    implements $TaxAndSuperCopyWith<$Res> {
  _$TaxAndSuperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tax = null,
    Object? superAmount = null,
    Object? taxRate = null,
    Object? superRate = null,
  }) {
    return _then(_value.copyWith(
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      superAmount: null == superAmount
          ? _value.superAmount
          : superAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      superRate: null == superRate
          ? _value.superRate
          : superRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaxAndSuperImplCopyWith<$Res>
    implements $TaxAndSuperCopyWith<$Res> {
  factory _$$TaxAndSuperImplCopyWith(
          _$TaxAndSuperImpl value, $Res Function(_$TaxAndSuperImpl) then) =
      __$$TaxAndSuperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double tax,
      @JsonKey(name: 'super') double superAmount,
      double taxRate,
      double superRate});
}

/// @nodoc
class __$$TaxAndSuperImplCopyWithImpl<$Res>
    extends _$TaxAndSuperCopyWithImpl<$Res, _$TaxAndSuperImpl>
    implements _$$TaxAndSuperImplCopyWith<$Res> {
  __$$TaxAndSuperImplCopyWithImpl(
      _$TaxAndSuperImpl _value, $Res Function(_$TaxAndSuperImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tax = null,
    Object? superAmount = null,
    Object? taxRate = null,
    Object? superRate = null,
  }) {
    return _then(_$TaxAndSuperImpl(
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      superAmount: null == superAmount
          ? _value.superAmount
          : superAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      superRate: null == superRate
          ? _value.superRate
          : superRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaxAndSuperImpl implements _TaxAndSuper {
  const _$TaxAndSuperImpl(
      {required this.tax,
      @JsonKey(name: 'super') required this.superAmount,
      required this.taxRate,
      required this.superRate});

  factory _$TaxAndSuperImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaxAndSuperImplFromJson(json);

  @override
  final double tax;
  @override
  @JsonKey(name: 'super')
  final double superAmount;
  @override
  final double taxRate;
  @override
  final double superRate;

  @override
  String toString() {
    return 'TaxAndSuper(tax: $tax, superAmount: $superAmount, taxRate: $taxRate, superRate: $superRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaxAndSuperImpl &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.superAmount, superAmount) ||
                other.superAmount == superAmount) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.superRate, superRate) ||
                other.superRate == superRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tax, superAmount, taxRate, superRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaxAndSuperImplCopyWith<_$TaxAndSuperImpl> get copyWith =>
      __$$TaxAndSuperImplCopyWithImpl<_$TaxAndSuperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaxAndSuperImplToJson(
      this,
    );
  }
}

abstract class _TaxAndSuper implements TaxAndSuper {
  const factory _TaxAndSuper(
      {required final double tax,
      @JsonKey(name: 'super') required final double superAmount,
      required final double taxRate,
      required final double superRate}) = _$TaxAndSuperImpl;

  factory _TaxAndSuper.fromJson(Map<String, dynamic> json) =
      _$TaxAndSuperImpl.fromJson;

  @override
  double get tax;
  @override
  @JsonKey(name: 'super')
  double get superAmount;
  @override
  double get taxRate;
  @override
  double get superRate;
  @override
  @JsonKey(ignore: true)
  _$$TaxAndSuperImplCopyWith<_$TaxAndSuperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Payslip _$PayslipFromJson(Map<String, dynamic> json) {
  return _Payslip.fromJson(json);
}

/// @nodoc
mixin _$Payslip {
  String get payslipId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get generatedDate => throw _privateConstructorUsedError;
  PayslipEarnings get earnings => throw _privateConstructorUsedError;
  PayslipDeductions get deductions => throw _privateConstructorUsedError;
  double get netPay => throw _privateConstructorUsedError;
  PayslipYTD get ytd => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayslipCopyWith<Payslip> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayslipCopyWith<$Res> {
  factory $PayslipCopyWith(Payslip value, $Res Function(Payslip) then) =
      _$PayslipCopyWithImpl<$Res, Payslip>;
  @useResult
  $Res call(
      {String payslipId,
      String userId,
      String period,
      String generatedDate,
      PayslipEarnings earnings,
      PayslipDeductions deductions,
      double netPay,
      PayslipYTD ytd});

  $PayslipEarningsCopyWith<$Res> get earnings;
  $PayslipDeductionsCopyWith<$Res> get deductions;
  $PayslipYTDCopyWith<$Res> get ytd;
}

/// @nodoc
class _$PayslipCopyWithImpl<$Res, $Val extends Payslip>
    implements $PayslipCopyWith<$Res> {
  _$PayslipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payslipId = null,
    Object? userId = null,
    Object? period = null,
    Object? generatedDate = null,
    Object? earnings = null,
    Object? deductions = null,
    Object? netPay = null,
    Object? ytd = null,
  }) {
    return _then(_value.copyWith(
      payslipId: null == payslipId
          ? _value.payslipId
          : payslipId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _value.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      earnings: null == earnings
          ? _value.earnings
          : earnings // ignore: cast_nullable_to_non_nullable
              as PayslipEarnings,
      deductions: null == deductions
          ? _value.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as PayslipDeductions,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
      ytd: null == ytd
          ? _value.ytd
          : ytd // ignore: cast_nullable_to_non_nullable
              as PayslipYTD,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PayslipEarningsCopyWith<$Res> get earnings {
    return $PayslipEarningsCopyWith<$Res>(_value.earnings, (value) {
      return _then(_value.copyWith(earnings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PayslipDeductionsCopyWith<$Res> get deductions {
    return $PayslipDeductionsCopyWith<$Res>(_value.deductions, (value) {
      return _then(_value.copyWith(deductions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PayslipYTDCopyWith<$Res> get ytd {
    return $PayslipYTDCopyWith<$Res>(_value.ytd, (value) {
      return _then(_value.copyWith(ytd: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PayslipImplCopyWith<$Res> implements $PayslipCopyWith<$Res> {
  factory _$$PayslipImplCopyWith(
          _$PayslipImpl value, $Res Function(_$PayslipImpl) then) =
      __$$PayslipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String payslipId,
      String userId,
      String period,
      String generatedDate,
      PayslipEarnings earnings,
      PayslipDeductions deductions,
      double netPay,
      PayslipYTD ytd});

  @override
  $PayslipEarningsCopyWith<$Res> get earnings;
  @override
  $PayslipDeductionsCopyWith<$Res> get deductions;
  @override
  $PayslipYTDCopyWith<$Res> get ytd;
}

/// @nodoc
class __$$PayslipImplCopyWithImpl<$Res>
    extends _$PayslipCopyWithImpl<$Res, _$PayslipImpl>
    implements _$$PayslipImplCopyWith<$Res> {
  __$$PayslipImplCopyWithImpl(
      _$PayslipImpl _value, $Res Function(_$PayslipImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payslipId = null,
    Object? userId = null,
    Object? period = null,
    Object? generatedDate = null,
    Object? earnings = null,
    Object? deductions = null,
    Object? netPay = null,
    Object? ytd = null,
  }) {
    return _then(_$PayslipImpl(
      payslipId: null == payslipId
          ? _value.payslipId
          : payslipId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      generatedDate: null == generatedDate
          ? _value.generatedDate
          : generatedDate // ignore: cast_nullable_to_non_nullable
              as String,
      earnings: null == earnings
          ? _value.earnings
          : earnings // ignore: cast_nullable_to_non_nullable
              as PayslipEarnings,
      deductions: null == deductions
          ? _value.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as PayslipDeductions,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
      ytd: null == ytd
          ? _value.ytd
          : ytd // ignore: cast_nullable_to_non_nullable
              as PayslipYTD,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayslipImpl implements _Payslip {
  const _$PayslipImpl(
      {required this.payslipId,
      required this.userId,
      required this.period,
      required this.generatedDate,
      required this.earnings,
      required this.deductions,
      required this.netPay,
      required this.ytd});

  factory _$PayslipImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayslipImplFromJson(json);

  @override
  final String payslipId;
  @override
  final String userId;
  @override
  final String period;
  @override
  final String generatedDate;
  @override
  final PayslipEarnings earnings;
  @override
  final PayslipDeductions deductions;
  @override
  final double netPay;
  @override
  final PayslipYTD ytd;

  @override
  String toString() {
    return 'Payslip(payslipId: $payslipId, userId: $userId, period: $period, generatedDate: $generatedDate, earnings: $earnings, deductions: $deductions, netPay: $netPay, ytd: $ytd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayslipImpl &&
            (identical(other.payslipId, payslipId) ||
                other.payslipId == payslipId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.generatedDate, generatedDate) ||
                other.generatedDate == generatedDate) &&
            (identical(other.earnings, earnings) ||
                other.earnings == earnings) &&
            (identical(other.deductions, deductions) ||
                other.deductions == deductions) &&
            (identical(other.netPay, netPay) || other.netPay == netPay) &&
            (identical(other.ytd, ytd) || other.ytd == ytd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, payslipId, userId, period,
      generatedDate, earnings, deductions, netPay, ytd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayslipImplCopyWith<_$PayslipImpl> get copyWith =>
      __$$PayslipImplCopyWithImpl<_$PayslipImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayslipImplToJson(
      this,
    );
  }
}

abstract class _Payslip implements Payslip {
  const factory _Payslip(
      {required final String payslipId,
      required final String userId,
      required final String period,
      required final String generatedDate,
      required final PayslipEarnings earnings,
      required final PayslipDeductions deductions,
      required final double netPay,
      required final PayslipYTD ytd}) = _$PayslipImpl;

  factory _Payslip.fromJson(Map<String, dynamic> json) = _$PayslipImpl.fromJson;

  @override
  String get payslipId;
  @override
  String get userId;
  @override
  String get period;
  @override
  String get generatedDate;
  @override
  PayslipEarnings get earnings;
  @override
  PayslipDeductions get deductions;
  @override
  double get netPay;
  @override
  PayslipYTD get ytd;
  @override
  @JsonKey(ignore: true)
  _$$PayslipImplCopyWith<_$PayslipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayslipEarnings _$PayslipEarningsFromJson(Map<String, dynamic> json) {
  return _PayslipEarnings.fromJson(json);
}

/// @nodoc
mixin _$PayslipEarnings {
  double get baseHours => throw _privateConstructorUsedError;
  double get baseRate => throw _privateConstructorUsedError;
  double get baseAmount => throw _privateConstructorUsedError;
  double get penalties => throw _privateConstructorUsedError;
  double get allowances => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayslipEarningsCopyWith<PayslipEarnings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayslipEarningsCopyWith<$Res> {
  factory $PayslipEarningsCopyWith(
          PayslipEarnings value, $Res Function(PayslipEarnings) then) =
      _$PayslipEarningsCopyWithImpl<$Res, PayslipEarnings>;
  @useResult
  $Res call(
      {double baseHours,
      double baseRate,
      double baseAmount,
      double penalties,
      double allowances,
      double total});
}

/// @nodoc
class _$PayslipEarningsCopyWithImpl<$Res, $Val extends PayslipEarnings>
    implements $PayslipEarningsCopyWith<$Res> {
  _$PayslipEarningsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseHours = null,
    Object? baseRate = null,
    Object? baseAmount = null,
    Object? penalties = null,
    Object? allowances = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      baseHours: null == baseHours
          ? _value.baseHours
          : baseHours // ignore: cast_nullable_to_non_nullable
              as double,
      baseRate: null == baseRate
          ? _value.baseRate
          : baseRate // ignore: cast_nullable_to_non_nullable
              as double,
      baseAmount: null == baseAmount
          ? _value.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double,
      penalties: null == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as double,
      allowances: null == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayslipEarningsImplCopyWith<$Res>
    implements $PayslipEarningsCopyWith<$Res> {
  factory _$$PayslipEarningsImplCopyWith(_$PayslipEarningsImpl value,
          $Res Function(_$PayslipEarningsImpl) then) =
      __$$PayslipEarningsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double baseHours,
      double baseRate,
      double baseAmount,
      double penalties,
      double allowances,
      double total});
}

/// @nodoc
class __$$PayslipEarningsImplCopyWithImpl<$Res>
    extends _$PayslipEarningsCopyWithImpl<$Res, _$PayslipEarningsImpl>
    implements _$$PayslipEarningsImplCopyWith<$Res> {
  __$$PayslipEarningsImplCopyWithImpl(
      _$PayslipEarningsImpl _value, $Res Function(_$PayslipEarningsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? baseHours = null,
    Object? baseRate = null,
    Object? baseAmount = null,
    Object? penalties = null,
    Object? allowances = null,
    Object? total = null,
  }) {
    return _then(_$PayslipEarningsImpl(
      baseHours: null == baseHours
          ? _value.baseHours
          : baseHours // ignore: cast_nullable_to_non_nullable
              as double,
      baseRate: null == baseRate
          ? _value.baseRate
          : baseRate // ignore: cast_nullable_to_non_nullable
              as double,
      baseAmount: null == baseAmount
          ? _value.baseAmount
          : baseAmount // ignore: cast_nullable_to_non_nullable
              as double,
      penalties: null == penalties
          ? _value.penalties
          : penalties // ignore: cast_nullable_to_non_nullable
              as double,
      allowances: null == allowances
          ? _value.allowances
          : allowances // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayslipEarningsImpl implements _PayslipEarnings {
  const _$PayslipEarningsImpl(
      {required this.baseHours,
      required this.baseRate,
      required this.baseAmount,
      required this.penalties,
      required this.allowances,
      required this.total});

  factory _$PayslipEarningsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayslipEarningsImplFromJson(json);

  @override
  final double baseHours;
  @override
  final double baseRate;
  @override
  final double baseAmount;
  @override
  final double penalties;
  @override
  final double allowances;
  @override
  final double total;

  @override
  String toString() {
    return 'PayslipEarnings(baseHours: $baseHours, baseRate: $baseRate, baseAmount: $baseAmount, penalties: $penalties, allowances: $allowances, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayslipEarningsImpl &&
            (identical(other.baseHours, baseHours) ||
                other.baseHours == baseHours) &&
            (identical(other.baseRate, baseRate) ||
                other.baseRate == baseRate) &&
            (identical(other.baseAmount, baseAmount) ||
                other.baseAmount == baseAmount) &&
            (identical(other.penalties, penalties) ||
                other.penalties == penalties) &&
            (identical(other.allowances, allowances) ||
                other.allowances == allowances) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, baseHours, baseRate, baseAmount,
      penalties, allowances, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayslipEarningsImplCopyWith<_$PayslipEarningsImpl> get copyWith =>
      __$$PayslipEarningsImplCopyWithImpl<_$PayslipEarningsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayslipEarningsImplToJson(
      this,
    );
  }
}

abstract class _PayslipEarnings implements PayslipEarnings {
  const factory _PayslipEarnings(
      {required final double baseHours,
      required final double baseRate,
      required final double baseAmount,
      required final double penalties,
      required final double allowances,
      required final double total}) = _$PayslipEarningsImpl;

  factory _PayslipEarnings.fromJson(Map<String, dynamic> json) =
      _$PayslipEarningsImpl.fromJson;

  @override
  double get baseHours;
  @override
  double get baseRate;
  @override
  double get baseAmount;
  @override
  double get penalties;
  @override
  double get allowances;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$PayslipEarningsImplCopyWith<_$PayslipEarningsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayslipDeductions _$PayslipDeductionsFromJson(Map<String, dynamic> json) {
  return _PayslipDeductions.fromJson(json);
}

/// @nodoc
mixin _$PayslipDeductions {
  double get tax => throw _privateConstructorUsedError;
  @JsonKey(name: 'super')
  double get superAmount => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayslipDeductionsCopyWith<PayslipDeductions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayslipDeductionsCopyWith<$Res> {
  factory $PayslipDeductionsCopyWith(
          PayslipDeductions value, $Res Function(PayslipDeductions) then) =
      _$PayslipDeductionsCopyWithImpl<$Res, PayslipDeductions>;
  @useResult
  $Res call(
      {double tax, @JsonKey(name: 'super') double superAmount, double total});
}

/// @nodoc
class _$PayslipDeductionsCopyWithImpl<$Res, $Val extends PayslipDeductions>
    implements $PayslipDeductionsCopyWith<$Res> {
  _$PayslipDeductionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tax = null,
    Object? superAmount = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      superAmount: null == superAmount
          ? _value.superAmount
          : superAmount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayslipDeductionsImplCopyWith<$Res>
    implements $PayslipDeductionsCopyWith<$Res> {
  factory _$$PayslipDeductionsImplCopyWith(_$PayslipDeductionsImpl value,
          $Res Function(_$PayslipDeductionsImpl) then) =
      __$$PayslipDeductionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double tax, @JsonKey(name: 'super') double superAmount, double total});
}

/// @nodoc
class __$$PayslipDeductionsImplCopyWithImpl<$Res>
    extends _$PayslipDeductionsCopyWithImpl<$Res, _$PayslipDeductionsImpl>
    implements _$$PayslipDeductionsImplCopyWith<$Res> {
  __$$PayslipDeductionsImplCopyWithImpl(_$PayslipDeductionsImpl _value,
      $Res Function(_$PayslipDeductionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tax = null,
    Object? superAmount = null,
    Object? total = null,
  }) {
    return _then(_$PayslipDeductionsImpl(
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      superAmount: null == superAmount
          ? _value.superAmount
          : superAmount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayslipDeductionsImpl implements _PayslipDeductions {
  const _$PayslipDeductionsImpl(
      {required this.tax,
      @JsonKey(name: 'super') required this.superAmount,
      required this.total});

  factory _$PayslipDeductionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayslipDeductionsImplFromJson(json);

  @override
  final double tax;
  @override
  @JsonKey(name: 'super')
  final double superAmount;
  @override
  final double total;

  @override
  String toString() {
    return 'PayslipDeductions(tax: $tax, superAmount: $superAmount, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayslipDeductionsImpl &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.superAmount, superAmount) ||
                other.superAmount == superAmount) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tax, superAmount, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayslipDeductionsImplCopyWith<_$PayslipDeductionsImpl> get copyWith =>
      __$$PayslipDeductionsImplCopyWithImpl<_$PayslipDeductionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayslipDeductionsImplToJson(
      this,
    );
  }
}

abstract class _PayslipDeductions implements PayslipDeductions {
  const factory _PayslipDeductions(
      {required final double tax,
      @JsonKey(name: 'super') required final double superAmount,
      required final double total}) = _$PayslipDeductionsImpl;

  factory _PayslipDeductions.fromJson(Map<String, dynamic> json) =
      _$PayslipDeductionsImpl.fromJson;

  @override
  double get tax;
  @override
  @JsonKey(name: 'super')
  double get superAmount;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$PayslipDeductionsImplCopyWith<_$PayslipDeductionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayslipYTD _$PayslipYTDFromJson(Map<String, dynamic> json) {
  return _PayslipYTD.fromJson(json);
}

/// @nodoc
mixin _$PayslipYTD {
  double get grossPay => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  @JsonKey(name: 'super')
  double get superAmount => throw _privateConstructorUsedError;
  double get netPay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayslipYTDCopyWith<PayslipYTD> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayslipYTDCopyWith<$Res> {
  factory $PayslipYTDCopyWith(
          PayslipYTD value, $Res Function(PayslipYTD) then) =
      _$PayslipYTDCopyWithImpl<$Res, PayslipYTD>;
  @useResult
  $Res call(
      {double grossPay,
      double tax,
      @JsonKey(name: 'super') double superAmount,
      double netPay});
}

/// @nodoc
class _$PayslipYTDCopyWithImpl<$Res, $Val extends PayslipYTD>
    implements $PayslipYTDCopyWith<$Res> {
  _$PayslipYTDCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grossPay = null,
    Object? tax = null,
    Object? superAmount = null,
    Object? netPay = null,
  }) {
    return _then(_value.copyWith(
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      superAmount: null == superAmount
          ? _value.superAmount
          : superAmount // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayslipYTDImplCopyWith<$Res>
    implements $PayslipYTDCopyWith<$Res> {
  factory _$$PayslipYTDImplCopyWith(
          _$PayslipYTDImpl value, $Res Function(_$PayslipYTDImpl) then) =
      __$$PayslipYTDImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double grossPay,
      double tax,
      @JsonKey(name: 'super') double superAmount,
      double netPay});
}

/// @nodoc
class __$$PayslipYTDImplCopyWithImpl<$Res>
    extends _$PayslipYTDCopyWithImpl<$Res, _$PayslipYTDImpl>
    implements _$$PayslipYTDImplCopyWith<$Res> {
  __$$PayslipYTDImplCopyWithImpl(
      _$PayslipYTDImpl _value, $Res Function(_$PayslipYTDImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grossPay = null,
    Object? tax = null,
    Object? superAmount = null,
    Object? netPay = null,
  }) {
    return _then(_$PayslipYTDImpl(
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      superAmount: null == superAmount
          ? _value.superAmount
          : superAmount // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayslipYTDImpl implements _PayslipYTD {
  const _$PayslipYTDImpl(
      {required this.grossPay,
      required this.tax,
      @JsonKey(name: 'super') required this.superAmount,
      required this.netPay});

  factory _$PayslipYTDImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayslipYTDImplFromJson(json);

  @override
  final double grossPay;
  @override
  final double tax;
  @override
  @JsonKey(name: 'super')
  final double superAmount;
  @override
  final double netPay;

  @override
  String toString() {
    return 'PayslipYTD(grossPay: $grossPay, tax: $tax, superAmount: $superAmount, netPay: $netPay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayslipYTDImpl &&
            (identical(other.grossPay, grossPay) ||
                other.grossPay == grossPay) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.superAmount, superAmount) ||
                other.superAmount == superAmount) &&
            (identical(other.netPay, netPay) || other.netPay == netPay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, grossPay, tax, superAmount, netPay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayslipYTDImplCopyWith<_$PayslipYTDImpl> get copyWith =>
      __$$PayslipYTDImplCopyWithImpl<_$PayslipYTDImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayslipYTDImplToJson(
      this,
    );
  }
}

abstract class _PayslipYTD implements PayslipYTD {
  const factory _PayslipYTD(
      {required final double grossPay,
      required final double tax,
      @JsonKey(name: 'super') required final double superAmount,
      required final double netPay}) = _$PayslipYTDImpl;

  factory _PayslipYTD.fromJson(Map<String, dynamic> json) =
      _$PayslipYTDImpl.fromJson;

  @override
  double get grossPay;
  @override
  double get tax;
  @override
  @JsonKey(name: 'super')
  double get superAmount;
  @override
  double get netPay;
  @override
  @JsonKey(ignore: true)
  _$$PayslipYTDImplCopyWith<_$PayslipYTDImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayrollSummary _$PayrollSummaryFromJson(Map<String, dynamic> json) {
  return _PayrollSummary.fromJson(json);
}

/// @nodoc
mixin _$PayrollSummary {
  String get organizationId => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  int get totalEmployees => throw _privateConstructorUsedError;
  double get totalGrossPay => throw _privateConstructorUsedError;
  double get totalTax => throw _privateConstructorUsedError;
  double get totalSuper => throw _privateConstructorUsedError;
  double get totalNetPay => throw _privateConstructorUsedError;
  List<EmployeePayrollSummary> get employees =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollSummaryCopyWith<PayrollSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollSummaryCopyWith<$Res> {
  factory $PayrollSummaryCopyWith(
          PayrollSummary value, $Res Function(PayrollSummary) then) =
      _$PayrollSummaryCopyWithImpl<$Res, PayrollSummary>;
  @useResult
  $Res call(
      {String organizationId,
      String period,
      int totalEmployees,
      double totalGrossPay,
      double totalTax,
      double totalSuper,
      double totalNetPay,
      List<EmployeePayrollSummary> employees});
}

/// @nodoc
class _$PayrollSummaryCopyWithImpl<$Res, $Val extends PayrollSummary>
    implements $PayrollSummaryCopyWith<$Res> {
  _$PayrollSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? totalEmployees = null,
    Object? totalGrossPay = null,
    Object? totalTax = null,
    Object? totalSuper = null,
    Object? totalNetPay = null,
    Object? employees = null,
  }) {
    return _then(_value.copyWith(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      totalGrossPay: null == totalGrossPay
          ? _value.totalGrossPay
          : totalGrossPay // ignore: cast_nullable_to_non_nullable
              as double,
      totalTax: null == totalTax
          ? _value.totalTax
          : totalTax // ignore: cast_nullable_to_non_nullable
              as double,
      totalSuper: null == totalSuper
          ? _value.totalSuper
          : totalSuper // ignore: cast_nullable_to_non_nullable
              as double,
      totalNetPay: null == totalNetPay
          ? _value.totalNetPay
          : totalNetPay // ignore: cast_nullable_to_non_nullable
              as double,
      employees: null == employees
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeePayrollSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollSummaryImplCopyWith<$Res>
    implements $PayrollSummaryCopyWith<$Res> {
  factory _$$PayrollSummaryImplCopyWith(_$PayrollSummaryImpl value,
          $Res Function(_$PayrollSummaryImpl) then) =
      __$$PayrollSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String organizationId,
      String period,
      int totalEmployees,
      double totalGrossPay,
      double totalTax,
      double totalSuper,
      double totalNetPay,
      List<EmployeePayrollSummary> employees});
}

/// @nodoc
class __$$PayrollSummaryImplCopyWithImpl<$Res>
    extends _$PayrollSummaryCopyWithImpl<$Res, _$PayrollSummaryImpl>
    implements _$$PayrollSummaryImplCopyWith<$Res> {
  __$$PayrollSummaryImplCopyWithImpl(
      _$PayrollSummaryImpl _value, $Res Function(_$PayrollSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? organizationId = null,
    Object? period = null,
    Object? totalEmployees = null,
    Object? totalGrossPay = null,
    Object? totalTax = null,
    Object? totalSuper = null,
    Object? totalNetPay = null,
    Object? employees = null,
  }) {
    return _then(_$PayrollSummaryImpl(
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      totalGrossPay: null == totalGrossPay
          ? _value.totalGrossPay
          : totalGrossPay // ignore: cast_nullable_to_non_nullable
              as double,
      totalTax: null == totalTax
          ? _value.totalTax
          : totalTax // ignore: cast_nullable_to_non_nullable
              as double,
      totalSuper: null == totalSuper
          ? _value.totalSuper
          : totalSuper // ignore: cast_nullable_to_non_nullable
              as double,
      totalNetPay: null == totalNetPay
          ? _value.totalNetPay
          : totalNetPay // ignore: cast_nullable_to_non_nullable
              as double,
      employees: null == employees
          ? _value._employees
          : employees // ignore: cast_nullable_to_non_nullable
              as List<EmployeePayrollSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollSummaryImpl implements _PayrollSummary {
  const _$PayrollSummaryImpl(
      {required this.organizationId,
      required this.period,
      required this.totalEmployees,
      required this.totalGrossPay,
      required this.totalTax,
      required this.totalSuper,
      required this.totalNetPay,
      required final List<EmployeePayrollSummary> employees})
      : _employees = employees;

  factory _$PayrollSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollSummaryImplFromJson(json);

  @override
  final String organizationId;
  @override
  final String period;
  @override
  final int totalEmployees;
  @override
  final double totalGrossPay;
  @override
  final double totalTax;
  @override
  final double totalSuper;
  @override
  final double totalNetPay;
  final List<EmployeePayrollSummary> _employees;
  @override
  List<EmployeePayrollSummary> get employees {
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employees);
  }

  @override
  String toString() {
    return 'PayrollSummary(organizationId: $organizationId, period: $period, totalEmployees: $totalEmployees, totalGrossPay: $totalGrossPay, totalTax: $totalTax, totalSuper: $totalSuper, totalNetPay: $totalNetPay, employees: $employees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollSummaryImpl &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.totalEmployees, totalEmployees) ||
                other.totalEmployees == totalEmployees) &&
            (identical(other.totalGrossPay, totalGrossPay) ||
                other.totalGrossPay == totalGrossPay) &&
            (identical(other.totalTax, totalTax) ||
                other.totalTax == totalTax) &&
            (identical(other.totalSuper, totalSuper) ||
                other.totalSuper == totalSuper) &&
            (identical(other.totalNetPay, totalNetPay) ||
                other.totalNetPay == totalNetPay) &&
            const DeepCollectionEquality()
                .equals(other._employees, _employees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      organizationId,
      period,
      totalEmployees,
      totalGrossPay,
      totalTax,
      totalSuper,
      totalNetPay,
      const DeepCollectionEquality().hash(_employees));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollSummaryImplCopyWith<_$PayrollSummaryImpl> get copyWith =>
      __$$PayrollSummaryImplCopyWithImpl<_$PayrollSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollSummaryImplToJson(
      this,
    );
  }
}

abstract class _PayrollSummary implements PayrollSummary {
  const factory _PayrollSummary(
          {required final String organizationId,
          required final String period,
          required final int totalEmployees,
          required final double totalGrossPay,
          required final double totalTax,
          required final double totalSuper,
          required final double totalNetPay,
          required final List<EmployeePayrollSummary> employees}) =
      _$PayrollSummaryImpl;

  factory _PayrollSummary.fromJson(Map<String, dynamic> json) =
      _$PayrollSummaryImpl.fromJson;

  @override
  String get organizationId;
  @override
  String get period;
  @override
  int get totalEmployees;
  @override
  double get totalGrossPay;
  @override
  double get totalTax;
  @override
  double get totalSuper;
  @override
  double get totalNetPay;
  @override
  List<EmployeePayrollSummary> get employees;
  @override
  @JsonKey(ignore: true)
  _$$PayrollSummaryImplCopyWith<_$PayrollSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeePayrollSummary _$EmployeePayrollSummaryFromJson(
    Map<String, dynamic> json) {
  return _EmployeePayrollSummary.fromJson(json);
}

/// @nodoc
mixin _$EmployeePayrollSummary {
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  double get grossPay => throw _privateConstructorUsedError;
  double get netPay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeePayrollSummaryCopyWith<EmployeePayrollSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeePayrollSummaryCopyWith<$Res> {
  factory $EmployeePayrollSummaryCopyWith(EmployeePayrollSummary value,
          $Res Function(EmployeePayrollSummary) then) =
      _$EmployeePayrollSummaryCopyWithImpl<$Res, EmployeePayrollSummary>;
  @useResult
  $Res call({String userId, String userName, double grossPay, double netPay});
}

/// @nodoc
class _$EmployeePayrollSummaryCopyWithImpl<$Res,
        $Val extends EmployeePayrollSummary>
    implements $EmployeePayrollSummaryCopyWith<$Res> {
  _$EmployeePayrollSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? grossPay = null,
    Object? netPay = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeePayrollSummaryImplCopyWith<$Res>
    implements $EmployeePayrollSummaryCopyWith<$Res> {
  factory _$$EmployeePayrollSummaryImplCopyWith(
          _$EmployeePayrollSummaryImpl value,
          $Res Function(_$EmployeePayrollSummaryImpl) then) =
      __$$EmployeePayrollSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String userName, double grossPay, double netPay});
}

/// @nodoc
class __$$EmployeePayrollSummaryImplCopyWithImpl<$Res>
    extends _$EmployeePayrollSummaryCopyWithImpl<$Res,
        _$EmployeePayrollSummaryImpl>
    implements _$$EmployeePayrollSummaryImplCopyWith<$Res> {
  __$$EmployeePayrollSummaryImplCopyWithImpl(
      _$EmployeePayrollSummaryImpl _value,
      $Res Function(_$EmployeePayrollSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? grossPay = null,
    Object? netPay = null,
  }) {
    return _then(_$EmployeePayrollSummaryImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      grossPay: null == grossPay
          ? _value.grossPay
          : grossPay // ignore: cast_nullable_to_non_nullable
              as double,
      netPay: null == netPay
          ? _value.netPay
          : netPay // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeePayrollSummaryImpl implements _EmployeePayrollSummary {
  const _$EmployeePayrollSummaryImpl(
      {required this.userId,
      required this.userName,
      required this.grossPay,
      required this.netPay});

  factory _$EmployeePayrollSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeePayrollSummaryImplFromJson(json);

  @override
  final String userId;
  @override
  final String userName;
  @override
  final double grossPay;
  @override
  final double netPay;

  @override
  String toString() {
    return 'EmployeePayrollSummary(userId: $userId, userName: $userName, grossPay: $grossPay, netPay: $netPay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeePayrollSummaryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.grossPay, grossPay) ||
                other.grossPay == grossPay) &&
            (identical(other.netPay, netPay) || other.netPay == netPay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, userName, grossPay, netPay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeePayrollSummaryImplCopyWith<_$EmployeePayrollSummaryImpl>
      get copyWith => __$$EmployeePayrollSummaryImplCopyWithImpl<
          _$EmployeePayrollSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeePayrollSummaryImplToJson(
      this,
    );
  }
}

abstract class _EmployeePayrollSummary implements EmployeePayrollSummary {
  const factory _EmployeePayrollSummary(
      {required final String userId,
      required final String userName,
      required final double grossPay,
      required final double netPay}) = _$EmployeePayrollSummaryImpl;

  factory _EmployeePayrollSummary.fromJson(Map<String, dynamic> json) =
      _$EmployeePayrollSummaryImpl.fromJson;

  @override
  String get userId;
  @override
  String get userName;
  @override
  double get grossPay;
  @override
  double get netPay;
  @override
  @JsonKey(ignore: true)
  _$$EmployeePayrollSummaryImplCopyWith<_$EmployeePayrollSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
