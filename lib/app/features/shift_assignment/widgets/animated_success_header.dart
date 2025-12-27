import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

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
    _iconScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
    ));

    _iconRotationAnimation = Tween<double>(
      begin: -0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
    ));

    // Title animations
    _titleSlideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
    ));

    _titleFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
    ));

    // Details animations
    _detailsSlideAnimation = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
    ));

    _detailsFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
    ));

    // Pulse animation
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Confetti animation
    _confettiAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _confettiController,
      curve: Curves.easeOut,
    ));
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildSuccessIcon(),
              const SizedBox(height: 24.0),
              _buildTitle(),
              const SizedBox(height: 16.0),
              _buildDetails(),
              const SizedBox(height: 8.0),
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
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorSuccess.withOpacity(0.1),
            ),
          ),
        ),
        // Main icon container
        Transform.scale(
          scale: _iconScaleAnimation.value,
          child: Transform.rotate(
            angle: _iconRotationAnimation.value,
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.colorSuccess,
                    Color(0xFF059669),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorSuccess,
                    blurRadius: 20.0,
                    offset: Offset(0, 8.0),
                    spreadRadius: -5.0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.colorWhite,
                size: 40.0,
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
      AppColors.colorPrimary,
      AppColors.colorSecondary,
      AppColors.colorAccent,
      AppColors.colorSuccess,
      AppColors.colorInfo,
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
                  shape: BoxShape.circle,
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
        child: const Text(
          'Assignment Successful!',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: AppColors.colorPrimary,
            letterSpacing: -0.5,
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
              label: 'Employee',
              value: widget.employeeName,
              color: AppColors.colorBlue,
            ),
            const SizedBox(height: 12.0),
            _buildDetailRow(
              icon: Icons.business_outlined,
              label: 'Client',
              value: widget.clientName,
              color: AppColors.colorSecondary,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: color.withOpacity(0.1),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.colorGrey600,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.colorFontPrimary,
                    fontSize: 16.0,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.colorSuccess.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            widget.assignmentSummary,
            style: const TextStyle(
              color: AppColors.colorSuccess,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
