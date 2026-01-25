import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

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
        color: BauhausDesign.info.withOpacity(0.1),
        border: Border.all(color: BauhausDesign.info, width: 1),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bug_report, size: 16, color: BauhausDesign.info),
              const SizedBox(width: 8),
              Text(
                'DEBUG MODE',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.info,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: 'Fill Test Creds',
                  onPressed: () {
                    final loginViewModel = ref.read(loginViewModelProvider);
                    loginViewModel.setDebugCredentials();
                    _showSnackBar(context, 'Debug credentials filled!');
                  },
                  icon: Icons.copy,
                  variant: BauhausActionVariant.info,
                  isSmall: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: BauhausActionButton(
                  text: 'Clear',
                  onPressed: () {
                    final loginViewModel = ref.read(loginViewModelProvider);
                    loginViewModel.clearCredentials();
                    _showSnackBar(context, 'Credentials cleared!');
                  },
                  icon: Icons.clear,
                  variant: BauhausActionVariant.secondary,
                  isSmall: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Debug login test button
          SizedBox(
            width: double.infinity,
            child: BauhausActionButton(
              text: 'Test Login Flow',
              onPressed: () async {
                final loginViewModel = ref.read(loginViewModelProvider);
                try {
                  await loginViewModel.debugClearTokenAndLogin(context);
                  if (context.mounted) {
                    _showSnackBar(context, 'Debug login test triggered!');
                  }
                } catch (e) {
                  if (context.mounted) {
                    _showSnackBar(context, 'Debug login failed: $e',
                        isError: true);
                  }
                }
              },
              icon: Icons.login,
              variant: BauhausActionVariant.primary,
              isSmall: true,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral.withOpacity(0.2)),
            ),
            child: Text(
              'Test Email: logintest@example.com\nTest Password: password123',
              style: TextStyle(
                fontSize: 10,
                color: BauhausDesign.textMuted,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: BauhausDesign.surfaceWhite),
        ),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.neutral,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
      ),
    );
  }
}
