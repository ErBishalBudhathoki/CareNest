import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants/bauhaus_design.dart';
import '../models/trip_model.dart';

class TripListItem extends StatelessWidget {
  final Trip trip;

  const TripListItem({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: BauhausCard(
        child: Row(
          children: [
            // Status Chip
            _buildStatusChip(),
            const SizedBox(width: BauhausDesign.space4),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getClientName(),
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    trip.date.toString().split(' ')[0], // Or use DateFormat
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.textMuted,
                            ),
                  ),
                ],
              ),
            ),

            // Distance Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space1,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.neutral.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              child: Text(
                '${trip.distance.toStringAsFixed(1)} km',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark,
                    ),
              ),
            ),
          ],
        ),
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

  Widget _buildStatusChip() {
    BauhausChipVariant variant = BauhausChipVariant.neutral;
    if (trip.status == 'APPROVED') variant = BauhausChipVariant.success;
    if (trip.status == 'REJECTED') variant = BauhausChipVariant.error;
    if (trip.status == 'PENDING') variant = BauhausChipVariant.warning;

    // Use a small icon or initial instead of full chip to save space if needed?
    // Or just a small dot?
    // Let's use a small dot/icon styled container for compact list item

    Color color = BauhausDesign.neutral;
    IconData icon = Icons.help_outline;

    switch (variant) {
      case BauhausChipVariant.success:
        color = BauhausDesign.success;
        icon = Icons.check;
        break;
      case BauhausChipVariant.error:
        color = BauhausDesign.error;
        icon = Icons.close;
        break;
      case BauhausChipVariant.warning:
        color = BauhausDesign.warning;
        icon = Icons.access_time;
        break;
      default:
        color = BauhausDesign.neutral;
        break;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Icon(
        icon,
        size: 16,
        color: BauhausDesign.textDark,
      ),
    );
  }
}
