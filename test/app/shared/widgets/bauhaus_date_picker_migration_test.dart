import 'dart:io';

import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every Material date picker in lib/ has been moved onto the Bauhaus picker in
/// features/invoice/widgets/bauhaus_date_range_picker.dart, the one schedule
/// assignment has always used.
///
/// Material's `showDatePicker` and `showDateRangePicker` draw circular day cells
/// and a stadium-shaped range highlight, all against DESIGN.md's zero-radius
/// rule. Theming them with DatePickerTheme squares the cells but not the range
/// band, so the only route to a fully square calendar is to replace the picker.
///
/// The single-date Bauhaus picker is exercised here because the 17 migrated
/// call sites sit behind navigation and providers that a widget test cannot
/// reach; the shared picker is what they all resolve to.
const _pickerPath =
    'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';

void main() {
  /// Every .dart under lib/, generated parts excluded.
  List<File> dartSources() => Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  /// Walks lib/ and returns every file still calling a Material picker.
  List<String> materialPickerCallers() {
    final out = <String>[];
    for (final f in dartSources()) {
      final src = f.readAsStringSync();
      for (final m in RegExp(
        r'\b(showDateRangePicker|showDatePicker)\(',
      ).allMatches(src)) {
        // The helper's own declarations are not call sites.
        final line = src.substring(0, m.start).split('\n').last;
        if (line.trimLeft().startsWith('Future<') ||
            line.contains('Future<DateTime')) {
          continue;
        }
        out.add('${f.path}: ${m.group(1)}()');
      }
    }
    return out;
  }

  test('no view calls a Material date picker any more', () {
    final callers = materialPickerCallers();
    expect(
      callers,
      isEmpty,
      reason:
          'these still open Material\'s rounded picker. Use '
          'showBauhausDatePicker or showBauhausDateRangePicker from '
          '$_pickerPath:\n${callers.join('\n')}',
    );
  });

  test('every migrated view imports the shared Bauhaus picker', () {
    // A mechanical call-site rewrite can compile while the import is missing
    // from a file, so the import is asserted rather than inferred.
    final missing = <String>[];
    for (final f in dartSources()) {
      final src = f.readAsStringSync();
      if (!src.contains('showBauhausDatePicker(') &&
          !src.contains('showBauhausDateRangePicker(')) {
        continue;
      }
      if (f.path.endsWith('bauhaus_date_range_picker.dart')) continue;
      if (!src.contains(_pickerPath)) {
        missing.add(f.path);
      }
    }
    expect(
      missing,
      isEmpty,
      reason:
          'these call the Bauhaus picker without importing $_pickerPath:\n'
          '${missing.join('\n')}',
    );
  });

  test('the Bauhaus picker is the single source of the range dialog', () {
    // schedule assignment, the leave form and the 15 migrated views all have to
    // resolve to the same file, or a fix to the picker reaches only some of them.
    final users = dartSources()
        .where((f) => !f.path.endsWith('bauhaus_date_range_picker.dart'))
        .where((f) => f.readAsStringSync().contains(_pickerPath))
        .length;
    expect(
      users,
      greaterThanOrEqualTo(15),
      reason: 'expected the picker to be shared widely, found $users files',
    );
  });

  testWidgets('the single-date Bauhaus picker opens and returns a DateTime', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    DateTime? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () async {
                  result = await showBauhausDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 3650),
                    ),
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(
      tester.takeException(),
      isNull,
      reason:
          'the picker must lay out without a RenderFlex overflow at 390 wide',
    );
    expect(find.textContaining('CONFIRM'), findsWidgets);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('the picker returns a range for the range variant', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    DateTimeRange? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: BauhausDesign.lightTheme,
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: ElevatedButton(
                onPressed: () async {
                  result = await showBauhausDateRangePicker(
                    context: context,
                    initialStart: DateTime.now(),
                    initialEnd: DateTime.now().add(const Duration(days: 3)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('CONFIRM PERIOD'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });
}
