import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

/// Standardized error widget using Bauhaus design system
///
/// Provides consistent error display across the app with:
/// - Clear visual hierarchy
/// - Retry functionality
/// - Optional diagnostics for debugging
/// - Haptic feedback on actions
class BauhausErrorWidget extends StatelessWidget {
  /// Error title displayed prominently
  final String title;

  /// Detailed error message
  final String message;

  /// Optional callback for retry action
  final VoidCallback? onRetry;

  /// Whether to show diagnostics button (dev mode)
  final bool showDiagnostics;

  /// Optional diagnostic information
  final String? diagnosticInfo;

  /// Icon to display (defaults to error icon)
  final IconData icon;

  /// Whether to use compact layout
  final bool compact;

  const BauhausErrorWidget({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.showDiagnostics = false,
    this.diagnosticInfo,
    this.icon = Icons.error_outline,
    this.compact = false,
  });

  /// Factory for network errors
  factory BauhausErrorWidget.network({
    VoidCallback? onRetry,
    bool compact = false,
  }) {
    return BauhausErrorWidget(
      title: 'CONNECTION ERROR',
      message: 'Unable to connect to the server. Please check your internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
      compact: compact,
    );
  }

  /// Factory for empty state
  factory BauhausErrorWidget.empty({
    String title = 'NO RESULTS',
    String message = 'No items found matching your criteria.',
    IconData icon = Icons.inbox_outlined,
  }) {
    return BauhausErrorWidget(
      title: title,
      message: message,
      icon: icon,
    );
  }

  /// Factory for permission errors
  factory BauhausErrorWidget.permission({
    required String permissionType,
    VoidCallback? onRequestPermission,
  }) {
    return BauhausErrorWidget(
      title: 'PERMISSION REQUIRED',
      message: '$permissionType access is required for this feature. Please grant permission to continue.',
      icon: Icons.lock_outline,
      onRetry: onRequestPermission,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _buildCompact(context);
    }
    return _buildFull(context);
  }

  Widget _buildFull(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(BauhausDesign.space4),
        padding: const EdgeInsets.all(BauhausDesign.space6),
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border.all(color: BauhausDesign.error, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with tinted background
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.error.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.error, width: 2),
              ),
              child: Icon(
                icon,
                size: 48,
                color: BauhausDesign.error,
              ),
            ),
            const SizedBox(height: BauhausDesign.space6),

            // Title
            Text(
              title,
              style: GoogleFonts.oswald(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.error,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space3),

            // Divider
            Container(
              height: 3,
              width: 60,
              color: BauhausDesign.error,
            ),
            const SizedBox(height: BauhausDesign.space4),

            // Message
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: BauhausDesign.textDark,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space6),

            // Actions
            if (onRetry != null) ...[
              _BauhausRetryButton(onPressed: () {
                HapticFeedback.mediumImpact();
                onRetry!();
              }),
            ],

            if (showDiagnostics && diagnosticInfo != null) ...[
              const SizedBox(height: BauhausDesign.space3),
              _DiagnosticsButton(info: diagnosticInfo!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCompact(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.error.withOpacity(0.1),
        border: Border.all(color: BauhausDesign.error, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          Icon(icon, color: BauhausDesign.error, size: 24),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.error,
                  ),
                ),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: BauhausDesign.textDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: BauhausDesign.space2),
            InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                onRetry!();
              },
              child: Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.error,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: BauhausDesign.textLight,
                  size: 20,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BauhausRetryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BauhausRetryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space6,
          vertical: BauhausDesign.space3,
        ),
        decoration: BoxDecoration(
          color: BauhausDesign.error,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.refresh, color: BauhausDesign.textLight, size: 20),
            const SizedBox(width: BauhausDesign.space2),
            Text(
              'TRY AGAIN',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textLight,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiagnosticsButton extends StatelessWidget {
  final String info;

  const _DiagnosticsButton({required this.info});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              'DIAGNOSTICS',
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
            ),
            content: SingleChildScrollView(
              child: SelectableText(
                info,
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: BauhausDesign.textDark,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: info));
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
                },
                child: const Text('COPY'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('CLOSE'),
              ),
            ],
          ),
        );
      },
      child: Text(
        'VIEW DIAGNOSTICS',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: BauhausDesign.neutral,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
