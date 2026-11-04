import 'package:freezed_annotation/freezed_annotation.dart';

part 'sil_models.freezed.dart';
part 'sil_models.g.dart';

// ---------------------------------------------------------------------------
// Property
// ---------------------------------------------------------------------------

@freezed
abstract class SILAddress with _$SILAddress {
  const factory SILAddress({
    @Default('') String line1,
    @Default('') String line2,
    @Default('') String suburb,
    @Default('') String state,
    @Default('') String postcode,
    @Default('Australia') String country,
  }) = _SILAddress;

  factory SILAddress.fromJson(Map<String, dynamic> json) =>
      _$SILAddressFromJson(json);
}

@freezed
abstract class SILRoom with _$SILRoom {
  const factory SILRoom({
    required String roomId,
    @Default('') String label,
    @Default(true) bool vacant,
    @Default(<String>[]) List<String> accessibility,
  }) = _SILRoom;

  factory SILRoom.fromJson(Map<String, dynamic> json) => _$SILRoomFromJson(json);
}

@freezed
abstract class SILProperty with _$SILProperty {
  const factory SILProperty({
    required String id,
    required String name,
    @Default('') String reference,
    @Default('house') String propertyType,
    @Default('basic') String silDesignCategory,
    @Default(0) int bedrooms,
    @Default(0) int maxOccupancy,
    @Default(true) bool active,
    @Default(<SILRoom>[]) List<SILRoom> rooms,
    @Default(<String>[]) List<String> amenities,
    SILAddress? address,
  }) = _SILProperty;

  factory SILProperty.fromJson(Map<String, dynamic> json) =>
      _$SILPropertyFromJson(json);
}

// ---------------------------------------------------------------------------
// Occupancy
// ---------------------------------------------------------------------------

@freezed
abstract class SILOccupancy with _$SILOccupancy {
  const factory SILOccupancy({
    required String id,
    required String propertyId,
    required String roomId,
    required String clientId,
    @Default('active') String status,
    @Default('plan_managed') String fundingType,
    String? startDate,
    String? endDate,
  }) = _SILOccupancy;

  factory SILOccupancy.fromJson(Map<String, dynamic> json) =>
      _$SILOccupancyFromJson(json);
}

@freezed
abstract class SILVacancyRoom with _$SILVacancyRoom {
  const factory SILVacancyRoom({
    required String roomId,
    @Default('') String label,
    @Default(false) bool occupied,
    @Default(<String>[]) List<String> accessibility,
  }) = _SILVacancyRoom;

  factory SILVacancyRoom.fromJson(Map<String, dynamic> json) =>
      _$SILVacancyRoomFromJson(json);
}

@freezed
abstract class SILVacancyBoard with _$SILVacancyBoard {
  const factory SILVacancyBoard({
    required String propertyId,
    @Default('') String propertyName,
    @Default(0) int totalRooms,
    @Default(0) int occupiedCount,
    @Default(0) int vacantCount,
    @Default(<SILVacancyRoom>[]) List<SILVacancyRoom> rooms,
  }) = _SILVacancyBoard;

  factory SILVacancyBoard.fromJson(Map<String, dynamic> json) =>
      _$SILVacancyBoardFromJson(json);
}

// ---------------------------------------------------------------------------
// Ratio rules
// ---------------------------------------------------------------------------

@freezed
abstract class SILRatioValue with _$SILRatioValue {
  const factory SILRatioValue({
    @Default(1) int staff,
    @Default(1) int participants,
  }) = _SILRatioValue;

  factory SILRatioValue.fromJson(Map<String, dynamic> json) =>
      _$SILRatioValueFromJson(json);
}

@freezed
abstract class SILRatioRule with _$SILRatioRule {
  const factory SILRatioRule({
    required String id,
    required String name,
    @Default(SILRatioValue()) SILRatioValue ratio,
    @Default('day') String shiftType,
    @Default(1) int minParticipants,
    @Default(0) int maxParticipants,
    @Default(true) bool isActive,
  }) = _SILRatioRule;

  factory SILRatioRule.fromJson(Map<String, dynamic> json) =>
      _$SILRatioRuleFromJson(json);
}

// ---------------------------------------------------------------------------
// Roster
// ---------------------------------------------------------------------------

@freezed
abstract class SILRosterEntry with _$SILRosterEntry {
  const factory SILRosterEntry({
    String? shiftId,
    @Default(<String>[]) List<String> clientIds,
    @Default(<String>[]) List<String> staffUserIds,
    @Default('day') String shiftType,
    @Default(1) int requiredStaff,
    @Default(0) int assignedStaff,
    @Default('ok') String compliance,
    String? startTime,
    String? endTime,
  }) = _SILRosterEntry;

  factory SILRosterEntry.fromJson(Map<String, dynamic> json) =>
      _$SILRosterEntryFromJson(json);
}

@freezed
abstract class SILRatioWarning with _$SILRatioWarning {
  const factory SILRatioWarning({
    @Default('') String role,
    @Default('') String message,
  }) = _SILRatioWarning;

