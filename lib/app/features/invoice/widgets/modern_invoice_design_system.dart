import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'dart:ui';

/// Modern Invoice Design System
/// Implements the same design patterns as the pricing module
class ModernInvoiceDesign {
  // Modern Color Palette - Next-Gen SAAS Colors with 3D Support
  static const Color primary = Color(0xFF6366F1); // Indigo - More vibrant
  static const Color primaryDark = Color(0xFF4338CA); // Deep Indigo
  static const Color primaryLight = Color(0xFFA5B4FC); // Light Indigo
  static const Color primaryGlow = Color(0x336366F1); // Glow effect

  static const Color secondary = Color(0xFF06D6A0); // Teal Green - More modern
  static const Color secondaryDark = Color(0xFF059669); // Dark Teal
  static const Color secondaryLight = Color(0xFF7DD3FC); // Light Teal
  static const Color secondaryGlow = Color(0x3306D6A0); // Glow effect

  static const Color accent = Color(0xFFFF6B6B); // Coral - More playful
  static const Color accentDark = Color(0xFFDC2626); // Dark Coral
  static const Color accentLight = Color(0xFFFECACA); // Light Coral
  static const Color accentGlow = Color(0x33FF6B6B); // Glow effect

  static const Color error = Color(0xFFEF4444); // Red
  static const Color errorDark = Color(0xFFDC2626); // Dark Red
  static const Color errorLight = Color(0xFFFECACA); // Light Red

  static const Color warning = Color(0xFF06D6A0); // Teal Green
  static const Color success = Color(0xFF10B981); // Green
  static const Color info = Color(0xFF3B82F6); // Blue

  // Neutral Colors - Modern Gray Scale
  static const Color neutral50 = Color(0xFFF8FAFC);
  static const Color neutral100 = Color(0xFFF1F5F9);
  static const Color neutral200 = Color(0xFFE2E8F0);
  static const Color neutral300 = Color(0xFFCBD5E1);
  static const Color neutral400 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral600 = Color(0xFF475569);
  static const Color neutral700 = Color(0xFF334155);
  static const Color neutral800 = Color(0xFF1E293B);
  static const Color neutral900 = Color(0xFF0F172A);

  // Surface Colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundSecondary = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color borderFocus = Color(0xFF3B82F6);

  // Christmas/Holiday Theme Colors
  static const Color christmasRed = Color(0xFFDC2626); // Festive Red
  static const Color christmasGreen = Color(0xFF059669); // Christmas Green
  static const Color christmasGold = Color(0xFF06D6A0); // Teal Green
  static const Color christmasPink = Color(0xFFF8BBD9); // Soft Pink Background
  static const Color christmasPinkDark = Color(0xFFEC4899); // Vibrant Pink
  static const Color christmasWhite = Color(0xFFFFFBFF); // Pure White
  static const Color christmasSnow = Color(0xFFF1F5F9); // Snow White

