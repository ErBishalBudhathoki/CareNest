// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sil_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SILAddress _$SILAddressFromJson(Map<String, dynamic> json) => _SILAddress(
  line1: json['line1'] as String? ?? '',
  line2: json['line2'] as String? ?? '',
  suburb: json['suburb'] as String? ?? '',
  state: json['state'] as String? ?? '',
  postcode: json['postcode'] as String? ?? '',
  country: json['country'] as String? ?? 'Australia',
);

Map<String, dynamic> _$SILAddressToJson(_SILAddress instance) =>
    <String, dynamic>{
      'line1': instance.line1,
      'line2': instance.line2,
      'suburb': instance.suburb,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
    };

_SILRoom _$SILRoomFromJson(Map<String, dynamic> json) => _SILRoom(
  roomId: json['roomId'] as String,
  label: json['label'] as String? ?? '',
  vacant: json['vacant'] as bool? ?? true,
  accessibility:
      (json['accessibility'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$SILRoomToJson(_SILRoom instance) => <String, dynamic>{
  'roomId': instance.roomId,
  'label': instance.label,
  'vacant': instance.vacant,
  'accessibility': instance.accessibility,
};

_SILProperty _$SILPropertyFromJson(Map<String, dynamic> json) => _SILProperty(
  id: json['id'] as String,
  name: json['name'] as String,
  reference: json['reference'] as String? ?? '',
  propertyType: json['propertyType'] as String? ?? 'house',
  silDesignCategory: json['silDesignCategory'] as String? ?? 'basic',
  bedrooms: (json['bedrooms'] as num?)?.toInt() ?? 0,
  maxOccupancy: (json['maxOccupancy'] as num?)?.toInt() ?? 0,
  active: json['active'] as bool? ?? true,
  rooms:
      (json['rooms'] as List<dynamic>?)
          ?.map((e) => SILRoom.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SILRoom>[],
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  address: json['address'] == null
      ? null
      : SILAddress.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SILPropertyToJson(_SILProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reference': instance.reference,
      'propertyType': instance.propertyType,
      'silDesignCategory': instance.silDesignCategory,
      'bedrooms': instance.bedrooms,
      'maxOccupancy': instance.maxOccupancy,
      'active': instance.active,
      'rooms': instance.rooms,
      'amenities': instance.amenities,
      'address': instance.address,
    };

_SILOccupancy _$SILOccupancyFromJson(Map<String, dynamic> json) =>
    _SILOccupancy(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      roomId: json['roomId'] as String,
      clientId: json['clientId'] as String,
      status: json['status'] as String? ?? 'active',
      fundingType: json['fundingType'] as String? ?? 'plan_managed',
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$SILOccupancyToJson(_SILOccupancy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'roomId': instance.roomId,
      'clientId': instance.clientId,
      'status': instance.status,
      'fundingType': instance.fundingType,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

_SILVacancyRoom _$SILVacancyRoomFromJson(Map<String, dynamic> json) =>
    _SILVacancyRoom(
      roomId: json['roomId'] as String,
      label: json['label'] as String? ?? '',
      occupied: json['occupied'] as bool? ?? false,
      accessibility:
          (json['accessibility'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$SILVacancyRoomToJson(_SILVacancyRoom instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'label': instance.label,
      'occupied': instance.occupied,
      'accessibility': instance.accessibility,
    };

_SILVacancyBoard _$SILVacancyBoardFromJson(Map<String, dynamic> json) =>
    _SILVacancyBoard(
      propertyId: json['propertyId'] as String,
      propertyName: json['propertyName'] as String? ?? '',
      totalRooms: (json['totalRooms'] as num?)?.toInt() ?? 0,
      occupiedCount: (json['occupiedCount'] as num?)?.toInt() ?? 0,
      vacantCount: (json['vacantCount'] as num?)?.toInt() ?? 0,
      rooms:
          (json['rooms'] as List<dynamic>?)
              ?.map((e) => SILVacancyRoom.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SILVacancyRoom>[],
    );

Map<String, dynamic> _$SILVacancyBoardToJson(_SILVacancyBoard instance) =>
    <String, dynamic>{
      'propertyId': instance.propertyId,
      'propertyName': instance.propertyName,
      'totalRooms': instance.totalRooms,
      'occupiedCount': instance.occupiedCount,
      'vacantCount': instance.vacantCount,
      'rooms': instance.rooms,
    };

_SILRatioValue _$SILRatioValueFromJson(Map<String, dynamic> json) =>
    _SILRatioValue(
      staff: (json['staff'] as num?)?.toInt() ?? 1,
      participants: (json['participants'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$SILRatioValueToJson(_SILRatioValue instance) =>
    <String, dynamic>{
      'staff': instance.staff,
      'participants': instance.participants,
    };

_SILRatioRule _$SILRatioRuleFromJson(Map<String, dynamic> json) =>
    _SILRatioRule(
      id: json['id'] as String,
      name: json['name'] as String,
      ratio: json['ratio'] == null
          ? const SILRatioValue()
          : SILRatioValue.fromJson(json['ratio'] as Map<String, dynamic>),
      shiftType: json['shiftType'] as String? ?? 'day',
      minParticipants: (json['minParticipants'] as num?)?.toInt() ?? 1,
      maxParticipants: (json['maxParticipants'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$SILRatioRuleToJson(_SILRatioRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ratio': instance.ratio,
      'shiftType': instance.shiftType,
      'minParticipants': instance.minParticipants,
      'maxParticipants': instance.maxParticipants,
      'isActive': instance.isActive,
    };

_SILRosterEntry _$SILRosterEntryFromJson(Map<String, dynamic> json) =>
    _SILRosterEntry(
      shiftId: json['shiftId'] as String?,
      clientIds:
          (json['clientIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      staffUserIds:
          (json['staffUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      shiftType: json['shiftType'] as String? ?? 'day',
      requiredStaff: (json['requiredStaff'] as num?)?.toInt() ?? 1,
      assignedStaff: (json['assignedStaff'] as num?)?.toInt() ?? 0,
      compliance: json['compliance'] as String? ?? 'ok',
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
    );

Map<String, dynamic> _$SILRosterEntryToJson(_SILRosterEntry instance) =>
    <String, dynamic>{
      'shiftId': instance.shiftId,
      'clientIds': instance.clientIds,
      'staffUserIds': instance.staffUserIds,
      'shiftType': instance.shiftType,
      'requiredStaff': instance.requiredStaff,
      'assignedStaff': instance.assignedStaff,
      'compliance': instance.compliance,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

_SILRatioWarning _$SILRatioWarningFromJson(Map<String, dynamic> json) =>
    _SILRatioWarning(
      role: json['role'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$SILRatioWarningToJson(_SILRatioWarning instance) =>
    <String, dynamic>{'role': instance.role, 'message': instance.message};

_SILRoster _$SILRosterFromJson(Map<String, dynamic> json) => _SILRoster(
  id: json['id'] as String,
  propertyId: json['propertyId'] as String,
  status: json['status'] as String? ?? 'draft',
  weekStarting: json['weekStarting'] as String?,
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => SILRosterEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SILRosterEntry>[],
  ratioWarnings:
      (json['ratioWarnings'] as List<dynamic>?)
          ?.map((e) => SILRatioWarning.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SILRatioWarning>[],
);

Map<String, dynamic> _$SILRosterToJson(_SILRoster instance) =>
    <String, dynamic>{
      'id': instance.id,
      'propertyId': instance.propertyId,
      'status': instance.status,
      'weekStarting': instance.weekStarting,
      'entries': instance.entries,
      'ratioWarnings': instance.ratioWarnings,
    };

_SILPriceValidation _$SILPriceValidationFromJson(Map<String, dynamic> json) =>
    _SILPriceValidation(
      passed: json['passed'] as bool? ?? true,
      capApplied: (json['capApplied'] as num?)?.toDouble(),
      type: json['type'] as String?,
      errors:
          (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$SILPriceValidationToJson(_SILPriceValidation instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'capApplied': instance.capApplied,
      'type': instance.type,
      'errors': instance.errors,
    };

_SILQuoteLine _$SILQuoteLineFromJson(Map<String, dynamic> json) =>
    _SILQuoteLine(
      supportNumber: json['supportNumber'] as String,
      supportName: json['supportName'] as String? ?? '',
      shiftType: json['shiftType'] as String? ?? 'day',
      hoursPerWeek: (json['hoursPerWeek'] as num?)?.toDouble() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
      gstCode: json['gstCode'] as String? ?? 'P2',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      days:
          (json['days'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      priceValidation: json['priceValidation'] == null
          ? const SILPriceValidation()
          : SILPriceValidation.fromJson(
              json['priceValidation'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$SILQuoteLineToJson(_SILQuoteLine instance) =>
    <String, dynamic>{
      'supportNumber': instance.supportNumber,
      'supportName': instance.supportName,
      'shiftType': instance.shiftType,
      'hoursPerWeek': instance.hoursPerWeek,
      'unitPrice': instance.unitPrice,
      'gstCode': instance.gstCode,
      'amount': instance.amount,
      'days': instance.days,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'priceValidation': instance.priceValidation,
    };

_SILQuoteTotals _$SILQuoteTotalsFromJson(Map<String, dynamic> json) =>
    _SILQuoteTotals(
      weeklyHours: (json['weeklyHours'] as num?)?.toDouble() ?? 0,
      weeklyAmount: (json['weeklyAmount'] as num?)?.toDouble() ?? 0,
      annualAmount: (json['annualAmount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$SILQuoteTotalsToJson(_SILQuoteTotals instance) =>
    <String, dynamic>{
      'weeklyHours': instance.weeklyHours,
      'weeklyAmount': instance.weeklyAmount,
      'annualAmount': instance.annualAmount,
    };

_SILQuote _$SILQuoteFromJson(Map<String, dynamic> json) => _SILQuote(
  id: json['id'] as String,
  clientId: json['clientId'] as String,
  propertyId: json['propertyId'] as String?,
  status: json['status'] as String? ?? 'draft',
  fundingType: json['fundingType'] as String? ?? 'plan_managed',
  validUntil: json['validUntil'] as String?,
  lines:
      (json['lines'] as List<dynamic>?)
          ?.map((e) => SILQuoteLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SILQuoteLine>[],
  totals: json['totals'] == null
      ? const SILQuoteTotals()
      : SILQuoteTotals.fromJson(json['totals'] as Map<String, dynamic>),
  rosterOfCareId: json['rosterOfCareId'] as String?,
);

Map<String, dynamic> _$SILQuoteToJson(_SILQuote instance) => <String, dynamic>{
  'id': instance.id,
  'clientId': instance.clientId,
  'propertyId': instance.propertyId,
  'status': instance.status,
  'fundingType': instance.fundingType,
  'validUntil': instance.validUntil,
  'lines': instance.lines,
  'totals': instance.totals,
  'rosterOfCareId': instance.rosterOfCareId,
};

_SILRocSupport _$SILRocSupportFromJson(Map<String, dynamic> json) =>
    _SILRocSupport(
      supportNumber: json['supportNumber'] as String,
      supportName: json['supportName'] as String? ?? '',
      shiftType: json['shiftType'] as String? ?? 'day',
      hoursPerWeek: (json['hoursPerWeek'] as num?)?.toDouble() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
      gstCode: json['gstCode'] as String? ?? 'P2',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      days:
          (json['days'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
    );

Map<String, dynamic> _$SILRocSupportToJson(_SILRocSupport instance) =>
    <String, dynamic>{
      'supportNumber': instance.supportNumber,
      'supportName': instance.supportName,
      'shiftType': instance.shiftType,
      'hoursPerWeek': instance.hoursPerWeek,
      'unitPrice': instance.unitPrice,
      'gstCode': instance.gstCode,
      'amount': instance.amount,
      'days': instance.days,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

_SILReviewSchedule _$SILReviewScheduleFromJson(Map<String, dynamic> json) =>
    _SILReviewSchedule(
      cadence: json['cadence'] as String? ?? 'quarterly',
      nextReviewDate: json['nextReviewDate'] as String?,
    );

Map<String, dynamic> _$SILReviewScheduleToJson(_SILReviewSchedule instance) =>
    <String, dynamic>{
      'cadence': instance.cadence,
      'nextReviewDate': instance.nextReviewDate,
    };

_SILRosterOfCare _$SILRosterOfCareFromJson(Map<String, dynamic> json) =>
    _SILRosterOfCare(
      id: json['id'] as String,
      clientId: json['clientId'] as String,
      propertyId: json['propertyId'] as String?,
      quoteId: json['quoteId'] as String?,
      status: json['status'] as String? ?? 'draft',
      effectiveFrom: json['effectiveFrom'] as String?,
      effectiveTo: json['effectiveTo'] as String?,
      reviewSchedule: json['reviewSchedule'] == null
          ? const SILReviewSchedule()
          : SILReviewSchedule.fromJson(
              json['reviewSchedule'] as Map<String, dynamic>,
            ),
      supports:
          (json['supports'] as List<dynamic>?)
              ?.map((e) => SILRocSupport.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SILRocSupport>[],
    );

Map<String, dynamic> _$SILRosterOfCareToJson(_SILRosterOfCare instance) =>
    <String, dynamic>{
      'id': instance.id,
      'clientId': instance.clientId,
      'propertyId': instance.propertyId,
      'quoteId': instance.quoteId,
      'status': instance.status,
      'effectiveFrom': instance.effectiveFrom,
      'effectiveTo': instance.effectiveTo,
      'reviewSchedule': instance.reviewSchedule,
      'supports': instance.supports,
    };
