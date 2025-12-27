/// PricingSettings model representing organization-wide general pricing settings.
///
/// Immutable data class with JSON serialization, copyWith, and equality.
/// Matches the backend `/api/settings/general` payload contract.
class PricingSettings {
  /// Three-letter currency code (e.g., `AUD`).
  final String defaultCurrency;

  /// Pricing model label (<= 100 characters).
  final String pricingModel;

  /// Rounding method label (<= 100 characters).
  final String roundingMethod;

  /// Tax calculation mode: `GST Inclusive` or `GST Exclusive`.
  final String taxCalculation;

  /// Default markup percentage (0–100).
  final double defaultMarkup;

  /// Maximum allowed price variation percentage (0–100).
  final double maxPriceVariation;

  /// Price history retention in days (1–3650).
  final int priceHistoryRetention;

  /// Bulk operation record limit (1–10000).
  final int bulkOperationLimit;

  /// When true, pricing updates can run automatically.
  final bool autoUpdatePricing;

  /// When true, price validation features are enabled.
  final bool enablePriceValidation;

  /// When true, changes require approval.
  final bool requireApprovalForChanges;

  /// When true, bulk operations are enabled.
  final bool enableBulkOperations;

  /// When true, price history is recorded.
  final bool enablePriceHistory;

  /// When true, notifications are enabled.
  final bool enableNotifications;

  /// Optional: last update timestamp returned by backend.
  final DateTime? updatedAt;

  /// Optional: last updater email returned by backend.
  final String? updatedBy;

  /// Optional: configuration version returned by backend.
  final int? version;

  /// Creates a new immutable PricingSettings instance.
  const PricingSettings({
    required this.defaultCurrency,
    required this.pricingModel,
    required this.roundingMethod,
    required this.taxCalculation,
    required this.defaultMarkup,
    required this.maxPriceVariation,
    required this.priceHistoryRetention,
    required this.bulkOperationLimit,
    required this.autoUpdatePricing,
    required this.enablePriceValidation,
    required this.requireApprovalForChanges,
    required this.enableBulkOperations,
    required this.enablePriceHistory,
    required this.enableNotifications,
    this.updatedAt,
    this.updatedBy,
    this.version,
  });

  /// Factory to construct from a JSON map.
  ///
  /// Accepts backend response keys and normalizes types.
  factory PricingSettings.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is String && v.isNotEmpty) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          return null;
        }
      }
      return null;
    }

    return PricingSettings(
      defaultCurrency: (json['defaultCurrency'] as String? ?? '').trim().toUpperCase(),
      pricingModel: (json['pricingModel'] as String? ?? '').trim(),
      roundingMethod: (json['roundingMethod'] as String? ?? '').trim(),
      taxCalculation: (json['taxCalculation'] as String? ?? '').trim(),
      defaultMarkup: (json['defaultMarkup'] as num? ?? 0).toDouble(),
      maxPriceVariation: (json['maxPriceVariation'] as num? ?? 0).toDouble(),
      priceHistoryRetention: (json['priceHistoryRetention'] as int?) ?? 0,
      bulkOperationLimit: (json['bulkOperationLimit'] as int?) ?? 0,
      autoUpdatePricing: (json['autoUpdatePricing'] as bool?) ?? false,
      enablePriceValidation: (json['enablePriceValidation'] as bool?) ?? false,
      requireApprovalForChanges: (json['requireApprovalForChanges'] as bool?) ?? false,
      enableBulkOperations: (json['enableBulkOperations'] as bool?) ?? false,
      enablePriceHistory: (json['enablePriceHistory'] as bool?) ?? false,
      enableNotifications: (json['enableNotifications'] as bool?) ?? false,
      updatedAt: parseDate(json['updatedAt']),
      updatedBy: json['updatedBy'] as String?,
      version: json['version'] as int?,
    );
  }

  /// Converts to a JSON map matching the backend update payload.
  Map<String, dynamic> toJson() => {
        'defaultCurrency': defaultCurrency,
        'pricingModel': pricingModel,
        'roundingMethod': roundingMethod,
        'taxCalculation': taxCalculation,
        'defaultMarkup': defaultMarkup,
        'maxPriceVariation': maxPriceVariation,
        'priceHistoryRetention': priceHistoryRetention,
        'bulkOperationLimit': bulkOperationLimit,
        'autoUpdatePricing': autoUpdatePricing,
        'enablePriceValidation': enablePriceValidation,
        'requireApprovalForChanges': requireApprovalForChanges,
        'enableBulkOperations': enableBulkOperations,
        'enablePriceHistory': enablePriceHistory,
        'enableNotifications': enableNotifications,
      };

  /// Returns a copy with optional changes to fields.
  PricingSettings copyWith({
    String? defaultCurrency,
    String? pricingModel,
    String? roundingMethod,
    String? taxCalculation,
    double? defaultMarkup,
    double? maxPriceVariation,
    int? priceHistoryRetention,
    int? bulkOperationLimit,
    bool? autoUpdatePricing,
    bool? enablePriceValidation,
    bool? requireApprovalForChanges,
    bool? enableBulkOperations,
    bool? enablePriceHistory,
    bool? enableNotifications,
    DateTime? updatedAt,
    String? updatedBy,
    int? version,
  }) {
    return PricingSettings(
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      pricingModel: pricingModel ?? this.pricingModel,
      roundingMethod: roundingMethod ?? this.roundingMethod,
      taxCalculation: taxCalculation ?? this.taxCalculation,
      defaultMarkup: defaultMarkup ?? this.defaultMarkup,
      maxPriceVariation: maxPriceVariation ?? this.maxPriceVariation,
      priceHistoryRetention: priceHistoryRetention ?? this.priceHistoryRetention,
      bulkOperationLimit: bulkOperationLimit ?? this.bulkOperationLimit,
      autoUpdatePricing: autoUpdatePricing ?? this.autoUpdatePricing,
      enablePriceValidation: enablePriceValidation ?? this.enablePriceValidation,
      requireApprovalForChanges:
          requireApprovalForChanges ?? this.requireApprovalForChanges,
      enableBulkOperations: enableBulkOperations ?? this.enableBulkOperations,
      enablePriceHistory: enablePriceHistory ?? this.enablePriceHistory,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      version: version ?? this.version,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PricingSettings &&
        other.defaultCurrency == defaultCurrency &&
        other.pricingModel == pricingModel &&
        other.roundingMethod == roundingMethod &&
        other.taxCalculation == taxCalculation &&
        other.defaultMarkup == defaultMarkup &&
        other.maxPriceVariation == maxPriceVariation &&
        other.priceHistoryRetention == priceHistoryRetention &&
        other.bulkOperationLimit == bulkOperationLimit &&
        other.autoUpdatePricing == autoUpdatePricing &&
        other.enablePriceValidation == enablePriceValidation &&
        other.requireApprovalForChanges == requireApprovalForChanges &&
        other.enableBulkOperations == enableBulkOperations &&
        other.enablePriceHistory == enablePriceHistory &&
        other.enableNotifications == enableNotifications &&
        other.updatedAt == updatedAt &&
        other.updatedBy == updatedBy &&
        other.version == version;
  }

  @override
  int get hashCode => Object.hash(
        defaultCurrency,
        pricingModel,
        roundingMethod,
        taxCalculation,
        defaultMarkup,
        maxPriceVariation,
        priceHistoryRetention,
        bulkOperationLimit,
        autoUpdatePricing,
        enablePriceValidation,
        requireApprovalForChanges,
        enableBulkOperations,
        enablePriceHistory,
        enableNotifications,
        updatedAt,
        updatedBy,
        version,
      );
}