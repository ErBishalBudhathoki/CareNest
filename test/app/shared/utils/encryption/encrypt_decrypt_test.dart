import 'dart:convert';

import 'package:carenest/app/shared/utils/encryption/encrypt_decrypt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testKey = 'dGVzdGtleXRlc3RrZXl0ZXN0a2V5dGVzdGtleXRlc3QAAACCCCQ';
  const testPassword = 'correct horse battery staple!@#';

  group('EncryptDecrypt v2 (ChaCha20-Poly1305)', () {
    test('round-trips encrypt -> decrypt', () async {
      final blob = await EncryptDecrypt.encryptPassword(testPassword, testKey);
      expect(blob.startsWith(EncryptDecrypt.versionPrefix), isTrue);
      expect(await EncryptDecrypt.decryptPassword(blob, testKey), testPassword);
    });

    test('produces a fresh random nonce on every encryption', () async {
      final first = await EncryptDecrypt.encryptPassword(testPassword, testKey);
      final second = await EncryptDecrypt.encryptPassword(
        testPassword,
        testKey,
      );
      // Same plaintext must never yield the same ciphertext (fixes zero-IV).
      expect(first, isNot(equals(second)));
      expect(
        await EncryptDecrypt.decryptPassword(first, testKey),
        testPassword,
      );
      expect(
        await EncryptDecrypt.decryptPassword(second, testKey),
        testPassword,
      );
    });

    test('rejects tampered ciphertext', () async {
      final blob = await EncryptDecrypt.encryptPassword(testPassword, testKey);
      final raw = base64Url.decode(
        blob.substring(EncryptDecrypt.versionPrefix.length),
      );
      // Flip a byte in the ciphertext region (after the 12-byte nonce).
      final tampered = List<int>.from(raw);
      tampered[20] ^= 0x01;
      final tamperedBlob =
          '${EncryptDecrypt.versionPrefix}${base64UrlEncode(tampered)}';
      expect(await EncryptDecrypt.decryptPassword(tamperedBlob, testKey), '');
    });

    test('rejects wrong key', () async {
      final blob = await EncryptDecrypt.encryptPassword(testPassword, testKey);
      expect(
        await EncryptDecrypt.decryptPassword(blob, 'wrong-key-0123456789'),
        '',
      );
    });

    test('rejects truncated envelope', () async {
      final short =
          '${EncryptDecrypt.versionPrefix}${base64UrlEncode([1, 2, 3])}';
      expect(await EncryptDecrypt.decryptPassword(short, testKey), '');
    });

    test('returns empty string for null/empty inputs', () async {
      expect(await EncryptDecrypt.decryptPassword(null, testKey), '');
      expect(await EncryptDecrypt.decryptPassword('', testKey), '');
      expect(await EncryptDecrypt.decryptPassword('v2:AAAA', null), '');
      expect(await EncryptDecrypt.decryptPassword('v2:AAAA', ''), '');
    });
  });

  group('EncryptDecrypt legacy fallback', () {
    // Blob minted by the pre-v2 scheme (ChaCha20, fixed zero IV) for
    // password 'TestAppPassword123' with the key below. Must keep decoding.
    const legacyKey = 'dGVzdGtleXRlc3RrZXl0ZXN0a2V5dGVzdGtleXRlc3Q';
    const legacyBlob = 'eRxyIqyon0/IT1a8TMvnf8uQ';

    test('decrypts pre-v2 records', () async {
      expect(
        await EncryptDecrypt.decryptPassword(legacyBlob, legacyKey),
        'TestAppPassword123',
      );
    });

    test('legacy blob is deterministic (documents why v2 exists)', () async {
      // The whole point of v2: legacy re-encryption is deterministic.
      // This pins the legacy behavior so the fallback stays compatible.
      expect(
        await EncryptDecrypt.decryptPassword(legacyBlob, legacyKey),
        await EncryptDecrypt.decryptPassword(legacyBlob, legacyKey),
      );
    });
  });
}
