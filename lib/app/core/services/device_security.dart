import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/core/utils/navigation.dart';

/// Device integrity posture reported by the native shells
/// (root/jailbreak indicators, emulator, debuggable build).
@immutable
class SecurityPosture {
  const SecurityPosture({
    required this.compromised,
    required this.reasons,
    required this.emulator,
    required this.debuggable,
    this.unknown = false,
  });

  final bool compromised;
  final List<String> reasons;
  final bool emulator;
  final bool debuggable;
  final bool unknown;

  static const unknownPosture = SecurityPosture(
    compromised: false,
    reasons: [],
    emulator: false,
    debuggable: false,
    unknown: true,
  );

  factory SecurityPosture.fromMap(Map? map) {
    if (map == null) return unknownPosture;
    bool asBool(Object? v) => v is bool ? v : v.toString() == 'true';
    final rawReasons = map['reasons'];
    final reasons = rawReasons is Iterable
        ? rawReasons.map((e) => e.toString()).toList()
        : <String>[];
    return SecurityPosture(
      compromised: asBool(map['compromised']),
      reasons: reasons,
      emulator: asBool(map['emulator']),
      debuggable: asBool(map['debuggable']),
    );
  }
}

/// Root/jailbreak detection bridge (no third-party packages).
///
/// Native checks live in `MainActivity.kt` (Android) and `AppDelegate.swift`
/// (iOS) behind the `com.bishal.invoice/device_security` channel. Detection
/// is best-effort by nature — it raises the bar and warns the user, it does
/// not brick the app (rooted devices include legitimate power users, and
/// checks are bypassable by a determined attacker regardless).
class DeviceSecurity {
  DeviceSecurity._();

  static const channelName = 'com.bishal.invoice/device_security';
  static const _channel = MethodChannel(channelName);

  /// Queries the native shell. Never throws — returns [unknownPosture]
  /// when the platform channel is unavailable (e.g. unit tests, web).
  static Future<SecurityPosture> check() async {
    if (kIsWeb) return SecurityPosture.unknownPosture;
    try {
      final result = await _channel.invokeMethod('getSecurityPosture');
      if (result is Map) return SecurityPosture.fromMap(result);
      return SecurityPosture.unknownPosture;
    } on MissingPluginException {
      return SecurityPosture.unknownPosture;
    } on PlatformException {
      return SecurityPosture.unknownPosture;
    }
  }

  /// One-shot startup check: shows a non-dismissible warning on compromised
  /// devices. Safe to call on every launch; no-ops everywhere else.
  static Future<void> runStartupCheck() async {
    final posture = await check();
    if (!posture.compromised) return;
    final nav = navigatorKey.currentState;
    if (nav == null || !nav.mounted) return;
    await showDialog<void>(
      context: nav.context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Security warning'),
        content: Text(
          'This device shows signs of rooting or jailbreaking '
          '(${posture.reasons.join(', ')}), which exposes app data — '
          'including NDIS participant information — to other apps on '
          'this device.\n\nConsider using CareNest on a non-modified '
          'device for client work.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('I understand'),
          ),
        ],
      ),
    );
  }
}
