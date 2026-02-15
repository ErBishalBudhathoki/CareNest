// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_payroll_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollCalculationImpl _$$PayrollCalculationImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollCalculationImpl(
      userId: json['userId'] as String,
      period: json['period'] as String,
      baseHours: (json['baseHours'] as num).toDouble(),
      baseRate: (json['baseRate'] as num).toDouble(),
      baseAmount: (json['baseAmount'] as num).toDouble(),
      penalties:
          PenaltyRates.fromJson(json['penalties'] as Map<String, dynamic>),
      allowances:
          Allowances.fromJson(json['allowances'] as Map<String, dynamic>),
      leaveAccrual:
          LeaveAccrual.fromJson(json['leaveAccrual'] as Map<String, dynamic>),
      taxAndSuper:
          TaxAndSuper.fromJson(json['taxAndSuper'] as Map<String, dynamic>),
      grossPay: (json['grossPay'] as num).toDouble(),
      netPay: (json['netPay'] as num).toDouble(),
    );

Map<String, dynamic> _$$PayrollCalculationImplToJson(
        _$PayrollCalculationImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'period': instance.period,
      'baseHours': instance.baseHours,
      'baseRate': instance.baseRate,
      'baseAmount': instance.baseAmount,
      'penalties': instance.penalties,
      'allowances': instance.allowances,
      'leaveAccrual': instance.leaveAccrual,
      'taxAndSuper': instance.taxAndSuper,
      'grossPay': instance.grossPay,
      'netPay': instance.netPay,
    };

