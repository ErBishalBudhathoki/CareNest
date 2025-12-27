import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/backend/api_method.dart';

/// A button widget that allows users to manually refresh their FCM token
/// and force registration with the backend.
class NotificationRefreshButton extends ConsumerWidget {
  const NotificationRefreshButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(userEmailProvider);
    final organizationId = ref.watch(organizationIdProvider);

    return ElevatedButton.icon(
      icon: const Icon(Icons.refresh),
      label: const Text('Refresh Notifications'),
      onPressed: () async {
        if (userEmail == null || organizationId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please log in to refresh notifications')),
          );
          return;
        }

        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Refreshing notification settings...'),
              ],
            ),
          ),
        );

        try {
          // Get a fresh FCM token
          await FirebaseMessaging.instance.deleteToken();
          final newToken = await FirebaseMessaging.instance.getToken();

          if (newToken == null) {
            throw Exception('Failed to get FCM token');
          }

          debugPrint('New FCM token: ${newToken.substring(0, 15)}...');

          // Send the token to the backend
          final apiMethod = ApiMethod();
          await apiMethod.registerFcmToken(
            userEmail,
            organizationId,
            newToken,
          );

          // Close loading dialog
          Navigator.of(context).pop();

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Notification settings refreshed successfully'),
            ),
          );
        } catch (e) {
          // Close loading dialog
          Navigator.of(context).pop();

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to refresh notification settings: $e'),
            ),
          );
        }
      },
    );
  }
}

/// A more comprehensive notification settings panel that can be added to a settings screen
class NotificationSettingsPanel extends ConsumerWidget {
  const NotificationSettingsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(userEmailProvider);
    final organizationId = ref.watch(organizationIdProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'If you are not receiving notifications, try refreshing your notification settings.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            FutureBuilder<String?>(
              future: FirebaseMessaging.instance.getToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final token = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FCM Token Status: ${token != null ? "Available" : "Not Available"}',
                      style: TextStyle(
                        color: token != null ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (token != null)
                      Text(
                        'Token: ${token.substring(0, 15)}...',
                        style: const TextStyle(fontSize: 12),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Token'),
                  onPressed: () async {
                    if (userEmail == null || organizationId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Please log in to refresh notifications')),
                      );
                      return;
                    }

                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Refreshing notification settings...'),
                          ],
                        ),
                      ),
                    );

                    try {
                      // Get a fresh FCM token
                      await FirebaseMessaging.instance.deleteToken();
                      final newToken =
                          await FirebaseMessaging.instance.getToken();

                      if (newToken == null) {
                        throw Exception('Failed to get FCM token');
                      }

                      debugPrint(
                          'New FCM token: ${newToken.substring(0, 15)}...');

                      // Send the token to the backend
                      final apiMethod = ApiMethod();
                      await apiMethod.registerFcmToken(
                        userEmail,
                        organizationId,
                        newToken,
                      );

                      // Close loading dialog
                      Navigator.of(context).pop();

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Notification settings refreshed successfully'),
                        ),
                      );
                    } catch (e) {
                      // Close loading dialog
                      Navigator.of(context).pop();

                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Failed to refresh notification settings: $e'),
                        ),
                      );
                    }
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.settings),
                  label: const Text('Open Settings'),
                  onPressed: () async {
                    // Open device notification settings
                    await FirebaseMessaging.instance.requestPermission(
                      alert: true,
                      badge: true,
                      sound: true,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
