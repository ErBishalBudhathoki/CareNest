import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/providers/pricing_settings_providers.dart';
import 'package:carenest/app/features/invoice/viewmodels/pricing_settings_view_model.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Keeps the panel-title-to-first-card spacing identical across the Pricing
/// Configuration tabs.
///
/// The General Settings tab is the reference: a lone panel title, `space3`,
/// then its sections. Pricing Rules and Integrations used to differ, so their
/// first card sat visibly lower:
///
/// 1. Pricing Rules put a 36px action icon in the title `Row`. The row is
///    sized by that icon while the heading is 16px, so the heading floats
///    centred and leaves ~10px of dead band above the cards.
/// 2. Both tabs used `Expanded(ListView)` where General Settings uses a
///    `SingleChildScrollView` + `Column`, so their geometry could drift
///    independently.
///
/// This pumps the real widget and compares absolute positions, so a
/// reintroduced gap fails with actual numbers rather than a source heuristic.
class FakeVm extends PricingSettingsViewModel {
  FakeVm() : super(null);

  @override
  PricingSettingsState build() => PricingSettingsState(
    settings: ref.watch(defaultPricingSettingsProvider),
    isLoading: false,
  );
}

/// Panel title of each tab, in tab order.
const _headings = <String>[
  'GENERAL PRICING SETTINGS',
  'PRICING RULES',
  'SYSTEM INTEGRATIONS',
];

Future<void> _pumpTab(WidgetTester tester, int index) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        app_providers.apiMethodProvider.overrideWith((_) => ApiMethod()),
        pricingSettingsViewModelProvider.overrideWith(FakeVm.new),
      ],
      child: MaterialApp(
        theme: BauhausDesign.lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: PricingConfigurationView(
            adminEmail: 'a@b.com',
            organizationId: 'org',
            organizationName: 'Org',
          ),
        ),
      ),
    ),
  );
  for (var n = 0; n < 8; n++) {
    await tester.pump(const Duration(milliseconds: 150));
  }
  await _selectTab(tester, index);
}

/// Switches to `index`. The tab bar is scrollable, so later tabs sit outside
/// the viewport and have to be scrolled in before they can be tapped.
Future<void> _selectTab(WidgetTester tester, int index) async {
  final tab = find.byType(Tab).at(index);
  await tester.ensureVisible(tab);
  await tester.pump(const Duration(milliseconds: 150));
  await tester.tap(tab);
  for (var n = 0; n < 15; n++) {
    await tester.pump(const Duration(milliseconds: 150));
  }
}

/// Gap from the bottom of the panel title to the top of the first card.
double _headingToCardGap(WidgetTester tester, int index) {
  final heading = tester.getRect(
    find
        .descendant(
          of: find.byType(TabBarView),
          matching: find.text(_headings[index]),
        )
        .first,
  );
  // The first section header is the first inverseSurface-filled box in the
  // tab. Locating it by colour avoids matching text, which is ambiguous: the
  // Integrations heading and its first card header are the same string.
  final cardTop = tester.getRect(
    find
        .descendant(
          of: find.byType(TabBarView),
          matching: find.byWidgetPredicate(
            (w) =>
                w is Container &&
                w.color == BauhausDesign.lightTheme.colorScheme.inverseSurface,
          ),
        )
        .first,
  );
  return cardTop.top - heading.bottom;
}

void main() {
  testWidgets('general settings is the reference spacing', (tester) async {
    await _pumpTab(tester, 0);
    // space3 (12) plus the heading's line-height descender.
    expect(_headingToCardGap(tester, 0), closeTo(14.5, 0.5));
  });

  testWidgets('pricing rules matches general settings spacing', (tester) async {
    await _pumpTab(tester, 0);
    final reference = _headingToCardGap(tester, 0);
    await _selectTab(tester, 1);
    // The add-rule action is 36px beside a 16px heading, so ~10px of the
    // heading's own row is unavoidable dead band. The space1 gap below
    // compensates, leaving a ~2px residual that is not perceptible.
    expect(
      _headingToCardGap(tester, 1),
      closeTo(reference, 3),
      reason: 'Pricing Rules must sit flush with General Settings',
    );
  });

  testWidgets('integrations matches general settings spacing', (tester) async {
    await _pumpTab(tester, 0);
    final reference = _headingToCardGap(tester, 0);
    await _selectTab(tester, 2);
    expect(
      _headingToCardGap(tester, 2),
      closeTo(reference, 0.5),
      reason: 'Integrations must sit flush with General Settings',
    );
  });

  testWidgets('add-rule action sits in the pricing rules heading row', (
    tester,
  ) async {
    await _pumpTab(tester, 1);
    // The action belongs beside the heading, and it must not carry the app
    // bar's vertical padding: that would make the row 52px tall and add a
    // dead band no gap can absorb.
    expect(
      find.descendant(
        of: find.byType(TabBarView),
        matching: find.byIcon(Icons.add),
      ),
      findsOneWidget,
    );
    // 36px unpadded, not 52px with the app bar's space2 either side.
    final row = tester.getRect(
      find
          .descendant(of: find.byType(TabBarView), matching: find.byType(Row))
          .first,
    );
    expect(
      row.height,
      lessThanOrEqualTo(40.0),
      reason: 'the title row must not carry the app bar icon padding',
    );
  });
}
