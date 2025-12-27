import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

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
  late Animation<double> _slideAnimation;
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

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

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
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value.clamp(0.0, 1.0),
              child: _buildCard(),
            ),
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
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: AppColors.colorCard,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.colorGrey300
                    .withOpacity(0.1),
                blurRadius: _isHovered ? 12.0 : 8.0,
                offset: Offset(0, _isHovered ? 6.0 : 4.0),
                spreadRadius: _isHovered ? 2.0 : 0.0,
              ),
            ],
            border: Border.all(
              color: AppColors.colorGrey200,
              width: 1.0,
            ),
          ),
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16.0),
                _buildShiftDetails(),
                if (widget.shiftDetails.containsKey('timeWorked')) ...[
                  const SizedBox(height: 12.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: AppColors.colorPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'Shift ${widget.index + 1}',
            style: const TextStyle(
              color: AppColors.colorPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
        ),
        const Spacer(),
        Icon(
          Icons.schedule,
          color: AppColors.colorGrey500,
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
          label: 'Date',
          value: widget.shiftDetails['date'] ?? 'N/A',
          color: AppColors.colorBlue,
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildDetailRow(
                icon: Icons.play_arrow,
                label: 'Start',
                value: widget.shiftDetails['startTime'] ?? 'N/A',
                color: AppColors.colorSuccess,
                isCompact: true,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _buildDetailRow(
                icon: Icons.stop,
                label: 'End',
                value: widget.shiftDetails['endTime'] ?? 'N/A',
                color: AppColors.colorWarning,
                isCompact: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _buildDetailRow(
          icon: Icons.coffee,
          label: 'Break',
          value: widget.shiftDetails['break'] ?? 'N/A',
          color: AppColors.colorInfo,
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
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            icon,
            color: color,
            size: isCompact ? 16.0 : 18.0,
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
                  fontSize: isCompact ? 12.0 : 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.colorFontPrimary,
                  fontSize: isCompact ? 14.0 : 15.0,
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
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.colorSuccess.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.colorSuccess.withOpacity(0.1),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.timer,
            color: AppColors.colorSuccess,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            'Time Worked: ',
            style: TextStyle(
              color: AppColors.colorGrey600,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            widget.shiftDetails['timeWorked'] ?? 'N/A',
            style: const TextStyle(
              color: AppColors.colorSuccess,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
