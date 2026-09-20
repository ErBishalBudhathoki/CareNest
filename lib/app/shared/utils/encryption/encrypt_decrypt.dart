import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' show sha256;
import 'package:cryptography/cryptography.dart' as crypto_pkg;
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/stream/chacha20.dart';

/// Field-level encryption for sensitive values sent to / received from the
/// backend (currently: the invoicing-email app password, which the backend
/// stores opaquely and returns verbatim).
///
/// ## Format
/// New ciphertexts use an authenticated (AEAD) envelope:
///
///   `v2:` + base64url( nonce[12] ‖ ciphertext ‖ mac[16] )
///
/// * Algorithm: ChaCha20-Poly1305 via the vetted `cryptography` package.
/// * The 12-byte nonce is randomly generated per encryption — identical
///   plaintexts never produce identical ciphertexts.
/// * The 16-byte Poly1305 tag is verified on decrypt; tampered blobs are
///   rejected instead of producing garbage plaintext.
/// * The AEAD key is `SHA-256(storedSecret)` (exactly 32 bytes), so raw
///   variable-length secrets are never used as cipher keys directly.
///
/// ## Backwards compatibility
/// Ciphertexts minted by the legacy scheme (raw ChaCha20 with a fixed zero
/// IV, no `v2:` prefix) are still readable through [decryptPassword]'s
/// legacy fallback so existing MongoDB records keep working. New encryptions
/// always use the v2 envelope. Callers should opportunistically re-encrypt
/// (write back the v2 blob) after a successful legacy decrypt.
class EncryptDecrypt {
  static const _storage = FlutterSecureStorage();
  static const _keyStorageKey = 'encryption_key';

  /// Version prefix for AEAD (v2) ciphertext envelopes.
  static const String versionPrefix = 'v2:';

  static final _aead = crypto_pkg.Chacha20.poly1305Aead();

  static final _secureRandom = Random.secure();

  static Future<String?> generateEncryptionKey({int length = 32}) async {
    // Secure random generator.
    final values = Uint8List(length);
    for (var i = 0; i < values.length; i++) {
      values[i] = _secureRandom.nextInt(256);
    }
    // Encode as Base64 for readability.
    final encodedKey = base64UrlEncode(values);
    final key = await setSecureEncryptionKey(encodedKey);
    debugPrint('Encryption key generated and stored securely');
    return key;
  }

  static Future<String?> setSecureEncryptionKey(String key) async {
    await _storage.write(key: _keyStorageKey, value: key);
    return getSecureEncryptionKey();
  }

  static Future<String?> getSecureEncryptionKey() async {
    return await _storage.read(key: _keyStorageKey);
  }

  /// Derives a fixed 32-byte AEAD key from an arbitrary stored secret.
  static Future<crypto_pkg.SecretKey> _deriveKey(String key) async {
    final digest = sha256.convert(utf8.encode(key)).bytes;
    return crypto_pkg.SecretKey(digest);
  }

  /// Encrypts [password] with ChaCha20-Poly1305 and returns a `v2:` envelope.
  ///
  /// A fresh random nonce is generated on every call.
  static Future<String> encryptPassword(String password, String key) async {
    final secretKey = await _deriveKey(key);
    final secretBox = await _aead.encrypt(
      utf8.encode(password),
      secretKey: secretKey,
    );
    final envelope = Uint8List.fromList([
      ...secretBox.nonce,
      ...secretBox.cipherText,
      ...secretBox.mac.bytes,
    ]);
    return '$versionPrefix${base64UrlEncode(envelope)}';
  }

  /// Decrypts a value produced by [encryptPassword].
  ///
  /// Returns `''` when the input is null/empty, malformed, or fails
  /// authentication (wrong key or tampered data). Ciphertexts without the
  /// `v2:` prefix are decrypted with the legacy routine for backwards
  /// compatibility with records minted before the AEAD migration.
  static Future<String> decryptPassword(
    String? encryptedPassword,
    String? key,
  ) async {
    if (encryptedPassword == null || encryptedPassword.isEmpty) {
      debugPrint('Error: Encrypted password is null or empty');
      return '';
    }
    if (key == null || key.isEmpty) {
      debugPrint('Error: Decryption key is null or empty');
      return '';
    }

    if (!encryptedPassword.startsWith(versionPrefix)) {
      // Legacy (pre-AEAD) ciphertext: ChaCha20 with fixed zero IV.
      // ignore: deprecated_member_use_from_same_package
      return _decryptLegacy(encryptedPassword, key);
    }

    try {
      final envelope = base64Url.decode(
        encryptedPassword.substring(versionPrefix.length),
      );
      // nonce[12] ‖ ciphertext[>=0] ‖ mac[16]
      if (envelope.length < 12 + 16) {
        debugPrint('Error: v2 envelope too short');
        return '';
      }
      final nonce = envelope.sublist(0, 12);
      final macBytes = envelope.sublist(envelope.length - 16);
      final cipherText = envelope.sublist(12, envelope.length - 16);

      final secretKey = await _deriveKey(key);
      final secretBox = crypto_pkg.SecretBox(
        cipherText,
        nonce: nonce,
        mac: crypto_pkg.Mac(macBytes),
      );
      final clearText = await _aead.decrypt(secretBox, secretKey: secretKey);
      return utf8.decode(clearText);
    } on FormatException catch (e) {
      debugPrint('Error decoding v2 envelope: $e');
      return '';
    } on crypto_pkg.SecretBoxAuthenticationError {
      // Wrong key or tampered ciphertext — never return partial plaintext.
      debugPrint('Error: v2 authentication failed (wrong key or tampered)');
      return '';
    } catch (e) {
      debugPrint('Error during v2 decryption: $e');
      return '';
    }
  }

  /// Legacy decryptor for pre-AEAD records (ChaCha20, fixed zero IV).
  ///
  /// Read-only compatibility path — new code must use [encryptPassword].
  /// These blobs are deterministic (same plaintext ⇒ same ciphertext) and
  /// unauthenticated; callers should re-encrypt via [encryptPassword] after
  /// a successful legacy decrypt.
  @Deprecated('Legacy read-only path. Encrypt with encryptPassword (v2).')
  static String _decryptLegacy(String encryptedPassword, String key) {
    try {
      final keyBytes = utf8.encode(key);
      final encryptedBytes = base64Decode(encryptedPassword);

      final keyParam = KeyParameter(keyBytes);
      final params = ParametersWithIV(keyParam, Uint8List(8));

      final cipher = ChaCha20Engine();
      cipher.init(false, params);

      final decryptedBytes = cipher.process(Uint8List.fromList(encryptedBytes));
      try {
        return utf8.decode(decryptedBytes);
      } catch (e) {
        debugPrint('Error decoding decrypted bytes: $e');
        return '';
      }
    } catch (e) {
      debugPrint('Error during legacy decryption process: $e');
      return '';
    }
  }
}
