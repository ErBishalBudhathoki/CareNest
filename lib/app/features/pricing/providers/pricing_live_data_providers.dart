import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/invoice/providers/ndis_providers.dart';
import 'package:carenest/app/features/pricing/models/pricing_analytics_models.dart';
import 'package:carenest/app/features/pricing/repositories/pricing_repository.dart';

class PricingLiveRecord {
  final String supportItemNumber;
  final String supportItemName;
  final String supportCategoryName;
  final String registrationGroupName;
  final String unit;
  final String source;
  final double? customPrice;
  final double standardPrice;
  final double? priceCap;
  final bool isCustom;
  final bool isQuotable;
  final bool? ndisCompliant;
  final bool? exceedsNdisCap;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PricingLiveRecord({
    required this.supportItemNumber,
    required this.supportItemName,
    required this.supportCategoryName,
    required this.registrationGroupName,
    required this.unit,
    required this.source,
    required this.customPrice,
    required this.standardPrice,
    required this.priceCap,
    required this.isCustom,
    required this.isQuotable,
    required this.ndisCompliant,
    required this.exceedsNdisCap,
    required this.createdAt,
    required this.updatedAt,
  });

  DateTime? get effectiveTimestamp => updatedAt ?? createdAt;
}

double pricingToDouble(dynamic value) {
  if (value is num) return value.toDouble();
  if (value is String) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.\-]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }
  return 0.0;
}

DateTime? pricingParseDate(dynamic raw) {
  if (raw == null) return null;
  if (raw is DateTime) return raw;
  if (raw is String) return DateTime.tryParse(raw);
  if (raw is Map && raw['\$date'] != null) {
    return DateTime.tryParse(raw['\$date'].toString());
  }
  return null;
}

bool pricingIsFallbackSource(String? source) {
  if (source == null) return false;
  final normalized = source.trim().toLowerCase();
  return normalized == 'base-rate' ||
      normalized == 'fallback-base-rate' ||
      normalized == 'fallback' ||
      normalized == 'ndis_default';
}

bool _isEmployeeRecord(Map<String, dynamic> user) {
  final roleTags = <String>{};

  final role = user['role']?.toString().toLowerCase().trim();
  if (role != null && role.isNotEmpty) roleTags.add(role);

  final orgRole = user['organizationRole']?.toString().toLowerCase().trim();
  if (orgRole != null && orgRole.isNotEmpty) roleTags.add(orgRole);

  final roles = user['roles'];
  if (roles is List) {
    for (final entry in roles) {
      final tag = entry.toString().toLowerCase().trim();
      if (tag.isNotEmpty) roleTags.add(tag);
    }
  }

  final clientId = user['clientId']?.toString().trim();
  if (clientId != null && clientId.isNotEmpty) return false;
  if (roleTags.contains('client') || roleTags.contains('family')) {
    return false;
  }
  return true;
}

final pricingOrgEmployeesProvider = FutureProvider.autoDispose
    .family<List<User>, String>((ref, organizationId) async {
      if (organizationId.trim().isEmpty) return const [];

      final api = ref.read(app_providers.apiMethodProvider);
      final response = await api.getOrganizationEmployees(organizationId);
      final rawPeople = (response['employees'] as List<dynamic>? ?? const []);

      return rawPeople
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .where(_isEmployeeRecord)
          .map(User.fromJson)
          .toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    });

final pricingOrgAnalyticsProvider = FutureProvider.autoDispose
    .family<PricingAnalytics?, String>((ref, organizationId) async {
      if (organizationId.trim().isEmpty) return null;
      try {
        final repo = ref.read(pricingRepositoryProvider);
        return await repo.fetchPricingAnalytics(organizationId: organizationId);
      } catch (_) {
        return null;
      }
    });

final pricingLiveRecordsProvider = FutureProvider.autoDispose
    .family<List<PricingLiveRecord>, String>((ref, organizationId) async {
      if (organizationId.trim().isEmpty) return const [];

      final ndisItems = await ref.watch(ndisItemsProvider.future);
      final pricingLookup = await ref.watch(
        ndisPricingProvider(organizationId).future,
      );

      final records = <PricingLiveRecord>[];

      for (final item in ndisItems) {
        final raw = pricingLookup[item.itemNumber];
        final map = raw is Map
            ? Map<String, dynamic>.from(raw)
            : const <String, dynamic>{};

        final source = map['source']?.toString() ?? 'ndis_default';
        final customPriceRaw = pricingToDouble(
          map['price'] ?? map['customPrice'] ?? map['fixedPrice'],
        );
        final customPrice = customPriceRaw > 0 ? customPriceRaw : null;

        final capRaw = pricingToDouble(map['priceCap']);
        final cap = capRaw > 0 ? capRaw : null;

        final statePrice = item.getApplicablePrice();
        final isCustom =
            customPrice != null && !pricingIsFallbackSource(source);

        records.add(
          PricingLiveRecord(
            supportItemNumber: item.itemNumber,
            supportItemName:
                map['supportItemName']?.toString().trim().isNotEmpty == true
                ? map['supportItemName'].toString()
                : item.itemName,
            supportCategoryName: item.supportCategoryName,
            registrationGroupName: item.registrationGroupName,
            unit: item.unit,
            source: source,
            customPrice: customPrice,
            standardPrice: statePrice,
            priceCap: cap,
            isCustom: isCustom,
            isQuotable: item.isQuotable,
            ndisCompliant: map['ndisCompliant'] is bool
                ? map['ndisCompliant'] as bool
                : null,
            exceedsNdisCap: map['exceedsNdisCap'] is bool
                ? map['exceedsNdisCap'] as bool
                : null,
            createdAt: pricingParseDate(map['createdAt']),
            updatedAt: pricingParseDate(map['updatedAt']),
          ),
        );
      }

      records.sort((a, b) {
        final ad = a.effectiveTimestamp;
        final bd = b.effectiveTimestamp;
        if (ad == null && bd == null) return 0;
        if (ad == null) return 1;
        if (bd == null) return -1;
        return bd.compareTo(ad);
      });

      return records;
    });

final pricingOrgClientsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, organizationId) async {
      if (organizationId.trim().isEmpty) return const [];
      final api = ref.read(app_providers.apiMethodProvider);
      try {
        return await api.getClientsByOrganizationId(organizationId);
      } catch (_) {
        return const [];
      }
    });

class PriceHistoryQuery {
  final String supportItemNumber;
  final String clientId;

  const PriceHistoryQuery({
    required this.supportItemNumber,
    required this.clientId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PriceHistoryQuery &&
        other.supportItemNumber == supportItemNumber &&
        other.clientId == clientId;
  }

  @override
  int get hashCode => Object.hash(supportItemNumber, clientId);
}

final pricingDetailedHistoryProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, PriceHistoryQuery>((ref, query) async {
      if (query.supportItemNumber.trim().isEmpty ||
          query.clientId.trim().isEmpty) {
        return const [];
      }
      final api = ref.read(app_providers.apiMethodProvider);
      final rows = await api.getPriceHistory(
        query.supportItemNumber,
        query.clientId,
      );
      return rows ?? const [];
    });
