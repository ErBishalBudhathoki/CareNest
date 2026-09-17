import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/backend/api_method.dart';

const pricingRegions = [
  PriceRegion.national,
  PriceRegion.remote,
  PriceRegion.veryRemote,
];

double? positivePricingValue(dynamic value) {
  final price = value is num ? value.toDouble() : double.tryParse('$value');
  return price != null && price.isFinite && price > 0 ? price : null;
}

PriceRegion pricingRegion(dynamic value) => pricingRegions.firstWhere(
  (region) => region.name == value,
  orElse: () => PriceRegion.national,
);

bool isHighIntensityPricingItem(NDISItem item) =>
    item.registrationGroupNumber == '0104' ||
    item.itemNumber.split('_').elementAtOrNull(2) == '0104' ||
    RegExp(
      r'high[\s-]+intensity',
      caseSensitive: false,
    ).hasMatch('${item.itemName} ${item.registrationGroupName}');

double? regionalPricingCap(
  NDISItem item,
  PriceRegion region, {
  Map<String, dynamic>? caps,
}) {
  if (!pricingRegions.contains(region)) return null;
  return positivePricingValue(caps?[region.name]) ??
      positivePricingValue(item.regionalPrices[region]);
}

Map<String, dynamic>? scopedPricing(
  Map<String, dynamic>? lookup, {
  required String? clientId,
}) {
  if (lookup == null) return null;
  final source = lookup['source']?.toString().toLowerCase().replaceAll(
    '-',
    '_',
  );
  final client =
      lookup['clientSpecific'] == true || source == 'client_specific';
  if (const {
    'ndis_default',
    'fallback',
    'base_rate',
    'fallback_base_rate',
  }.contains(source))
    return null;
  final custom =
      lookup['_id'] != null ||
      client ||
      source == 'organization' ||
      source == 'organization_specific';
  if (!custom || client != (clientId != null)) return null;
  if (client && lookup['clientId'] != null && lookup['clientId'] != clientId) {
    return null;
  }
  final price =
      positivePricingValue(lookup['customPrice']) ??
      positivePricingValue(lookup['price']) ??
      positivePricingValue(lookup['fixedPrice']);
  if (price == null) return null;
  return {
    ...lookup,
    'price': price,
    'customPrice': price,
    'clientSpecific': client,
    if (lookup['region'] != null) 'region': pricingRegion(lookup['region']).name,
  };
}

double? effectiveScopedPrice(
  Map<String, dynamic>? lookup, {
  required String? clientId,
  double? fallback,
}) {
  if (lookup == null) return null;
  final source = lookup['source']?.toString().toLowerCase().replaceAll(
    '-',
    '_',
  );
  final isFallback =
      const {
        'ndis_default',
        'fallback',
        'base_rate',
        'fallback_base_rate',
      }.contains(source);
  final clientSpecific =
      lookup['clientSpecific'] == true || source == 'client_specific';
  final custom =
      lookup['_id'] != null ||
      clientSpecific ||
      source == 'organization' ||
      source == 'organization_specific';
  if (isFallback || !custom) return fallback;
  if (clientSpecific && clientId == null) {
    return positivePricingValue(lookup['price']) ?? fallback;
  }
  if (!clientSpecific && clientId != null) {
    return positivePricingValue(lookup['price']) ?? fallback;
  }
  final matchingClient =
      clientSpecific && lookup['clientId'] != null
          ? lookup['clientId'].toString() == clientId
          : true;
  if (!matchingClient) return fallback;
  return positivePricingValue(lookup['price']) ?? fallback;
}

class PricingDraft {
  PricingDraft(this.saved, double fallback)
    : priceText = (positivePricingValue(saved?['price']) ?? fallback)
          .toStringAsFixed(2),
      region = saved?['region'] == null
          ? PriceRegion.national
          : pricingRegion(saved?['region']),
      initialPrice = positivePricingValue(saved?['price']) ?? fallback;

  Map<String, dynamic>? saved;
  String priceText;
  PriceRegion region;
  bool regionTouched = false;

  bool get hasSavedRegion => saved?['region'] != null;

  bool get isDirty =>
      priceText !=
          (positivePricingValue(saved?['price']) ?? initialPrice)
              .toStringAsFixed(2) ||
      region != pricingRegion(saved?['region']);

  final double initialPrice;

  double? get price => positivePricingValue(priceText);

