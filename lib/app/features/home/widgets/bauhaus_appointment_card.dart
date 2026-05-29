import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class BauhausAppointmentCard extends ConsumerWidget {
  final Map<String, dynamic> appointment;
  final VoidCallback? onTap;

  const BauhausAppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Extract Data
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
        clientName =
            clientDetails['clientName']?.toString() ??
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
    final timerService = ref.watch(timerServiceProviderWithNotifier);
    final clientEmail = appointment['clientEmail'];
    final isClockedIn =
        timerService.isRunning && timerService.timerClientEmail == clientEmail;

    final shiftStatus = appointment['_shiftStatus']?.toString();
    final isOverdue = shiftStatus == 'overdue';
    final isOvertime = shiftStatus == 'overtime';
    final showShiftStatusBadge =
        shiftStatus == 'in_progress' || isOverdue || isOvertime;

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
        border: Border.all(color: BauhausDesign.textDark, width: 3),
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
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: DATE
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary, // Red background
                        border: Border.all(
                          color: BauhausDesign.textDark,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        date.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).labelSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.surfaceWhite,
                            ),
                      ),
                    ),
                    const Spacer(),
                    if (showShiftStatusBadge) ...[
                      _buildShiftStatusBadge(
                        context,
                        isOverdue: isOverdue,
                        isOvertime: isOvertime,
                        isClockedIn: isClockedIn,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                    ],
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space1),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceWhite,
                        border: Border.all(
                          color: BauhausDesign.textDark,
                          width: 2,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: BauhausDesign.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space4),

                // Client Name
                Text(
                  clientName.isNotEmpty
                      ? clientName.toUpperCase()
                      : 'UNKNOWN CLIENT',
                  style: BauhausDesign.getTextTheme(context).headlineMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space2),

                // Time & Location
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 18,
                      color: BauhausDesign.neutral,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      time,
                      style: BauhausDesign.getTextTheme(context).bodyMedium
                          ?.copyWith(
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

  Widget _buildShiftStatusBadge(
    BuildContext context, {
    required bool isOverdue,
    required bool isOvertime,
    required bool isClockedIn,
  }) {
    Color badgeColor = BauhausDesign.success;
    String badgeText = 'IN PROGRESS';

    if (isOvertime) {
      badgeColor = BauhausDesign.warning;
      badgeText = 'OVERTIME';
    } else if (isOverdue) {
      badgeColor = BauhausDesign.error;
      badgeText = 'OVERDUE';
    } else if (!isClockedIn) {
      badgeColor = BauhausDesign.warning;
      badgeText = 'CLOCK IN';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        border: Border.all(color: BauhausDesign.textDark, width: 2),
        boxShadow: const [
          BoxShadow(
            color: BauhausDesign.textDark,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        badgeText,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: badgeColor == BauhausDesign.warning
              ? BauhausDesign.textDark
              : BauhausDesign.surfaceWhite,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
