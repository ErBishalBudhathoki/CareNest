// Verifies the device-key registration path — the gap that made signed invoices
// unverifiable.
//
// Signing without registering is worse than not signing: the verifier receives a
// signature and no public key to check it against, and can only report
// `unregistered-key`. These tests pin that a registration call is actually made,
// with the right endpoint, payload and tenant header, and that it is cached so it
// does not fire once per invoice.

import 'dart:convert';

import 'package:cryptography/cryptography.dart';

import 'package:carenest/app/features/invoice/services/invoice_signing_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// Records what the signing service asked the caller to POST.
///
/// A plain class rather than an implementor of [KeyRegistrationPoster]: a
/// function-typed typedef cannot be used as a supertype, so the recorder is
/// passed as a closure instead.
class _Recorder {
  final List<Map<String, dynamic>> calls = [];
  Map<String, dynamic>? reply;
  Object? error;

  Future<Map<String, dynamic>> call(
    String endpoint,
    Map<String, dynamic> body,
    Map<String, String> headers,
  ) async {
    calls.add({
      'endpoint': endpoint,
      'body': body,
      'headers': headers,
    });
    if (error != null) throw error!;
    return reply ?? {'success': true, 'data': {}};
  }

  KeyRegistrationPoster get poster =>
      (endpoint, body, headers) => call(endpoint, body, headers);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // One key pair for the whole suite. Secure storage does not persist under
  // flutter test, so loading the key repeatedly would yield a different key each
  // time — exactly the instability that makes the registration cache untestable,
  // hence passing the key explicitly.
  late final SimpleKeyPair sharedKeyPair;
  setUpAll(() async {
    sharedKeyPair = await InvoiceSigningService.loadOrCreateKeyPair();
  });

  test('a signing key pair is a usable 32-byte Ed25519 key', () async {
    final keyPair = await InvoiceSigningService.loadOrCreateKeyPair();
    final pub = base64.encode((await keyPair.extractPublicKey()).bytes);
    expect(base64.decode(pub), hasLength(32));

    final canonical = InvoiceSigningService.canonicalInvoiceForm(
      invoiceNumber: 'INV-TEST-001',
      periodStart: '2026-09-07',
      periodEnd: '2026-09-13',
      subtotal: 1541,
      tax: 0,
      total: 1541,
      items: const [
        InvoiceSignableItem(
          code: '01_011_0107_1_1',
          date: '2026-09-07',
          hours: 3,
          rate: 73.58,
          amount: 220.74,
        ),
      ],
    );
    final sig = await InvoiceSigningService.signWith(
      canonical,
      Future.value(keyPair),
    );
    expect(sig, isNotEmpty);
    expect(base64.decode(sig), hasLength(64));
  });

  test('registration is attempted against the right endpoint and tenant', () async {
    final poster = _Recorder();
    final ok = await InvoiceSigningService.ensureRegistered(
      post: poster.poster,
      organizationId: 'org-abc-123',
      keyPair: sharedKeyPair,
    );

    expect(ok, isTrue);
    expect(poster.calls, isNotEmpty);
    final call = poster.calls.first;
    expect(call['endpoint'], 'invoice-signing/register');
    // The backend requires this header to resolve the caller's organization.
    expect(call['headers']['x-organization-id'], 'org-abc-123');

    final body = call['body'] as Map<String, dynamic>;
    expect(body['deviceKeyId'], isA<String>());
    expect(body['publicKeyBase64'], isA<String>());
    expect(base64.decode(body['publicKeyBase64'] as String), hasLength(32));
  });

  test('registration is cached, so it does not fire per invoice', () async {
    final poster = _Recorder();
    // A fresh key so the registration cache from earlier tests in this suite
    // does not already satisfy this one.
    final freshKey = await InvoiceSigningService.loadOrCreateKeyPair();
    const org = 'org-cache-check-001';
    expect(
      await InvoiceSigningService.ensureRegistered(
        post: poster.poster,
        organizationId: org,
        keyPair: freshKey,
      ),
      isTrue,
    );
    final firstCount = poster.calls.length;

    // A second call with the same key must be served from cache — an HTTP call
    // per invoice would be a per-invoice latency cost.
    final second = await InvoiceSigningService.ensureRegistered(
      post: poster.poster,
      organizationId: org,
      keyPair: freshKey,
    );
    expect(second, isTrue);
    expect(poster.calls.length, firstCount);
  });

  test('registration is skipped entirely with no organisation context', () async {
    final poster = _Recorder();
    // Guessing an organisation and binding a signing key to it is what the
    // backend guard rejects; refusing to register is the safe failure.
    final ok = await InvoiceSigningService.ensureRegistered(
      post: poster.poster,
      organizationId: '',
    );
    expect(ok, isFalse);
    expect(poster.calls, isEmpty);
  });

  test('a rejected registration fails soft rather than throwing', () async {
    final poster = _Recorder()
      ..reply = {'success': false, 'message': 'device key already registered'};
    // A fresh key, so the registration cache from the earlier tests does not
    // short-circuit before the rejection is exercised.
    final freshKey = await InvoiceSigningService.loadOrCreateKeyPair();
    final ok = await InvoiceSigningService.ensureRegistered(
      post: poster.poster,
      organizationId: 'org-reject-001',
      keyPair: freshKey,
    );
    expect(ok, isFalse);
  });

  test('a network failure fails soft rather than throwing', () async {
    final poster = _Recorder()..error = Exception('offline');
    // A device on a flaky connection must still be able to invoice; the
    // generated signature is simply unverifiable until registration succeeds.
    final freshKey = await InvoiceSigningService.loadOrCreateKeyPair();
    final ok = await InvoiceSigningService.ensureRegistered(
      post: poster.poster,
      organizationId: 'org-offline-001',
      keyPair: freshKey,
    );
    expect(ok, isFalse);
  });
}
