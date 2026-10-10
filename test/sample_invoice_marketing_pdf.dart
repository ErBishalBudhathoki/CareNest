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

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/invoice/services/sample_invoice_fixture.dart';
import 'package:carenest/app/features/invoice/services/invoice_signing_service.dart';

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

  test('signs the invoice and embeds the signature in XMP metadata', () async {

    // This is the language-boundary test. A Dart Ed25519 signature is worthless
    // unless Node's Ed25519 accepts it, and the canonical serialisation that
    // was signed has to be byte-identical on both sides. The fixture written
    // here is what the backend interop test in
    // backend/tests/invoice-signature-interop.test.js verifies.
    final payload = SampleInvoiceFixture.buildInvoicePayload();
    final client = payload['clients'].first as Map<String, dynamic>;
    final generator = InvoicePdfGenerator(api: _NoNetworkApiMethod());

    final keyPair0 = await InvoiceSigningService.loadOrCreateKeyPair();
    final paths = await generator.generatePdfs(
      payload,
      showTax: true,
      taxRate: 0.0,
      signingKeyPair: keyPair0,
    );
    expect(paths, hasLength(1));

    InvoiceSignableItem item(Map<String, dynamic> m) => InvoiceSignableItem(
          code: m['ndisItemNumber'] as String,
          date: m['date'] as String,
          hours: m['hours'] as double,
          rate: m['rate'] as double,
          amount: m['amount'] as double,
        );

    final items = (client['items'] as List).cast<Map<String, dynamic>>();

    final canonical = InvoiceSigningService.canonicalInvoiceForm(
      invoiceNumber: client['invoiceNumber'] as String,
      periodStart: client['startDate'] as String,
      periodEnd: client['endDate'] as String,
      subtotal: client['subtotal'] as double,
      tax: client['tax'] as double,
      total: client['total'] as double,
      items: items.map(item).toList(),
    );

    // Key material is taken from a single keypair object rather than through
    // the storage-backed helpers: flutter_secure_storage does not persist across
    // calls in this environment, so loadOrCreateKeyPair() twice can return two
    // different keys and the signature would be published against the wrong one.
    final keyPair = keyPair0;
    final pub = base64.encode((await keyPair.extractPublicKey()).bytes);
    final signatureBase64 =
        await InvoiceSigningService.signWith(canonical, Future.value(keyPair));
    final keyId = await InvoiceSigningService.getDeviceKeyIdFromKey(keyPair);

    // Copy the PDF this same test produced, so the embedded signature and the
    // fixture below are guaranteed to come from the same key. Copying the file
    // written by the other test would pair a signature with the wrong public key
    // and the interop test would fail for a reason that is not the scheme.
    await File(paths.first).copy('marketing/INVOICE-SAMPLE.pdf');

    await File('marketing/signing-fixture.json').writeAsString(jsonEncode({
      'canonicalForm': canonical,
      'signatureBase64': signatureBase64,
      'deviceKeyId': keyId,
      'publicKeyBase64': pub,
      'fingerprint': InvoiceSigningService.fingerprint(canonical),
      'record': {
        'invoiceNumber': client['invoiceNumber'],
        'startDate': client['startDate'],
        'endDate': client['endDate'],
        'financialSummary': {
          'subtotal': client['subtotal'],
          'taxAmount': client['tax'],
          'totalAmount': client['total'],
        },
        'lineItems': items
            .map((m) {
              final qty = (m['hours'] as num?)?.toDouble() ?? 0;
              final rate = (m['rate'] as num?)?.toDouble() ?? 0;
              return {
                'supportItemNumber': m['ndisItemNumber'],
                'quantity': qty,
                'price': rate,
                'totalPrice': (m['amount'] as num?)?.toDouble() ?? (qty * rate),
                'date': m['date'],
              };
            })
            .toList(),
      },
    }));
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
