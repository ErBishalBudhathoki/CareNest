import 'package:freezed_annotation/freezed_annotation.dart';

part 'advanced_payroll_models.freezed.dart';
part 'advanced_payroll_models.g.dart';

@freezed
class PayrollCalculation with _$PayrollCalculation {
  const factory PayrollCalculation({
    required String userId,
    required String period,
    required double baseHours,
    required double baseRate,
    required double baseAmount,
    required PenaltyRates penalties,
    required Allowances allowances,
    required LeaveAccrual leaveAccrual,
    required TaxAndSuper taxAndSuper,
    required double grossPay,
    required double netPay,
  }) = _PayrollCalculation;

  factory PayrollCalculation.fromJson(Map<String, dynamic> json) =>
      _$PayrollCalculationFromJson(json);
}

@freezed
class PenaltyRates with _$PenaltyRates {
  const factory PenaltyRates({
    required PenaltyRate saturday,
    required PenaltyRate sunday,
    required PenaltyRate publicHoliday,
    required PenaltyRate overtime,
    required double total,
  }) = _PenaltyRates;

  factory PenaltyRates.fromJson(Map<String, dynamic> json) =>
      _$PenaltyRatesFromJson(json);
}

@freezed
class PenaltyRate with _$PenaltyRate {
  const factory PenaltyRate({
    required double hours,
    required double rate,
    required double amount,
  }) = _PenaltyRate;

  factory PenaltyRate.fromJson(Map<String, dynamic> json) =>
      _$PenaltyRateFromJson(json);
}

@freezed
class Allowances with _$Allowances {
  const factory Allowances({
    required double travel,
    required double meal,
    required double sleepover,
    required double firstAid,
    required double total,
  }) = _Allowances;

  factory Allowances.fromJson(Map<String, dynamic> json) =>
      _$AllowancesFromJson(json);
}

@freezed
class LeaveAccrual with _$LeaveAccrual {
  const factory LeaveAccrual({
    required LeaveAccrualDetail annualLeave,
    required LeaveAccrualDetail sickLeave,
  }) = _LeaveAccrual;

  factory LeaveAccrual.fromJson(Map<String, dynamic> json) =>
      _$LeaveAccrualFromJson(json);
}

@freezed
class LeaveAccrualDetail with _$LeaveAccrualDetail {
  const factory LeaveAccrualDetail({
    required double hours,
    required double amount,
  }) = _LeaveAccrualDetail;

  factory LeaveAccrualDetail.fromJson(Map<String, dynamic> json) =>
      _$LeaveAccrualDetailFromJson(json);
}

@freezed
class TaxAndSuper with _$TaxAndSuper {
  const factory TaxAndSuper({
    required double tax,
    @JsonKey(name: 'super') required double superAmount,
    required double taxRate,
    required double superRate,
  }) = _TaxAndSuper;

  factory TaxAndSuper.fromJson(Map<String, dynamic> json) =>
      _$TaxAndSuperFromJson(json);
}

@freezed
class Payslip with _$Payslip {
  const factory Payslip({
    required String payslipId,
    required String userId,
    required String period,
    required String generatedDate,
    required PayslipEarnings earnings,
    required PayslipDeductions deductions,
    required double netPay,
    required PayslipYTD ytd,
  }) = _Payslip;

  factory Payslip.fromJson(Map<String, dynamic> json) =>
      _$PayslipFromJson(json);
}

@freezed
class PayslipEarnings with _$PayslipEarnings {
  const factory PayslipEarnings({
    required double baseHours,
    required double baseRate,
    required double baseAmount,
    required double penalties,
    required double allowances,
    required double total,
  }) = _PayslipEarnings;

  factory PayslipEarnings.fromJson(Map<String, dynamic> json) =>
      _$PayslipEarningsFromJson(json);
}

@freezed
class PayslipDeductions with _$PayslipDeductions {
  const factory PayslipDeductions({
    required double tax,
    @JsonKey(name: 'super') required double superAmount,
    required double total,
  }) = _PayslipDeductions;

  factory PayslipDeductions.fromJson(Map<String, dynamic> json) =>
      _$PayslipDeductionsFromJson(json);
}

@freezed
class PayslipYTD with _$PayslipYTD {
  const factory PayslipYTD({
    required double grossPay,
    required double tax,
    @JsonKey(name: 'super') required double superAmount,
    required double netPay,
  }) = _PayslipYTD;

  factory PayslipYTD.fromJson(Map<String, dynamic> json) =>
      _$PayslipYTDFromJson(json);
}

@freezed
class PayrollSummary with _$PayrollSummary {
  const factory PayrollSummary({
    required String organizationId,
    required String period,
    required int totalEmployees,
    required double totalGrossPay,
    required double totalTax,
    required double totalSuper,
    required double totalNetPay,
    required List<EmployeePayrollSummary> employees,
  }) = _PayrollSummary;

  factory PayrollSummary.fromJson(Map<String, dynamic> json) =>
      _$PayrollSummaryFromJson(json);
}

@freezed
class EmployeePayrollSummary with _$EmployeePayrollSummary {
  const factory EmployeePayrollSummary({
    required String userId,
    required String userName,
    required double grossPay,
    required double netPay,
  }) = _EmployeePayrollSummary;

  factory EmployeePayrollSummary.fromJson(Map<String, dynamic> json) =>
      _$EmployeePayrollSummaryFromJson(json);
}
