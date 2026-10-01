import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/pricing/constants/schads_rate_constants.dart';

void main() {
  group('SchadsRateConstants Data Integrity', () {
    test('Streams list should be derived from levelsForStream keys', () {
      expect(SchadsRateConstants.streams, isNotEmpty);
      expect(
        SchadsRateConstants.streams,
        containsAll(SchadsRateConstants.levelsForStream.keys),
      );
      expect(
        SchadsRateConstants.streams.length,
        SchadsRateConstants.levelsForStream.keys.length,
      );
    });

    test('All streams should have levels defined', () {
      for (final stream in SchadsRateConstants.streams) {
        final levels = SchadsRateConstants.levelsForStream[stream];
        expect(levels, isNotNull, reason: 'Stream "$stream" has null levels');
        expect(levels, isNotEmpty, reason: 'Stream "$stream" has empty levels');
      }
    });

    test(
      'getPayPoints should return valid points for known stream/level combinations',
      () {
        // Test Social & Community Services
        final sacsPoints = SchadsRateConstants.getPayPoints(
          'Social & Community Services',
          'Level 1',
        );
        expect(sacsPoints, isNotEmpty);
        expect(sacsPoints, contains('Pay Point 1'));

        // Test Home Care (Aged)
        final agedPoints = SchadsRateConstants.getPayPoints(
          'Home Care (Aged)',
          'Level 1',
        );
        expect(agedPoints, isNotEmpty);
        expect(agedPoints, contains('Introductory'));
      },
    );

    test('Rates map should contain keys for valid combinations', () {
      // Pick a few random combinations to verify
      const key1 = 'Social & Community Services - Level 1 - Pay Point 1';
      expect(SchadsRateConstants.rates.containsKey(key1), isTrue);

      const key2 = 'Home Care (Aged) - Level 1 - Introductory';
      expect(SchadsRateConstants.rates.containsKey(key2), isTrue);
    });
  });
}
