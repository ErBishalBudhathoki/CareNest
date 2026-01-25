import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/bauhaus_design.dart';

class TrackerCard extends StatelessWidget {
  final bool isTracking;
  final VoidCallback onToggle;

  const TrackerCard({
    super.key,
    required this.isTracking,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Tracker',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                child: _buildStatusDisplay(context),
              ),
              const SizedBox(width: BauhausDesign.space4),
              _buildActionButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDisplay(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTracking ? 'TRACKING...' : 'READY',
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isTracking
                    ? BauhausDesign.primary
                    : BauhausDesign.textMuted,
              ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          isTracking ? '00:45:21' : '00:00:00',
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return BauhausActionButton(
      text: isTracking ? 'Stop Trip' : 'Start Trip',
      onPressed: onToggle,
      variant: isTracking
          ? BauhausActionVariant.primary
          : BauhausActionVariant.secondary,
      isSmall: false,
    );
  }
}
