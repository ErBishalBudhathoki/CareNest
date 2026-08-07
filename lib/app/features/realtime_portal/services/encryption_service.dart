import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

/// Encryption service for secure messaging
class EncryptionService {
  late encrypt.Encrypter _encrypter;
  late encrypt.IV _iv;
  late encrypt.Key _key;

  /// Initialize encryption with key
  void initialize(String encryptionKey) {
    // Generate key from string (32 bytes for AES-256)
    final keyBytes = _generateKeyFromString(encryptionKey);
    _key = encrypt.Key(keyBytes);

    // Generate IV (16 bytes)
    _iv = encrypt.IV.fromLength(16);

    // Create encrypter with AES algorithm
    _encrypter = encrypt.Encrypter(
      encrypt.AES(_key, mode: encrypt.AESMode.cbc),
    );

    debugPrint('Encryption service initialized');
  }

  /// Encrypt message
  String encryptMessage(String message) {
    try {
      final encrypted = _encrypter.encrypt(message, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      debugPrint('Error encrypting message: $e');
      rethrow;
    }
  }

  /// Decrypt message
  String decryptMessage(String encryptedMessage) {
    try {
      final encrypted = encrypt.Encrypted.fromBase64(encryptedMessage);
      final decrypted = _encrypter.decrypt(encrypted, iv: _iv);
      return decrypted;
    } catch (e) {
      debugPrint('Error decrypting message: $e');
      rethrow;
    }
  }

  /// Encrypt message with custom IV
  Map<String, String> encryptMessageWithIV(String message) {
    try {
      // Generate random IV for this message
      final iv = encrypt.IV.fromSecureRandom(16);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(_key, mode: encrypt.AESMode.cbc),
      );

      final encrypted = encrypter.encrypt(message, iv: iv);

      return {'encrypted': encrypted.base64, 'iv': iv.base64};
    } catch (e) {
      debugPrint('Error encrypting message with IV: $e');
      rethrow;
    }
  }

  /// Decrypt message with custom IV
  String decryptMessageWithIV(String encryptedMessage, String ivString) {
    try {
      final iv = encrypt.IV.fromBase64(ivString);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(_key, mode: encrypt.AESMode.cbc),
      );
      final encrypted = encrypt.Encrypted.fromBase64(encryptedMessage);

      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      return decrypted;
    } catch (e) {
      debugPrint('Error decrypting message with IV: $e');
      rethrow;
    }
  }

  /// Generate hash for message integrity
  String generateHash(String message) {
    final bytes = utf8.encode(message);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// Verify message hash
  bool verifyHash(String message, String hash) {
    final calculatedHash = generateHash(message);
    return calculatedHash == hash;
  }

  /// Generate signature hash for digital signature
  String generateSignatureHash(String signatureData, DateTime timestamp) {
    final combined = signatureData + timestamp.toIso8601String();
    return generateHash(combined);
  }

  /// Verify signature hash
  bool verifySignatureHash(
    String signatureData,
    DateTime timestamp,
    String hash,
  ) {
    final calculatedHash = generateSignatureHash(signatureData, timestamp);
    return calculatedHash == hash;
  }

  /// Encrypt file data
  Uint8List encryptFileData(Uint8List fileData) {
    try {
      final encrypted = _encrypter.encryptBytes(fileData, iv: _iv);
      return encrypted.bytes;
    } catch (e) {
      debugPrint('Error encrypting file data: $e');
      rethrow;
    }
  }

  /// Decrypt file data
  Uint8List decryptFileData(Uint8List encryptedData) {
    try {
      final encrypted = encrypt.Encrypted(encryptedData);
      final decrypted = _encrypter.decryptBytes(encrypted, iv: _iv);
      return Uint8List.fromList(decrypted);
    } catch (e) {
      debugPrint('Error decrypting file data: $e');
      rethrow;
    }
  }

  /// Generate encryption key from string
  Uint8List _generateKeyFromString(String keyString) {
    // Use SHA-256 to generate 32-byte key from string
    final bytes = utf8.encode(keyString);
    final hash = sha256.convert(bytes);
    return Uint8List.fromList(hash.bytes);
  }

  /// Generate random encryption key
  static String generateRandomKey() {
    final key = encrypt.Key.fromSecureRandom(32);
    return key.base64;
  }

  /// Generate random IV
  static String generateRandomIV() {
    final iv = encrypt.IV.fromSecureRandom(16);
    return iv.base64;
  }

  /// Encrypt JSON data
  String encryptJson(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    return encryptMessage(jsonString);
  }

  /// Decrypt JSON data
  Map<String, dynamic> decryptJson(String encryptedData) {
    final decrypted = decryptMessage(encryptedData);
    return jsonDecode(decrypted) as Map<String, dynamic>;
  }

  /// Create encrypted message package
  Map<String, String> createEncryptedPackage(String message) {
    final encrypted = encryptMessageWithIV(message);
    final hash = generateHash(message);

    return {
      'encrypted': encrypted['encrypted']!,
      'iv': encrypted['iv']!,
      'hash': hash,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  /// Verify and decrypt message package
  String? verifyAndDecryptPackage(Map<String, String> package) {
    try {
      final encrypted = package['encrypted'];
      final iv = package['iv'];
      final hash = package['hash'];

      if (encrypted == null || iv == null || hash == null) {
        debugPrint('Invalid package: missing required fields');
        return null;
      }

      // Decrypt message
      final decrypted = decryptMessageWithIV(encrypted, iv);

      // Verify hash
      final isValid = verifyHash(decrypted, hash);
      if (!isValid) {
        debugPrint('Hash verification failed');
        return null;
      }

      return decrypted;
    } catch (e) {
      debugPrint('Error verifying and decrypting package: $e');
      return null;
    }
  }

  /// Generate secure token
  String generateSecureToken() {
    final random = encrypt.Key.fromSecureRandom(32);
    return random.base64;
  }

  /// Hash password with salt
  String hashPassword(String password, String salt) {
    final combined = password + salt;
    final bytes = utf8.encode(combined);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// Verify password
  bool verifyPassword(String password, String salt, String hash) {
    final calculatedHash = hashPassword(password, salt);
    return calculatedHash == hash;
  }
}