  // Christmas Gradients
  static const LinearGradient christmasRedGradient = LinearGradient(
    colors: [Color(0xFFDC2626), Color(0xFFEF4444), Color(0xFFF87171)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient christmasGreenGradient = LinearGradient(
    colors: [Color(0xFF059669), Color(0xFF10B981), Color(0xFF34D399)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient christmasGoldGradient = LinearGradient(
    colors: [Color(0xFF06D6A0), Color(0xFF10B981), Color(0xFF34D399)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient christmasPinkGradient = LinearGradient(
    colors: [Color(0xFFF8BBD9), Color(0xFFF3E8FF), Color(0xFFFFFFFF)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Advanced 3D Gradients with Depth
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFF4338CA)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF06D6A0), Color(0xFF10B981), Color(0xFF059669)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFF06D6A0), Color(0xFF10B981), Color(0xFF059669)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphism Card Gradient
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0x40FFFFFF), Color(0x20FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Mesh Gradients for 3D Effects
  static const RadialGradient meshGradient1 = RadialGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
    stops: [0.0, 0.6, 1.0],
    center: Alignment.topLeft,
    radius: 1.5,
  );

  static const RadialGradient meshGradient2 = RadialGradient(
    colors: [Color(0xFF06D6A0), Color(0xFF3B82F6), Color(0xFF6366F1)],
    stops: [0.0, 0.6, 1.0],
    center: Alignment.bottomRight,
    radius: 1.2,
  );

  // Holographic Gradient
  static const LinearGradient holographicGradient = LinearGradient(
    colors: [
      Color(0xFFFF6B6B),
      Color(0xFFFFD93D),
      Color(0xFF6BCF7F),
      Color(0xFF4D96FF),
      Color(0xFF9B59B6),
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Typography Scale - Modern Font Sizes
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
    color: textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
    color: textPrimary,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: textTertiary,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: textTertiary,
  );

  // Spacing System - 8pt Grid
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;
  static const double space24 = 96.0;
  static const double space32 = 128.0;
  static const double space40 = 160.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 20.0;
  static const double radius3xl = 24.0;
  static const double radiusFull = 9999.0;

  // Advanced 3D Shadows & Elevation
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 15,
      offset: Offset(0, 8),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 6,
      offset: Offset(0, 4),
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x25000000),
      blurRadius: 25,
      offset: Offset(0, 15),
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 10,
      offset: Offset(0, 8),
      spreadRadius: -3,
    ),
  ];

  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x30000000),
      blurRadius: 40,
      offset: Offset(0, 25),
      spreadRadius: -8,
    ),
    BoxShadow(
      color: Color(0x20000000),
      blurRadius: 15,
      offset: Offset(0, 12),
      spreadRadius: -5,
    ),
  ];

  // 3D Depth Shadows
  static const List<BoxShadow> shadow3D = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 60,
      offset: Offset(0, 30),
      spreadRadius: -10,
    ),
    BoxShadow(
      color: Color(0x25000000),
      blurRadius: 25,
      offset: Offset(0, 15),
      spreadRadius: -5,
    ),
    BoxShadow(
      color: Color(0x15000000),
      blurRadius: 10,
      offset: Offset(0, 8),
      spreadRadius: -2,
    ),
  ];

  // Colored Glow Shadows
  static const List<BoxShadow> shadowPrimaryGlow = [
    BoxShadow(
      color: Color(0x406366F1),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowSecondaryGlow = [
    BoxShadow(
      color: Color(0x4006D6A0),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowAccentGlow = [
    BoxShadow(
      color: Color(0x40FF6B6B),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Breakpoints for Responsive Design
  static const double breakpointMobile = 480;
  static const double breakpointTablet = 768;
  static const double breakpointDesktop = 1024;
  static const double breakpointLarge = 1280;

  // Icon Sizes
  static const double iconSize = 24.0;

  // Helper Methods
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < breakpointMobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= breakpointMobile && width < breakpointDesktop;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= breakpointDesktop;
  }

  static double getResponsivePadding(BuildContext context) {
    if (isMobile(context)) return space4;
    if (isTablet(context)) return space6;
    return space8;
  }

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) return baseSize * 0.9;
    if (isTablet(context)) return baseSize;
    return baseSize * 1.1;
  }
}

/// Modern 3D Floating Action Button
class Modern3DFloatingButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final bool isExtended;
  final String? label;

  const Modern3DFloatingButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 56.0,
    this.isExtended = false,
    this.label,
  });

  @override
  State<Modern3DFloatingButton> createState() => _Modern3DFloatingButtonState();
}

