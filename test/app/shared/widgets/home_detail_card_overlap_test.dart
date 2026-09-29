import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/home_detail_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The Get Started cards on the admin dashboard put a floating figure over the
/// heading, and the figure's first characters were blocking the heading's first
/// characters.
///
/// The extent is measured from the asset's own alpha channel rather than
/// guessed: at the heading's vertical band the figure spans card-local x
/// 0..55.5, so the heading has to begin past that.
void main() {
  late ui.Image asset;
  late int aw, ah;
  late Uint8List figurePixels;

  setUpAll(() async {
    final bytes = await File('assets/images/she_with_phone.png').readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    asset = (await codec.getNextFrame()).image;
    aw = asset.width;
    ah = asset.height;
    figurePixels = (await asset.toByteData(
      format: ui.ImageByteFormat.rawStraightRgba,
    ))!.buffer.asUint8List();
  });

  /// Rightmost opaque pixel of the figure, in card-local px, within the
  /// card-local y range [top, bottom].
  double figureRightForBand(double top, double bottom, {double boxW = 151}) {
    final px = figurePixels;
    const boxH = 180.0, boxTop = -50.0;
    final drawnH = boxW / (aw / ah);
    final drawnTop = boxTop + (boxH - drawnH) / 2;
    var maxX = 0;
    for (var y = 0; y < ah; y++) {
      final cardY = drawnTop + (y / ah) * drawnH;
      if (cardY < top || cardY > bottom) continue;
      for (var x = 0; x < aw; x++) {
        if (px[(y * aw + x) * 4 + 3] > 24 && x > maxX) maxX = x;
      }
    }
    return maxX / aw * boxW;
  }

  for (final (int index, String heading) in <(int, String)>[
    (0, 'KNOW YOUR CLIENT'),
    (1, 'KNOW YOUR BUSINESS'),
  ]) {
    testWidgets('$heading clears the floating figure', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          theme: BauhausDesign.lightTheme,
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Row(
                children: [
                  for (final c in <(String, String, Color)>[
                    ('KNOW YOUR CLIENT', 'ADD CLIENT', BauhausDesign.secondary),
                    (
                      'KNOW YOUR BUSINESS',
                      'ADD BUSINESS',
                      BauhausDesign.primary,
                    ),
                  ])
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: HomeDetailCard(
                          buttonLabel: c.$2,
                          cardLabel: c.$1,
                          image: Image.asset(
                            'assets/images/she_with_phone.png',
                            fit: BoxFit.contain,
                          ),
                          onPressed: () {},
                          gradientStartColor: c.$3,
                          gradientEndColor: c.$3,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
      for (var n = 0; n < 10; n++) {
        await tester.pump(const Duration(milliseconds: 120));
      }
      final card = find.byType(HomeDetailCard).at(index);
      final cardRect = tester.getRect(card);
      final label = tester.getRect(
        find.descendant(of: card, matching: find.text(heading)),
      );
      final local = label.left - cardRect.left;
      final figureRight = figureRightForBand(0, label.bottom - cardRect.top);
      expect(
        local,
        greaterThan(figureRight),
        reason:
            'heading starts at $local but the figure reaches $figureRight in '
            'that band, so its first characters are covered',
      );
      expect(
        label.bottom,
        lessThanOrEqualTo(cardRect.bottom),
        reason: 'heading must stay inside the card',
      );
    });
  }
}
