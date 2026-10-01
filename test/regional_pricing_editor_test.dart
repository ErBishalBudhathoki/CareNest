import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/pricing/viewmodels/scoped_pricing_editor.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';

NDISItem item({
  String name = 'Support',
  String group = '0107',
  Map<PriceRegion, double?>? caps,
}) => NDISItem(
  itemNumber: '01_001_${group}_1_1',
  itemName: name,
  supportCategoryNumber: '',
  supportCategoryName: '',
  registrationGroupNumber: group,
  registrationGroupName: '',
  unit: 'H',
  type: '',
  isQuotable: false,
  regionalPrices:
      caps ??
      {
        PriceRegion.national: 80,
        PriceRegion.remote: 120,
        PriceRegion.veryRemote: 160,
      },
  supportPurposeId: '',
  generalCategory: '',
);

class PricingApi extends ApiMethod {
  Map<String, dynamic>? org = {
    '_id': 'org-price',
    'source': 'organization',
    'clientSpecific': false,
    'price': 60.0,
    'region': 'remote',
  };
  Map<String, dynamic>? client;
  final calls = <String>[];
  @override
  Future<double?> getFallbackBaseRate(String organizationId) async => 55;
  @override
  Future<Map<String, dynamic>?> getPricingLookup(
    String organizationId,
    String supportItemNumber, {
    String? clientId,
  }) async => {
    ...?(clientId == null ? org : client ?? org),
    'priceCaps': {'national': 80, 'remote': 120, 'veryRemote': 160},
  };
  @override
  Future<Map<String, dynamic>> updateCustomPricing({
    required String pricingId,
    double? price,
    String pricingType = 'fixed',
    required String userEmail,
    String? supportItemName,
    double? multiplier,
    String? clientId,
    bool? clientSpecific,
    String? region,
  }) async {
    calls.add('update:$pricingId:$region');
    final value = {
      '_id': pricingId,
      'price': price,
      'clientSpecific': clientSpecific,
      'clientId': clientId,
      'region': region,
    };
    if (clientSpecific == true) {
      client = value;
    } else {
      org = value;
    }
    return {'success': true, 'data': value};
  }

  @override
  Future<Map<String, dynamic>> saveClientCustomPricing(
    String organizationId,
    String clientId,
    String supportItemNumber,
    double price,
    String pricingType,
    String userEmail, {
    String? supportItemName,
    String? region,
  }) async {
    calls.add('create:client:$region');
    client = {
      '_id': 'client-price',
      'price': price,
      'clientSpecific': true,
      'clientId': clientId,
      'region': region,
    };
    return {'success': true, 'data': client};
  }
}

void main() {
  test('intensity classification never selects geography', () {
    final standard = item();
    final high = item(name: 'High Intensity Support');
    expect(isHighIntensityPricingItem(standard), false);
    expect(isHighIntensityPricingItem(high), true);
    expect(isHighIntensityPricingItem(item(group: '0104')), true);
    for (final region in pricingRegions) {
      expect(
        regionalPricingCap(high, region),
        regionalPricingCap(standard, region),
      );
    }
    expect(regionalPricingCap(high, PriceRegion.national), 80);
  });
  test(
    'all tier filters use only exact caps including sparse bundled fallback',
    () {
      for (final available in pricingRegions) {
        final sparse = item(caps: {available: 100});
        for (final requested in pricingRegions) {
          expect(
            regionalPricingCap(sparse, requested, caps: {'national': null}),
            available == requested ? 100 : null,
          );
        }
      }
      final empty = item(caps: {});
      for (final region in pricingRegions) {
        expect(
          regionalPricingCap(empty, region, caps: {'highIntensity': 200}),
          null,
        );
      }
      expect(
        regionalPricingCap(item(), PriceRegion.remote, caps: {'remote': 130}),
        130,
      );
      expect(
        regionalPricingCap(
          item(caps: {PriceRegion.national: 80}),
          PriceRegion.remote,
        ),
        null,
      );
    },
  );
  test('draft fallback is base rate, and missing cap never synthetic', () {
    final draft = PricingDraft(null, 50);
    expect(draft.price, 50);
    expect(draft.isDirty, false);
    draft.priceText = 'NaN';
    expect(draft.isDirty, true);
    expect(draft.validFor(item(), null), false);
    draft.priceText = '50';
    expect(draft.validFor(item(caps: {}), null), false);
  });
  test('lookup preserves id and region without inheriting another scope', () {
    final lookup = {
      '_id': 'org',
      'source': 'organization',
      'price': 65,
      'region': 'veryRemote',
    };
    expect(scopedPricing(lookup, clientId: 'client'), null);
    expect(scopedPricing(lookup, clientId: null)?['_id'], 'org');
    expect(scopedPricing(lookup, clientId: null)?['region'], 'veryRemote');
    expect(
      scopedPricing({'source': 'ndis_default', 'price': 160}, clientId: null),
      null,
    );
    expect(
      scopedPricing({
        '_id': 'x',
        'source': 'fallback',
        'price': 160,
      }, clientId: null),
      null,
    );
  });
  test(
    'editor restores scopes independently, creates client and updates by id',
    () async {
      final api = PricingApi();
      final editor = ScopedPricingEditor(
        api: api,
        organizationId: 'org',
        item: item(),
        clientId: 'client',
      );
      await editor.load();
      expect(editor.draft.price, 55);
      expect(editor.draft.region, PriceRegion.national);
      editor.draft.priceText = '140';
      editor.draft.region = PriceRegion.veryRemote;
      editor.clientScope = false;
      expect(editor.draft.price, 60);
      expect(editor.draft.region, PriceRegion.remote);
      editor.draft.priceText = '100';
      editor.clientScope = true;
      expect(editor.draft.price, 140);
      await editor.save('test@example.invalid');
      expect(api.calls, ['create:client:veryRemote']);
      expect(api.org?['price'], 60);
      expect(editor.hasUnsavedChanges, true);
      editor.clientScope = false;
      await editor.save('test@example.invalid');
      expect(api.calls.last, 'update:org-price:remote');
      expect(editor.hasUnsavedChanges, false);
      final reload = ScopedPricingEditor(
        api: api,
        organizationId: 'org',
        item: item(),
        clientId: 'client',
      );
      await reload.load();
      expect(reload.draft.price, 140);
      expect(reload.draft.region, PriceRegion.veryRemote);
      reload.draft.priceText = '150';
      await reload.save('test@example.invalid');
      expect(api.calls.last, 'update:client-price:veryRemote');
      reload.clientScope = false;
      expect(reload.draft.price, 100);
      expect(reload.draft.region, PriceRegion.remote);
    },
  );
  test('invalid draft cannot save above selected cap', () async {
    final api = PricingApi();
    final editor = ScopedPricingEditor(
      api: api,
      organizationId: 'org',
      item: item(),
    );
    await editor.load();
    editor.draft.region = PriceRegion.national;
    editor.draft.priceText = '100';
    await expectLater(editor.save('test@example.invalid'), throwsStateError);
    expect(api.calls, isEmpty);
  });
}
