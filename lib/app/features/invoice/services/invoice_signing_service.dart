import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';

/// XMP namespace and element names for the invoice signature.
///
/// These are a contract with the backend parser; changing them makes every
/// previously issued signature unreadable.
const String kSigningNamespace = 'urn:carenest:invoice-signing:1';
const String kSigningSigElement = 'carenest:sig';
const String kSigningKeyIdElement = 'carenest:keyId';
const String kSigningFingerprintElement = 'carenest:fp';
const String kSigningVersionElement = 'carenest:v';

/// Invoice signing: the device side of the Ed25519 scheme.
///
/// ## Why per-device asymmetric keys
///
/// The earlier watermark was an HMAC over the invoice number alone, keyed by a
/// secret generated on one device. That failed twice over: it could not detect an
/// edited amount (it signed the number, not the money), and because the secret
/// never left the device, nobody else — including the developer — could verify
/// it. An organisation using several phones then had invoices that only the
/// generating phone could vouch for.
///
/// This scheme fixes both without adding a shared secret to the server:
///
///   * Each device generates an Ed25519 keypair. The private key stays in the
///     platform keystore; only the public key is registered to the backend.
///   * The signature covers the invoice's financial content, so editing any
///     amount, date or line item invalidates it.
///   * Verification needs only the public key, which the backend holds. It works
///     on any device, on the developer's machine, and in the admin console — the
///     generating device does not have to be present.
///   * Because keys are per device, a stolen key can sign as one phone, not for
///     the whole organisation, and can be revoked individually.
///
/// ## Honest limitation
///
/// This is tamper-EVIDENCE, not tamper-PROOF. It detects an edited PDF. It does
/// not stop someone who has extracted the private key from a compromised or
/// rooted device from signing a fresh forgery; against that, a forgery must be
/// signed by a key the backend has never seen or has revoked.
/// Signature of the HTTP call used to register a device key.
///
/// Injected rather than hard-coding ApiMethod so the registration path is
/// testable without the network, and so a backend change does not require
/// touching the crypto.
typedef KeyRegistrationPoster = Future<Map<String, dynamic>> Function(
  String endpoint,
  Map<String, dynamic> body,
  Map<String, String> headers,
);

class InvoiceSigningService {
  InvoiceSigningService._();

  static final Ed25519 _algorithm = Ed25519();
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  /// Bump only alongside [invoiceSignatureService] on the backend, and keep the
  /// previous version verifiable — every already-issued signature is pinned to
  /// the version that produced it.
  static const int canonicalVersion = 1;

  /// Keys already registered during this process. Avoids a disk read and a
  /// repeated HTTP call for every invoice generated in a session; secure storage
  /// still carries it across launches.
  static final Set<String> _registeredThisSession = <String>{};

  static const String _privateSeedKey = 'carenest.invoice.signing.seed';
  static const String _registeredKeyPrefix = 'carenest.invoice.signing.registered.';

  /// Endpoint the backend exposes for public-key registration.
  static const String _registerEndpoint = 'invoice-signing/register';

  /// The device's key id.
  ///
  /// Derived from the public key rather than stored as a random string: it is
  /// then stable and reproducible (anyone holding the key can recompute it), and
  /// there is no separate piece of state to lose — which is exactly what
  /// happened in tests, where the generated id and the key disagreed.
  static Future<String> getDeviceKeyIdFromKey(SimpleKeyPair keyPair) async {
    final pub = (await keyPair.extractPublicKey()).bytes;
    final digest = sha256.convert(pub).bytes;
    return base64Url.encode(digest.sublist(0, 12)).replaceAll('=', '');
  }

  static Future<String> getDeviceKeyId() async =>
      getDeviceKeyIdFromKey(await loadOrCreateKeyPair());

  /// Raw 32-byte Ed25519 public key, base64. Registered with the backend.
  static Future<String> getPublicKeyBase64() async {
    final keyPair = await loadOrCreateKeyPair();
    return base64.encode((await keyPair.extractPublicKey()).bytes);
  }

  /// Loads this device's keypair, creating it on first use.
  static Future<SimpleKeyPair> loadOrCreateKeyPair() async {
    final seed = await _storage.read(key: _privateSeedKey);
    if (seed != null && seed.isNotEmpty) {
      return _algorithm.newKeyPairFromSeed(base64.decode(seed));
    }
    final keyPair = await _algorithm.newKeyPair();
    final seedBytes = await keyPair.extractPrivateKeyBytes();
    await _storage.write(key: _privateSeedKey, value: base64.encode(seedBytes));
    return keyPair;
  }

