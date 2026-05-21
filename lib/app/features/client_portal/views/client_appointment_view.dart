import 'package:carenest/app/features/client_portal/viewmodels/client_portal_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../viewmodels/client_appointment_viewmodel.dart';
import '../models/client_portal_models.dart';
import 'client_appointment_detail_view.dart';
import 'client_service_history_view.dart';
import 'package:intl/intl.dart';

DateTime? _parseAppointmentDateTime({
  required String dateValue,
  String? timeValue,
}) {
  final date = _parseFlexibleDate(dateValue);
  if (date == null) return null;

  final time = _parseFlexibleTime(timeValue);
  if (time == null) {
    return DateTime(date.year, date.month, date.day);
  }

  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
    time.second,
  );
}

DateTime? _parseFlexibleDate(String raw) {
  final value = raw.trim();
  if (value.isEmpty) return null;

  final parsed = DateTime.tryParse(value);
  if (parsed != null) {
    return DateTime(parsed.year, parsed.month, parsed.day);
  }

  const patterns = <String>[
    'MM/dd/yyyy',
    'M/d/yyyy',
    'dd/MM/yyyy',
    'd/M/yyyy',
    'yyyy/MM/dd',
    'yyyy-M-d',
    'MM-dd-yyyy',
    'M-d-yyyy',
    'dd-MM-yyyy',
    'd-M-yyyy',
  ];

  for (final pattern in patterns) {
    try {
      final parsedWithPattern = DateFormat(pattern).parseStrict(value);
      return DateTime(
        parsedWithPattern.year,
        parsedWithPattern.month,
        parsedWithPattern.day,
      );
    } catch (_) {}
  }

  return null;
}

DateTime? _parseFlexibleTime(String? raw) {
  final value = (raw ?? '').trim();
  if (value.isEmpty) return null;

  const patterns = <String>[
    'HH:mm:ss',
    'H:mm:ss',
    'HH:mm',
    'H:mm',
    'hh:mm a',
    'h:mm a',
    'hh:mm:ss a',
    'h:mm:ss a',
  ];

  for (final pattern in patterns) {
    try {
      return DateFormat(pattern).parseStrict(value);
    } catch (_) {}
  }

  return null;
}

class ClientAppointmentView extends ConsumerStatefulWidget {
  final String? clientId;

  const ClientAppointmentView({
    super.key,
    this.clientId,
  });

  @override
  ConsumerState<ClientAppointmentView> createState() =>
      _ClientAppointmentViewState();
}

class _ClientAppointmentViewState extends ConsumerState<ClientAppointmentView> {
  String _selectedFilter = 'upcoming';

