import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/assignment/views/enhanced_ndis_item_selection_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectorPricingApi extends ApiMethod {
  final updates = <Map<String, dynamic>>[];

  final Map<String, dynamic> org = {
    '_id': 'org-price',
    'source': 'organization',
    'clientSpecific': false,
    'price': 60.0,
    'region': 'remote',
  };

  final Map<String, dynamic> client = {
    '_id': 'client-price',
    'source': 'client_specific',
    'clientSpecific': true,
    'clientId': 'client-1',
    'price': 95.0,
    'region': 'veryRemote',
  };

  Map<String, dynamic> lookup({String? clientId}) => {
    ...(clientId == null ? org : client),
    'priceCaps': {'national': 80.0, 'remote': 120.0, 'veryRemote': 160.0},
  };

  @override
  Future<List<Map<String, dynamic>>> getAllSupportItems() async => [
    {
      'Support Item Number': '01_001_0107_1_1',
      'Support Item Name': 'Assist Personal Activities',
      'Support Category Number': '01',
      'Support Category Name': 'Assistance',
      'Registration Group Number': '0107',
      'Registration Group Name': 'Daily Personal Activities',
      'Unit': 'H',
      'Type': 'Priced Supports',
      'Quote': 'No',
      'isLegacy': false,
      'National': 80,
      ' ACT ': 80,
      ' Remote ': 120,
      ' Very Remote ': 160,
    },
  ];

  @override
  Future<double?> getFallbackBaseRate(String organizationId) async => 55;

  @override
  Future<Map<String, dynamic>?> getBulkPricingLookupResponse(
    String organizationId,
    List<String> supportItemNumbers, {
    String? clientId,
  }) async => {
    'data': {
      for (final number in supportItemNumbers)
        number: lookup(clientId: clientId),
    },
    'metadata': {'fallbackBaseRate': 55},
  };

  @override
  Future<Map<String, dynamic>?> getPricingLookup(
    String organizationId,
    String supportItemNumber, {
    String? clientId,
  }) async => lookup(clientId: clientId);

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
    updates.add({
      'id': pricingId,
      'price': price,
      'region': region,
      'clientId': clientId,
    });
    org['price'] = price;
    org['region'] = region;
    return {'success': true, 'data': Map<String, dynamic>.from(org)};
  }
}

Future<void> pumpSelector(WidgetTester tester, SelectorPricingApi api) async {
  tester.view.physicalSize = const Size(800, 1400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  SharedPreferences.setMockInitialValues({
    'userEmail': 'tester@example.com',
    'organizationId': 'org-1',
  });
  await tester.pumpWidget(
    ProviderScope(
      overrides: [app_providers.apiMethodProvider.overrideWithValue(api)],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: const EnhancedNdisItemSelectionView(
          organizationId: 'org-1',
          clientId: 'client-1',
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> openOverride(WidgetTester tester) async {
  await tester.tap(find.byTooltip('Set custom price'));
  await tester.pumpAndSettle();
  await tester.ensureVisible(
    find.text('Enable custom price for this support item'),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Enable custom price for this support item'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('effective price stays client-first while editing org scope', (
    tester,
  ) async {
    final api = SelectorPricingApi();
    await pumpSelector(tester, api);

    expect(find.text('\$95.00/hr'), findsOneWidget);
    expect(find.text('Client Custom Price'), findsOneWidget);

    await openOverride(tester);
    expect(find.text('CLIENT-SPECIFIC'), findsOneWidget);
    expect(find.text('95.00'), findsOneWidget);
    expect(find.text('\$160.00/hr'), findsOneWidget);

    await tester.tap(find.text('ORG PRICE'));
    await tester.pumpAndSettle();

    expect(find.text('ORG-WIDE'), findsOneWidget);
    expect(find.text('60.00'), findsOneWidget);
    expect(find.text('\$120.00/hr'), findsOneWidget);
    expect(find.text('\$95.00/hr'), findsWidgets);
  });

  testWidgets('exact regional cap blocks invalid save and passes region', (
    tester,
  ) async {
    final api = SelectorPricingApi();
    await pumpSelector(tester, api);

    await openOverride(tester);
    await tester.tap(find.text('ORG PRICE'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remote'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('National').last);
    await tester.pumpAndSettle();
    expect(find.text('\$80.00/hr'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '90.00');
    await tester.pump();
    expect(find.text('Price exceeds NDIS cap'), findsOneWidget);
    final blocked = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'SAVE ORG PRICE'),
    );
    expect(blocked.onPressed, isNull);

    await tester.enterText(find.byType(TextFormField), '50.00');
    await tester.pump();
    expect(find.text('Price exceeds NDIS cap'), findsNothing);
    await tester.tap(find.text('SAVE ORG PRICE'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(api.updates, hasLength(1));
    expect(api.updates.single['id'], 'org-price');
    expect(api.updates.single['price'], 50.0);
    expect(api.updates.single['region'], 'national');
    expect(find.text('Organization custom price saved'), findsOneWidget);
    expect(find.text('\$95.00/hr'), findsOneWidget);
  });

  testWidgets('unsaved draft guards item selection', (tester) async {
    final api = SelectorPricingApi();
    await pumpSelector(tester, api);

    await openOverride(tester);
    await tester.enterText(find.byType(TextFormField), '70.00');
    await tester.pump();

    await tester.tap(find.text('Assist Personal Activities'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(
      find.text(
        'Save or discard your price changes before selecting this item.',
      ),
      findsOneWidget,
    );
    expect(find.byType(EnhancedNdisItemSelectionView), findsOneWidget);
  });
}