class _Modern3DFloatingButtonState extends State<Modern3DFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateZ(_rotationAnimation.value)
            ..scale(_scaleAnimation.value),
          child: Container(
            decoration: BoxDecoration(
              gradient: ModernInvoiceDesign.primaryGradient,
              borderRadius: BorderRadius.circular(widget.size / 2),
              boxShadow: ModernInvoiceDesign.shadowPrimaryGlow,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onPressed,
                onTapDown: (_) => _onPressedDown(),
                onTapUp: (_) => _onPressedUp(),
                onTapCancel: () => _onPressedUp(),
                borderRadius: BorderRadius.circular(widget.size / 2),
                child: Container(
                  width: widget.isExtended ? null : widget.size,
                  height: widget.size,
                  padding: widget.isExtended
                      ? const EdgeInsets.symmetric(
                          horizontal: ModernInvoiceDesign.space4)
                      : null,
                  child: widget.isExtended
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.icon,
                              color: widget.foregroundColor ??
                                  ModernInvoiceDesign.textOnPrimary,
                              size: 24,
                            ),
                            if (widget.label != null) ...[
                              const SizedBox(width: ModernInvoiceDesign.space2),
                              Text(
                                widget.label!,
                                style: ModernInvoiceDesign.labelLarge.copyWith(
                                  color: widget.foregroundColor ??
                                      ModernInvoiceDesign.textOnPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        )
                      : Icon(
                          widget.icon,
                          color: widget.foregroundColor ??
                              ModernInvoiceDesign.textOnPrimary,
                          size: 24,
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPressedDown() {
    setState(() {
      _isPressed = true;
    });
    _controller.forward();
  }

  void _onPressedUp() {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse();
  }
}

/// Holographic Progress Indicator
class HolographicProgressIndicator extends StatefulWidget {
  final double value;
  final double size;
  final double strokeWidth;
  final bool isAnimated;

  const HolographicProgressIndicator({
    super.key,
    required this.value,
    this.size = 60.0,
    this.strokeWidth = 6.0,
    this.isAnimated = true,
  });

  @override
  State<HolographicProgressIndicator> createState() =>
      _HolographicProgressIndicatorState();
}

class _HolographicProgressIndicatorState
    extends State<HolographicProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    if (widget.isAnimated) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Colors.transparent,
                  ModernInvoiceDesign.primary,
                  ModernInvoiceDesign.secondary,
                  ModernInvoiceDesign.accent,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.strokeWidth),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ModernInvoiceDesign.surface,
                ),
                child: Center(
                  child: Text(
                    '${(widget.value * 100).toInt()}%',
                    style: ModernInvoiceDesign.labelLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ModernInvoiceDesign.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Modern 3D Avatar with Glow Effect
class Modern3DAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final bool hasGlowEffect;
  final VoidCallback? onTap;

  const Modern3DAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 48.0,
    this.backgroundColor,
    this.hasGlowEffect = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: backgroundColor != null
              ? null
              : ModernInvoiceDesign.primaryGradient,
          color: backgroundColor,
          boxShadow: hasGlowEffect
              ? ModernInvoiceDesign.shadowPrimaryGlow
              : ModernInvoiceDesign.shadowMd,
        ),
        child: ClipOval(
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildInitialsAvatar();
                  },
                )
              : _buildInitialsAvatar(),
        ),
      ),
    ).animate().scale(duration: ModernInvoiceDesign.durationFast);
  }

  Widget _buildInitialsAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: backgroundColor != null
            ? null
            : ModernInvoiceDesign.primaryGradient,
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          initials ?? '?',
          style: TextStyle(
            color: ModernInvoiceDesign.textOnPrimary,
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// Animated Mesh Background
class AnimatedMeshBackground extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const AnimatedMeshBackground({
    super.key,
    required this.child,
    this.colors = const [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
      Color(0xFF06D6A0),
    ],
    this.duration = const Duration(seconds: 10),
  });

  @override
  State<AnimatedMeshBackground> createState() => _AnimatedMeshBackgroundState();
}

class _AnimatedMeshBackgroundState extends State<AnimatedMeshBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                widget.colors[0].withValues(alpha: 0.3),
                widget.colors[1].withValues(alpha: 0.2),
                widget.colors[2].withValues(alpha: 0.1),
                widget.colors[3].withValues(alpha: 0.05),
              ],
              stops: [
                0.0,
                0.3 + (_animation.value * 0.2),
                0.6 + (_animation.value * 0.3),
                1.0,
              ],
              center: Alignment(
                -0.5 + (_animation.value * 1.0),
                -0.5 + (_animation.value * 1.0),
              ),
              radius: 1.5 + (_animation.value * 0.5),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Modern 3D Card Widget with Glassmorphism
class ModernInvoiceCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool isHoverable;
  final bool isGlassmorphic;
  final bool is3D;
  final Gradient? gradient;

  const ModernInvoiceCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.boxShadow,
    this.borderRadius,
    this.border,
    this.isHoverable = true,
    this.isGlassmorphic = false,
    this.is3D = false,
    this.gradient,
  });

  @override
  State<ModernInvoiceCard> createState() => _ModernInvoiceCardState();
}

