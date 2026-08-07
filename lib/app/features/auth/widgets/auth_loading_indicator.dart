import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

/// Enhanced loading indicator widget for authentication processes
/// with smooth animations and user feedback
class AuthLoadingIndicator extends StatefulWidget {
  final String message;
  final bool isVisible;
  final VoidCallback? onCancel;
  final Duration animationDuration;

  const AuthLoadingIndicator({
    super.key,
    this.message = 'Signing you in...',
    this.isVisible = false,
    this.onCancel,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AuthLoadingIndicator> createState() => _AuthLoadingIndicatorState();
}

class _AuthLoadingIndicatorState extends State<AuthLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    if (widget.isVisible) {
      _startAnimations();
    }
  }

  @override
  void didUpdateWidget(AuthLoadingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _startAnimations();
      } else {
        _stopAnimations();
      }
    }
  }

  void _startAnimations() {
    _fadeController.forward();
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
  }

  void _stopAnimations() {
    _fadeController.reverse();
    _rotationController.stop();
    _pulseController.stop();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Container(
            color: BauhausDesign.textDark.withOpacity(0.1),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Bauhaus geometric loading indicator - square with animation
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: AnimatedBuilder(
                            animation: _rotationAnimation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _rotationAnimation.value * 2 * 3.14159,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: BauhausDesign.primary,
                                    border: Border.all(
                                      color: BauhausDesign.neutral,
                                      width: 2,
                                    ),
                                    boxShadow: const [
                                      BauhausDesign.shadowHardSm,
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.security_outlined,
                                    color: BauhausDesign.surfaceWhite,
                                    size: 30,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Loading message
                    Text(
                      widget.message,
                      style: BauhausDesign.getTextTheme(context).titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      'Please wait while we verify your credentials',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                      textAlign: TextAlign.center,
                    ),

                    // Cancel button (if provided)
                    if (widget.onCancel != null) ...[
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: widget.onCancel,
                        style: TextButton.styleFrom(
                          foregroundColor: BauhausDesign.textMuted,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: BauhausDesign.getTextTheme(
                            context,
                          ).labelLarge?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
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

/// Overlay loading indicator that can be shown on top of any widget
class AuthLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String loadingMessage;
  final VoidCallback? onCancel;

  const AuthLoadingOverlay({
    super.key,
    required this.child,
    this.isLoading = false,
    this.loadingMessage = 'Processing...',
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AuthLoadingIndicator(
            message: loadingMessage,
            isVisible: isLoading,
            onCancel: onCancel,
          ),
      ],
    );
  }
}
