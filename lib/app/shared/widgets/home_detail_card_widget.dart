import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class HomeDetailCard extends StatefulWidget {
  final String buttonLabel;
  final String cardLabel;
  final Image image;
  final VoidCallback onPressed;
  final Color gradientStartColor;
  final Color gradientEndColor;

  const HomeDetailCard({
    super.key,
    required this.buttonLabel,
    required this.cardLabel,
    required this.image,
    required this.onPressed,
    required this.gradientStartColor,
    required this.gradientEndColor,
  });

  @override
  State<HomeDetailCard> createState() => _HomeDetailCardState();
}

class _HomeDetailCardState extends State<HomeDetailCard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _floatingController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatingAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Hover animation controller
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Floating animation controller
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Setup animations
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    _floatingAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    // Start floating animation
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1.1,
      child: AnimatedBuilder(
        animation: Listenable.merge([_hoverController, _floatingController]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: MouseRegion(
              onEnter: (_) => _handleHover(true),
              onExit: (_) => _handleHover(false),
              child: GestureDetector(
                onTapDown: (_) => _handleHover(true),
                onTapUp: (_) => _handleHover(false),
                onTapCancel: () => _handleHover(false),
                onTap: widget.onPressed,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main card container with enhanced shadow
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusLg,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            widget.gradientStartColor,
                            widget.gradientEndColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // No card shadow. Both shadows here were offset on the
                        // vertical axis only, with alpha fills, so instead of
                        // reading as depth they painted a coloured band under
                        // the card. The gradient already separates the card
                        // from the page.
                      ),
                    ),

                    // Animated overlay for hover effect
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusLg,
                        ),
                        gradient: LinearGradient(
                          colors: _isHovered
                              ? [
                                  colorScheme.surface.withValues(alpha: 0.1),
                                  colorScheme.surface.withValues(alpha: 0.05),
                                ]
                              : [Colors.transparent, Colors.transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),

                    // Content inside the card
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(BauhausDesign.space4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              // Measured against the asset's alpha channel: at
                              // the heading's vertical band the figure spans
                              // card-local x 0..55, so the heading has to start
                              // past that or its first characters sit behind it.
                              padding: const EdgeInsets.only(left: 44),
                              child: Text(
                                widget.cardLabel,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: BauhausDesign.getTextTheme(context)
                                    .titleMedium
                                    ?.copyWith(
                                      color: colorScheme.surface,
                                      letterSpacing: -0.5,
                                      height: 1.1,
                                      shadows: [
                                        Shadow(
                                          color: colorScheme.shadow.withValues(
                                            alpha: 0.26,
                                          ),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space3),

                            // Enhanced Button with ripple effect
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  BauhausDesign.radiusMd,
                                ),
                                // BauhausDesign.shadowHardSm, not a
                                // bottom-only translucent offset. A shadow
                                // cast on one axis with an alpha fill reads as
                                // soft ambient depth, which DESIGN.md forbids;
                                // the design language wants a solid black
                                // offset on both axes.
                                boxShadow: const [BauhausDesign.shadowHardSm],
                              ),
                              child: Material(
                                color: colorScheme.surface.withValues(
                                  alpha: 0.95,
                                ),
                                borderRadius: BorderRadius.circular(
                                  BauhausDesign.radiusMd,
                                ),
                                child: InkWell(
                                  onTap: widget.onPressed,
                                  borderRadius: BorderRadius.circular(
                                    BauhausDesign.radiusMd,
                                  ),
                                  splashColor: widget.gradientStartColor
                                      .withValues(alpha: 0.2),
                                  highlightColor: widget.gradientStartColor
                                      .withValues(alpha: 0.1),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: BauhausDesign.space3,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline_rounded,
                                          color: widget.gradientStartColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: BauhausDesign.space2,
                                        ),
                                        Flexible(
                                          child: Text(
                                            widget.buttonLabel,
                                            style:
                                                BauhausDesign.getTextTheme(
                                                  context,
                                                ).labelLarge?.copyWith(
                                                  color:
                                                      widget.gradientStartColor,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.2,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Floating 3D image with enhanced animation
                    Positioned(
                      top: -50,
                      left: 0,
                      right: 0,
                      child: Transform.translate(
                        offset: Offset(0, _floatingAnimation.value),
                        child: Container(
                          height: 180,
                          // No boxShadow here. This container has no fill, so a
                          // shadow on it does not read as depth, it paints an
                          // opaque plate behind the floating asset. The original
                          // 20px blur hid this; with the blur removed for
                          // DESIGN.md's zero-blur rule, the offset became a
                          // visible hard rectangle behind the image. The card
                          // behind it already carries its own hard shadow.
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              BauhausDesign.radiusMd,
                            ),
                            child: widget.image,
                          ),
                        ),
                      ),
                    ),

                    // Shimmer effect for premium feel
                    if (_isHovered)
                      Positioned.fill(
                        child:
                            Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      BauhausDesign.radiusLg,
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        colorScheme.surface.withValues(
                                          alpha: 0.1,
                                        ),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 0.5, 1.0],
                                      begin: const Alignment(-1.0, -1.0),
                                      end: const Alignment(1.0, 1.0),
                                    ),
                                  ),
                                )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .shimmer(
                                  duration: 2000.ms,
                                  color: colorScheme.surface.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
