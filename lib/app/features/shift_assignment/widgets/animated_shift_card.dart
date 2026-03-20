import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Animated card widget for displaying individual shift details
class AnimatedShiftCard extends StatefulWidget {
  final Map<String, String> shiftDetails;
  final int index;
  final Duration delay;
  final VoidCallback? onTap;

  const AnimatedShiftCard({
    super.key,
    required this.shiftDetails,
    required this.index,
    this.delay = Duration.zero,
    this.onTap,
  });

  @override
  State<AnimatedShiftCard> createState() => _AnimatedShiftCardState();
}

class _AnimatedShiftCardState extends State<AnimatedShiftCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimation();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));
  }

  void _startAnimation() {
    Future.delayed(widget.delay, () {
      if (mounted) {
        _animationController.forward();
      }
    });
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value.clamp(0.0, 1.0),
            child: _buildCard(),
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            boxShadow: _isHovered
                ? const [BauhausDesign.shadowHardSm]
                : const [BauhausDesign.shadowHardXs],
            border: Border.all(
              color: BauhausDesign.neutral,
              width: 2,
            ),
          ),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: BauhausDesign.space2),
                _buildShiftDetails(),
                if (widget.shiftDetails.containsKey('timeWorked')) ...[
                  const SizedBox(height: BauhausDesign.space1),
                  _buildTimeWorked(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3, vertical: BauhausDesign.space1),
          decoration: BoxDecoration(
            color: BauhausDesign.primary.withOpacity(0.1),
            border: Border.all(color: BauhausDesign.primary, width: 1.5),
          ),
          child: Text(
            AppLocalizations.of(context)!.shiftIndex(widget.index + 1),
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.schedule,
          color: BauhausDesign.neutral,
          size: 20.0,
        ),
      ],
    );
  }

  Widget _buildShiftDetails() {
    return Column(
      children: [
        _buildDetailRow(
          icon: Icons.calendar_today,
          label: AppLocalizations.of(context)!.dateLabel,
          value: widget.shiftDetails['date'] ?? 'N/A',
          color: BauhausDesign.info,
        ),
        const SizedBox(height: BauhausDesign.space1),
        Row(
          children: [
            Expanded(
              child: _buildDetailRow(
                icon: Icons.play_arrow,
                label: AppLocalizations.of(context)!.startLabel,
                value: widget.shiftDetails['startTime'] ?? 'N/A',
                color: BauhausDesign.success,
                isCompact: true,
              ),
            ),
            const SizedBox(width: BauhausDesign.space2),
            Expanded(
              child: _buildDetailRow(
                icon: Icons.stop,
                label: AppLocalizations.of(context)!.endLabel,
                value: widget.shiftDetails['endTime'] ?? 'N/A',
                color: BauhausDesign.warning,
                isCompact: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space1),
        _buildDetailRow(
          icon: Icons.coffee,
          label: AppLocalizations.of(context)!.breakLabel,
          value: widget.shiftDetails['break'] ?? 'N/A',
          color: BauhausDesign.secondary,
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isCompact = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Icon(
            icon,
            color: color,
            size: isCompact ? 16.0 : 18.0,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textDark,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeWorked() {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space2),
      decoration: BoxDecoration(
        color: BauhausDesign.success.withOpacity(0.1),
        border: Border.all(
          color: BauhausDesign.success,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.timer,
            color: BauhausDesign.success,
            size: 18.0,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Text(
            '${AppLocalizations.of(context)!.timeWorked}: ',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            widget.shiftDetails['timeWorked'] ?? 'N/A',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.success,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
