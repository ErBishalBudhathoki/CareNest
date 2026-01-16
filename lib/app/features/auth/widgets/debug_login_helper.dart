import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';

/// Debug helper widget for login screen
/// Only visible in debug mode to help with testing
class DebugLoginHelper extends ConsumerWidget {
  const DebugLoginHelper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show in debug mode
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BauhausDesign.neutral.withOpacity(0.1),
        border: Border.all(color: BauhausDesign.neutral, width: 1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🐛 DEBUG MODE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.neutral,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final loginViewModel = ref.read(loginViewModelProvider);
                    loginViewModel.setDebugCredentials();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Debug credentials filled!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bug_report, size: 16),
                  label: const Text(
                    'Fill Test Creds',
                    style: TextStyle(fontSize: 11),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                    foregroundColor: BauhausDesign.surfaceLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 32),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final loginViewModel = ref.read(loginViewModelProvider);
                    loginViewModel.clearCredentials();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Credentials cleared!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.clear, size: 16),
                  label: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 11),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                    foregroundColor: BauhausDesign.surfaceLight,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 32),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Debug login test button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                final loginViewModel = ref.read(loginViewModelProvider);
                try {
                  await loginViewModel.debugClearTokenAndLogin(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Debug login test triggered!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Debug login failed: $e'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.login, size: 16),
              label: const Text(
                'Test Login Flow',
                style: TextStyle(fontSize: 11),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                foregroundColor: BauhausDesign.surfaceLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                minimumSize: const Size(0, 32),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Test Email: logintest@example.com\nTest Password: password123',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}