class _ModernInvoiceCardState extends State<ModernInvoiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: ModernInvoiceDesign.durationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.01).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(ModernInvoiceDesign.radiusLg);

    Widget cardContent = Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.isGlassmorphic
            ? Colors.white.withValues(alpha: 0.1)
            : widget.backgroundColor ?? ModernInvoiceDesign.surface,
        gradient: widget.gradient ??
            (widget.isGlassmorphic ? ModernInvoiceDesign.cardGradient : null),
        borderRadius: borderRadius,
        boxShadow: widget.is3D
            ? ModernInvoiceDesign.shadow3D
            : (widget.boxShadow ?? ModernInvoiceDesign.shadowMd),
        border: widget.border ??
            (widget.isGlassmorphic
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.2), width: 1)
                : Border.all(color: ModernInvoiceDesign.border, width: 1)),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: widget.isGlassmorphic
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: _buildCardContent(),
              )
            : _buildCardContent(),
      ),
    );

    if (widget.is3D) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_rotationAnimation.value)
              ..rotateY(_rotationAnimation.value * 0.5)
              ..scale(_scaleAnimation.value),
            child: cardContent,
          );
        },
      );
    }

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedScale(
        scale: _isHovered && widget.isHoverable ? 1.02 : 1.0,
        duration: ModernInvoiceDesign.durationFast,
        child: cardContent,
      ),
    );
  }

  Widget _buildCardContent() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: widget.borderRadius ??
            BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        child: Padding(
          padding: widget.padding ??
              const EdgeInsets.all(ModernInvoiceDesign.space4),
          child: widget.child,
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    if (!widget.isHoverable) return;
    setState(() {
      _isHovered = isHovered;
    });
    if (widget.is3D) {
      if (isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }
}

/// Modern Button Widget for Invoice Module
class ModernInvoiceButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isSecondary;
  final bool isOutlined;
  final bool isSmall;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const ModernInvoiceButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSecondary = false,
    this.isOutlined = false,
    this.isSmall = false,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    Color bgColor;
    Color fgColor;

    if (isOutlined) {
      bgColor = Colors.transparent;
      fgColor = backgroundColor ?? ModernInvoiceDesign.primary;
    } else if (isSecondary) {
      bgColor = backgroundColor ?? ModernInvoiceDesign.neutral100;
      fgColor = textColor ?? ModernInvoiceDesign.textPrimary;
    } else {
      bgColor = backgroundColor ?? ModernInvoiceDesign.primary;
      fgColor = textColor ?? ModernInvoiceDesign.textOnPrimary;
    }

    return SizedBox(
      width: width,
      height: isSmall ? 36 : 48,
      child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            elevation: isOutlined ? 0 : 2,
            shadowColor: ModernInvoiceDesign.primary.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              side: isOutlined
                  ? BorderSide(color: fgColor, width: 1.5)
                  : BorderSide.none,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isSmall
                  ? ModernInvoiceDesign.space3
                  : ModernInvoiceDesign.space4,
              vertical: isSmall
                  ? ModernInvoiceDesign.space2
                  : ModernInvoiceDesign.space3,
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: isSmall ? 16 : 20,
                  height: isSmall ? 16 : 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: isSmall ? 16 : 18),
                      SizedBox(width: ModernInvoiceDesign.space2),
                    ],
                    Flexible(
                      child: Text(
                        text,
                        style: (isSmall
                                ? ModernInvoiceDesign.labelMedium
                                : ModernInvoiceDesign.labelLarge)
                            .copyWith(
                          color: fgColor,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
    )
        .animate(target: isEnabled ? 1 : 0)
        .scaleXY(end: 1.05, duration: ModernInvoiceDesign.durationFast);
  }
}

/// Section Header with trailing action button (responsive)
class ModernSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;
  final bool actionOutlined;
  final EdgeInsetsGeometry? margin;
  final double? bottomSpacing;

  const ModernSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
    this.actionOutlined = false,
    this.margin,
    this.bottomSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ModernInvoiceDesign.isMobile(context);
    final gap = bottomSpacing ??
        (isMobile ? ModernInvoiceDesign.space3 : ModernInvoiceDesign.space4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: isMobile
                    ? ModernInvoiceDesign.headlineSmall
                    : ModernInvoiceDesign.headlineLarge,
              ),
              if (onAction != null)
                ModernInvoiceButton(
                  text: actionLabel ?? 'Action',
                  icon: actionIcon,
                  onPressed: onAction,
                  isOutlined: actionOutlined,
                  isSmall: isMobile,
                ),
            ],
          ),
        ),
        SizedBox(height: gap),
      ],
    );
  }
}

/// Modern Input Field Widget for Invoice Module
class ModernInvoiceTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  final int? maxLines;
  final bool enabled;
  final String? errorText;

  const ModernInvoiceTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.maxLines = 1,
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ModernInvoiceDesign.labelLarge,
        ),
        const SizedBox(height: ModernInvoiceDesign.space2),
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          enabled: enabled,
          style: ModernInvoiceDesign.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: ModernInvoiceDesign.bodyLarge.copyWith(
              color: ModernInvoiceDesign.textTertiary,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: ModernInvoiceDesign.textSecondary)
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon,
                        color: ModernInvoiceDesign.textSecondary),
                    onPressed: onSuffixIconTap,
                  )
                : null,
            filled: true,
            fillColor: enabled
                ? ModernInvoiceDesign.surface
                : ModernInvoiceDesign.neutral100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              borderSide: const BorderSide(color: ModernInvoiceDesign.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              borderSide: const BorderSide(color: ModernInvoiceDesign.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              borderSide: const BorderSide(
                  color: ModernInvoiceDesign.borderFocus, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              borderSide: const BorderSide(color: ModernInvoiceDesign.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              borderSide:
                  const BorderSide(color: ModernInvoiceDesign.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: ModernInvoiceDesign.space4,
              vertical: ModernInvoiceDesign.space3,
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
