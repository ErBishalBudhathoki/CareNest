import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';
import 'package:carenest/app/features/client_portal/viewmodels/client_invoice_viewmodel.dart';
import 'package:carenest/app/features/client_portal/viewmodels/client_portal_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/views/secure_messaging_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/platform_map_widget.dart';
import 'package:carenest/app/features/client_portal/views/client_service_history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'client_invoice_detail_view.dart';

class ClientPortalDashboard extends StatelessWidget {
  final String? clientId;

  const ClientPortalDashboard({
    super.key,
    this.clientId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      body: ClientPortalDashboardBody(
        clientId: clientId,
      ),
    );
  }
}

class ClientPortalDashboardBody extends ConsumerStatefulWidget {
  final String? clientId;
  final bool showHeroHeader;
  final bool useSafeArea;
  final Widget? footer;

  const ClientPortalDashboardBody({
    super.key,
    this.clientId,
    this.showHeroHeader = true,
    this.useSafeArea = true,
    this.footer,
  });

  @override
  ConsumerState<ClientPortalDashboardBody> createState() =>
      _ClientPortalDashboardBodyState();
}

class _ClientPortalDashboardBodyState
    extends ConsumerState<ClientPortalDashboardBody> {
  static const List<String> _timePatterns = <String>[
    'HH:mm:ss',
    'H:mm:ss',
    'HH:mm',
    'H:mm',
    'hh:mm a',
    'h:mm a',
    'hh:mm:ss a',
    'h:mm:ss a',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.clientId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(clientPortalViewModelProvider.notifier)
            .loadDashboard(widget.clientId!);
        ref
            .read(clientPortalViewModelProvider.notifier)
            .loadServiceHistory(widget.clientId!, silent: true);
      });
    }
  }

  DateTime? _parseTodayTime(String? rawTime) {
    final raw = (rawTime ?? '').trim();
    if (raw.isEmpty) return null;

    final direct = DateTime.tryParse(raw);
    if (direct != null) return direct.toLocal();

    final now = DateTime.now();
    for (final pattern in _timePatterns) {
      try {
        final parsed = DateFormat(pattern).parseStrict(raw);
        return DateTime(
          now.year,
          now.month,
          now.day,
          parsed.hour,
          parsed.minute,
          parsed.second,
        );
      } catch (_) {}
    }

    final normalizedUpper = raw.toUpperCase();
    if (RegExp(r'^\d{1,2}:\d{2}\s*[AP]M$').hasMatch(normalizedUpper)) {
      try {
        final parsed = DateFormat('h:mm a').parseStrict(
          normalizedUpper.replaceAll(RegExp(r'\s+'), ' '),
        );
        return DateTime(
          now.year,
          now.month,
          now.day,
          parsed.hour,
          parsed.minute,
          parsed.second,
        );
      } catch (_) {}
    }

    return null;
  }

  bool _isWithinShiftWindow(TodayAppointment appointment) {
    final startAt = _parseTodayTime(appointment.startTime);
    final parsedEndAt = _parseTodayTime(appointment.endTime);
    if (startAt == null || parsedEndAt == null) return false;

    final endAt = parsedEndAt.isAfter(startAt)
        ? parsedEndAt
        : parsedEndAt.add(const Duration(days: 1));
    final now = DateTime.now();
    final chatStart = startAt.subtract(const Duration(hours: 2));
    final chatEnd = endAt.add(const Duration(hours: 2));

    return !now.isBefore(chatStart) && !now.isAfter(chatEnd);
  }

  DateTime? _resolveFeedbackEndAt(TodayAppointment appointment) {
    final startAt = _parseTodayTime(appointment.startTime);
    final parsedEndAt = _parseTodayTime(appointment.endTime);
    if (startAt == null || parsedEndAt == null) return null;
    return parsedEndAt.isAfter(startAt)
        ? parsedEndAt
        : parsedEndAt.add(const Duration(days: 1));
  }

  TodayAppointment? _getPrimaryAppointment(
      List<TodayAppointment> appointments) {
    if (appointments.isEmpty) return null;

    for (final appt in appointments) {
      if (_isWithinShiftWindow(appt)) return appt;
    }

    return appointments.first;
  }

  TodayAppointment? _getFeedbackEligibleAppointment(
    List<TodayAppointment> appointments,
  ) {
    if (appointments.isEmpty) return null;

    final now = DateTime.now();
    for (final appt in appointments) {
      final endAt = _resolveFeedbackEndAt(appt);
      if (endAt != null && now.isAfter(endAt)) {
        return appt;
      }
      if (appt.status.toLowerCase() == 'completed') {
        return appt;
      }
    }

    return null;
  }

  void _showActionSnackBar(
      BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isSuccess ? BauhausDesign.success : BauhausDesign.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(clientPortalViewModelProvider);

    final todayAppointments =
        state.dashboard?.todayAppointments ?? <TodayAppointment>[];
    final upcomingAppointments =
        state.dashboard?.upcomingAppointments ?? <UpcomingAppointment>[];
    final invoicesState = ref.watch(clientInvoicesProvider);
    final serviceHistory = state.serviceHistory;

    final content = state.isLoading
        ? const Center(child: BauhausLoadingState())
        : state.error != null && state.dashboard == null
            ? Center(
                child: BauhausErrorState(
                  title: 'Error Loading Dashboard',
                  message: state.error!,
                  onRetry: () {
                    if (widget.clientId != null) {
                      ref
                          .read(clientPortalViewModelProvider.notifier)
                          .loadDashboard(widget.clientId!);
                    }
                  },
                ),
              )
            : RefreshIndicator(
                color: BauhausDesign.primary,
                backgroundColor: BauhausDesign.surfaceWhite,
                onRefresh: () async {
                  if (widget.clientId != null) {
                    await ref
                        .read(clientPortalViewModelProvider.notifier)
                        .loadDashboard(widget.clientId!);
                    await ref
                        .read(clientPortalViewModelProvider.notifier)
                        .loadServiceHistory(
                          widget.clientId!,
                          silent: true,
                        );
                  }
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.showHeroHeader) ...[
                        _buildHeader(context),
                        const SizedBox(height: BauhausDesign.space6),
                      ],
                      _buildFamilyAccessSection(context),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildTodayAppointmentsSection(
                          context, todayAppointments),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildWorkerLocationSection(
                        context,
                        todayAppointments,
                        state,
                      ),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildMessagingSection(context, todayAppointments),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildFeedbackSection(context, todayAppointments),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildInvoicesSection(context, invoicesState),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildUpcomingAppointmentsSection(
                        context,
                        upcomingAppointments,
                      ),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildServiceHistorySection(context, serviceHistory),
                      if (widget.footer != null) ...[
                        const SizedBox(height: BauhausDesign.space6),
                        widget.footer!,
                      ],
                    ],
                  ),
                ),
              );

    if (!widget.useSafeArea) {
      return content;
    }

    return SafeArea(child: content);
  }

  Widget _buildFamilyAccessSection(BuildContext context) {
    final hasClientContext =
        widget.clientId != null && widget.clientId!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'FAMILY ACCESS',
          subtitle: 'Control what approved family members can see and do',
        ),
        const SizedBox(height: BauhausDesign.space3),
        BauhausCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space3),
                    decoration: BoxDecoration(
                      color: BauhausDesign.warning.withOpacity(0.14),
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                      border: Border.all(
                        color: BauhausDesign.warning.withOpacity(0.35),
                      ),
                    ),
                    child: const Icon(
                      Icons.family_restroom_outlined,
                      size: 24,
                      color: BauhausDesign.warning,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share visibility without losing control',
                          style: BauhausDesign.getTextTheme(context)
                              .headlineMedium,
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          'Invite family members, manage permissions, and decide who can view appointments, messages, location, and service approvals.',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space4),
              Wrap(
                spacing: BauhausDesign.space2,
                runSpacing: BauhausDesign.space2,
                children: [
                  _buildFamilyFeatureChip(context, 'Appointments'),
                  _buildFamilyFeatureChip(context, 'Messages'),
                  _buildFamilyFeatureChip(context, 'Location'),
                  _buildFamilyFeatureChip(context, 'Approvals'),
                ],
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausActionButton(
                onPressed: hasClientContext
                    ? () {
                        Navigator.of(context).pushNamed(
                          Routes.familyManagement,
                          arguments: {
                            'clientId': widget.clientId,
                          },
                        );
                      }
                    : null,
                text: hasClientContext
                    ? 'MANAGE FAMILY ACCESS'
                    : 'CLIENT REQUIRED',
                icon:
                    hasClientContext ? Icons.arrow_forward : Icons.info_outline,
                variant: BauhausActionVariant.warning,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFamilyFeatureChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 1.2,
        ),
      ),
      child: Text(
        label,
        style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              color: BauhausDesign.textDark,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.primary,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
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
              Icons.dashboard_outlined,
              color: BauhausDesign.surfaceWhite,
              size: 24,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLIENT PORTAL',
                  style: GoogleFonts.oswald(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.surfaceWhite,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  'Real-time updates for your assigned services',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: BauhausDesign.surfaceWhite.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayAppointmentsSection(
    BuildContext context,
    List<TodayAppointment> appointments,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'TODAY\'S APPOINTMENTS',
          subtitle: appointments.isEmpty
              ? 'No appointments scheduled'
              : '${appointments.length} appointment(s)',
        ),
        const SizedBox(height: BauhausDesign.space3),
        if (appointments.isEmpty)
          BauhausCard(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    decoration: BoxDecoration(
                      color: BauhausDesign.neutral.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.event_busy_outlined,
                      size: 40,
                      color: BauhausDesign.textMuted,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  Text(
                    'No Appointments Today',
                    style: BauhausDesign.getTextTheme(context).headlineMedium,
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    'Newly assigned shifts will appear automatically.',
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          ...appointments.map((appt) => _buildAppointmentCard(context, appt)),
      ],
    );
  }

  Widget _buildAppointmentCard(
      BuildContext context, TodayAppointment appointment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: BauhausCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border:
                    Border.all(color: BauhausDesign.success.withOpacity(0.3)),
              ),
              child: Icon(
                Icons.access_time,
                color: BauhausDesign.success,
                size: 24,
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.startTime,
                    style: GoogleFonts.oswald(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                  Text(
                    '${appointment.workerName} - ${appointment.serviceName}',
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: appointment.status.toLowerCase() == 'completed'
                          ? BauhausDesign.neutral
                          : BauhausDesign.success,
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusXs),
                    ),
                    child: Text(
                      appointment.status.toUpperCase(),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerLocationSection(
    BuildContext context,
    List<TodayAppointment> appointments,
    ClientPortalState state,
  ) {
    final trackAppointment = _getPrimaryAppointment(appointments);
    final hasAppointment = trackAppointment != null;
    final hasVisibleLocation = state.workerLocation != null;
    final statusMessage = (state.error ?? '').trim();

    String helperText;
    if (!hasAppointment) {
      helperText =
          'Location tracking becomes available when a shift is assigned.';
    } else if (hasVisibleLocation) {
      helperText =
          'Live tracking is active. Location visibility follows worker geofence settings.';
    } else if (statusMessage.isNotEmpty) {
      helperText = statusMessage;
    } else {
      helperText =
          'Tracking unlocks when the worker enters your approved geofence region.';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'WORKER LOCATION',
          subtitle:
              'Visible when location sharing is enabled and worker is in geofence range',
        ),
        const SizedBox(height: BauhausDesign.space3),
        BauhausCard(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: BauhausDesign.secondary.withOpacity(0.3)),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 40,
                  color: BauhausDesign.secondary,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                hasAppointment ? 'Track Your Worker' : 'No Active Appointments',
                style: BauhausDesign.getTextTheme(context).headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                helperText,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: hasAppointment &&
                              !hasVisibleLocation &&
                              statusMessage.isNotEmpty
                          ? BauhausDesign.error
                          : BauhausDesign.textMuted,
                    ),
                textAlign: TextAlign.center,
              ),
              if (state.workerLocation != null) ...[
                const SizedBox(height: BauhausDesign.space4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                        color: BauhausDesign.neutral.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Visible Location',
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        '${state.workerLocation!.workerName} • ETA: ${state.workerLocation!.eta ?? 'N/A'}',
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Lat: ${state.workerLocation!.latitude.toStringAsFixed(6)}, '
                        'Lng: ${state.workerLocation!.longitude.toStringAsFixed(6)}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (state.workerLocation!.distanceRemaining != null)
                        Text(
                          'Distance: ${state.workerLocation!.distanceRemaining!.toStringAsFixed(2)} km',
                          style: BauhausDesign.getTextTheme(context)
                              .bodySmall
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Updated: ${state.workerLocation!.lastUpdated ?? state.workerLocation!.timestamp}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: BauhausDesign.space3),
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    child: PlatformMapWidget(
                      center: LatLng(
                        state.workerLocation!.latitude,
                        state.workerLocation!.longitude,
                      ),
                      zoom: 16,
                      showMyLocation: false,
                      startMarker: LatLng(
                        state.workerLocation!.latitude,
                        state.workerLocation!.longitude,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: BauhausDesign.space4),
              BauhausActionButton(
                onPressed: hasAppointment
                    ? () async {
                        await ref
                            .read(clientPortalViewModelProvider.notifier)
                            .getWorkerLocation(trackAppointment.appointmentId);

                        if (!mounted) return;
                        final updatedState =
                            ref.read(clientPortalViewModelProvider);
                        final location = updatedState.workerLocation;

                        if (location != null) {
                          _showActionSnackBar(
                            context,
                            'Location visible for ${location.workerName}.',
                            true,
                          );
                        } else {
                          _showActionSnackBar(
                            context,
                            updatedState.error ??
                                'Location is hidden until worker enters your geofence region.',
                            false,
                          );
                        }
                      }
                    : null,
                text: 'VIEW LOCATION',
                icon: Icons.my_location,
                variant: BauhausActionVariant.secondary,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessagingSection(
    BuildContext context,
    List<TodayAppointment> appointments,
  ) {
    final appointment = _getPrimaryAppointment(appointments);
    final chatEnabled = appointment != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'MESSAGING',
          subtitle: 'Secure chat with your assigned worker',
        ),
        const SizedBox(height: BauhausDesign.space3),
        BauhausCard(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.warning.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: BauhausDesign.warning.withOpacity(0.3)),
                ),
                child: Icon(
                  Icons.message_outlined,
                  size: 40,
                  color: BauhausDesign.warning,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'Secure Shift Messaging',
                style: BauhausDesign.getTextTheme(context).headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                appointment != null
                    ? 'Connected to ${appointment.workerName} for today\'s scheduled service.'
                    : 'No assigned shift available for secure messaging.',
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausActionButton(
                onPressed: chatEnabled
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SecureMessagingView(
                              userId: widget.clientId,
                              userType: 'client',
                              preferredConversationId:
                                  'conv-${appointment.appointmentId}',
                            ),
                          ),
                        );
                      }
                    : null,
                text: 'OPEN CHAT',
                icon: Icons.send,
                variant: BauhausActionVariant.warning,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeedbackSection(
    BuildContext context,
    List<TodayAppointment> appointments,
  ) {
    final feedbackAppointment = _getFeedbackEligibleAppointment(appointments);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'SERVICE FEEDBACK',
          subtitle: 'Optional feedback after service completion',
        ),
        const SizedBox(height: BauhausDesign.space3),
        BauhausCard(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: BauhausDesign.accent.withOpacity(0.3)),
                ),
                child: Icon(
                  Icons.star_outline,
                  size: 40,
                  color: BauhausDesign.accent,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                'Share Your Experience',
                style: BauhausDesign.getTextTheme(context).headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                feedbackAppointment != null
                    ? 'Rate your completed service with ${feedbackAppointment.workerName}.'
                    : 'Feedback unlocks after a shift has finished.',
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausActionButton(
                onPressed: () =>
                    _handleFeedbackTap(context, feedbackAppointment),
                text: 'SUBMIT FEEDBACK',
                icon: Icons.rate_review,
                variant: BauhausActionVariant.primary,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvoicesSection(
    BuildContext context,
    AsyncValue<List<ClientInvoice>> invoicesState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BauhausSectionHeader(
          title: 'INVOICES',
          subtitle: 'Latest invoice updates and payment status',
        ),
        const SizedBox(height: BauhausDesign.space3),
        invoicesState.when(
          loading: () => const BauhausCard(
            child: Center(
              child: BauhausLoadingState(showMessage: false),
            ),
          ),
          error: (error, _) => BauhausCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unable to load invoices.',
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(color: BauhausDesign.error),
                ),
                const SizedBox(height: BauhausDesign.space3),
                BauhausActionButton(
                  onPressed: () => ref.invalidate(clientInvoicesProvider),
                  text: 'RETRY',
                ),
              ],
            ),
          ),
          data: (invoices) {
            if (invoices.isEmpty) {
              return BauhausCard(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'No invoices available yet.',
                    style: BauhausDesign.getTextTheme(context).bodyMedium,
                  ),
                ),
              );
            }

            return Column(
              children: invoices.take(3).map((invoice) {
                final status =
                    (invoice.workflow['status'] ?? 'pending').toString();
                final total =
                    (invoice.financialSummary['totalAmount'] ?? 0).toString();

                return Padding(
                  padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
                  child: BauhausCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ClientInvoiceDetailView(invoiceId: invoice.id),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(BauhausDesign.space3),
                          decoration: BoxDecoration(
                            color: BauhausDesign.primary.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusSm),
                            border: Border.all(
                              color: BauhausDesign.primary.withOpacity(0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.receipt_long_outlined,
                            size: 22,
                            color: BauhausDesign.primary,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                invoice.invoiceNumber,
                                style: BauhausDesign.getTextTheme(context)
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              Text(
                                'Total: $total',
                                style: BauhausDesign.getTextTheme(context)
                                    .bodySmall
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space2,
                            vertical: BauhausDesign.space1,
                          ),
                          decoration: BoxDecoration(
                            color: BauhausDesign.secondary,
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(
                                  color: BauhausDesign.surfaceWhite,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildUpcomingAppointmentsSection(
    BuildContext context,
    List<UpcomingAppointment> appointments,
  ) {
    if (appointments.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'UPCOMING APPOINTMENTS',
          subtitle: '${appointments.length} scheduled',
        ),
        const SizedBox(height: BauhausDesign.space3),
        ...appointments
            .take(3)
            .map((appt) => _buildUpcomingAppointmentCard(context, appt)),
      ],
    );
  }

  Widget _buildUpcomingAppointmentCard(
    BuildContext context,
    UpcomingAppointment appointment,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: BauhausCard(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border:
                    Border.all(color: BauhausDesign.secondary.withOpacity(0.3)),
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                color: BauhausDesign.secondary,
                size: 20,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.date,
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${appointment.workerName} - ${appointment.serviceName}',
                    style: BauhausDesign.getTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: BauhausDesign.textMuted),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: BauhausDesign.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceHistorySection(
    BuildContext context,
    List<ServiceHistory> history,
  ) {
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
                        onPressed: () =>
                            _showServiceHistoryFeedbackDialog(context, service),
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
        if (history.isNotEmpty && widget.clientId != null)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        ClientServiceHistoryView(clientId: widget.clientId!),
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

  void _showMessageDialog(BuildContext context, TodayAppointment appointment) {
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        child: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.warning,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(BauhausDesign.radiusMd),
                    topRight: Radius.circular(BauhausDesign.radiusMd),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.message_outlined, color: BauhausDesign.textDark),
                    const SizedBox(width: BauhausDesign.space3),
                    Text(
                      'SEND MESSAGE',
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.textDark,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(BauhausDesign.space5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Worker: ${appointment.workerName}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      'Shift: ${appointment.startTime} - ${appointment.endTime}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    TextField(
                      controller: messageController,
                      decoration:
                          BauhausDesign.inputDecoration('Your message...'),
                      maxLines: 5,
                    ),
                    const SizedBox(height: BauhausDesign.space5),
                    Row(
                      children: [
                        Expanded(
                          child: BauhausActionButton(
                            onPressed: () => Navigator.pop(context),
                            text: 'CANCEL',
                            variant: BauhausActionVariant.ghost,
                            textColor: BauhausDesign.neutral,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space3),
                        Expanded(
                          child: BauhausActionButton(
                            onPressed: () async {
                              final message = messageController.text.trim();
                              if (message.isEmpty) return;

                              final success = await ref
                                  .read(clientPortalViewModelProvider.notifier)
                                  .sendMessage({
                                'clientId': widget.clientId,
                                'appointmentId': appointment.appointmentId,
                                'message': message,
                                'messageType': 'text',
                                'timestamp': DateTime.now().toIso8601String(),
                              });

                              if (!context.mounted) return;

                              Navigator.pop(context);
                              final latestState =
                                  ref.read(clientPortalViewModelProvider);
                              _showActionSnackBar(
                                context,
                                success
                                    ? 'Message sent securely.'
                                    : (latestState.error ??
                                        'Unable to send message. Chat is available from 2 hours before shift start until 2 hours after shift end.'),
                                success,
                              );
                            },
                            text: 'SEND',
                            variant: BauhausActionVariant.warning,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeedbackDialog(
    BuildContext context,
    TodayAppointment appointment,
  ) {
    int rating = 5;
    final feedbackController = TextEditingController();
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            side: const BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  decoration: BoxDecoration(
                    color: BauhausDesign.accent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(BauhausDesign.radiusMd),
                      topRight: Radius.circular(BauhausDesign.radiusMd),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: BauhausDesign.textDark),
                      const SizedBox(width: BauhausDesign.space3),
                      Text(
                        'SERVICE FEEDBACK',
                        style: GoogleFonts.oswald(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service: ${appointment.serviceName}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Worker: ${appointment.workerName}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Text(
                        'Rate your service:',
                        style: BauhausDesign.getTextTheme(context)
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: BauhausDesign.space4,
                        ),
                        decoration: BoxDecoration(
                          color: BauhausDesign.backgroundLight,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(
                              color: BauhausDesign.neutral.withOpacity(0.3)),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () => setState(() => rating = index + 1),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Icon(
                                    index < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: BauhausDesign.accent,
                                    size: 40,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      TextField(
                        controller: feedbackController,
                        decoration: BauhausDesign.inputDecoration(
                            'Additional comments...'),
                        maxLines: 4,
                      ),
                      const SizedBox(height: BauhausDesign.space5),
                      Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              onPressed: () => Navigator.pop(context),
                              text: 'CANCEL',
                              variant: BauhausActionVariant.ghost,
                              textColor: BauhausDesign.neutral,
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: BauhausActionButton(
                              onPressed: () async {
                                if (isSubmitting) return;
                                setState(() => isSubmitting = true);

                                final success = await ref
                                    .read(
                                        clientPortalViewModelProvider.notifier)
                                    .submitFeedback({
                                  'clientId': widget.clientId,
                                  'appointmentId': appointment.appointmentId,
                                  'rating': rating,
                                  'comments': feedbackController.text.trim(),
                                  'timestamp': DateTime.now().toIso8601String(),
                                });

                                if (!mounted) return;

                                Navigator.pop(context);
                                final latestState =
                                    ref.read(clientPortalViewModelProvider);
                                _showActionSnackBar(
                                  this.context,
                                  success
                                      ? 'Feedback submitted. Thank you.'
                                      : (latestState.error ??
                                          'Feedback can only be submitted after service completion.'),
                                  success,
                                );

                                if (success && widget.clientId != null) {
                                  ref
                                      .read(clientPortalViewModelProvider
                                          .notifier)
                                      .loadServiceHistory(
                                        widget.clientId!,
                                        silent: true,
                                      );
                                }
                              },
                              text: isSubmitting ? 'SUBMITTING...' : 'SUBMIT',
                              variant: BauhausActionVariant.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showServiceHistoryFeedbackDialog(
    BuildContext context,
    ServiceHistory service,
  ) {
    if (widget.clientId == null || widget.clientId!.isEmpty) {
      _showActionSnackBar(
        context,
        'Unable to submit feedback: missing client context.',
        false,
      );
      return;
    }

    int rating = service.rating > 0 ? service.rating : 5;
    final feedbackController =
        TextEditingController(text: service.feedback ?? '');
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            side: const BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
          child: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  decoration: BoxDecoration(
                    color: BauhausDesign.accent,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(BauhausDesign.radiusMd),
                      topRight: Radius.circular(BauhausDesign.radiusMd),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: BauhausDesign.textDark),
                      const SizedBox(width: BauhausDesign.space3),
                      Text(
                        'SERVICE FEEDBACK',
                        style: GoogleFonts.oswald(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.textDark,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service: ${service.serviceName}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Worker: ${service.workerName}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Text(
                        'Rate your service:',
                        style: BauhausDesign.getTextTheme(context)
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: BauhausDesign.space4,
                        ),
                        decoration: BoxDecoration(
                          color: BauhausDesign.backgroundLight,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(
                              color: BauhausDesign.neutral.withOpacity(0.3)),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () => setState(() => rating = index + 1),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Icon(
                                    index < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: BauhausDesign.accent,
                                    size: 40,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      TextField(
                        controller: feedbackController,
                        decoration: BauhausDesign.inputDecoration(
                            'Additional comments...'),
                        maxLines: 4,
                      ),
                      const SizedBox(height: BauhausDesign.space5),
                      Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              onPressed: () => Navigator.pop(context),
                              text: 'CANCEL',
                              variant: BauhausActionVariant.ghost,
                              textColor: BauhausDesign.neutral,
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: BauhausActionButton(
                              onPressed: () async {
                                if (isSubmitting) return;
                                setState(() => isSubmitting = true);

                                final success = await ref
                                    .read(
                                        clientPortalViewModelProvider.notifier)
                                    .submitFeedback({
                                  'clientId': widget.clientId,
                                  'appointmentId': service.serviceId,
                                  'rating': rating,
                                  'comments': feedbackController.text.trim(),
                                  'timestamp': DateTime.now().toIso8601String(),
                                });

                                if (!mounted) return;

                                Navigator.pop(context);
                                final latestState =
                                    ref.read(clientPortalViewModelProvider);
                                _showActionSnackBar(
                                  this.context,
                                  success
                                      ? 'Feedback submitted. Thank you.'
                                      : (latestState.error ??
                                          'Feedback can only be submitted after service completion.'),
                                  success,
                                );

                                if (success && widget.clientId != null) {
                                  ref
                                      .read(clientPortalViewModelProvider
                                          .notifier)
                                      .loadServiceHistory(
                                        widget.clientId!,
                                        silent: true,
                                      );
                                }
                              },
                              text: isSubmitting ? 'SUBMITTING...' : 'SUBMIT',
                              variant: BauhausActionVariant.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleFeedbackTap(
    BuildContext context,
    TodayAppointment? appointment,
  ) {
    if (widget.clientId == null || widget.clientId!.isEmpty) {
      _showActionSnackBar(
        context,
        'Unable to submit feedback: missing client context.',
        false,
      );
      return;
    }

    if (appointment == null) {
      _showActionSnackBar(
        context,
        'Feedback is available after a service is completed.',
        false,
      );
      return;
    }

    _showFeedbackDialog(context, appointment);
  }
}
