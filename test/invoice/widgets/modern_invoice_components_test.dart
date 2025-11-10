// Tests for SourceBadge and NdisCapChip widgets
// These verify labels, tooltip wrapping, and basic compliance indicators.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:carenest/app/features/invoice/widgets/modern_invoice_components.dart';

Widget _wrapInMaterial(Widget child) {
  return MaterialApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('SourceBadge', () {
    testWidgets('renders label for client_specific', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(source: 'client_specific')));
      expect(find.text('Client Rate'), findsOneWidget);
    });

    testWidgets('renders label for organization', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(source: 'organization')));
      expect(find.text('Organization Rate'), findsOneWidget);
    });

    testWidgets('renders label for base-rate', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(source: 'base-rate')));
      expect(find.text('Base Rate (Fallback)'), findsOneWidget);
    });

    testWidgets('renders label for ndis_default', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(source: 'ndis_default')));
      expect(find.text('NDIS Default'), findsOneWidget);
    });

    testWidgets('renders label for fallback', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(source: 'fallback')));
      expect(find.text('Fallback'), findsOneWidget);
    });

    testWidgets('renders input source text for unknown values', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(source: 'custom_source_x')));
      expect(find.text('custom_source_x'), findsOneWidget);
    });

    testWidgets('wraps badge in Tooltip when tooltip provided', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const SourceBadge(
        source: 'organization',
        tooltip: 'Organization-wide custom pricing',
      )));
      expect(find.byType(Tooltip), findsOneWidget);
      expect(find.text('Organization Rate'), findsOneWidget);
    });
  });

  group('NdisCapChip', () {
    testWidgets('shows cap and within-cap state', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const NdisCapChip(
        priceCap: 50.0,
        currentPrice: 40.0,
      )));
      expect(find.text('NDIS Cap: \$50.00'), findsOneWidget);
      // Within cap should use shield icon
      expect(find.byIcon(Icons.shield_rounded), findsOneWidget);
    });

    testWidgets('shows cap and exceeds-cap state', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const NdisCapChip(
        priceCap: 30.0,
        currentPrice: 40.0,
      )));
      expect(find.text('NDIS Cap: \$30.00'), findsOneWidget);
      // Exceeds cap should use error icon
      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    });

    testWidgets('shows default label when cap missing', (tester) async {
      await tester.pumpWidget(_wrapInMaterial(const NdisCapChip(
        priceCap: null,
        currentPrice: 40.0,
      )));
      expect(find.text('NDIS Cap'), findsOneWidget);
    });
  });
}