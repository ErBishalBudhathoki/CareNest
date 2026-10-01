import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer_io.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('PdfViewPage renders correctly with buttons', (
    WidgetTester tester,
  ) async {
    // Create a dummy widget
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const MaterialApp(
          home: PdfViewPage(
            pdfPath: 'dummy.pdf',
            receiptUrls: ['https://example.com/receipt1.jpg'],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // It will try to load the PDF and fail, but the UI scaffold should render.
    // The PdfView might throw error, but let's see.
    // We expect to see the AppBar with buttons.

    expect(find.text('Invoice PDF'), findsOneWidget);

    // Check for buttons
    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.byIcon(Icons.download), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long), findsOneWidget);
    expect(find.byIcon(Icons.open_in_new), findsOneWidget);

    // Check tooltips
    expect(find.byTooltip('Share PDF'), findsOneWidget);
    expect(find.byTooltip('Download PDF'), findsOneWidget);
    expect(find.byTooltip('Download Receipts'), findsOneWidget);
    expect(find.byTooltip('Open PDF externally'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  });

  testWidgets('PdfViewPage shows receipt dialog on multiple receipts', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const MaterialApp(
          home: PdfViewPage(
            pdfPath: 'dummy.pdf',
            receiptUrls: ['url1', 'url2'],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final receiptButton = find.byTooltip('Download Receipts');
    expect(receiptButton, findsOneWidget);

    await tester.tap(receiptButton);
    await tester.pumpAndSettle();

    expect(find.text('Attached Receipts'), findsOneWidget);
    expect(find.text('Receipt 1'), findsOneWidget);
    expect(find.text('Receipt 2'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
  });
}
