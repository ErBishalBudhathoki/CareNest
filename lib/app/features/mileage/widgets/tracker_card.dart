import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/design_system/bauhaus_design_system.dart';

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        // Strict Bauhaus: Radius 0 or full circle. Using 0 for card.
        borderRadius: BorderRadius.zero,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVE TRACKER',
            style: GoogleFonts.oswald(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: BauhausDesign.neutral,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                child: _buildStatusDisplay(),
              ),
              const SizedBox(width: BauhausDesign.space4),
              _buildActionButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTracking ? 'TRACKING...' : 'READY',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isTracking ? BauhausDesign.primary : BauhausDesign.neutral.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          isTracking ? '00:45:21' : '00:00:00',
          style: GoogleFonts.oswald(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.neutral,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return InkWell(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space6,
          vertical: BauhausDesign.space4,
        ),
        decoration: BoxDecoration(
          color: isTracking ? BauhausDesign.primary : BauhausDesign.secondary,
          // Radius 0 for strict geometric shape
          borderRadius: BorderRadius.zero,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Text(
          isTracking ? 'STOP TRIP' : 'START TRIP',
          style: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
