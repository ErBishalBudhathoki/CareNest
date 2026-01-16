import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/design_system/bauhaus_design_system.dart';
import '../../../../models/trip.dart';

class TripListItem extends StatelessWidget {
  final Trip trip;

  const TripListItem({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space3),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Row(
        children: [
          // Geometric Status Indicator
          _buildStatusIndicator(),
          const SizedBox(width: BauhausDesign.space4),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getClientName(),
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.neutral,
                  ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  trip.date.toString().split(' ')[0],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: BauhausDesign.neutral.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          
          // Distance
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.neutral,
              borderRadius: BorderRadius.zero,
            ),
            child: Text(
              '${trip.distance.toStringAsFixed(1)} km',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getClientName() {
    if (trip.tripType == 'WITH_CLIENT') {
      return trip.clientId ?? 'Client Trip';
    } else if (trip.tripType == 'BETWEEN_CLIENTS') {
      return 'Between Clients';
    } else {
      return 'Commute';
    }
  }

  Widget _buildStatusIndicator() {
    final bool isApproved = trip.status == 'APPROVED';
    final bool isRejected = trip.status == 'REJECTED';
    
    // Geometric shape: Circle for Approved, Square for Pending/Rejected
    // Colors: Blue (Approved), Yellow (Pending), Red (Rejected)
    
    Color color = BauhausDesign.accent; // Pending
    if (isApproved) color = BauhausDesign.secondary;
    if (isRejected) color = BauhausDesign.primary;

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: isApproved ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
    );
  }
}
