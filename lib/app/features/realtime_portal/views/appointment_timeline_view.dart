import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/views/admin_service_confirmations_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimelineAppointment {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final String status;
  final bool isActive;
  final String details;

  TimelineAppointment({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.status,
    required this.isActive,
    required this.details,
  });
}

/// Dynamic provider that loads and merges active appointments and completed history for the timeline
final timelineAppointmentsProvider = FutureProvider.family
    .autoDispose<List<TimelineAppointment>, String>((ref, clientId) async {
      final api = ref.read(apiMethodProvider);
      final List<TimelineAppointment> list = [];

      // 1. Get today's active appointments from client portal dashboard data
      try {
        final dashboardResponse = await api.getClientDashboard(
          clientId: clientId,
        );
        if (dashboardResponse['success'] == true &&
            dashboardResponse['data'] != null) {
          final rawAppointments =
              dashboardResponse['data']['todayAppointments'] as List?;
          if (rawAppointments != null) {
            for (final item in rawAppointments) {
              final apt = TodayAppointment.fromJson(
                Map<String, dynamic>.from(item),
              );
              list.add(
                TimelineAppointment(
                  id: apt.appointmentId,
                  title: apt.serviceName,
                  subtitle: 'Worker: ${apt.workerName}',
                  time: '${apt.startTime} - ${apt.endTime}',
                  status: apt.status.toUpperCase(),
                  isActive: true,
                  details: apt.eta != null
                      ? 'ETA: ${apt.eta}'
                      : 'Active Service Shift',
                ),
              );
            }
          }
        }
      } catch (e) {
        debugPrint('Error loading active appointments: $e');
      }

      // 2. Get past completed appointments from service history data
      try {
        final historyResponse = await api.getServiceHistory(clientId: clientId);
        if (historyResponse['success'] == true &&
            historyResponse['data'] is List) {
          final rawHistory = historyResponse['data'] as List;
          for (final item in rawHistory) {
            final service = ServiceHistory.fromJson(
              Map<String, dynamic>.from(item),
            );
            list.add(
              TimelineAppointment(
                id: service.serviceId,
                title: service.serviceName,
                subtitle: 'Worker: ${service.workerName}',
                time:
                    '${service.date} • ${service.startTime} - ${service.endTime}',
                status: 'COMPLETED',
                isActive: false,
                details:
                    service.feedback != null && service.feedback!.isNotEmpty
                    ? 'Feedback quote: "${service.feedback}"'
                    : 'Service completed successfully',
              ),
            );
          }
        }
      } catch (e) {
        debugPrint('Error loading completed appointments: $e');
      }

      return list;
    });

class AppointmentTimelineView extends ConsumerWidget {
  final String? clientId;
  final String? clientName;

