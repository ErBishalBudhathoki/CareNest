import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';
import 'package:carenest/app/features/client_portal/repositories/client_portal_repository.dart';
import 'package:carenest/app/features/client_portal/viewmodels/client_appointment_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: Text(
          'Appointment Details',
          style: BauhausDesign.getTextTheme(context).headlineSmall,
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.background,
        elevation: 0,
        leading: BauhausIconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back,
          variant: BauhausActionVariant.ghost,
        ),
      ),
      body: appointmentState.when(
        data: (appointment) => _buildContent(context, ref, appointment),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: BauhausCard(
            backgroundColor: BauhausDesign.error.withOpacity(0.1),
            child: Text(
              'Error loading details: $error',
              style: TextStyle(color: BauhausDesign.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref,
      ClientAppointmentDetail appointment) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context, appointment),
          const SizedBox(height: BauhausDesign.space4),
          _buildEmployeeCard(context, appointment.employee),
          const SizedBox(height: BauhausDesign.space4),
          _buildDetailsCard(context, appointment),
          const SizedBox(height: BauhausDesign.space6),
          _buildActionButtons(context, ref, appointment),
        ],
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, ClientAppointmentDetail appointment) {
    DateTime? date;
    try {
      date = DateTime.parse(appointment.date);
    } catch (_) {}

    final dateStr = date != null
        ? DateFormat('EEEE, MMMM d, y').format(date)
        : appointment.date;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.calendar_today,
            size: 40,
            color: BauhausDesign.primary,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        Text(
          dateStr,
          style: BauhausDesign.getTextTheme(context).headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          '${appointment.startTime} - ${appointment.endTime}',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.textMuted,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmployeeCard(BuildContext context, ClientEmployee? employee) {
    if (employee == null) return const SizedBox.shrink();

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support Worker',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: BauhausDesign.neutral.withOpacity(0.2),
                  image: employee.photo != null
                      ? DecorationImage(
                          image: NetworkImage(employee.photo!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: employee.photo == null
                    ? Icon(Icons.person, color: BauhausDesign.textMuted)
                    : null,
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${employee.firstName} ${employee.lastName}',
                      style: BauhausDesign.getTextTheme(context).titleMedium,
                    ),
                    if (employee.phone != null) ...[
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        employee.phone ?? '-',
                        style: BauhausDesign.getTextTheme(context).bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
              if (employee.phone != null)
                BauhausIconButton(
                  onPressed: () => _launchPhone(employee.phone!),
                  icon: Icons.phone,
                  variant: BauhausActionVariant.secondary,
                  isSmall: true,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(
      BuildContext context, ClientAppointmentDetail appointment) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Details',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildDetailRow(context, 'Service Type', appointment.serviceName ?? 'Not specified'),
          const Divider(height: BauhausDesign.space4),
          _buildDetailRow(
              context, 'Location', appointment.location ?? 'Client Home'),
          const Divider(height: BauhausDesign.space4),
          _buildDetailRow(context, 'Status', 'Scheduled'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref,
      ClientAppointmentDetail appointment) {
    return Column(
      children: [
        BauhausActionButton(
          text: 'Request Change',
          icon: Icons.edit_calendar,
          variant: BauhausActionVariant.secondary,
          isFullWidth: true,
          onPressed: () =>
              _showRequestDialog(context, ref, 'change', appointment),
        ),
        const SizedBox(height: BauhausDesign.space3),
        BauhausActionButton(
          text: 'Report Issue',
          icon: Icons.report_problem,
          variant: BauhausActionVariant.ghost,
          textColor: BauhausDesign.error,
          isFullWidth: true,
          onPressed: () =>
              _showRequestDialog(context, ref, 'issue', appointment),
        ),
      ],
    );
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void _showRequestDialog(BuildContext context, WidgetRef ref, String type,
      ClientAppointmentDetail appointment) {
    final noteController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(type == 'change' ? 'Request Change' : 'Report Issue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(type == 'change'
                ? 'Describe the changes you need for this appointment.'
                : 'Describe the issue or concern regarding this appointment.'),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: 'Enter details...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
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
                        content: Text(
                            'Request submitted successfully. We will contact you shortly.')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
