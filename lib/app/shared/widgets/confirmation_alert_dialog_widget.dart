import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';

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

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

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
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              insetPadding: const EdgeInsets.all(BauhausDesign.space4),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(BauhausDesign.space6),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: (widget.confirmColor ?? BauhausDesign.primary)
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.confirmColor ?? BauhausDesign.primary,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.help_outline,
                        size: 32,
                        color: widget.confirmColor ?? BauhausDesign.primary,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space6),

                    // Title
                    Text(
                      widget.title,
                      style: BauhausDesign.getTextTheme(context).headlineSmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: BauhausDesign.space3),

                    // Content
                    Text(
                      widget.content,
                      style: BauhausDesign.getTextTheme(context).bodyLarge
                          ?.copyWith(
                            color: BauhausDesign.textDark, // Requested textDark
                            height: 1.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: BauhausDesign.space6),

                    // Buttons
                    Row(
                      children: [
                        // Cancel button
                        Expanded(
                          child: BauhausActionButton(
                            text: widget.cancelText ?? 'Cancel',
                            onPressed: () => Navigator.of(context).pop(),
                            variant: BauhausActionVariant.secondary,
                            isFullWidth: true,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        // Confirm button
                        Expanded(
                          child: BauhausActionButton(
                            text: widget.confirmText ?? 'Confirm',
                            onPressed: widget.confirmAction,
                            backgroundColor: widget.confirmColor,
                            // If confirmColor is provided, we use it as background,
                            // otherwise variant defaults to primary in the widget logic
                            // if we don't pass backgroundColor, but passing it explicitly overrides.
                            // If widget.confirmColor is null, let's stick to primary variant logic inside BauhausActionButton
                            // by not passing it if null, but here we can pass it.
                            variant: BauhausActionVariant.primary,
                            isFullWidth: true,
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
}
