// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advanced_payroll_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PayrollCalculation _$PayrollCalculationFromJson(
  Map<String, dynamic> json,
) => _PayrollCalculation(
  userId: json['userId'] as String,
  period: json['period'] as String,
  baseHours: (json['baseHours'] as num).toDouble(),
  baseRate: (json['baseRate'] as num).toDouble(),
  baseAmount: (json['baseAmount'] as num).toDouble(),
  penalties: PenaltyRates.fromJson(json['penalties'] as Map<String, dynamic>),
  allowances: Allowances.fromJson(json['allowances'] as Map<String, dynamic>),
  leaveAccrual: LeaveAccrual.fromJson(
    json['leaveAccrual'] as Map<String, dynamic>,
  ),
  taxAndSuper: TaxAndSuper.fromJson(
    json['taxAndSuper'] as Map<String, dynamic>,
  ),
  grossPay: (json['grossPay'] as num).toDouble(),
  netPay: (json['netPay'] as num).toDouble(),
);

Map<String, dynamic> _$PayrollCalculationToJson(_PayrollCalculation instance) =>
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

_PenaltyRates _$PenaltyRatesFromJson(Map<String, dynamic> json) =>
    _PenaltyRates(
      saturday: PenaltyRate.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: PenaltyRate.fromJson(json['sunday'] as Map<String, dynamic>),
      publicHoliday: PenaltyRate.fromJson(
        json['publicHoliday'] as Map<String, dynamic>,
      ),
      overtime: PenaltyRate.fromJson(json['overtime'] as Map<String, dynamic>),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$PenaltyRatesToJson(_PenaltyRates instance) =>
    <String, dynamic>{
      'saturday': instance.saturday,
      'sunday': instance.sunday,
      'publicHoliday': instance.publicHoliday,
      'overtime': instance.overtime,
      'total': instance.total,
    };

_PenaltyRate _$PenaltyRateFromJson(Map<String, dynamic> json) => _PenaltyRate(
  hours: (json['hours'] as num).toDouble(),
  rate: (json['rate'] as num).toDouble(),
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$PenaltyRateToJson(_PenaltyRate instance) =>
    <String, dynamic>{
      'hours': instance.hours,
      'rate': instance.rate,
      'amount': instance.amount,
    };

_Allowances _$AllowancesFromJson(Map<String, dynamic> json) => _Allowances(
  travel: (json['travel'] as num).toDouble(),
  meal: (json['meal'] as num).toDouble(),
  sleepover: (json['sleepover'] as num).toDouble(),
  firstAid: (json['firstAid'] as num).toDouble(),
  total: (json['total'] as num).toDouble(),
);

Map<String, dynamic> _$AllowancesToJson(_Allowances instance) =>
    <String, dynamic>{
      'travel': instance.travel,
      'meal': instance.meal,
      'sleepover': instance.sleepover,
      'firstAid': instance.firstAid,
      'total': instance.total,
    };

_LeaveAccrual _$LeaveAccrualFromJson(Map<String, dynamic> json) =>
    _LeaveAccrual(
      annualLeave: LeaveAccrualDetail.fromJson(
        json['annualLeave'] as Map<String, dynamic>,
      ),
      sickLeave: LeaveAccrualDetail.fromJson(
        json['sickLeave'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$LeaveAccrualToJson(_LeaveAccrual instance) =>
    <String, dynamic>{
      'annualLeave': instance.annualLeave,
      'sickLeave': instance.sickLeave,
    };

_LeaveAccrualDetail _$LeaveAccrualDetailFromJson(Map<String, dynamic> json) =>
    _LeaveAccrualDetail(
      hours: (json['hours'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$LeaveAccrualDetailToJson(_LeaveAccrualDetail instance) =>
    <String, dynamic>{'hours': instance.hours, 'amount': instance.amount};

_TaxAndSuper _$TaxAndSuperFromJson(Map<String, dynamic> json) => _TaxAndSuper(
  tax: (json['tax'] as num).toDouble(),
  superAmount: (json['super'] as num).toDouble(),
  taxRate: (json['taxRate'] as num).toDouble(),
  superRate: (json['superRate'] as num).toDouble(),
);

Map<String, dynamic> _$TaxAndSuperToJson(_TaxAndSuper instance) =>
    <String, dynamic>{
      'tax': instance.tax,
      'super': instance.superAmount,
      'taxRate': instance.taxRate,
      'superRate': instance.superRate,
    };

_Payslip _$PayslipFromJson(Map<String, dynamic> json) => _Payslip(
  payslipId: json['payslipId'] as String,
  userId: json['userId'] as String,
  period: json['period'] as String,
  generatedDate: json['generatedDate'] as String,
  earnings: PayslipEarnings.fromJson(json['earnings'] as Map<String, dynamic>),
  deductions: PayslipDeductions.fromJson(
    json['deductions'] as Map<String, dynamic>,
  ),
  netPay: (json['netPay'] as num).toDouble(),
  ytd: PayslipYTD.fromJson(json['ytd'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PayslipToJson(_Payslip instance) => <String, dynamic>{
  'payslipId': instance.payslipId,
  'userId': instance.userId,
  'period': instance.period,
  'generatedDate': instance.generatedDate,
  'earnings': instance.earnings,
  'deductions': instance.deductions,
  'netPay': instance.netPay,
  'ytd': instance.ytd,
};

_PayslipEarnings _$PayslipEarningsFromJson(Map<String, dynamic> json) =>
    _PayslipEarnings(
      baseHours: (json['baseHours'] as num).toDouble(),
      baseRate: (json['baseRate'] as num).toDouble(),
      baseAmount: (json['baseAmount'] as num).toDouble(),
      penalties: (json['penalties'] as num).toDouble(),
      allowances: (json['allowances'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$PayslipEarningsToJson(_PayslipEarnings instance) =>
    <String, dynamic>{
      'baseHours': instance.baseHours,
      'baseRate': instance.baseRate,
      'baseAmount': instance.baseAmount,
      'penalties': instance.penalties,
      'allowances': instance.allowances,
      'total': instance.total,
    };

_PayslipDeductions _$PayslipDeductionsFromJson(Map<String, dynamic> json) =>
    _PayslipDeductions(
      tax: (json['tax'] as num).toDouble(),
      superAmount: (json['super'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$PayslipDeductionsToJson(_PayslipDeductions instance) =>
    <String, dynamic>{
      'tax': instance.tax,
      'super': instance.superAmount,
      'total': instance.total,
    };

_PayslipYTD _$PayslipYTDFromJson(Map<String, dynamic> json) => _PayslipYTD(
  grossPay: (json['grossPay'] as num).toDouble(),
  tax: (json['tax'] as num).toDouble(),
  superAmount: (json['super'] as num).toDouble(),
  netPay: (json['netPay'] as num).toDouble(),
);

Map<String, dynamic> _$PayslipYTDToJson(_PayslipYTD instance) =>
    <String, dynamic>{
      'grossPay': instance.grossPay,
      'tax': instance.tax,
      'super': instance.superAmount,
      'netPay': instance.netPay,
    };

_PayrollSummary _$PayrollSummaryFromJson(Map<String, dynamic> json) =>
    _PayrollSummary(
      organizationId: json['organizationId'] as String,
      period: json['period'] as String,
      totalEmployees: (json['totalEmployees'] as num).toInt(),
      totalGrossPay: (json['totalGrossPay'] as num).toDouble(),
      totalTax: (json['totalTax'] as num).toDouble(),
      totalSuper: (json['totalSuper'] as num).toDouble(),
      totalNetPay: (json['totalNetPay'] as num).toDouble(),
      employees: (json['employees'] as List<dynamic>)
          .map(
            (e) => EmployeePayrollSummary.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$PayrollSummaryToJson(_PayrollSummary instance) =>
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

_EmployeePayrollSummary _$EmployeePayrollSummaryFromJson(
  Map<String, dynamic> json,
) => _EmployeePayrollSummary(
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  grossPay: (json['grossPay'] as num).toDouble(),
  netPay: (json['netPay'] as num).toDouble(),
);

Map<String, dynamic> _$EmployeePayrollSummaryToJson(
  _EmployeePayrollSummary instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'userName': instance.userName,
  'grossPay': instance.grossPay,
  'netPay': instance.netPay,
};
