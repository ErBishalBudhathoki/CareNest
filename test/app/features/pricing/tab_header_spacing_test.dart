import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the heading-to-card spacing in the Pricing Configuration tabs.
///
/// The "Pricing Rules" and "Integrations" tabs were rendering a ~30px band of
/// dead space between the first heading and the first card:
///
/// 1. `_buildHeaderActionIcon` adds `space2` of vertical padding so that the
///    app-bar `actions` have breathing room. Reusing that same helper inside a
///    panel title `Row` made the row 52px tall while the heading is only 16px,
///    so the heading floated centred and left ~18px of empty band beneath it.
/// 2. The tab then added a further `space3` on top of that.
///
/// The source is scanned rather than pumped because these are private tab
/// builders on a screen that needs several Riverpod providers and a live
/// Firestore-backed view model.
void main() {
  final file = File(
    '${Directory.current.path}/lib/app/features/pricing/views/pricing_configuration_view.dart',
  );

  String source() {
    expect(
      file.existsSync(),
      isTrue,
      reason: 'pricing_configuration_view.dart must exist',
    );
    return file.readAsStringSync();
  }

  /// Returns the body of `Widget <name>(...)`, from its signature up to the
  /// next top-level `Widget ` declaration.
  String bodyOf(String src, String name) {
    final start = src.indexOf('Widget $name(');
    expect(start, isNot(-1), reason: 'could not find $name(');
    final next = src.indexOf('\n  Widget ', start + 1);
    return next == -1 ? src.substring(start) : src.substring(start, next);
  }

  test('panel title action icon opts out of app-bar edge padding', () {
    final rules = bodyOf(source(), '_buildPricingRulesTab');
    expect(
      rules,
      contains('padEdges: false'),
      reason:
          'The add-rule icon must pass padEdges: false. With the default '
          'app-bar padding the title Row becomes 52px tall and the 16px '
          'heading floats centred, leaving a tall dead band above the cards.',
    );
  });

  test('panel title action icon keeps its padding by default', () {
    // The app-bar call sites rely on the padding, so it must stay the default
    // rather than being removed from the shared helper.
    final src = source();
    expect(src, contains('bool padEdges = true'));
    final helper = bodyOf(src, '_buildHeaderActionIcon');
    expect(
      helper,
      contains('padEdges ? BauhausDesign.space2 : 0'),
      reason:
          'The shared helper must keep app-bar padding by default and only '
          'drop it when a caller opts out.',
    );
  });

  test('pricing rules tab uses the tight section gap below the heading', () {
    final rules = bodyOf(source(), '_buildPricingRulesTab');
    expect(rules, contains('SizedBox(height: BauhausDesign.space2)'));
    expect(
      rules,
      isNot(contains('SizedBox(height: BauhausDesign.space3)')),
      reason: 'space3 below the rules heading re-inflates the dead band.',
    );
  });

  test('integrations tab uses the tight section gap below the heading', () {
    final integrations = bodyOf(source(), '_buildIntegrationsTab');
    expect(integrations, contains('SizedBox(height: BauhausDesign.space2)'));
    expect(
      integrations,
      isNot(contains('SizedBox(height: BauhausDesign.space3)')),
      reason: 'space3 below the integrations heading over-spaces the cards.',
    );
  });
}
