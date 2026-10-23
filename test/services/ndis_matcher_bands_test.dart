import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/features/invoice/utils/ndis_time_band_splitter.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';

class _EmptySupportItemsApi extends ApiMethod {
  @override
  Future<List<Map<String, dynamic>>> getAllSupportItems() async => [];
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('NDIS matcher uses 06:00/20:00 time bands', () async {
    final matcher = NDISMatcher(apiMethod: _EmptySupportItemsApi());
    await matcher.loadItems();
    expect(matcher.items, isNotEmpty);

    NDISItem? matchAt(int hour) => matcher.findBestMatch(
      shiftStart: DateTime(2026, 6, 1, hour), // Monday
      dynamicHolidays: const [],
      preferredSupportCategoryNumber: '1',
      preferredRegistrationGroupNumber: '107',
    );

    expect(matchAt(15)?.itemName.toLowerCase(), contains('weekday daytime'));
    expect(matchAt(21)?.itemName.toLowerCase(), contains('weekday evening'));
    expect(matchAt(1)?.itemName.toLowerCase(), contains('weekday night'));
  });

  test(
    'a public holiday from the merged calendar wins over the weekday band',
    () async {
      final matcher = NDISMatcher(apiMethod: _EmptySupportItemsApi());
      await matcher.loadItems();

      final match = matcher.findBestMatch(
        shiftStart: DateTime(2026, 6, 1, 15),
        dynamicHolidays: const ['2026-06-01'],
        preferredSupportCategoryNumber: '1',
        preferredRegistrationGroupNumber: '107',
      );
      expect(match?.itemName.toLowerCase(), contains('public holiday'));
    },
  );

  test('a 15:00–23:00 shift splits into daytime and evening items', () async {
    final matcher = NDISMatcher(apiMethod: _EmptySupportItemsApi());
    await matcher.loadItems();

    final baseItem = matcher.findBestMatch(
      shiftStart: DateTime(2026, 6, 1, 15),
      dynamicHolidays: const [],
      preferredSupportCategoryNumber: '1',
      preferredRegistrationGroupNumber: '107',
    );
    expect(baseItem, isNotNull);

    final windows = NdisTimeBandSplitter(matcher).split(
      start: DateTime(2026, 6, 1, 15),
      end: DateTime(2026, 6, 1, 23),
      totalHours: 8,
      holidays: const {},
      fallbackItem: baseItem,
    );

    expect(windows, hasLength(2));
    expect(
      windows[0].item?.itemName.toLowerCase(),
      contains('weekday daytime'),
    );
    expect(
      windows[1].item?.itemName.toLowerCase(),
      contains('weekday evening'),
    );
    expect(windows.fold<double>(0, (sum, window) => sum + window.hours), 8);
  });
}