  bool validFor(NDISItem item, Map<String, dynamic>? caps) {
    final cap = regionalPricingCap(item, region, caps: caps);
    return price != null && cap != null && price! <= cap;
  }

  void discard() {
    priceText = (positivePricingValue(saved?['price']) ?? initialPrice)
        .toStringAsFixed(2);
    region = saved?['region'] == null
        ? PriceRegion.national
        : pricingRegion(saved?['region']);
    regionTouched = false;
  }

  void accept(Map<String, dynamic> value) {
    saved = Map<String, dynamic>.from(value);
    priceText = positivePricingValue(value['price'])!.toStringAsFixed(2);
    region = value['region'] == null
        ? PriceRegion.national
        : pricingRegion(value['region']);
    regionTouched = false;
  }
}

class ScopedPricingEditor {
  ScopedPricingEditor({
    required this.api,
    required this.organizationId,
    required this.item,
    this.clientId,
  });

  final ApiMethod api;
  final String organizationId;
  final NDISItem item;
  final String? clientId;
  final Map<bool, PricingDraft> drafts = {};
  Map<String, dynamic>? caps;
  double fallback = 50;
  bool clientScope = false;

  PricingDraft get draft => drafts[clientScope]!;
  bool get hasUnsavedChanges => drafts.values.any((draft) => draft.isDirty);

  Future<void> load() async {
    final results = await Future.wait([
      api.getPricingLookup(organizationId, item.itemNumber),
      if (clientId != null)
        api.getPricingLookup(
          organizationId,
          item.itemNumber,
          clientId: clientId,
        ),
    ]);
    if (results.any((result) => result == null)) {
      throw StateError('Pricing lookup unavailable');
    }
    fallback =
        positivePricingValue(await api.getFallbackBaseRate(organizationId)) ??
        50;
    final org = scopedPricing(results.first, clientId: null);
    final client = clientId == null
        ? null
        : scopedPricing(results.last, clientId: clientId);
    final rawCaps = results.last?['priceCaps'] ?? results.first?['priceCaps'];
    if (rawCaps is Map) caps = Map<String, dynamic>.from(rawCaps);
    drafts[false] = PricingDraft(org, fallback);
    if (clientId != null) drafts[true] = PricingDraft(client, fallback);
    clientScope = clientId != null;
  }

  Future<Map<String, dynamic>> save(String userEmail) async {
    final savingClientScope = clientScope;
    final savingDraft = draft;
    if (!savingDraft.validFor(item, caps))
      throw StateError('Invalid regional price');
    final price = savingDraft.price!;
    final targetClient = savingClientScope ? clientId : null;
    final lookup = await api.getPricingLookup(
      organizationId,
      item.itemNumber,
      clientId: targetClient,
    );
    if (lookup == null) throw StateError('Pricing lookup unavailable');
    final existing = scopedPricing(lookup, clientId: targetClient);
    final savedRegion = savingDraft.saved?['region'];
    final region = savingDraft.regionTouched
        ? savingDraft.region.name
        : savedRegion?.toString() ??
              (existing == null ? savingDraft.region.name : null);
    final id = existing?['_id']?.toString();
    final Map<String, dynamic> response;
    if (id != null && id.isNotEmpty) {
      response = await api.updateCustomPricing(
        pricingId: id,
        price: price,
        userEmail: userEmail,
        supportItemName: item.itemName,
        clientSpecific: savingClientScope,
        clientId: targetClient,
        region: region,
      );
    } else if (targetClient != null) {
      response = await api.saveClientCustomPricing(
        organizationId,
        targetClient,
        item.itemNumber,
        price,
        'fixed',
        userEmail,
        supportItemName: item.itemName,
        region: region,
      );
    } else {
      response = await api.saveAsCustomPricing(
        organizationId,
        item.itemNumber,
        price,
        'fixed',
        userEmail,
        supportItemName: item.itemName,
        region: region,
      );
    }
    if (response['success'] != true) throw StateError('Pricing save failed');
    final confirmed = scopedPricing(
      await api.getPricingLookup(
        organizationId,
        item.itemNumber,
        clientId: targetClient,
      ),
      clientId: targetClient,
    );
    if (confirmed == null ||
        confirmed['region'] != region ||
        (positivePricingValue(confirmed['price'])! - price).abs() > 0.001 ||
        confirmed['_id'] == null) {
      throw StateError('Pricing persistence confirmation failed');
    }
    savingDraft.accept(confirmed);
    return confirmed;
  }
}
