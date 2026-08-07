import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PermissionManager {
  static const String _keyNotificationDenied = 'notification_permission_denied';
  static const String _keyStorageDenied = 'storage_permission_denied';

  /// Requests notification permission.
  /// Should be called after successful login.
  static Future<void> requestNotificationPermission(
    BuildContext context,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasDeniedBefore = prefs.getBool(_keyNotificationDenied) ?? false;

    // If previously denied, we might want to skip or show a different UI,
    // but typically we try again or show settings dialog if permanently denied.

    // Check current status first
    // For Firebase, we use requestPermission which handles status check internally mostly,
    // but let's use it directly.

    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
        );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted permission');
      // Reset denied flag if granted
      await prefs.setBool(_keyNotificationDenied, false);
    } else {
      debugPrint('User declined or has not accepted permission');
      await prefs.setBool(_keyNotificationDenied, true);

      // If the user explicitly denied, and we want to guide them:
      if (context.mounted) {
        // We can check if it's permanently denied on Android using permission_handler
        // equivalent, but Firebase doesn't expose "permanently denied" easily.
        // We can rely on the fact that if we asked and it's still denied, we might want to help.
        // However, standard flow is: request -> OS dialog. If denied, next time it might not show.

        // Let's offer to open settings if we think they denied it.
        // But we don't want to spam. Only if they just clicked deny?
        // Or if we know they denied it before?

        if (hasDeniedBefore) {
          _showSettingsDialog(
            context,
            'Enable Notifications',
            'Notifications are required to receive important updates. Please enable them in settings.',
          );
        }
      }
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
