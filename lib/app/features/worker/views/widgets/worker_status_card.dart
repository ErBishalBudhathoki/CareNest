import 'package:flutter/material.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';

class WorkerStatusCard extends StatelessWidget {
  final Map<String, dynamic>? activeTimer;

  const WorkerStatusCard({super.key, this.activeTimer});

  @override
  Widget build(BuildContext context) {
    final bool isClockedIn = activeTimer != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BauhausTheme.blockDecoration.copyWith(
        color: isClockedIn
            ? BauhausTheme.yellow.withOpacity(0.2)
            : BauhausTheme.white,
        border: Border.all(
          color: isClockedIn ? BauhausTheme.yellow : BauhausTheme.black,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isClockedIn ? 'ON SHIFT' : 'OFF DUTY',
                style: BauhausTheme.headerStyle.copyWith(
                  color: isClockedIn
                      ? BauhausTheme.textDark
                      : BauhausTheme.textDark,
                ),
              ),
              if (isClockedIn) ...[
                const SizedBox(height: 4),
                Text(
                  'Started at ${_formatTime(activeTimer!['startTime'])}',
                  style: BauhausTheme.bodyStyle,
                ),
              ],
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: isClockedIn ? BauhausTheme.red : BauhausTheme.black,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isClockedIn ? Icons.stop : Icons.play_arrow,
              color: BauhausTheme.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(dynamic startTime) {
    if (startTime == null) return '';
    final dt = DateTime.parse(startTime.toString()).toLocal();
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