  factory SILRatioWarning.fromJson(Map<String, dynamic> json) =>
      _$SILRatioWarningFromJson(json);
}

@freezed
abstract class SILRoster with _$SILRoster {
  const factory SILRoster({
    required String id,
    required String propertyId,
    @Default('draft') String status,
    String? weekStarting,
    @Default(<SILRosterEntry>[]) List<SILRosterEntry> entries,
    @Default(<SILRatioWarning>[]) List<SILRatioWarning> ratioWarnings,
  }) = _SILRoster;

  factory SILRoster.fromJson(Map<String, dynamic> json) =>
      _$SILRosterFromJson(json);
}

// ---------------------------------------------------------------------------
// Quote
// ---------------------------------------------------------------------------

@freezed
abstract class SILPriceValidation with _$SILPriceValidation {
  const factory SILPriceValidation({
    @Default(true) bool passed,
    double? capApplied,
    String? type,
    @Default(<String>[]) List<String> errors,
  }) = _SILPriceValidation;

  factory SILPriceValidation.fromJson(Map<String, dynamic> json) =>
      _$SILPriceValidationFromJson(json);
}

@freezed
abstract class SILQuoteLine with _$SILQuoteLine {
  const factory SILQuoteLine({
    required String supportNumber,
    @Default('') String supportName,
    @Default('day') String shiftType,
    @Default(0) double hoursPerWeek,
    @Default(0) double unitPrice,
    @Default('P2') String gstCode,
    @Default(0) double amount,
    @Default(<String>[]) List<String> days,
    @Default('') String startTime,
    @Default('') String endTime,
    @Default(SILPriceValidation()) SILPriceValidation priceValidation,
  }) = _SILQuoteLine;

  factory SILQuoteLine.fromJson(Map<String, dynamic> json) =>
      _$SILQuoteLineFromJson(json);
}

@freezed
abstract class SILQuoteTotals with _$SILQuoteTotals {
  const factory SILQuoteTotals({
    @Default(0) double weeklyHours,
    @Default(0) double weeklyAmount,
    @Default(0) double annualAmount,
  }) = _SILQuoteTotals;

  factory SILQuoteTotals.fromJson(Map<String, dynamic> json) =>
      _$SILQuoteTotalsFromJson(json);
}

/// Milestone 6.1: Digital E-Signature record for SIL Quotes
@freezed
abstract class SILQuoteSignature with _$SILQuoteSignature {
  const factory SILQuoteSignature({
    @Default('') String signedBy,
    @Default('participant') String signatoryRole,
    @Default('') String signatureData,
    String? signedAt,
    @Default('') String ipAddress,
  }) = _SILQuoteSignature;

  factory SILQuoteSignature.fromJson(Map<String, dynamic> json) =>
      _$SILQuoteSignatureFromJson(json);
}

@freezed
abstract class SILQuote with _$SILQuote {
  const factory SILQuote({
    required String id,
    required String clientId,
    String? propertyId,
    @Default('draft') String status,
    @Default('plan_managed') String fundingType,
    String? validUntil,
    @Default(<SILQuoteLine>[]) List<SILQuoteLine> lines,
    @Default(SILQuoteTotals()) SILQuoteTotals totals,
    String? rosterOfCareId,
    // Milestone 6.1: Digital e-signature metadata
    SILQuoteSignature? signature,
  }) = _SILQuote;

  factory SILQuote.fromJson(Map<String, dynamic> json) =>
      _$SILQuoteFromJson(json);
}

// ---------------------------------------------------------------------------
// Roster of care
// ---------------------------------------------------------------------------

@freezed
abstract class SILRocSupport with _$SILRocSupport {
  const factory SILRocSupport({
    required String supportNumber,
    @Default('') String supportName,
    @Default('day') String shiftType,
    @Default(0) double hoursPerWeek,
    @Default(0) double unitPrice,
    @Default('P2') String gstCode,
    @Default(0) double amount,
    @Default(<String>[]) List<String> days,
    @Default('') String startTime,
    @Default('') String endTime,
  }) = _SILRocSupport;

  factory SILRocSupport.fromJson(Map<String, dynamic> json) =>
      _$SILRocSupportFromJson(json);
}

@freezed
abstract class SILReviewSchedule with _$SILReviewSchedule {
  const factory SILReviewSchedule({
    @Default('quarterly') String cadence,
    String? nextReviewDate,
  }) = _SILReviewSchedule;

  factory SILReviewSchedule.fromJson(Map<String, dynamic> json) =>
      _$SILReviewScheduleFromJson(json);
}

@freezed
abstract class SILRosterOfCare with _$SILRosterOfCare {
  const factory SILRosterOfCare({
    required String id,
    required String clientId,
    String? propertyId,
    String? quoteId,
    @Default('draft') String status,
    String? effectiveFrom,
    String? effectiveTo,
    @Default(SILReviewSchedule()) SILReviewSchedule reviewSchedule,
    @Default(<SILRocSupport>[]) List<SILRocSupport> supports,
  }) = _SILRosterOfCare;