  /// Signs [canonicalForm] and returns the base64 signature.
  ///
  /// [canonicalForm] must be produced by [canonicalInvoiceForm] so the backend
  /// derives the same bytes; signing anything else produces a signature that
  /// will not verify.
  static Future<String> sign(String canonicalForm) =>
      signWith(canonicalForm, loadOrCreateKeyPair());

  /// Signs [canonicalForm] with a specific [keyPair].
  ///
  /// Used when the caller already holds the key pair — signing and publishing the
  /// public key must come from the same object, or the signature is unverifiable.
  static Future<String> signWith(String canonicalForm, Future<SimpleKeyPair> keyPairFuture) async {
    final keyPair = await keyPairFuture;
    final signature = await _algorithm.sign(
      utf8.encode(canonicalForm),
      keyPair: keyPair,
    );
    return base64.encode(signature.bytes);
  }

  /// Story kept minimal: no key generation method above; use [canonicalInvoiceForm].
  static String canonicalInvoiceForm({
    required String invoiceNumber,
    required String periodStart,
    required String periodEnd,
    required num subtotal,
    required num tax,
    required num total,
    required List<InvoiceSignableItem> items,
  }) {
    final sorted = [...items]..sort(_compareItems);

    final lines = <String>[
      'CarenestInvoice|v$canonicalVersion',
      'invoiceNumber=$invoiceNumber',
      'periodStart=$periodStart',
      'periodEnd=$periodEnd',
      'subtotal=${_fixed2(subtotal)}',
      'tax=${_fixed2(tax)}',
      'total=${_fixed2(total)}',
      'itemCount=${sorted.length}',
    ];
    for (final it in sorted) {
      lines.add(
        'item=${it.code}|${it.date}|${_fixed2(it.hours)}|${_fixed2(it.rate)}|${_fixed2(it.amount)}',
      );
    }
    return '${lines.join('\n')}\n';
  }

  /// SHA-256 of the canonical form, hex. Cheap to compare without a key.
  static String fingerprint(String canonicalForm) {
    return sha256.convert(utf8.encode(canonicalForm)).toString();
  }

