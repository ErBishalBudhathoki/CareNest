import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_model.freezed.dart';
part 'client_model.g.dart';

/// Helper to safely parse dates from dynamic values (ISO string, int milliseconds, etc.).
DateTime? _parseDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value);
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  return null;
}

/// Helper to parse boolean values permissively from bool, num, or string values.
bool _parseBool(dynamic value, {required bool defaultValue}) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
      return true;
    }
    if (normalized == 'false' || normalized == '0' || normalized == 'no') {
      return false;
    }
  }
  return defaultValue;
}

/// Helper to parse double numbers safely.
double _parseDouble(dynamic value, {double defaultValue = 0.0}) {
  if (value is num) return value.toDouble();
  if (value is String && value.isNotEmpty) {
    return double.tryParse(value) ?? defaultValue;
  }
  return defaultValue;
}

// ---------------------------------------------------------------------------
// NDIS Plan & Sub-Models (Milestone 2.2 — Backend Parity)
// ---------------------------------------------------------------------------

@freezed
abstract class ClientPlanCategory with _$ClientPlanCategory {
  const factory ClientPlanCategory({
    required String categoryNumber,
    @Default('') String name,
    @Default(0.0) double budget,
  }) = _ClientPlanCategory;

  factory ClientPlanCategory.fromJson(Map<String, dynamic> json) =>
      _$ClientPlanCategoryFromJson(json);
}

@freezed
abstract class ClientPlan with _$ClientPlan {
  const factory ClientPlan({
    DateTime? startDate,
    DateTime? endDate,
    @Default(0.0) double totalBudget,
    @Default(<ClientPlanCategory>[]) List<ClientPlanCategory> categories,
    @Default('not_configured') String status,
    @Default('manual') String source,
    String? documentUrl,
    String? documentName,
    String? notes,
    DateTime? updatedAt,
    String? updatedBy,
  }) = _ClientPlan;

  factory ClientPlan.fromJson(Map<String, dynamic> json) {
    final rawCategories = json['categories'];
    List<ClientPlanCategory> parsedCategories = [];
    if (rawCategories is List) {
      parsedCategories = rawCategories
          .whereType<Map<String, dynamic>>()
          .map((c) => ClientPlanCategory.fromJson(c))
          .toList();
    }

    return ClientPlan(
      startDate: _parseDate(json['startDate']),
      endDate: _parseDate(json['endDate']),
      totalBudget: _parseDouble(json['totalBudget']),
      categories: parsedCategories,
      status: (json['status'] ?? 'not_configured').toString(),
      source: (json['source'] ?? 'manual').toString(),
      documentUrl: json['documentUrl'] as String?,
      documentName: json['documentName'] as String?,
      notes: json['notes'] as String?,
      updatedAt: _parseDate(json['updatedAt']),
      updatedBy: json['updatedBy'] as String?,
    );
  }
}

@freezed
abstract class ClientSilRef with _$ClientSilRef {
  const factory ClientSilRef({
    String? propertyId,
    String? roomId,
    String? rosterOfCareId,
  }) = _ClientSilRef;

  factory ClientSilRef.fromJson(Map<String, dynamic> json) =>
      _$ClientSilRefFromJson(json);
}

@freezed
abstract class ClientStakeholderRef with _$ClientStakeholderRef {
  const factory ClientStakeholderRef({
    String? stakeholderId,
    @Default('other') String role,
    @Default(false) bool isPrimary,
  }) = _ClientStakeholderRef;

  factory ClientStakeholderRef.fromJson(Map<String, dynamic> json) =>
      _$ClientStakeholderRefFromJson(json);
}

// ---------------------------------------------------------------------------
// Client / Patient Master Model
// ---------------------------------------------------------------------------

@freezed
abstract class ClientModel with _$ClientModel {
  // Required for custom methods/getters like displayName in Freezed
  const ClientModel._();

