import 'package:carenest/app/features/invoice/utils/ndis_time_band_splitter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NdisTimeBandSplitter.windows', () {
    test('weekday day shift stays in one window', () {
      final windows = NdisTimeBandSplitter.windows(
        DateTime(2026, 6, 1, 9),
        DateTime(2026, 6, 1, 17),
      );
      expect(windows, hasLength(1));
      expect(windows.single.start, DateTime(2026, 6, 1, 9));
      expect(windows.single.end, DateTime(2026, 6, 1, 17));
    });

    test('15:00–23:00 splits into daytime and evening at 20:00', () {
      final windows = NdisTimeBandSplitter.windows(
        DateTime(2026, 6, 1, 15),
        DateTime(2026, 6, 1, 23),
      );
      expect(windows, hasLength(2));
      expect(windows[0].start, DateTime(2026, 6, 1, 15));
      expect(windows[0].end, DateTime(2026, 6, 1, 20));
      expect(windows[1].start, DateTime(2026, 6, 1, 20));
      expect(windows[1].end, DateTime(2026, 6, 1, 23));
    });

    test('overnight shift splits at midnight and 06:00', () {
      final windows = NdisTimeBandSplitter.windows(
        DateTime(2026, 6, 1, 22),
        DateTime(2026, 6, 2, 7),
      );
      expect(windows, hasLength(3));
      expect(windows[0].start, DateTime(2026, 6, 1, 22));
      expect(windows[0].end, DateTime(2026, 6, 2, 0));
      expect(windows[1].start, DateTime(2026, 6, 2, 0));
      expect(windows[1].end, DateTime(2026, 6, 2, 6));
      expect(windows[2].start, DateTime(2026, 6, 2, 6));
      expect(windows[2].end, DateTime(2026, 6, 2, 7));
    });

    test('early morning keeps the 06:00 boundary', () {
      final windows = NdisTimeBandSplitter.windows(
        DateTime(2026, 6, 1, 5),
        DateTime(2026, 6, 1, 21),
      );
      expect(windows, hasLength(3));
      expect(windows[0].end, DateTime(2026, 6, 1, 6));
      expect(windows[1].end, DateTime(2026, 6, 1, 20));
      expect(windows[2].start, DateTime(2026, 6, 1, 20));
    });

    test('windows cover the shift exactly once', () {
      final start = DateTime(2026, 6, 5, 21, 30);
      final end = DateTime(2026, 6, 7, 3, 15);
      final windows = NdisTimeBandSplitter.windows(start, end);
      expect(windows.first.start, start);
      expect(windows.last.end, end);
      for (var i = 1; i < windows.length; i++) {
        expect(windows[i].start, windows[i - 1].end);
      }
    });

    test('zero or reversed shifts produce no windows', () {
      final t = DateTime(2026, 6, 1, 9);
      expect(NdisTimeBandSplitter.windows(t, t), isEmpty);
      expect(
        NdisTimeBandSplitter.windows(
          DateTime(2026, 6, 1, 17),
          DateTime(2026, 6, 1, 9),
        ),
        isEmpty,
      );
    });
  });
}