  const AppointmentTimelineView({super.key, this.clientId, this.clientName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final resolvedClientId =
        clientId ?? args?['clientId'] as String? ?? 'client_123';
    final resolvedClientName =
        clientName ?? args?['clientName'] as String? ?? 'Client';

    final timelineState = ref.watch(
      timelineAppointmentsProvider(resolvedClientId),
    );
    final textTheme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Text(
          'CLIENT APPOINTMENT TIMELINE',
          style: GoogleFonts.oswald(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1.1,
          ),
        ),
        foregroundColor: BauhausDesign.textDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BauhausDesign.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                ref.invalidate(timelineAppointmentsProvider(resolvedClientId)),
            icon: const Icon(Icons.refresh, color: BauhausDesign.textDark),
            tooltip: 'Refresh Timeline',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(color: BauhausDesign.neutral, height: 1.5),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Client context strip
          _buildClientContextStrip(
            context,
            resolvedClientName,
            resolvedClientId,
          ),

          Expanded(
            child: timelineState.when(
              loading: () => const Center(child: BauhausLoadingState()),
              error: (err, _) => Center(
                child: BauhausErrorState(
                  title: 'Timeline Error',
                  message: err.toString(),
                  onRetry: () => ref.invalidate(
                    timelineAppointmentsProvider(resolvedClientId),
                  ),
                ),
              ),
              data: (appointments) {
                if (appointments.isEmpty) {
                  return const Center(
                    child: BauhausEmptyState(
                      title: 'Timeline Empty',
                      message:
                          'No appointments (active or completed) exist for this client.',
                      icon: Icons.timeline_rounded,
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space5),
                  itemCount: appointments.length + 1,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space4),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const BauhausSectionHeader(
                        title: 'CHRONOLOGICAL TIMELINE LEDGER',
                        subtitle:
                            'Visual history of scheduled, ongoing, and completed service interactions.',
                      );
                    }

                    final appointment = appointments[index - 1];
                    return _buildTimelineNode(
                      context,
                      ref,
                      appointment,
                      index == appointments.length,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientContextStrip(
    BuildContext context,
    String resolvedClientName,
    String resolvedClientId,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThick,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVE CLIENT',
            style: BauhausDesign.neoMonoStyle(
              context,
              color: BauhausDesign.textMuted,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            resolvedClientName,
            style: GoogleFonts.oswald(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: BauhausDesign.primary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Client ID: $resolvedClientId',
            style: GoogleFonts.shareTechMono(
              fontSize: 11,
              color: BauhausDesign.textMuted,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode(
    BuildContext context,
    WidgetRef ref,
    TimelineAppointment apt,
    bool isLast,
  ) {
    final color = apt.isActive
        ? (apt.status == 'COMPLETED'
              ? BauhausDesign.success
              : BauhausDesign.primaryBlue)
        : BauhausDesign.neutral;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Vertical timeline line and dot
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2.5, color: BauhausDesign.neutral),
                ),
            ],
          ),
          const SizedBox(width: BauhausDesign.space4),

          // Timeline node content card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          apt.time,
                          style: GoogleFonts.shareTechMono(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textMuted,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            border: Border.all(color: color, width: 1.5),
                          ),
                          child: Text(
                            apt.status,
                            style: BauhausDesign.neoMonoStyle(
                              context,
                              color: color,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Text(
                      apt.title.toUpperCase(),
                      style: GoogleFonts.oswald(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: BauhausDesign.textDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      apt.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textMuted,
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    Text(
                      apt.details,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (apt.status == 'COMPLETED') ...[
                      const SizedBox(height: BauhausDesign.space4),
                      Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              onPressed: () => _inspectServiceConfirmation(
                                context,
                                ref,
                                apt,
                              ),
                              text: 'VIEW AUDIT DETAILS',
                              icon: Icons.assignment_turned_in_outlined,
                              variant: BauhausActionVariant.primary,
                              isSmall: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _inspectServiceConfirmation(
    BuildContext context,
    WidgetRef ref,
    TimelineAppointment apt,
  ) {
    // Instantiate a fallback ServiceHistory wrapper for _AdminServiceHistoryCard compatibility
    final serviceHist = ServiceHistory(
      serviceId: apt.id,
      workerName: apt.subtitle.replaceAll('Worker: ', ''),
      serviceName: apt.title,
      date: apt.time.split(' • ').first,
      startTime: apt.time.split(' • ').last.split(' - ').first,
      endTime: apt.time.split(' • ').last.split(' - ').last,
      rating: 5,
    );

    // Reuse the exact verification bottom sheet defined in AdminServiceConfirmationsView!
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(BauhausDesign.radiusLg),
        ),
      ),
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Consumer(
          builder: (context, ref, _) {
            final detailState = ref.watch(
              serviceConfirmationDetailsProvider(apt.id),
            );

            return detailState.when(
              loading: () => const SizedBox(
                height: 300,
                child: Center(child: BauhausLoadingState()),
              ),
              error: (error, _) => SizedBox(
                height: 300,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(BauhausDesign.space6),
                    child: Text(
                      'No submission record found: $error',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: BauhausDesign.fontMd,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textMuted,
                      ),
                    ),
                  ),
                ),
              ),
              data: (confirmation) {
                if (confirmation == null) {
                  return SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        'Detailed confirmation data is pending client submission.',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontMd,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textMuted,
                        ),
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.symmetric(
                            vertical: BauhausDesign.space3,
                          ),
                          decoration: BoxDecoration(
                            color: BauhausDesign.neutral,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          BauhausDesign.space5,
                          0,
                          BauhausDesign.space5,
                          BauhausDesign.space4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'VERIFICATION INSIGHTS',
                              style: GoogleFonts.oswald(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.primary,
                                letterSpacing: 1.1,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: BauhausDesign.neutral,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: BauhausDesign.neutral,
                        height: 1.5,
                        thickness: 1.5,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(BauhausDesign.space5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: BauhausDesign.textDark,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Worker: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: BauhausDesign.textMuted,
                                      ),
                                    ),
                                    TextSpan(
                                      text: serviceHist.workerName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: BauhausDesign.textDark,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Service: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: BauhausDesign.textMuted,
                                      ),
                                    ),
                                    TextSpan(
                                      text: serviceHist.serviceName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: BauhausDesign.textDark,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'Date/Time: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: BauhausDesign.textMuted,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${serviceHist.date} • ${serviceHist.startTime} - ${serviceHist.endTime}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space4),

                            // Rating Section
                            Text(
                              'CLIENT RATING',
                              style: BauhausDesign.neoMonoStyle(
                                context,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            Container(
                              padding: const EdgeInsets.all(
                                BauhausDesign.space4,
                              ),
                              decoration: BauhausDesign.cardDecoration,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        index < (confirmation.rating ?? 0)
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 28,
                                        color: BauhausDesign.accent,
                                      ),
                                    ),
                                  ),
                                  if (confirmation.feedback != null &&
                                      confirmation.feedback!.isNotEmpty) ...[
                                    const SizedBox(
                                      height: BauhausDesign.space3,
                                    ),
                                    Text(
                                      '"${confirmation.feedback}"',
                                      style: GoogleFonts.inter(
                                        fontSize: BauhausDesign.fontMd,
                                        fontStyle: FontStyle.italic,
                                        color: BauhausDesign.textDark,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space5),

                            // Checklist Section
                            Text(
                              'COMPLETED TASK CHECKLIST',
                              style: BauhausDesign.neoMonoStyle(
                                context,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            if (confirmation.checklist == null ||
                                confirmation.checklist!.isEmpty)
                              Text(
                                'No tasks configured for this shift.',
                                style: GoogleFonts.inter(
                                  color: BauhausDesign.textMuted,
                                ),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  color: BauhausDesign.surfaceWhite,
                                  border: Border.all(
                                    color: BauhausDesign.neutral,
                                    width: 2,
                                  ),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: confirmation.checklist!.length,
                                  separatorBuilder: (_, __) => Divider(
                                    color: BauhausDesign.neutral,
                                    height: 1,
                                  ),
                                  itemBuilder: (context, idx) {
                                    final item = confirmation.checklist![idx];
                                    final completed = item.completed ?? false;
                                    return ListTile(
                                      leading: Icon(
                                        completed
                                            ? Icons.check_box_outlined
                                            : Icons.check_box_outline_blank,
                                        color: completed
                                            ? BauhausDesign.success
                                            : BauhausDesign.textMuted,
                                      ),
                                      title: Text(
                                        item.item,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          decoration: completed
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: completed
                                              ? BauhausDesign.textMuted
                                              : BauhausDesign.textDark,
                                        ),
                                      ),
                                      trailing: item.required
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: BauhausDesign.primaryBlue
                                                    .withOpacity(0.1),
                                                border: Border.all(
                                                  color:
                                                      BauhausDesign.primaryBlue,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                'REQ',
                                                style:
                                                    GoogleFonts.shareTechMono(
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: BauhausDesign
                                                          .primaryBlue,
                                                    ),
                                              ),
                                            )
                                          : null,
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: BauhausDesign.space5),

                            // Signature Section
                            Text(
                              'DIGITAL SIGNATURE VERIFICATION',
                              style: BauhausDesign.neoMonoStyle(
                                context,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            Container(
                              padding: const EdgeInsets.all(
                                BauhausDesign.space4,
                              ),
                              decoration: BauhausDesign.cardDecoration,
                              width: double.infinity,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.draw_rounded,
                                    size: 36,
                                    color: BauhausDesign.neutral,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ELECTRONIC SIGNATURE SECURED',
                                    style: GoogleFonts.shareTechMono(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.success,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Signature ID: ${confirmation.signatureId} • Secured: ${confirmation.timestamp != null ? DateFormat('yyyy-MM-dd HH:mm').format(confirmation.timestamp) : 'N/A'}',
                                    style: GoogleFonts.shareTechMono(
                                      fontSize: 9,
                                      color: BauhausDesign.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: BauhausDesign.space5),

                            // Incidents Section (if any)
                            if (confirmation.incidents != null &&
                                confirmation.incidents!.isNotEmpty) ...[
                              Text(
                                'SHIFTS ALERTS / INCIDENTS',
                                style: BauhausDesign.neoMonoStyle(
                                  context,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: BauhausDesign.warning,
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              ...confirmation.incidents!.map(
                                (incident) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(
                                    BauhausDesign.space4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: BauhausDesign.warning.withOpacity(
                                      0.1,
                                    ),
                                    border: Border.all(
                                      color: BauhausDesign.warning,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.warning_amber_rounded,
                                            color: BauhausDesign.warning,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '${incident.category.toUpperCase()} (${incident.severity.toUpperCase()})',
                                            style: GoogleFonts.shareTechMono(
                                              fontWeight: FontWeight.bold,
                                              color: BauhausDesign.warning,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        incident.description,
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: BauhausDesign.textDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).padding.bottom +
                            BauhausDesign.space5,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
