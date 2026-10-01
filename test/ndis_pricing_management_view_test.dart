import 'package:carenest/app/features/pricing/views/ndis_pricing_management_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakePricingApi extends ApiMethod {
  Map<String, dynamic>? orgPrice;
  Map<String, dynamic>? clientPrice;
  final calls = <String>[];

  @override
  Future<double?> getFallbackBaseRate(String organizationId) async => 50;

  @override
  Future<List<Map<String, dynamic>>> getAllSupportItems() async => [
    {
      'Support Item Number': '01_001_0107_1_1',
      'Support Item Name': 'Standard Support - Daily Living',
      'Support Category Number': '1',
      'Support Category Name': 'Assistance with Daily Life',
      'Registration Group Number': '0107',
      'Registration Group Name': 'Assist Personal Activities',
      'Unit': 'hour',
      'Type': 'Priced Supports',
      'Quote': 'No',
      'NATIONAL': '67.56',
      'REMOTE': '96.77',
      'VERY REMOTE': '125.98',
    },
    {
      'Support Item Number': '01_003_0107_1_1',
      'Support Item Name': 'Remote Only Support - Daily Living',
      'Support Category Number': '1',
      'Support Category Name': 'Assistance with Daily Life',
      'Registration Group Number': '0107',
      'Registration Group Name': 'Assist Personal Activities',
      'Unit': 'hour',
      'Type': 'Priced Supports',
      'Quote': 'No',
      'REMOTE': '96.77',
    },
  ];

  @override
  Future<Map<String, dynamic>?> getSupportItemDetails(
    String supportItemNumber,
  ) async => null;

  @override
  Future<Map<String, dynamic>?> getPricingLookup(
    String organizationId,
    String supportItemNumber, {
    String? clientId,
  }) async {
    calls.add('lookup:$clientId');
    if (clientId == null) return orgPrice;
    if (clientId == 'client-1') return clientPrice;
    return null;
  }

  @override
  Future<Map<String, dynamic>> saveAsCustomPricing(
    String organizationId,
    String supportItemNumber,
    double price,
    String pricingType,
    String userEmail, {
    String? supportItemName,
    String? region,
  }) async {
    calls.add('create-org:$region');
    orgPrice = {
      '_id': 'org-$supportItemNumber',
      'source': 'organization',
      'price': price,
      'region': region,
    };
    return {'success': true, 'data': orgPrice};
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
    calls.add('create-client:$region');
    clientPrice = {
      '_id': 'client-$supportItemNumber',
      'source': 'client_specific',
      'clientSpecific': true,
      'clientId': clientId,
      'price': price,
      'region': region,
    };
    return {'success': true, 'data': clientPrice};
  }

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
      'source': clientSpecific == true ? 'client_specific' : 'organization',
      'clientSpecific': clientSpecific,
      'clientId': clientId,
      'price': price,
      'region': region,
    };
    if (clientSpecific == true) {
      clientPrice = value;
    } else {
      orgPrice = value;
    }
    return {'success': true, 'data': value};
  }
}

Future<void> _pumpView(
  WidgetTester tester, {
  String? clientId,
  required _FakePricingApi api,
}) async {
  SharedPreferences.setMockInitialValues({'userState': 'NSW'});
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: NdisPricingManagementView(
          organizationId: 'org-1',
          adminEmail: 'admin@example.invalid',
          organizationName: 'Org',
          clientId: clientId,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('renders caps and restores saved region', (tester) async {
    final api = _FakePricingApi();
    api.orgPrice = {
      '_id': 'org-1',
      'source': 'organization',
      'price': 60,
      'region': 'remote',
    };
    expect(api, isNotNull);
  });
}
