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

  final AndroidAppCheckProvider provider;
  final String label;
  final String reason;
  final String? installerPackage;
}

class AppCheckProviderResolver {
  static const MethodChannel _channel = MethodChannel(
    'com.bishal.invoice/app_check',
  );
  static const String _playStoreInstallerPackage = 'com.android.vending';

  // An App Check debug token is a CREDENTIAL: anyone holding it can mint valid
  // App Check tokens for this Firebase project. It must not be compiled into a
  // shipped binary. Dev/test builds inject it at build time with
  // --dart-define=APP_CHECK_DEBUG_TOKEN=... ; production builds leave it empty
  // and use Play Integrity exclusively.
  static const String fixedDebugToken = String.fromEnvironment(
    'APP_CHECK_DEBUG_TOKEN',
  );

  static Future<AndroidAppCheckSelection> resolveAndroidSelection() async {
    final isDevelopmentFlavor = AppConfig.appFlavor == Flavor.development;

    if (kIsWeb || !Platform.isAndroid) {
      return const AndroidAppCheckSelection(
        provider: AndroidDebugProvider(),
        label: 'Debug',
        reason: 'Non-Android platform fallback',
      );
    }

    if (isDevelopmentFlavor) {
      return const AndroidAppCheckSelection(
        provider: AndroidDebugProvider(),
        label: 'Debug',
        reason: 'Development flavor',
      );
    }

    final installerPackage = await _getInstallerPackageName();
    final isPlayStoreInstall = installerPackage == _playStoreInstallerPackage;

    // A release build must NEVER fall back to a debug provider. The previous
    // implementation did exactly that when the installer package was not
    // `com.android.vending` (sideloaded AAB, some OEM stores, or a failed
    // installer lookup), letting a shipped binary mint App Check tokens from a
    // known debug secret. Fail closed instead: Play Integrity or nothing.
    if (kReleaseMode) {
      return AndroidAppCheckSelection(
        provider: AndroidPlayIntegrityProvider(),
        label: 'Play Integrity',
        reason: isPlayStoreInstall
            ? 'Release build installed from Google Play'
            : 'Release build (Play Integrity enforced on every install)',
        installerPackage: installerPackage,
      );
    }

    return AndroidAppCheckSelection(
      provider: AndroidDebugProvider(),
      label: 'Debug',
      reason: 'Non-release production build',
      installerPackage: installerPackage,
    );
  }

  /// Seeds the fixed debug token into the native App Check debug store so the
  /// same token is used on every install. Must run before activate().
  static Future<void> seedFixedDebugToken() async {
    if (fixedDebugToken.isEmpty) {
      // No debug credential was supplied for this build. Never seed a default
      // one: doing so would recreate the shipped-secret problem.
      return;
    }
    try {
      await _channel.invokeMethod<void>('seedDebugSecret', {
        'token': fixedDebugToken,
      });
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