_$PenaltyRatesImpl _$$PenaltyRatesImplFromJson(Map<String, dynamic> json) =>
    _$PenaltyRatesImpl(
      saturday: PenaltyRate.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: PenaltyRate.fromJson(json['sunday'] as Map<String, dynamic>),
      publicHoliday:
          PenaltyRate.fromJson(json['publicHoliday'] as Map<String, dynamic>),
      overtime: PenaltyRate.fromJson(json['overtime'] as Map<String, dynamic>),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$PenaltyRatesImplToJson(_$PenaltyRatesImpl instance) =>
    <String, dynamic>{
      'saturday': instance.saturday,
      'sunday': instance.sunday,
      'publicHoliday': instance.publicHoliday,
      'overtime': instance.overtime,
      'total': instance.total,
    };

_$PenaltyRateImpl _$$PenaltyRateImplFromJson(Map<String, dynamic> json) =>
    _$PenaltyRateImpl(
      hours: (json['hours'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$PenaltyRateImplToJson(_$PenaltyRateImpl instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'rate': instance.rate,
      'amount': instance.amount,
    };

_$AllowancesImpl _$$AllowancesImplFromJson(Map<String, dynamic> json) =>
    _$AllowancesImpl(
      travel: (json['travel'] as num).toDouble(),
      meal: (json['meal'] as num).toDouble(),
      sleepover: (json['sleepover'] as num).toDouble(),
      firstAid: (json['firstAid'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$AllowancesImplToJson(_$AllowancesImpl instance) =>
    <String, dynamic>{
      'travel': instance.travel,
      'meal': instance.meal,
      'sleepover': instance.sleepover,
      'firstAid': instance.firstAid,
      'total': instance.total,
    };

_$LeaveAccrualImpl _$$LeaveAccrualImplFromJson(Map<String, dynamic> json) =>
    _$LeaveAccrualImpl(
      annualLeave: LeaveAccrualDetail.fromJson(
          json['annualLeave'] as Map<String, dynamic>),
      sickLeave: LeaveAccrualDetail.fromJson(
          json['sickLeave'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LeaveAccrualImplToJson(_$LeaveAccrualImpl instance) =>
    <String, dynamic>{
      'annualLeave': instance.annualLeave,
      'sickLeave': instance.sickLeave,
    };

_$LeaveAccrualDetailImpl _$$LeaveAccrualDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveAccrualDetailImpl(
      hours: (json['hours'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$LeaveAccrualDetailImplToJson(
        _$LeaveAccrualDetailImpl instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'amount': instance.amount,
    };

_$TaxAndSuperImpl _$$TaxAndSuperImplFromJson(Map<String, dynamic> json) =>
    _$TaxAndSuperImpl(
      tax: (json['tax'] as num).toDouble(),
      superAmount: (json['super'] as num).toDouble(),
      taxRate: (json['taxRate'] as num).toDouble(),
      superRate: (json['superRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$TaxAndSuperImplToJson(_$TaxAndSuperImpl instance) =>
    <String, dynamic>{
      'tax': instance.tax,
      'super': instance.superAmount,
      'taxRate': instance.taxRate,
      'superRate': instance.superRate,
    };

_$PayslipImpl _$$PayslipImplFromJson(Map<String, dynamic> json) =>
    _$PayslipImpl(
      payslipId: json['payslipId'] as String,
      userId: json['userId'] as String,
      period: json['period'] as String,
      generatedDate: json['generatedDate'] as String,
      earnings:
          PayslipEarnings.fromJson(json['earnings'] as Map<String, dynamic>),
      deductions: PayslipDeductions.fromJson(
          json['deductions'] as Map<String, dynamic>),
      netPay: (json['netPay'] as num).toDouble(),
      ytd: PayslipYTD.fromJson(json['ytd'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PayslipImplToJson(_$PayslipImpl instance) =>
    <String, dynamic>{
      'payslipId': instance.payslipId,
      'userId': instance.userId,
      'period': instance.period,
      'generatedDate': instance.generatedDate,
      'earnings': instance.earnings,
      'deductions': instance.deductions,
      'netPay': instance.netPay,
      'ytd': instance.ytd,
    };

_$PayslipEarningsImpl _$$PayslipEarningsImplFromJson(
        Map<String, dynamic> json) =>
    _$PayslipEarningsImpl(
      baseHours: (json['baseHours'] as num).toDouble(),
      baseRate: (json['baseRate'] as num).toDouble(),
      baseAmount: (json['baseAmount'] as num).toDouble(),
      penalties: (json['penalties'] as num).toDouble(),
      allowances: (json['allowances'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$PayslipEarningsImplToJson(
        _$PayslipEarningsImpl instance) =>
    <String, dynamic>{
      'baseHours': instance.baseHours,
      'baseRate': instance.baseRate,
      'baseAmount': instance.baseAmount,
      'penalties': instance.penalties,
      'allowances': instance.allowances,
      'total': instance.total,
    };

_$PayslipDeductionsImpl _$$PayslipDeductionsImplFromJson(
        Map<String, dynamic> json) =>
    _$PayslipDeductionsImpl(
      tax: (json['tax'] as num).toDouble(),
      superAmount: (json['super'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$PayslipDeductionsImplToJson(
        _$PayslipDeductionsImpl instance) =>
    <String, dynamic>{
      'tax': instance.tax,
      'super': instance.superAmount,
      'total': instance.total,
    };

_$PayslipYTDImpl _$$PayslipYTDImplFromJson(Map<String, dynamic> json) =>
    _$PayslipYTDImpl(
      grossPay: (json['grossPay'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      superAmount: (json['super'] as num).toDouble(),
      netPay: (json['netPay'] as num).toDouble(),
    );

Map<String, dynamic> _$$PayslipYTDImplToJson(_$PayslipYTDImpl instance) =>
    <String, dynamic>{
      'grossPay': instance.grossPay,
      'tax': instance.tax,
      'super': instance.superAmount,
      'netPay': instance.netPay,
    };

_$PayrollSummaryImpl _$$PayrollSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PayrollSummaryImpl(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      totalEmployees: (json['totalEmployees'] as num).toInt(),
      totalGrossPay: (json['totalGrossPay'] as num).toDouble(),
      totalTax: (json['totalTax'] as num).toDouble(),
      totalSuper: (json['totalSuper'] as num).toDouble(),
      totalNetPay: (json['totalNetPay'] as num).toDouble(),
      employees: (json['employees'] as List<dynamic>)
          .map(
              (e) => EmployeePayrollSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PayrollSummaryImplToJson(
        _$PayrollSummaryImpl instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'period': instance.period,
      'totalEmployees': instance.totalEmployees,
      'totalGrossPay': instance.totalGrossPay,
      'totalTax': instance.totalTax,
      'totalSuper': instance.totalSuper,
      'totalNetPay': instance.totalNetPay,
      'employees': instance.employees,
    };

_$EmployeePayrollSummaryImpl _$$EmployeePayrollSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeePayrollSummaryImpl(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      grossPay: (json['grossPay'] as num).toDouble(),
      netPay: (json['netPay'] as num).toDouble(),
    );

Map<String, dynamic> _$$EmployeePayrollSummaryImplToJson(
        _$EmployeePayrollSummaryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'grossPay': instance.grossPay,
      'netPay': instance.netPay,
    };
