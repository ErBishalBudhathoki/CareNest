import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Animated header widget for the shift assignment success screen
class AnimatedSuccessHeader extends StatefulWidget {
  final String employeeName;
  final String clientName;
  final String assignmentSummary;
  final VoidCallback? onAnimationComplete;

  const AnimatedSuccessHeader({
    super.key,
    required this.employeeName,
    required this.clientName,
    required this.assignmentSummary,
    this.onAnimationComplete,
  });

  @override
  State<AnimatedSuccessHeader> createState() => _AnimatedSuccessHeaderState();
}

class _AnimatedSuccessHeaderState extends State<AnimatedSuccessHeader>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _confettiController;

  late Animation<double> _iconScaleAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _titleSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _detailsSlideAnimation;
  late Animation<double> _detailsFadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _confettiAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Main animation controller
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Confetti animation controller
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Icon animations
    _iconScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    _iconRotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    // Title animations
    _titleSlideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );

    // Details animations
    _detailsSlideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _detailsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    // Pulse animation
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Confetti animation
    _confettiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _confettiController, curve: Curves.easeOut),
    );
  }

  void _startAnimations() {
    _mainController.forward().then((_) {
      if (mounted) {
        _pulseController.repeat(reverse: true);
        _confettiController.forward();
        widget.onAnimationComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _mainController,
        _pulseController,
        _confettiController,
      ]),
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHardXs],
          ),
          child: Column(
            children: [
              _buildSuccessIcon(),
              const SizedBox(height: BauhausDesign.space3),
              _buildTitle(),
              const SizedBox(height: BauhausDesign.space2),
              _buildDetails(),
              const SizedBox(height: BauhausDesign.space2),
              _buildSummary(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuccessIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse surface
        Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: BauhausDesign.success.withOpacity(0.1),
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
            ),
          ),
        ),
        // Main icon container
        Transform.scale(
          scale: _iconScaleAnimation.value,
          child: Transform.rotate(
            angle: _iconRotationAnimation.value,
            child: Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: BauhausDesign.success,
                border: Border.all(color: BauhausDesign.neutral, width: 3),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: BauhausDesign.surfaceWhite,
                size: 34.0,
              ),
            ),
          ),
        ),
        // Confetti particles
        ..._buildConfettiParticles(),
      ],
    );
  }

  List<Widget> _buildConfettiParticles() {
    final particles = <Widget>[];
    const colors = [
      BauhausDesign.primary,
      BauhausDesign.secondary,
      BauhausDesign.accent,
      BauhausDesign.success,
      BauhausDesign.info,
    ];

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45.0) * (3.14159 / 180.0);
      final distance = 60.0 * _confettiAnimation.value;
      final x = distance * math.cos(angle);
      final y = distance * math.sin(angle);

      particles.add(
        Positioned(
          left: x,
          top: y,
          child: Transform.scale(
            scale: _confettiAnimation.value,
            child: Opacity(
              opacity: (1.0 - _confettiAnimation.value).clamp(0.0, 1.0),
              child: Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: colors[i % colors.length],
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return particles;
  }

  Widget _buildTitle() {
    return Transform.translate(
      offset: Offset(0, _titleSlideAnimation.value),
      child: Opacity(
        opacity: _titleFadeAnimation.value.clamp(0.0, 1.0),
        child: Text(
          AppLocalizations.of(context)!.assignmentSuccessful,
          style: BauhausDesign.getTextTheme(context).displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Transform.translate(
      offset: Offset(0, _detailsSlideAnimation.value),
      child: Opacity(
        opacity: _detailsFadeAnimation.value.clamp(0.0, 1.0),
        child: Column(
          children: [
            _buildDetailRow(
              icon: Icons.person_outline,
              label: AppLocalizations.of(context)!.employee,
              value: widget.employeeName,
              color: BauhausDesign.info,
            ),
            const SizedBox(height: BauhausDesign.space2),
            _buildDetailRow(
              icon: Icons.business_outlined,
              label: AppLocalizations.of(context)!.client,
              value: widget.clientName,
              color: BauhausDesign.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              border: Border.all(color: color),
            ),
            child: Icon(icon, color: color, size: 20.0),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: BauhausDesign.getTextTheme(context).bodyLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Transform.translate(
      offset: Offset(0, _detailsSlideAnimation.value),
      child: Opacity(
        opacity: _detailsFadeAnimation.value.clamp(0.0, 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: BauhausDesign.space4,
            vertical: BauhausDesign.space2,
          ),
          decoration: BoxDecoration(
            color: BauhausDesign.success.withOpacity(0.1),
            border: Border.all(color: BauhausDesign.success, width: 1.5),
          ),
          child: Text(
            widget.assignmentSummary,
            style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              color: BauhausDesign.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
