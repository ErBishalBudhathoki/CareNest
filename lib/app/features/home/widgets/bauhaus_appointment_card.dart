import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:google_fonts/google_fonts.dart';

class BauhausAppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final VoidCallback? onTap;

  const BauhausAppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Extract Data
    // Extract Data
    // Fallbacks for various API response structures
    Map<String, dynamic>? clientDetails;
    if (appointment['clientDetails'] != null) {
      if (appointment['clientDetails'] is Map) {
        clientDetails = appointment['clientDetails'];
      } else if (appointment['clientDetails'] is List &&
          (appointment['clientDetails'] as List).isNotEmpty) {
        clientDetails = appointment['clientDetails'][0];
      }
    }

    String? clientName = appointment['clientName']?.toString();
    if (clientName == null || clientName.isEmpty) {
      if (clientDetails != null) {
        clientName = clientDetails['clientName']?.toString() ??
            "${clientDetails['clientFirstName'] ?? ''} ${clientDetails['clientLastName'] ?? ''}"
                .trim();
      }
    }
    if (clientName == null || clientName.isEmpty) {
      clientName =
          "${appointment['clientFirstName'] ?? ''} ${appointment['clientLastName'] ?? ''}"
              .trim();
    }

    // Schedule parsing
    String date = 'Unknown Date';
    String time = 'Unknown Time';

    if (appointment['schedule'] != null &&
        appointment['schedule'] is List &&
        (appointment['schedule'] as List).isNotEmpty) {
      final firstSchedule = appointment['schedule'][0];
      date = firstSchedule['date']?.toString() ?? 'Unknown Date';
      time =
          "${firstSchedule['startTime'] ?? ''} - ${firstSchedule['endTime'] ?? ''}";
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(
          color: BauhausDesign.textDark,
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.textDark,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: DATE
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary, // Red background
                        border:
                            Border.all(color: BauhausDesign.textDark, width: 2),
                      ),
                      child: Text(
                        date.toUpperCase(),
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.surfaceLight,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceLight,
                        border:
                            Border.all(color: BauhausDesign.textDark, width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward,
                          size: 16, color: BauhausDesign.textDark),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Client Name
                Text(
                  clientName.isNotEmpty
                      ? clientName.toUpperCase()
                      : 'UNKNOWN CLIENT',
                  style: GoogleFonts.oswald(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textDark,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),

                // Time & Location
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 18, color: BauhausDesign.neutral),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
