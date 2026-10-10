/// Generates a marketing sample invoice PDF from [SampleInvoiceFixture].
///
/// This runs the app's real invoice PDF generator against entirely synthetic
/// data, so the output is faithful to what the product actually produces while
/// containing nothing about any real tenant, participant or employee.
///
/// ```
/// flutter test test/sample_invoice_marketing_pdf.dart
/// ```
///
/// Writes `marketing/INVOICE-SAMPLE.pdf` and fails if any real-looking
/// identifier leaks in.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/invoice/services/sample_invoice_fixture.dart';

/// Keeps generation offline. The generator only reaches the network to look up
/// bank details, and the fixture leaves `organizationId` and worker email
/// blank so those lookups short-circuit — this is the belt-and-braces half.
class _NoNetworkApiMethod extends ApiMethod {
  @override
  Future<Map<String, dynamic>> getOrganizationDetails(
    String id, {
    bool forceRefresh = false,
  }) async {
    fail('Sample generation must not call the API (organizationId: "$id")');
  }

  @override
  Future<Map<String, dynamic>> getBankDetailsForUserEmail(
    String email,
    String organizationId,
  ) async {
    fail('Sample generation must not call the API (email: "$email")');
  }
}

/// Redirects the generator's output directory into the repo so the sample file
/// lands somewhere the user can find it.
class _RepoPathProvider extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  @override
  Future<String?> getApplicationDocumentsPath() async => Directory.current.path;

  @override
  Future<String?> getTemporaryPath() async => Directory.systemTemp.path;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = _RepoPathProvider();

  test('produces a marketing sample invoice from synthetic data', () async {
    final payload = SampleInvoiceFixture.buildInvoicePayload();
    final generator = InvoicePdfGenerator(api: _NoNetworkApiMethod());

    final paths = await generator.generatePdfs(
      payload,
      showTax: true,
      taxRate: 0.0,
    );

    expect(paths, hasLength(1));
    expect(File(paths.first).existsSync(), isTrue);
    expect(File(paths.first).lengthSync(), greaterThan(1000));

    final outDir = Directory('marketing');
    if (!outDir.existsSync()) outDir.createSync(recursive: true);
    final target = File('marketing/INVOICE-SAMPLE.pdf');
    await File(paths.first).copy(target.path);

    // --- safety: nothing real survives into the artefact -------------------
    // The dev database contains one real tenant. None of these strings may
    // appear anywhere in the generated file.
    final banned = <String>[
      'Pari Care',
      'AKM71X',
      'ErBishal',
      'deverbishal331',
      'budhathokib085',
      'invoice-660f3',
    ];

    final bytes = await target.readAsBytes();
    expect(bytes.length, greaterThan(1000));
    expect(String.fromCharCodes(bytes.sublist(0, 5)), '%PDF-',
        reason: 'output must be a real PDF, not an error page');
    for (final needle in banned) {
      expect(
        bytesContainsString(bytes, needle),
        isFalse,
        reason: 'sample invoice must not contain "$needle"',
      );
    }
  }, timeout: const Timeout(Duration(minutes: 2)));
}

/// PDF content is compressed, so a plain substring test does not work. This
/// scans for the needle in any uncompressed literal string, which is enough to
/// catch plaintext metadata such as titles and author fields.
bool bytesContainsString(List<int> bytes, String needle) {
  final n = needle.codeUnits;
  if (n.isEmpty) return false;
  for (var i = 0; i + n.length <= bytes.length; i++) {
    var match = true;
    for (var j = 0; j < n.length; j++) {
      if (bytes[i + j] != n[j]) {
        match = false;
        break;
      }
    }
    if (match) return true;
  }
  return false;
}
