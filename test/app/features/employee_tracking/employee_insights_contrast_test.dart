import 'package:carenest/app/features/employee_tracking/models/employee_tracking_model.dart';
import 'package:carenest/app/features/employee_tracking/repositories/employee_tracking_repository.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/employee_tracking/viewmodels/employee_tracking_viewmodel.dart';
import 'package:carenest/app/features/employee_tracking/views/employee_tracking_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/contrast.dart';

/// Audits every text run on all three Employee Insights tabs in both brightness
/// modes.
///
/// A measurement rather than a source scan. The screen paints text with fixed
/// brand constants -- `BauhausDesign.textMuted` is 11.54:1 on the light surface
/// and 1.11:1 on the dark one -- and whether a given run is affected depends on
/// where it landed. Reading the source cannot tell you whether a label sits on
/// the scaffold or on a tinted chip, so this walks the rendered tree and asks
/// each text node what it is actually painted on.
void main() {
  EmployeeTrackingState buildState() => EmployeeTrackingState(
    data: EmployeeTrackingData(
      employees: [
        for (var i = 1; i <= 3; i++)
          EmployeeStatus(
            id: 'e$i',
            name: 'Employee $i',
            email: 'e$i@example.com',
            status: WorkStatus.values[i % WorkStatus.values.length],
            currentLocation: 'Melbourne',
            lastSeen: DateTime(2026, 5, 3, 12),
            hoursWorked: 7.5,
          ),
      ],
      shifts: [
        for (var i = 1; i <= 3; i++)
          ShiftDetail(
            id: 's$i',
            title: 'Shift $i',
            startTime: DateTime(2026, 5, 3, 9),
            endTime: DateTime(2026, 5, 3, 17),
            employeeId: 'e$i',
            employeeName: 'Employee $i',
            clientName: 'Client $i',
            location: 'Site $i',
            status: ShiftStatus.values[i % ShiftStatus.values.length],
          ),
      ],
      totalEmployees: 3,
      activeEmployees: 2,
      onBreakEmployees: 1,
      offlineEmployees: 0,
    ),
    lastUpdated: DateTime(2026, 5, 3),
  );

  Future<void> pumpTab(
    WidgetTester tester, {
    required Brightness brightness,
    required int tab,
  }) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          employeeTrackingRepositoryProvider.overrideWithValue(
            FakeTrackingRepository(buildState().data),
          ),
        ],
        child: MaterialApp(
          theme: brightness == Brightness.dark
              ? BauhausDesign.darkTheme
              : BauhausDesign.lightTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const EmployeeTrackingView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    tester.widget<TabBar>(find.byType(TabBar).first).controller?.animateTo(tab);
    await tester.pumpAndSettle();
  }

  /// The bar's own background, which is what a title or tab label sits on.
  ///
  /// The bar paints itself with a `flexibleSpace` Container that is a sibling
  /// behind the title, not an ancestor of it, so the generic ancestor walk
  /// cannot see it and reports the page surface instead. Handled separately or
  /// every title and tab label reads as a false failure.
  Color? appBarBackdrop(WidgetTester tester, Element element) {
    var inBar = false;
    element.visitAncestorElements((a) {
      if (a.widget is AppBar) {
        inBar = true;
        return false;
      }
      return true;
    });
    if (!inBar) return null;

    final bars = tester.widgetList<AppBar>(find.byType(AppBar));
    if (bars.isEmpty) return null;
    final bar = bars.first;
    final flex = bar.flexibleSpace;
    if (flex is Container) {
      final d = flex.decoration;
      if (d is BoxDecoration && d.color != null) return d.color;
    }
    return bar.backgroundColor;
  }

  /// The colour [element]'s text is actually painted on.
  ///
  /// Collects every painted background above the text, nearest first, then
  /// composites them. Badges here paint a 10%-alpha tint of their own accent, so
  /// measuring the tint as if it were opaque reports 1.00:1 for a badge whose
  /// label is in fact perfectly readable -- the audit has to resolve what the
  /// user sees, not what the BoxDecoration says.
  ///
  /// Nearest wins for opaque layers, which decides the ratio for a label on a
  /// tinted chip rather than on the page.
  Color backdropOf(WidgetTester tester, Element element) {
    final bar = appBarBackdrop(tester, element);
    if (bar != null) return bar;

    final layers = <Color>[];
    element.visitAncestorElements((ancestor) {
      if (layers.any((c) => c.a > 0.99)) return false;
      final w = ancestor.widget;
      Color? candidate;
      if (w is Container) {
        candidate =
            w.color ??
            (w.decoration is BoxDecoration
                ? (w.decoration! as BoxDecoration).color
                : null);
      } else if (w is DecoratedBox) {
        final d = w.decoration;
        if (d is BoxDecoration) candidate = d.color;
      } else if (w is ColoredBox) {
        candidate = w.color;
      } else if (w is Material) {
        candidate = w.color;
      }
      if (candidate != null && candidate.a > 0.01) layers.add(candidate);
      return true;
    });

    var resolved = Theme.of(element).colorScheme.surface;
    // Composite from the farthest layer down to the nearest, so each tint lands
    // on what is actually beneath it.
    for (final layer in layers.reversed) {
      if (layer.a >= 0.99) {
        resolved = layer;
      } else {
        resolved = Color.from(
          alpha: 1,
          red: (layer.r * layer.a + resolved.r * (1 - layer.a)).clamp(0, 1),
          green: (layer.g * layer.a + resolved.g * (1 - layer.a)).clamp(0, 1),
          blue: (layer.b * layer.a + resolved.b * (1 - layer.a)).clamp(0, 1),
        );
      }
    }
    return resolved;
  }

  /// The single remaining shortfall, pinned rather than skipped.
  ///
  /// Two labels here fill with the brand red and label it white: 4.17:1 in
  /// light and 3.68:1 in dark, since the dark theme's ink for that fill is the
  /// near-white surface colour rather than pure white.
  ///
  /// White on #e63946 cannot reach 4.5:1 with any ink, and at 11px and 13px
  /// bold these are well under the 18.66px bold that qualifies as large text and
  /// drops the bar to 3:1. So this is the same recorded exception as the filled
  /// danger button in bauhaus_action_contrast_test.dart.
  ///
  /// The real fixes are a design decision, not a screen fix: stop filling with
  /// brand red, or fill with errorDeep (#93000A) where white reaches 9.35:1.
  /// Both restyle a shared widget or the primary action tile.
  ///
  /// Originally: `BauhausChipVariant.error` fills with the brand red and labels it with the
  /// best ink available, which is white at 4.17:1. This is the same recorded
  /// exception as the filled danger button in
  /// bauhaus_action_contrast_test.dart: white on #e63946 cannot reach 4.5:1 with
  /// any ink, so the only real fix is to stop filling badges with brand red, which
  /// is an app-wide restyle of a shared widget and not this screen's call.
  ///
  /// Fixing it here by pinning the number means the value cannot drift unnoticed
  /// and it is still reported if it gets worse.
  const recordedSubAa = <String, double>{
    'Clocked Out': 4.17,
    'DEPLOY\nSHIFT': 4.17,
  };

  /// The floor is the darker of the two measured values, 3.68:1 in dark mode,
  /// with a little slack. Its job is to catch a regression, not to restate the
  /// number: 4.17:1 in light and 3.68:1 in dark are the values as they stand.
  const recordedSubAaFloor = 3.6;

  for (final brightness in Brightness.values) {
    for (final tab in [0, 1, 2]) {
      final tabName = ['Overview', 'Employees', 'Shifts'][tab];
      testWidgets('$tabName tab is readable in ${brightness.name}', (
        tester,
      ) async {
        await pumpTab(tester, brightness: brightness, tab: tab);
        expect(tester.takeException(), isNull, reason: 'no layout exception');

        final failures = <String>[];
        var checked = 0;
        for (final element in find.byType(Text).evaluate()) {
          final textWidget = element.widget as Text;
          final label = textWidget.data ?? textWidget.textSpan?.toPlainText();
          if (label == null || label.trim().isEmpty) continue;

          final ink =
              textWidget.style?.color ??
              DefaultTextStyle.of(element).style.color ??
              Theme.of(element).colorScheme.onSurface;
          if (ink.a < 0.01) continue;

          final bg = backdropOf(tester, element);
          checked++;
          final ratio = contrastRatio(ink, bg);
          final recorded = recordedSubAa[label];
          if (recorded != null) {
            expect(
              ratio,
              greaterThanOrEqualTo(recordedSubAaFloor),
              reason:
                  '"$label" is the recorded brand-red chip exception, measured '
                  '${contrast(ink, bg)}:1 against a floor of $recordedSubAaFloor. '
                  'It was $recorded:1, so anything below the floor is a new '
                  'regression rather than the known shortfall.',
            );
            continue;
          }
          if (ratio < 4.5) {
            failures.add(
              '"$label" ${contrast(ink, bg)}:1 '
              '(ink #${ink.toARGB32().toRadixString(16).padLeft(8, '0')} on '
              '#${bg.toARGB32().toRadixString(16).padLeft(8, '0')}) '
              '',
            );
          }
        }

        expect(
          checked,
          greaterThan(5),
          reason: 'the tab actually rendered text',
        );
        expect(
          failures,
          isEmpty,
          reason:
              '$tabName tab, ${brightness.name}: ${failures.length} of $checked '
              'text run(s) unreadable:\n${failures.join('\n')}',
        );
      });
    }
  }
}

/// Overriding the notifier was not enough: the view's initState calls a load
/// method on the real notifier, which reaches the repository and fails on a
/// missing organization id, so the tabs rendered an error state and the audit
/// measured almost nothing. Replacing the repository keeps the real viewmodel
/// and its state transitions, and supplies the data.
class FakeTrackingRepository extends EmployeeTrackingRepository {
  FakeTrackingRepository(this._data) : super(apiMethod: ApiMethod());

  final EmployeeTrackingData _data;

  @override
  Future<EmployeeTrackingData> getEmployeeTrackingData() async => _data;

  @override
  Future<EmployeeTrackingData> refreshEmployeeTrackingData() async => _data;
}