  factory SILRosterOfCare.fromJson(Map<String, dynamic> json) =>
      _$SILRosterOfCareFromJson(json);
}

// ---------------------------------------------------------------------------
// Roster-of-care invoice result
// ---------------------------------------------------------------------------

/// The stamped funding route of a generated invoice (`billing` block from the
/// backend). `artifact` is `claim_csv` for NDIA-managed work and
/// `invoice_pdf` otherwise.
class SILRosterOfCareBillingRoute {
  const SILRosterOfCareBillingRoute({
    this.fundingType = '',
    this.recipientType = '',
    this.artifact = '',
    this.planManagerStakeholderId,
  });

  final String fundingType;
  final String recipientType;
  final String artifact;
  final String? planManagerStakeholderId;

  bool get isClaim => artifact == 'claim_csv';

  factory SILRosterOfCareBillingRoute.fromJson(Map<String, dynamic> json) {
    return SILRosterOfCareBillingRoute(
      fundingType: json['fundingType']?.toString() ?? '',
      recipientType: json['recipientType']?.toString() ?? '',
      artifact: json['artifact']?.toString() ?? '',
      planManagerStakeholderId: json['planManagerStakeholderId']?.toString(),
    );
  }
}

/// Summary returned by `POST /api/sil/rosters-of-care/:id/invoice`.
class SILRosterOfCareInvoice {
  const SILRosterOfCareInvoice({
    required this.invoiceId,
    required this.invoiceNumber,
    this.billing,
    this.isIdempotentReplay,
  });

  final String invoiceId;
  final String invoiceNumber;
  final SILRosterOfCareBillingRoute? billing;
  // Milestone 7.1: Explicit flag indicating whether invoice was retrieved from an existing idempotent replay
  final bool? isIdempotentReplay;

  factory SILRosterOfCareInvoice.fromJson(Map<String, dynamic> json) {
    final billing = json['billing'];
    return SILRosterOfCareInvoice(
      invoiceId: json['invoiceId']?.toString() ?? '',
      invoiceNumber: json['invoiceNumber']?.toString() ?? '',
      billing: billing is Map
          ? SILRosterOfCareBillingRoute.fromJson(
              Map<String, dynamic>.from(billing),
            )
          : null,
      isIdempotentReplay: json['isIdempotentReplay'] == true,
    );
  }
}

// ---------------------------------------------------------------------------
// Service Agreement (Milestone 4.2 Consent Gate)
// ---------------------------------------------------------------------------

@freezed
abstract class SILServiceAgreement with _$SILServiceAgreement {
  const factory SILServiceAgreement({
    required String id,
    required String organizationId,
    required String clientId,
    String? propertyId,
    String? quoteId,
    String? rosterOfCareId,
    required String agreementNumber,
    @Default('sil') String agreementType,
    @Default('draft') String status,
    required String effectiveFrom,
    String? effectiveTo,
    String? signedAt,
    @Default('') String signedByName,
    @Default('participant') String signedByRole,
    @Default(0) double boardAndLodgingWeekly,
    @Default('') String notes,
  }) = _SILServiceAgreement;

  factory SILServiceAgreement.fromJson(Map<String, dynamic> json) =>
      _$SILServiceAgreementFromJson(_normalizeServiceAgreementJson(json));
}

/// Helper to normalize MongoDB _id and nested signedBy/contribution structures for SILServiceAgreement
Map<String, dynamic> _normalizeServiceAgreementJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  normalized['id'] ??= json['_id']?.toString() ?? '';
  if (json['clientId'] is Map) {
    normalized['clientId'] = json['clientId']['_id']?.toString() ??
        json['clientId']['id']?.toString() ??
        '';
  } else {
    normalized['clientId'] = json['clientId']?.toString() ?? '';
  }
  if (json['propertyId'] is Map) {
    normalized['propertyId'] = json['propertyId']['_id']?.toString() ??
        json['propertyId']['id']?.toString();
  }
  if (json['quoteId'] is Map) {
    normalized['quoteId'] = json['quoteId']['_id']?.toString() ??
        json['quoteId']['id']?.toString();
  }
  if (json['rosterOfCareId'] is Map) {
    normalized['rosterOfCareId'] =
        json['rosterOfCareId']['_id']?.toString() ??
            json['rosterOfCareId']['id']?.toString();
  }
  final signedBy = json['signedBy'] is Map ? json['signedBy'] as Map : null;
  if (signedBy != null) {
    normalized['signedByName'] = signedBy['name']?.toString() ??
        normalized['signedByName'] ??
        '';
    normalized['signedByRole'] = signedBy['role']?.toString() ??
        normalized['signedByRole'] ??
        'participant';
  }
  final contrib = json['participantContribution'] is Map
      ? json['participantContribution'] as Map
      : null;
  if (contrib != null) {
    normalized['boardAndLodgingWeekly'] =
        (contrib['boardAndLodgingWeekly'] as num?)?.toDouble() ?? 0.0;
  }
  return normalized;
}
