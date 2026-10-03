import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PermissionManager {
  static const String _keyNotificationDenied = 'notification_permission_denied';
  static const String _keyNotificationNudgeShown =
      'notification_permission_nudge_shown';
  static const String _keyStorageDenied = 'storage_permission_denied';

  /// Requests notification permission.
  /// Should be called after successful login.
  static Future<void> requestNotificationPermission(
    BuildContext context,
  ) async {
    // Callers invoke this from initState and post-frame callbacks, where an
    // unhandled async error takes the process down (and fails widget tests). A
    // missed permission prompt is far less harmful than that, so the guard
    // lives here rather than at each call site.
    try {
      final prefs = await SharedPreferences.getInstance();

      // Read the current status before doing anything that could prompt. The OS
      // only ever shows its dialog once, so asking again is a no-op — but it is
      // checking first that lets us tell "never asked" apart from "said no".
      final settings = await FirebaseMessaging.instance
          .getNotificationSettings();
      final status = settings.authorizationStatus;

      if (status == AuthorizationStatus.authorized ||
          status == AuthorizationStatus.provisional) {
        debugPrint('PermissionManager: notifications already allowed');
        await prefs.setBool(_keyNotificationDenied, false);
        // They fixed it in Settings, so they deserve the nudge again if they
        // ever deny again later.
        await prefs.remove(_keyNotificationNudgeShown);
        return;
      }

      if (status == AuthorizationStatus.notDetermined) {
        // First and only OS prompt.
        final result = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        );

        if (result.authorizationStatus == AuthorizationStatus.authorized ||
            result.authorizationStatus == AuthorizationStatus.provisional) {
          debugPrint('PermissionManager: notification permission granted');
          await prefs.setBool(_keyNotificationDenied, false);
          return;
        }

        debugPrint('PermissionManager: notification permission declined');
        await prefs.setBool(_keyNotificationDenied, true);
        // Deliberately no settings nudge here. They have only just answered,
        // and being pushed towards Settings before they have even seen the
        // prompt is hostile. The nudge below comes on a later visit instead.
        return;
      }

      // Already denied or permanently denied. The OS will not prompt again, so
      // the only thing left to offer is a pointer to Settings — and it is worth
      // showing exactly once per install. Showing it on every launch was the
      // nag loop: dismiss it, relaunch, get it again, forever.
      await prefs.setBool(_keyNotificationDenied, true);

      final nudgeShown = prefs.getBool(_keyNotificationNudgeShown) ?? false;
      if (nudgeShown) {
        debugPrint(
          'PermissionManager: notifications denied, settings nudge already shown',
        );
        return;
      }

      if (!context.mounted) return;

      // Recorded before showing so a concurrent call cannot double up. There is
      // no await between the read above and this write.
      await prefs.setBool(_keyNotificationNudgeShown, true);
      _showSettingsDialog(
        context,
        'Enable Notifications',
        'Notifications are used for important updates about shifts and '
            'schedules. You can turn them back on in Settings.',
      );
    } catch (error) {
      debugPrint(
        'PermissionManager: notification permission request failed: $error',
      );
    }
  }

  /// Requests storage permission.
  /// Should be called before generating invoices.
  static Future<bool> requestStoragePermission(BuildContext context) async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      // Android 13+ uses specific permissions for images/video/audio
      // But for general files/downloads, we might just need nothing or MANAGE_EXTERNAL_STORAGE (rarely).
      // If we are just writing to app directories, we don't need permissions on recent Android.
      // If we are writing to public Downloads, we verify.

      // Checking SDK version is good practice.
      // For now, let's assume standard storage permission flow.

      // Check if Android 13+ (API 33)
      // On Android 13, READ_EXTERNAL_STORAGE is deprecated for READ_MEDIA_IMAGES etc.
      // But for documents, it's tricky.
      // Let's use Permission.storage for < 13 and check logic.

      // Ideally, check device info, but permission_handler handles SDK checks often.
      // Permission.storage maps to READ_EXTERNAL_STORAGE / WRITE_EXTERNAL_STORAGE

      // For creating invoices (PDFs), usually we need storage if saving to public folder.

      status = await Permission.storage.status;

      // Android 13+ (API 33) handling for Images/Videos/Audio
      // If we are dealing with files, it's different.
      // permission_handler 10.0+ handles this.

      // However, if the app targets Android 13+, Permission.storage might return denied permanently.
      // We should check Permission.manageExternalStorage if absolutely needed (usually not).
      // Or just proceed if it's strictly scoped storage.

      // Let's stick to standard Permission.storage for now, as that's what was likely used.
      if (await Permission.storage.request().isGranted) {
        return true;
      }

      // Handle Android 13+ specific case where storage permission might not be applicable
      // If we are using media, we ask for photos.
      // If just files, we might not need permission if using MediaStore or SAF.
      // But assuming legacy app behavior:

      if (status.isDenied) {
        // Show explanation
        bool? result = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Storage Permission Required'),
            content: const Text(
              'This app needs storage permission to save invoices to your device.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Grant'),
              ),
            ],
          ),
        );

        if (result == true) {
          status = await Permission.storage.request();
        }
      }
    } else {
      // iOS etc.
      status = await Permission.storage.status;
      if (status.isDenied) {
        status = await Permission.storage.request();
      }
    }

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showSettingsDialog(
          context,
          'Storage Permission Required',
          'Storage permission is needed to save invoices. Please enable it in settings.',
        );
      }
      return false;
    }

    return false;
  }

  static void _showSettingsDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
