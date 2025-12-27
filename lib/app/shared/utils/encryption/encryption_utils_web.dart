import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';

class EncryptionUtils {
  static String? _encryptionKey;
  static String? get encryptionKey => _encryptionKey;

  static String generateEncryptionKey() {
    final random = Random.secure();
    final keyBytes = Uint8List(32);
    for (var i = 0; i < keyBytes.length; i++) {
      keyBytes[i] = random.nextInt(256);
    }

    void setEncryptionKey(String key) {
      _encryptionKey = key;
    }

    final base64Key = (base64Url.encode(keyBytes)).substring(0, 16);
    setEncryptionKey(base64Key);
    return base64Key;
  }

  Uint8List generateSalt({int length = 32}) {
    debugPrint("[WEB] generateSalt called");
    var random = Random.secure();
    return Uint8List.fromList(
        List.generate(length, (_) => random.nextInt(256)));
  }

  // Web-safe fallback using SHA-256 instead of Argon2 (which isn't JS-compatible here)
  String encryptPasswordWithArgon2andSalt(String password, Uint8List salt) {
    debugPrint("[WEB] encryptPasswordWithArgon2andSalt fallback using SHA-256");
    final salts = salt.isEmpty ? generateSalt() : salt;
    final passwordBytes = utf8.encode(password);
    final combined = <int>[...passwordBytes, ...salts]
      
      ;
    final digest = crypto.sha256.convert(combined);

    final resultHex = _bytesToHex(Uint8List.fromList(digest.bytes));
    final saltHex = _bytesToHex(salts);
    final hashedPasswordWithSalt = '$resultHex$saltHex';
    return hashedPasswordWithSalt;
  }

  Uint8List hexStringToUint8List(String hexString) {
    var bytes = <int>[];
    for (var i = 0; i < hexString.length; i += 2) {
      var hex = hexString.substring(i, i + 2);
      bytes.add(int.parse(hex, radix: 16));
    }
    return Uint8List.fromList(bytes);
  }

  String _bytesToHex(Uint8List bytes) {
    final buffer = StringBuffer();
    for (final b in bytes) {
      buffer.write(b.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }
}