  const factory ClientModel({
    @JsonKey(name: '_id') String? id, // MongoDB ObjectId from backend
    String? clientFirstName,
    String? clientLastName,
    @Default('') String clientEmail,
    String? clientPhone,
    String? clientAddress,
    String? clientCity,
    String? clientState,
    String? clientZip,
    String? businessName,
    String? clientName, // Added for cases where only clientName is provided
    String? careNotes,
    Map<String, dynamic>? preferences,
    @Default(true) bool isActive,
    @Default(false) bool isActivated,
    @Default(false) bool activationPending,
    DateTime? deletedAt,
    DateTime? purgeAfter,

    /// NDIS participant number (Phase 6) — required for bulk claiming.
    String? ndisNumber,

    /// Funding route (Phase 5/6): ndia_managed | plan_managed | self_managed | combination.
    @Default('plan_managed') String? fundingType,

    /// Linked NDIS Plan envelope (Milestone 2.2 parity).
    ClientPlan? plan,

    /// Linked Supported Independent Living context (Milestone 2.2 parity).
    ClientSilRef? sil,

    /// Linked Care Network stakeholders (Milestone 2.2 parity).
    @Default(<ClientStakeholderRef>[]) List<ClientStakeholderRef> stakeholders,

    /// Emergency contacts and assessments from backend.
    Map<String, dynamic>? emergencyContact,
    @Default(<String>[]) List<String> medicalConditions,
    Map<String, dynamic>? riskAssessment,
    String? organizationId,
  }) = _ClientModel;

  /// Computed display name with fallbacks:
  /// 1. First + Last name
  /// 2. First name only
  /// 3. Last name only
  /// 4. clientName field
  /// 5. clientEmail fallback
  String get displayName {
    if (clientFirstName != null && clientLastName != null) {
      return '${clientFirstName!} ${clientLastName!}';
    } else if (clientFirstName != null) {
      return clientFirstName!;
    } else if (clientLastName != null) {
      return clientLastName!;
    } else if (clientName != null) {
      return clientName!;
    } else {
      return clientEmail; // Fallback to email if no name is available
    }
  }

  /// Permissive factory from JSON handling legacy aliases and backend field variants.
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    final activationStatus =
        (json['activationStatus'] ?? json['activation_state'] ?? '')
            .toString()
            .trim()
            .toLowerCase();
    final activationPendingFromStatus = activationStatus == 'pending';
    final isActivatedFromStatus =
        activationStatus == 'activated' ||
        activationStatus == 'completed' ||
        activationStatus == 'active';

    // Parse nested NDIS plan if available
    ClientPlan? plan;
    final rawPlan = json['plan'];
    if (rawPlan is Map<String, dynamic>) {
      plan = ClientPlan.fromJson(rawPlan);
    }

    // Parse nested SIL reference if available
    ClientSilRef? sil;
    final rawSil = json['sil'];
    if (rawSil is Map<String, dynamic>) {
      sil = ClientSilRef.fromJson(rawSil);
    }

    // Parse nested stakeholders if available
    List<ClientStakeholderRef> stakeholders = [];
    final rawStakeholders = json['stakeholders'];
    if (rawStakeholders is List) {
      stakeholders = rawStakeholders
          .whereType<Map<String, dynamic>>()
          .map((s) => ClientStakeholderRef.fromJson(s))
          .toList();
    }

    // Parse medical conditions
    List<String> medicalConditions = [];
    final rawMed = json['medicalConditions'];
    if (rawMed is List) {
      medicalConditions = rawMed.map((e) => e.toString()).toList();
    }

    return ClientModel(
      id: (json['_id'] ?? json['id']) as String?,
      clientFirstName: json['clientFirstName'] as String?,
      clientLastName: json['clientLastName'] as String?,
      clientEmail: (json['clientEmail'] ?? json['email'] ?? '') as String,
      clientPhone: json['clientPhone'] as String?,
      clientAddress: json['clientAddress'] as String?,
      clientCity: json['clientCity'] as String?,
      clientState: json['clientState'] as String?,
      clientZip: json['clientZip'] as String?,
      businessName: json['businessName'] as String?,
      clientName: json['clientName'] as String?,
      careNotes: json['careNotes'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>?,
      isActive: _parseBool(json['isActive'], defaultValue: true),
      isActivated:
          _parseBool(json['isActivated'], defaultValue: false) ||
          isActivatedFromStatus,
      activationPending:
          _parseBool(json['activationPending'], defaultValue: false) ||
          activationPendingFromStatus,
      deletedAt: _parseDate(json['deletedAt']),
      purgeAfter: _parseDate(json['purgeAfter']),
      ndisNumber: json['ndisNumber'] as String?,
      fundingType: json['fundingType'] as String? ?? 'plan_managed',
      plan: plan,
      sil: sil,
      stakeholders: stakeholders,
      emergencyContact: json['emergencyContact'] as Map<String, dynamic>?,
      medicalConditions: medicalConditions,
      riskAssessment: json['riskAssessment'] as Map<String, dynamic>?,
      organizationId: json['organizationId'] as String?,
    );
  }
}

/// Backward compatibility alias for legacy code and existing widgets.
/// All existing references to `Patient` seamlessly refer to `ClientModel`.
typedef Patient = ClientModel;
