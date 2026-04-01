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
