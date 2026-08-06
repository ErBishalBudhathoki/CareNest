import 'dart:io' show Platform;

import 'package:carenest/config/environment.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode, debugPrint;
import 'package:flutter/services.dart';

class AndroidAppCheckSelection {
  const AndroidAppCheckSelection({
    required this.provider,
    required this.label,
    required this.reason,
    this.installerPackage,
  });

  final AndroidProvider provider;
  final String label;
  final String reason;
  final String? installerPackage;
}

class AppCheckProviderResolver {
  static const MethodChannel _channel =
      MethodChannel('com.bishal.invoice/app_check');
  static const String _playStoreInstallerPackage = 'com.android.vending';

  // Fixed debug token registered in Firebase App Check (dev app). Seeding it
  // into the native debug store keeps it stable across reinstalls, so the
  // token never needs re-registration.
  static const String fixedDebugToken =
      'E276BDC2-0B80-417E-9111-0A13765F1120';

  static Future<AndroidAppCheckSelection> resolveAndroidSelection() async {
    final isDevelopmentFlavor = AppConfig.appFlavor == Flavor.development;

    if (kIsWeb || !Platform.isAndroid) {
      return const AndroidAppCheckSelection(
        provider: AndroidProvider.debug,
        label: 'Debug',
        reason: 'Non-Android platform fallback',
      );
    }

    if (isDevelopmentFlavor) {
      return const AndroidAppCheckSelection(
        provider: AndroidProvider.debug,
        label: 'Debug',
        reason: 'Development flavor',
      );
    }

    final installerPackage = await _getInstallerPackageName();
    final isPlayStoreInstall = installerPackage == _playStoreInstallerPackage;

    if (kReleaseMode && isPlayStoreInstall) {
      return AndroidAppCheckSelection(
        provider: AndroidProvider.playIntegrity,
        label: 'Play Integrity',
        reason: 'Production release installed from Google Play',
        installerPackage: installerPackage,
      );
    }

    return AndroidAppCheckSelection(
      provider: AndroidProvider.debug,
      label: 'Debug',
      reason: kReleaseMode
          ? 'Production release installed outside Google Play'
          : 'Non-release production build',
      installerPackage: installerPackage,
    );
  }

  /// Seeds the fixed debug token into the native App Check debug store so the
  /// same token is used on every install. Must run before activate().
  static Future<void> seedFixedDebugToken() async {
    try {
      await _channel.invokeMethod<void>(
        'seedDebugSecret',
        {'token': fixedDebugToken},
      );
    } on PlatformException catch (e) {
      debugPrint('App Check debug secret seeding failed: ${e.message}');
    } catch (e) {
      debugPrint('App Check debug secret seeding failed: $e');
    }
  }

  /// Returns the currently stored debug secret (the seeded fixed token).
  static Future<String?> getDebugSecret() async {
    try {
      return await _channel.invokeMethod<String>('getDebugSecret');
    } on PlatformException catch (e) {
      debugPrint('App Check debug secret lookup failed: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('App Check debug secret lookup failed: $e');
      return null;
    }
  }

  static Future<String?> _getInstallerPackageName() async {
    try {
      return await _channel.invokeMethod<String>('getInstallerPackageName');
    } on PlatformException catch (e) {
      debugPrint('App Check installer lookup failed: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('App Check installer lookup failed: $e');
      return null;
    }
  }
}
