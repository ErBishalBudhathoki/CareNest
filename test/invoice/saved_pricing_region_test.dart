import 'package:carenest/app/core/providers/app_providers.dart' as app;
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations_en.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class RegionInvoiceApi extends ApiMethod {
  Map<String, dynamic>? clientPrice = {
    'price': 115.0,
    'source': 'client_specific',
    'region': 'veryRemote',
  };
  Map<String, dynamic>? orgPrice = {
    'customPrice': 80.0,
    'price': 80.0,
    'source': 'organization',
    'region': 'remote',
  };
  double? baseRate = 55;
  final requests = <List<Map<String, dynamic>>>[];

  @override
  Future<List<Map<String, dynamic>>> getAllSupportItems() async => [];

  @override
  Future<double?> getFallbackBaseRate(String organizationId) async => baseRate;

  @override
  Future<Map<String, dynamic>?> getPricingLookup(
    String organizationId,
    String supportItemNumber, {
    String? clientId,
  }) async => clientId != null ? clientPrice ?? orgPrice : orgPrice;

  @override
  Future<Map<String, dynamic>?> getBulkPricingLookup(
    String organizationId,
    List<String> supportItemNumbers, {
    String? clientId,
  }) async => {
    for (final number in supportItemNumbers)
      if ((clientId != null ? clientPrice ?? orgPrice : orgPrice) != null)
        number: clientId != null ? clientPrice ?? orgPrice : orgPrice,
  };

  @override
  Future<Map<String, dynamic>> validateInvoicePricing({
    required List<Map<String, dynamic>> lineItems,
    String state = 'NSW',
    String providerType = 'standard',
  }) async {
    requests.add(
      lineItems.map((item) => Map<String, dynamic>.from(item)).toList(),
    );
    return {
      'success': true,
      'data': {
        'results': lineItems
            .map(
              (item) => {
                'requestId': item['id'],
                'supportItemNumber': item['ndisItemNumber'],
                'isValid': item['region'] == 'veryRemote',
                'status': item['region'] == 'veryRemote'
                    ? 'valid'
                    : 'exceeds_cap',
                'priceCap': item['region'] == 'veryRemote' ? 160 : 100,
              },
            )
            .toList()
            .reversed
            .toList(),
        'summary': {'validItems': 1, 'invalidItems': 1},
      },
    };
  }
}

Map<String, dynamic> assignments({bool worked = false}) {
  final schedule = {
    'date': '2026-05-20',
    'startTime': '08:00',
    'endTime': '10:00',
    'ndisItem': {
      'itemNumber': '01_011_0107_1_1',
      'itemName': 'Weekday support',
      'highIntensity': true,
    },
  };
  return {
    'clients': [
      {
        'clientId': 'client-1',
        'clientEmail': 'client@example.com',
        'assignments': [
          {
            'clientEmail': 'client@example.com',
            'dateList': ['2026-05-20'],
            'startTimeList': ['08:00'],
            'endTimeList': ['10:00'],
            'Time': ['2'],
            'schedule': [schedule],
          },
        ],
        if (worked)
          'workedTimeData': {
            'success': true,
            'workedTimes': [
              {'actualWorkedTime': 2.0, 'correspondingSchedule': schedule},
            ],
          },
      },
    ],
  };
}

void main() {
  late RegionInvoiceApi api;
  late ProviderContainer container;
  setUp(() {
    api = RegionInvoiceApi();
    container = ProviderContainer(
      overrides: [app.apiMethodProvider.overrideWithValue(api)],
    );
  });
  tearDown(() => container.dispose());

  for (final worked in [false, true]) {
    test(
      'saved client region survives ${worked ? "worked" : "scheduled"} repeat generation and validation',
      () async {
        final processor = container.read(invoiceDataProcessorProvider);
        final service = container.read(enhancedInvoiceServiceProvider);
        processor.setEnhancedInvoiceService(service);
        for (var repeat = 0; repeat < 2; repeat++) {
          final data = await processor.processInvoiceData(
            assignedClients: assignments(worked: worked),
            lineItems: [],
            organizationId: 'org-1',
            invoiceType: 'client',
          );
          final item = data['clients'][0]['items'][0] as Map<String, dynamic>;
          expect(item['rate'], 115);
          expect(item['region'], 'veryRemote');
          final prompts = await service.testCheckForMissingPrices(
            data,
            organizationId: 'org-1',
            l10n: AppLocalizationsEn(),
          );
          expect(prompts, isEmpty);
          expect(item['rate'], 115);
          expect(item['price'], 115);
          expect(item['region'], 'veryRemote');
          expect(item['isCompliant'], isTrue);
          expect(item['metadata']['validation']['isValid'], isTrue);
          expect(api.requests.last.single['region'], 'veryRemote');
          expect(api.requests.last.single['unitPrice'], 115);
          expect(
            api.requests.last.single['serviceDate'],
            startsWith('2026-05-20'),
          );
          expect(api.requests.last.single['ndisItemNumber'], '01_011_0107_1_1');
        }
      },
    );
  }

  test(
    'organization price carries its own region and legacy has none',
    () async {
      api.clientPrice = null;
      final processor = container.read(invoiceDataProcessorProvider);
      for (final region in ['remote', null]) {
        api.orgPrice = {
          'price': 80.0,
          'source': 'organization',
          'region': ?region,
        };
        final data = await processor.processInvoiceData(
          assignedClients: assignments(),
          lineItems: [],
          organizationId: 'org-1',
        );
        final item = data['clients'][0]['items'][0] as Map<String, dynamic>;
        expect(item['rate'], 80);
        expect(item['region'], region);
        expect(item.containsKey('region'), region != null);
      }
    },
  );

  test(
    'configured base then 50 fallback never inherits custom region',
    () async {
      api.clientPrice = null;
      api.orgPrice = null;
      final processor = container.read(invoiceDataProcessorProvider);
      for (final base in [55.0, null]) {
        api.baseRate = base;
        final data = await processor.processInvoiceData(
          assignedClients: assignments(),
          lineItems: [],
          organizationId: 'org-1',
        );
        final item = data['clients'][0]['items'][0] as Map<String, dynamic>;
        expect(item['rate'], base ?? 50);
        expect(item.containsKey('region'), isFalse);
      }
    },
  );

  test('validation uses per-row identity for repeated item numbers', () async {
    final service = container.read(enhancedInvoiceServiceProvider);
    final items = [
      {
        'id': 'row-a',
        'ndisItemNumber': '01_011_0107_1_1',
        'rate': 115.0,
        'hours': 2.0,
        'date': '20/05/2026',
        'region': 'veryRemote',
      },
      {
        'id': 'row-b',
        'ndisItemNumber': '01_011_0107_1_1',
        'rate': 115.0,
        'hours': 3.0,
        'date': '21/05/2026',
        'pricingMetadata': {'region': 'remote'},
      },
    ];
    await service.testCheckForMissingPrices(
      {
        'clients': [
          {'clientId': 'client-1', 'items': items},
        ],
      },
      organizationId: 'org-1',
      l10n: AppLocalizationsEn(),
    );
    expect(api.requests.single, hasLength(2));
    expect(items[0]['isCompliant'], isTrue);
    expect(items[1]['isCompliant'], isFalse);
    expect(items[1]['exceedsPriceCap'], isTrue);
    expect(api.requests.single[1]['serviceDate'], startsWith('2026-05-21'));
    expect(api.requests.single[1]['region'], 'remote');
  });
}
