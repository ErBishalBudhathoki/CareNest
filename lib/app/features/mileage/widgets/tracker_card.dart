import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/bauhaus_design.dart';

class TrackerCard extends StatelessWidget {
  final bool isTracking;
  final DateTime? trackingStartTime;
  final VoidCallback onToggle;

  const TrackerCard({
    super.key,
    required this.isTracking,
    this.trackingStartTime,
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
              Expanded(child: _buildStatusDisplay(context)),
              const SizedBox(width: BauhausDesign.space4),
              _buildActionButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDisplay(BuildContext context) {
    final start = trackingStartTime;

    String formatDuration(Duration d) {
      final hours = d.inHours.toString().padLeft(2, '0');
      final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
      return '$hours:$minutes:$seconds';
    }

    Widget buildTimerText(String value) {
      return Text(
        value,
        style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: BauhausDesign.textDark,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTracking ? 'INSIGHTS...' : 'READY',
          style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isTracking ? BauhausDesign.primary : BauhausDesign.textMuted,
          ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        if (!isTracking || start == null)
          buildTimerText('00:00:00')
        else
          StreamBuilder<int>(
            stream: Stream<int>.periodic(
              const Duration(seconds: 1),
              (tick) => tick,
            ),
            builder: (context, snapshot) {
              final elapsed = DateTime.now().difference(start);
              return buildTimerText(formatDuration(elapsed));
            },
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
