import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

class ConfirmationAlertDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback confirmAction;
  final String? cancelText;
  final String? confirmText;
  final Color? confirmColor;

  const ConfirmationAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmAction,
    this.cancelText,
    this.confirmText,
    this.confirmColor,
  });

  @override
  State<ConfirmationAlertDialog> createState() =>
      _ConfirmationAlertDialogState();
}

class _ConfirmationAlertDialogState extends State<ConfirmationAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AlertDialog(
              backgroundColor: ModernSaasDesign.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: (widget.confirmColor ?? ModernSaasDesign.primary)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.help_outline,
                        size: 30,
                        color: widget.confirmColor ?? ModernSaasDesign.primary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      widget.title,
                      style: ModernSaasDesign.headlineMedium.copyWith(
                        color: ModernSaasDesign.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Content
                    Text(
                      widget.content,
                      style: ModernSaasDesign.bodyLarge.copyWith(
                        color: ModernSaasDesign.textSecondary,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Buttons
                    Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: _buildButton(
                            text: widget.cancelText ?? 'Cancel',
                            onPressed: () => Navigator.of(context).pop(),
                            isPrimary: false,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Confirm button
                        Expanded(
                          child: _buildButton(
                            text: widget.confirmText ?? 'Confirm',
                            onPressed: () {
                              widget.confirmAction();
                            },
                            isPrimary: true,
                            color: widget.confirmColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build modern button
  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
    Color? color,
  }) {
    final buttonColor = color ?? ModernSaasDesign.primary;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isPrimary ? buttonColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary
            ? null
            : Border.all(
                color: ModernSaasDesign.border,
                width: 1.5,
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: ModernSaasDesign.labelLarge.copyWith(
                color: isPrimary
                    ? ModernSaasDesign.textOnPrimary
                    : ModernSaasDesign.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
