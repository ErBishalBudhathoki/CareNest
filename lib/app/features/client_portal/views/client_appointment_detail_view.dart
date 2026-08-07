import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';
import 'package:carenest/app/features/client_portal/repositories/client_portal_repository.dart';
import 'package:carenest/app/features/client_portal/viewmodels/client_appointment_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientAppointmentDetailView extends ConsumerWidget {
  final String assignmentId;
  final String scheduleId;

  const ClientAppointmentDetailView({
    super.key,
    required this.assignmentId,
    required this.scheduleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = AppointmentParams(
      assignmentId: assignmentId,
      scheduleId: scheduleId,
    );
    final appointmentState = ref.watch(clientAppointmentDetailProvider(params));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'APPOINTMENT DETAILS',
          style: GoogleFonts.oswald(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      body: appointmentState.when(
        data: (appointment) => _buildContent(context, ref, appointment),
        loading: () => const Center(child: BauhausLoadingState()),
        error: (error, stack) => Center(
          child: BauhausErrorState(
            title: 'Error Loading Details',
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(clientAppointmentDetailProvider(params)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ClientAppointmentDetail appointment,
  ) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(context, appointment),
              const SizedBox(height: BauhausDesign.space4),
              if (appointment.employee != null) ...[
                _buildEmployeeCard(context, appointment.employee!),
                const SizedBox(height: BauhausDesign.space4),
              ],
              _buildServiceCard(context, appointment),
              const SizedBox(height: BauhausDesign.space4),
              _buildLocationCard(context, appointment),
              const SizedBox(height: BauhausDesign.space4),
              _buildNotesCard(context, appointment),
              const SizedBox(height: 100),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildActionButtons(context, ref, appointment),
        ),
      ],
    );
  }

  Widget _buildDateHeader(
    BuildContext context,
    ClientAppointmentDetail appointment,
  ) {
    DateTime? date;
    try {
      date = DateTime.parse(appointment.date);
    } catch (_) {}

    final dayName = date != null ? DateFormat('EEEE').format(date) : '';
    final formattedDate = date != null
        ? DateFormat('MMMM d, yyyy').format(date)
        : appointment.date;
    final status = appointment.status.isNotEmpty
        ? appointment.status
        : 'Scheduled';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.secondary,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_today,
              size: 40,
              color: BauhausDesign.surfaceWhite,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            dayName.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.surfaceWhite.withOpacity(0.8),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            formattedDate,
            style: GoogleFonts.oswald(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: BauhausDesign.surfaceWhite,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: BauhausDesign.space3),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space2,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  color: BauhausDesign.secondary,
                  size: 18,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  '${appointment.startTime} - ${appointment.endTime}',
                  style: GoogleFonts.oswald(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
            ),
            child: Text(
              status.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.surfaceWhite,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(BuildContext context, ClientEmployee employee) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.primary.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: BauhausDesign.primary,
                  size: 18,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                'SUPPORT WORKER',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: BauhausDesign.backgroundLight,
                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                  image: employee.photo != null
                      ? DecorationImage(
                          image: NetworkImage(employee.photo!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: employee.photo == null
                    ? Icon(
                        Icons.person,
                        color: BauhausDesign.textMuted,
                        size: 30,
                      )
                    : null,
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${employee.firstName} ${employee.lastName}',
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (employee.phone != null) ...[
                      const SizedBox(height: BauhausDesign.space1),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: BauhausDesign.textMuted,
                            size: 14,
                          ),
                          const SizedBox(width: BauhausDesign.space1),
                          Text(
                            employee.phone!,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (employee.phone != null)
                BauhausIconButton(
                  onPressed: () => _launchPhone(employee.phone!),
                  icon: Icons.phone,
                  variant: BauhausActionVariant.primary,
                  tooltip: 'Call',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    ClientAppointmentDetail appointment,
  ) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.warning.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: BauhausDesign.warning,
                  size: 18,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                'SERVICE DETAILS',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildDetailRow(
            context,
            'Service Type',
            appointment.serviceName ?? 'Not specified',
            Icons.category_outlined,
          ),
          if (appointment.services != null &&
              appointment.services!.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space3),
            _buildDetailRow(
              context,
              'Services',
              appointment.services!.join(', '),
              Icons.list_alt,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationCard(
    BuildContext context,
    ClientAppointmentDetail appointment,
  ) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.secondary.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: BauhausDesign.secondary,
                  size: 18,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                'LOCATION',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.backgroundLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.home_outlined,
                  color: BauhausDesign.textMuted,
                  size: 20,
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    appointment.location ?? 'Client Home',
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(
    BuildContext context,
    ClientAppointmentDetail appointment,
  ) {
    if (appointment.notes == null || appointment.notes!.isEmpty) {
      return const SizedBox.shrink();
    }

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.neutral.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.neutral.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  Icons.notes_outlined,
                  color: BauhausDesign.textMuted,
                  size: 18,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                'NOTES',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.backgroundLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(color: BauhausDesign.neutral.withOpacity(0.3)),
            ),
            child: Text(
              appointment.notes!,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: BauhausDesign.textMuted, size: 18),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
              ),
              Text(
                value,
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    ClientAppointmentDetail appointment,
  ) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(top: BorderSide(color: BauhausDesign.neutral, width: 2)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BauhausActionButton(
              text: 'Request Change',
              icon: Icons.edit_calendar,
              isFullWidth: true,
              variant: BauhausActionVariant.secondary,
              onPressed: () =>
                  _showRequestDialog(context, ref, 'change', appointment),
            ),
            const SizedBox(height: BauhausDesign.space3),
            BauhausActionButton(
              text: 'Report Issue',
              icon: Icons.report_problem_outlined,
              isFullWidth: true,
              variant: BauhausActionVariant.ghost,
              textColor: BauhausDesign.error,
              onPressed: () =>
                  _showRequestDialog(context, ref, 'issue', appointment),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
      case 'confirmed':
        return BauhausDesign.success;
      case 'pending':
        return BauhausDesign.warning;
      case 'cancelled':
        return BauhausDesign.error;
      case 'completed':
        return BauhausDesign.secondary;
      default:
        return BauhausDesign.neutral;
    }
  }

  void _showRequestDialog(
    BuildContext context,
    WidgetRef ref,
    String type,
    ClientAppointmentDetail appointment,
  ) {
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: Row(
          children: [
            Icon(
              type == 'change'
                  ? Icons.edit_calendar
                  : Icons.report_problem_outlined,
              color: type == 'change'
                  ? BauhausDesign.secondary
                  : BauhausDesign.error,
            ),
            const SizedBox(width: BauhausDesign.space2),
            Text(
              type == 'change' ? 'Request Change' : 'Report Issue',
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(
                  color: BauhausDesign.neutral.withOpacity(0.3),
                ),
              ),
              child: Text(
                type == 'change'
                    ? 'Describe the changes you need for this appointment.'
                    : 'Describe the issue or concern regarding this appointment.',
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            TextField(
              controller: noteController,
              decoration: BauhausDesign.inputDecoration('Enter details...'),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: TextStyle(color: BauhausDesign.neutral),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: type == 'change'
                  ? BauhausDesign.secondary
                  : BauhausDesign.error,
              foregroundColor: BauhausDesign.surfaceWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
            ),
            onPressed: () async {
              if (noteController.text.isEmpty) return;
              Navigator.pop(context);
              try {
                await ref
                    .read(clientPortalRepositoryProvider)
                    .requestAppointment({
                      'type': type,
                      'assignmentId': appointment.assignmentId,
                      'scheduleId': appointment.scheduleId,
                      'date': appointment.date,
                      'notes': noteController.text,
                    });
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Request submitted successfully. We will contact you shortly.',
                      ),
                      backgroundColor: BauhausDesign.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: BauhausDesign.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            child: Text(type == 'change' ? 'SUBMIT REQUEST' : 'SUBMIT REPORT'),
          ),
        ],
      ),
    );
  }
}