  /// Builds the XMP metadata block that carries the signature.
  ///
  /// XMP rather than the page content or the Info dictionary: the Info keys
  /// package:pdf exposes are a fixed set with no way to add custom ones, and
  /// anything drawn on the page needs a font that can encode it — which is
  /// exactly what broke the old zero-width watermark, since base-14 Helvetica
  /// cannot encode those code points and the PDF writer dropped them silently.
  static XmlDocument buildSignatureMetadata({
    required String signatureBase64,
    required String deviceKeyId,
    required String fingerprintHex,
  }) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'x:xmpmeta',
      namespaces: {'x': 'adobe:ns:meta/'},
      nest: () {
        builder.element(
          'rdf:RDF',
          namespaces: {
            'rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
            'carenest': kSigningNamespace,
          },
          nest: () {
            builder.element(
              'rdf:Description',
              attributes: {
                kSigningSigElement: signatureBase64,
                kSigningKeyIdElement: deviceKeyId,
                kSigningFingerprintElement: fingerprintHex,
                kSigningVersionElement: '$canonicalVersion',
              },
            );
          },
        );
      },
    );
    return builder.buildDocument();
  }

  /// Convenience: sign a canonical form and attach the metadata to [document].
  ///
  /// If signing fails the invoice still gets built, unsigned. A device with a
  /// broken keystore should not be unable to invoice; the verifier reports the
  /// missing signature instead, which is visible rather than silent.
  /// Registers this device's public key with the backend, once per key.
  ///
  /// Without this the device signs invoices and the verifier can only report
  /// `unregistered-key` — it has no public key to check the signature against,
  /// so the signature is worthless. Registration is idempotent server-side
  /// (re-registering the same key is a refresh), so it can be called lazily, and
  /// a per-key cache keeps it to one call per key rather than one per invoice.
  ///
  /// Never throws. A device on a flaky connection keeps generating invoices; it
  /// just produces an unverifiable signature instead of no invoice at all.
  static Future<bool> ensureRegistered({
    required KeyRegistrationPoster post,
    required String organizationId,
    SimpleKeyPair? keyPair,
  }) async {
    // An empty org means no tenant context. Guessing an organisation and binding
    // a signing key to it is exactly what the backend guard rejects.
    if (organizationId.isEmpty) return false;

    try {
      // The caller usually already holds the key pair to sign with; reusing it
      // avoids loading the keystore twice for one invoice.
      final resolved = keyPair ?? await loadOrCreateKeyPair();
      final keyId = await getDeviceKeyIdFromKey(resolved);
      final pub = base64.encode((await resolved.extractPublicKey()).bytes);

      // Comparing the stored key rather than just its presence: a different key
      // under the same key id must be re-registered.
      final cacheKey = '$_registeredKeyPrefix$keyId';
      final known = _registeredThisSession.contains(cacheKey) ||
          (await _storage.read(key: cacheKey)) == pub;
      if (known) return true;

      final res = await post(
        _registerEndpoint,
        {'deviceKeyId': keyId, 'publicKeyBase64': pub},
        {'x-organization-id': organizationId},
      );

      if (res['success'] == true) {
        _registeredThisSession.add(cacheKey);
        await _storage.write(key: cacheKey, value: pub);
        return true;
      }
      debugPrint('Device key registration rejected: ${res['message'] ?? res['error']}');
      return false;
    } catch (e) {
      debugPrint('Device key registration failed: $e');
      return false;
    }
  }

  /// Everything the caller needs to write the signature into a PDF.
  ///
  /// The XMP document is returned rather than attached here so the PDF library
  /// type stays with the generator, which already imports it. A null result
  /// means signing failed and the invoice will be emitted unsigned.
  static Future<SignedInvoiceMetadata?> buildMetadata(
    String canonicalForm, {
    SimpleKeyPair? keyPair,
  }) async {
    try {
      final resolved = keyPair ?? await loadOrCreateKeyPair();
      final keyId = await getDeviceKeyIdFromKey(resolved);
      final sig = await signWith(canonicalForm, Future.value(resolved));
      return SignedInvoiceMetadata(
        xml: buildSignatureMetadata(
          signatureBase64: sig,
          deviceKeyId: keyId,
          fingerprintHex: fingerprint(canonicalForm),
        ),
        signatureBase64: sig,
        deviceKeyId: keyId,
        fingerprintHex: fingerprint(canonicalForm),
      );
    } catch (e) {
      debugPrint('Invoice signing skipped: $e');
      return null;
    }
  }

  /// Mirrors the backend: sort by code unit, then date, then amount.
  ///
  /// Dart's [String.compareTo] compares UTF-16 code units, which is what the
  /// JavaScript side does with `<`/`>`. Using locale-aware collation here would
  /// make the two digests diverge.
  static int _compareItems(InvoiceSignableItem a, InvoiceSignableItem b) {
    final byCode = a.code.compareTo(b.code);
    if (byCode != 0) return byCode;
    final byDate = a.date.compareTo(b.date);
    if (byDate != 0) return byDate;
    return _fixed2(a.amount).compareTo(_fixed2(b.amount));
  }

  /// Identical arithmetic to the backend's `fixed2`: scale to cents, round the
  /// absolute value, re-attach the sign. Deliberately not `toStringAsFixed`,
  /// whose tie-breaking is not guaranteed to match JavaScript.
  static String _fixed2(num value) {
    if (!value.isFinite) return '0.00';
    final sign = value < 0 ? '-' : '';
    final cents = (value.abs() * 100).round();
    final whole = cents ~/ 100;
    final frac = (cents % 100).toString().padLeft(2, '0');
    return '$sign$whole.$frac';
  }
}

/// One line of the invoice, as the canonical form sees it.
class InvoiceSignableItem {
  const InvoiceSignableItem({
    required this.code,
    required this.date,
    required this.hours,
    required this.rate,
    required this.amount,
  });

  final String code;
  /// `yyyy-MM-dd`, already normalised.
  final String date;
  final num hours;
  final num rate;
  final num amount;
}

/// The signature block ready to embed in a PDF's XMP metadata.
class SignedInvoiceMetadata {
  const SignedInvoiceMetadata({
    required this.xml,
    required this.signatureBase64,
    required this.deviceKeyId,
    required this.fingerprintHex,
  });

  final XmlDocument xml;
  final String signatureBase64;
  final String deviceKeyId;
  final String fingerprintHex;
}
