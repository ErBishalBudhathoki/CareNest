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
    final colorScheme = Theme.of(context).colorScheme;

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
    final timerService = ref.watch(timerServiceProvider);
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
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline, width: 3),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
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
                        color: colorScheme.primary, // Red background
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        date.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).labelSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimary,
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
                        color: colorScheme.surface,
                        border: Border.all(
                          color: colorScheme.outline,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: colorScheme.onSurface,
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
                        color: colorScheme.onSurface,
                        height: 1.1,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space2),

                // Time & Location
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      time,
                      style: BauhausDesign.getTextTheme(context).bodyMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
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
    final colorScheme = Theme.of(context).colorScheme;
    Color badgeColor = colorScheme.secondary;
    String badgeText = 'IN PROGRESS';

    if (isOvertime) {
      badgeColor = colorScheme.primary;
      badgeText = 'OVERTIME';
    } else if (isOverdue) {
      badgeColor = colorScheme.error;
      badgeText = 'OVERDUE';
    } else if (!isClockedIn) {
      badgeColor = colorScheme.primary;
      badgeText = 'CLOCK IN';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space2,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        border: Border.all(color: colorScheme.outline, width: 2),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        badgeText,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: badgeColor == colorScheme.primary
              ? colorScheme.onPrimary
              : badgeColor == colorScheme.error
              ? colorScheme.onError
              : colorScheme.onSecondary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