  @override
  Widget build(BuildContext context) {
    final appointmentsState = ref.watch(clientAppointmentsProvider);

    return Column(
      children: [
        _buildFilterTabs(context),
        Expanded(
          child: appointmentsState.when(
            data: (appointments) {
              final filteredAppointments = _filterAppointments(appointments);

              if (filteredAppointments.isEmpty) {
                return _buildEmptyState(context, appointments.isEmpty);
              }

              return _buildAppointmentList(context, filteredAppointments);
            },
            loading: () => const Center(child: BauhausLoadingState()),
            error: (e, _) => Center(
              child: BauhausErrorState(
                title: 'Error Loading Appointments',
                message: e.toString(),
                onRetry: () => ref.invalidate(clientAppointmentsProvider),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Row(
        children: [
          _buildFilterTab(
            label: 'Upcoming',
            value: 'upcoming',
            icon: Icons.calendar_today,
          ),
          const SizedBox(width: BauhausDesign.space3),
          _buildFilterTab(
            label: 'Past',
            value: 'past',
            icon: Icons.history,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final isSelected = _selectedFilter == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: BauhausDesign.space3,
          ),
          decoration: BoxDecoration(
            color:
                isSelected ? BauhausDesign.primary : BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(
              color: isSelected ? BauhausDesign.primary : BauhausDesign.neutral,
              width: 1.5,
            ),
            boxShadow: isSelected ? const [BauhausDesign.shadowHardXs] : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? BauhausDesign.surfaceWhite
                    : BauhausDesign.textMuted,
                size: 18,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? BauhausDesign.surfaceWhite
                      : BauhausDesign.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ClientAppointment> _filterAppointments(
      List<ClientAppointment> appointments) {
    final now = DateTime.now();
    final filtered = appointments.where((appt) {
      final appointmentAt = _parseAppointmentDateTime(
        dateValue: appt.date,
        timeValue: appt.startTime,
      );
      if (appointmentAt == null) return false;

      if (_selectedFilter == 'upcoming') {
        return !appointmentAt.isBefore(now);
      }
      return appointmentAt.isBefore(now);
    }).toList();

    filtered.sort((a, b) {
      final firstAt = _parseAppointmentDateTime(
        dateValue: a.date,
        timeValue: a.startTime,
      );
      final secondAt = _parseAppointmentDateTime(
        dateValue: b.date,
        timeValue: b.startTime,
      );

      final firstMillis = firstAt?.millisecondsSinceEpoch ?? 0;
      final secondMillis = secondAt?.millisecondsSinceEpoch ?? 0;

      if (_selectedFilter == 'upcoming') {
        return firstMillis.compareTo(secondMillis);
      }
      return secondMillis.compareTo(firstMillis);
    });

    return filtered;
  }

  Widget _buildEmptyState(BuildContext context, bool isNoData) {
    return BauhausEmptyState(
      title: isNoData
          ? 'No Appointments'
          : 'No ${_selectedFilter == 'upcoming' ? 'Upcoming' : 'Past'} Appointments',
      message: isNoData
          ? 'Your appointments will appear here once scheduled.'
          : 'Check back later for ${_selectedFilter == 'upcoming' ? 'upcoming' : 'past'} appointments.',
      icon: Icons.calendar_today_outlined,
      action: BauhausActionButton(
        text: 'Request Appointment',
        icon: Icons.add,
        variant: BauhausActionVariant.primary,
        onPressed: () => _showRequestDialog(context),
      ),
    );
  }

  Widget _buildAppointmentList(
      BuildContext context, List<ClientAppointment> appointments) {
    final serviceHistory =
        ref.watch(clientPortalViewModelProvider).serviceHistory;

    return RefreshIndicator(
      color: BauhausDesign.primary,
      backgroundColor: BauhausDesign.surfaceWhite,
      onRefresh: () async {
        ref.invalidate(clientAppointmentsProvider);
        if (widget.clientId != null && widget.clientId!.isNotEmpty) {
          await ref
              .read(clientPortalViewModelProvider.notifier)
              .loadServiceHistory(widget.clientId!, silent: true);
        }
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        itemCount: appointments.length + 1,
        separatorBuilder: (_, __) =>
            const SizedBox(height: BauhausDesign.space3),
        itemBuilder: (context, index) {
          if (index == appointments.length) {
            return _ServiceHistoryFooter(
              history: serviceHistory,
              clientId: widget.clientId,
            );
          }

          final appt = appointments[index];
          return _AppointmentCard(
            appointment: appt,
            isUpcoming: _selectedFilter == 'upcoming',
          );
        },
      ),
    );
  }

  void _showRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: Text(
          'Request Appointment',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border:
                    Border.all(color: BauhausDesign.secondary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: BauhausDesign.secondary),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Text(
                      'Please contact support to request new appointments.',
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'GOT IT',
              style: TextStyle(color: BauhausDesign.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final ClientAppointment appointment;
  final bool isUpcoming;

  const _AppointmentCard({
    required this.appointment,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return BauhausCard(
      onTap: () {
        if (appointment.assignmentId != null &&
            appointment.scheduleId != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ClientAppointmentDetailView(
                assignmentId: appointment.assignmentId!,
                scheduleId: appointment.scheduleId!,
              ),
            ),
          );
        }
      },
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                _buildTimeRow(context),
                if (appointment.userEmail != null) ...[
                  const SizedBox(height: BauhausDesign.space3),
                  _buildWorkerRow(context),
                ],
                const SizedBox(height: BauhausDesign.space3),
                _buildViewDetailsRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final date = _parseAppointmentDateTime(
      dateValue: appointment.date,
      timeValue: appointment.startTime,
    );

    final dayName = date != null ? DateFormat('EEEE').format(date) : '';
    final formattedDate = date != null
        ? DateFormat('MMM d, yyyy').format(date)
        : appointment.date;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: isUpcoming ? BauhausDesign.secondary : BauhausDesign.neutral,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(BauhausDesign.radiusMd),
          topRight: Radius.circular(BauhausDesign.radiusMd),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite.withOpacity(0.2),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
            child: Icon(
              isUpcoming ? Icons.calendar_today : Icons.history,
              color: BauhausDesign.surfaceWhite,
              size: 20,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.surfaceWhite.withOpacity(0.8),
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  formattedDate,
                  style: GoogleFonts.oswald(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.surfaceWhite,
                  ),
                ),
              ],
            ),
          ),
          if (isUpcoming)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space2,
                vertical: BauhausDesign.space1,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.success,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
              ),
              child: Text(
                'SCHEDULED',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: BauhausDesign.surfaceWhite,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTimeRow(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: BauhausDesign.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(color: BauhausDesign.primary.withOpacity(0.3)),
          ),
          child: Icon(
            Icons.access_time,
            color: BauhausDesign.primary,
            size: 18,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TIME',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
            ),
            Text(
              '${appointment.startTime} - ${appointment.endTime}',
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkerRow(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: BauhausDesign.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(color: BauhausDesign.secondary.withOpacity(0.3)),
          ),
          child: Icon(
            Icons.person_outline,
            color: BauhausDesign.secondary,
            size: 18,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SUPPORT WORKER',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
              Text(
                appointment.userEmail!,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildViewDetailsRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: BauhausDesign.neutral.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.open_in_new,
            color: BauhausDesign.textMuted,
            size: 14,
          ),
          const SizedBox(width: BauhausDesign.space2),
          Text(
            'Tap to view details',
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }
}

class _ServiceHistoryFooter extends ConsumerWidget {
  final List<ServiceHistory> history;
  final String? clientId;

  const _ServiceHistoryFooter({
    required this.history,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (clientId == null || clientId!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'SERVICE HISTORY',
          subtitle: 'Completed services and feedback',
        ),
        const SizedBox(height: BauhausDesign.space3),
        if (history.isEmpty)
          BauhausCard(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'No completed services yet.',
                style: BauhausDesign.getTextTheme(context).bodyMedium,
              ),
            ),
          )
        else
          Column(
            children: history.take(5).map((service) {
              final rating = service.rating;
              final hasFeedback =
                  rating > 0 || (service.feedback ?? '').trim().isNotEmpty;
              final buttonLabel =
                  hasFeedback ? 'UPDATE FEEDBACK' : 'SUBMIT FEEDBACK';

              return Padding(
                padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
                child: BauhausCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceName,
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        '${service.date} • ${service.startTime} - ${service.endTime}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Worker: ${service.workerName}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      if (rating > 0)
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < rating ? Icons.star : Icons.star_border,
                              size: 16,
                              color: BauhausDesign.accent,
                            ),
                          ),
                        ),
                      if ((service.feedback ?? '').trim().isNotEmpty) ...[
                        const SizedBox(height: BauhausDesign.space2),
                        Text(
                          service.feedback!,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                        ),
                      ],
                      const SizedBox(height: BauhausDesign.space3),
                      BauhausActionButton(
                        onPressed: () {
                          _showServiceHistoryFeedbackDialog(
                            context,
                            ref,
                            service,
                            clientId!,
                          );
                        },
                        text: buttonLabel,
                        icon: Icons.rate_review,
                        variant: BauhausActionVariant.primary,
                        isFullWidth: true,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        if (history.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClientServiceHistoryView(
                      clientId: clientId!,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('View all history'),
            ),
          ),
      ],
    );
  }

  void _showServiceHistoryFeedbackDialog(
    BuildContext context,
    WidgetRef ref,
    ServiceHistory service,
    String clientId,
  ) {
    Navigator.pushNamed(
      context,
      Routes.serviceConfirmation,
      arguments: {
        'appointmentId': service.serviceId,
        'clientId': clientId,
        'workerId': 'worker_123',
        'workerName': service.workerName,
        'serviceName': service.serviceName,
      },
    );
  }
}
