import 'dart:io';

import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The leave request form opened Material's `showDateRangePicker`, which draws
/// a stadium-shaped range highlight and circular day cells, both against
/// DESIGN.md's zero-radius rule.
///
/// It now opens `showBauhausDateRangePicker`, the picker schedule assignment
/// already uses. Theming Material's picker with `DatePickerTheme` would have
/// squared the day cells but not the range band, so replacing the picker was
/// the only route to a fully square calendar.
void main() {
  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  }

  Future<void> open(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () => showBauhausDateRangePicker(
                  context: context,
                  initialStart: DateTime.now(),
                  initialEnd: DateTime.now().add(const Duration(days: 4)),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('the Bauhaus range picker opens from a plain context', (
    tester,
  ) async {
    await open(tester);
    expect(
      tester.takeException(),
      isNull,
      reason:
          'the picker overflowed by 7px and 17px at 390 wide before its two '
          'unwrapped Rows were made Flexible',
    );
    // The dialog rendered: its own confirm action is the marker.
    expect(find.text('CONFIRM PERIOD'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('the picker draws no rounded geometry', (tester) async {
    await open(tester);

    var rounded = <String>[];
    var circles = <String>[];

    for (final e in find.byType(Container).evaluate()) {
      final d = (e.widget as Container).decoration;
      if (d is! BoxDecoration) continue;
      if (d.shape == BoxShape.circle) {
        // DESIGN.md sanctions circles only for minute functional indicators,
        // and the today marker is a 4px dot.
        final size = e.size;
        if (size != null && (size.width > 12 || size.height > 12)) {
          circles.add('circle ${size.width}x${size.height}');
        }
        continue;
      }
      final b = d.borderRadius;
      if (b != null && b != BorderRadius.zero) {
        final size = e.size;
        if (size != null && (size.width > 12 || size.height > 12)) {
          rounded.add(
            'rounded ${size.width.toStringAsFixed(0)}x'
            '${size.height.toStringAsFixed(0)}',
          );
        }
      }
    }

    expect(
      rounded,
      isEmpty,
      reason:
          'DESIGN.md forbids rounded geometry outside avatars and minute '
          'indicators, but the picker painted:\n${rounded.join('\n')}',
    );
    expect(
      circles,
      isEmpty,
      reason:
          'the only circles allowed are the small today-dot indicators, '
          'but the picker painted:\n${circles.join('\n')}',
    );
    await dispose(tester);
  });

  test('the picker source uses no rounded shape constants', () {
    const file =
        'lib/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
    final src = File(file).readAsStringSync();
    expect(
      RegExp(r'BorderRadius\.circular').allMatches(src).isEmpty,
      isTrue,
      reason: 'no BorderRadius.circular anywhere in the Bauhaus picker',
    );
    expect(
      RegExp(
        r'CircleBorder|StadiumBorder|RoundedRectangleBorder',
      ).allMatches(src).isEmpty,
      isTrue,
      reason: 'no border shapes that imply rounding',
    );
    // The two circles that do exist must both be the 4px today marker.
    final circles = RegExp(r'shape: BoxShape\.circle').allMatches(src).length;
    expect(
      circles,
      2,
      reason: 'only the two single-date and range today-dots may be circular',
    );
  });

  test('the leave request form uses the Bauhaus picker', () {
    const file = 'lib/app/features/leave/views/leave_request_form.dart';
    final src = File(file).readAsStringSync();
    expect(
      src.contains('showBauhausDateRangePicker'),
      isTrue,
      reason: 'the leave form must use the Bauhaus range picker',
    );
    expect(
      src.contains('showDateRangePicker('),
      isFalse,
      reason:
          'Material\'s showDateRangePicker draws a stadium-shaped range '
          'highlight and circular day cells',
    );
    expect(
      src.contains('bauhaus_date_range_picker.dart'),
      isTrue,
      reason: 'the import should point at the picker schedule assignment uses',
    );
  });

  test('schedule assignment and the leave form share one picker', () {
    // Both should resolve to the same file, so a fix to the picker reaches both.
    const picker = 'features/invoice/widgets/bauhaus_date_range_picker.dart';
    for (final f in <String>[
      'lib/app/features/Appointment/views/schedule_assignment.dart',
      'lib/app/features/leave/views/leave_request_form.dart',
    ]) {
      expect(
        File(f).readAsStringSync().contains(picker),
        isTrue,
        reason: '$f should import the shared Bauhaus picker',
      );
    }
  });
}
