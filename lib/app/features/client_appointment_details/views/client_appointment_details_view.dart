import 'package:carenest/app/core/enums/view_state.dart';
import 'package:carenest/app/features/client_appointment_details/providers.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/client_appointment_details/models/client_detail_model.dart';

class ClientAppointmentDetailsView extends ConsumerWidget {
  final String? clientId;
  final String? clientEmail;

  const ClientAppointmentDetailsView({
    super.key,
    this.clientId,
    this.clientEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = ClientAppointmentDetailsParams(
      clientId: clientId ?? '',
      clientEmail: clientEmail,
    );
    ref.watch(clientAppointmentDetailsViewModelProvider);
    final viewModel = ref.read(
      clientAppointmentDetailsViewModelProvider.notifier,
    );
    viewModel.initialize(params.clientId, params.clientEmail);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Client Details',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            color: BauhausDesign.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: BauhausDesign.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: viewModel.viewState == ViewState.busy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.viewState == ViewState.error
          ? Center(child: Text('Error: ${viewModel.errorMessage}'))
          : _buildContent(context, viewModel, ref),
    );
  }

  Widget _buildContent(BuildContext context, dynamic viewModel, WidgetRef ref) {
    final client = viewModel.client;
    if (client == null) return const Center(child: Text('Client not found'));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClientInfoCard(context, client),
          const SizedBox(height: BauhausDesign.space4),
          _buildCareNotesCard(context, viewModel),
          const SizedBox(height: BauhausDesign.space4),
          _buildEmergencyAndMedicalCard(context, client),
          const SizedBox(height: BauhausDesign.space4),
          _buildVisitHistoryCard(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildClientInfoCard(BuildContext context, ClientDetailModel client) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: BauhausDesign.primary.withValues(alpha: 0.1),
                radius: 24,
                child: Text(
                  client.clientFirstName[0],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.primary,
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.fullName,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    client.clientEmail,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 32),
          _buildInfoRow(context, Icons.phone, client.clientPhone ?? 'N/A'),
          const SizedBox(height: BauhausDesign.space2),
          _buildInfoRow(context, Icons.location_on, client.fullAddress),
          const SizedBox(height: BauhausDesign.space4),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (client.fullAddress.isNotEmpty) {
                  NavigationHelper.openDirectionsToAddress(client.fullAddress);
                }
              },
              icon: const Icon(Icons.directions),
              label: const Text('Get Directions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: BauhausDesign.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: BauhausDesign.textMuted),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildCareNotesCard(BuildContext context, dynamic viewModel) {
    final notesController = TextEditingController(
      text: viewModel.client?.careNotes,
    );

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Care Notes',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.primary,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          TextField(
            controller: notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add important notes here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              filled: true,
              fillColor: BauhausDesign.backgroundLight,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                viewModel.updateCareNotes(notesController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Care notes updated')),
                );
              },
              child: const Text('Save Notes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyAndMedicalCard(
    BuildContext context,
    ClientDetailModel client,
  ) {
    final emergencyContact = client.emergencyContact;
    final conditions = client.medicalConditions;

    if (emergencyContact == null &&
        (conditions == null || conditions.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health & Safety',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.warning,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          if (emergencyContact != null) ...[
            Text(
              'Emergency Contact',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textMuted,
              ),
            ),
            Text(
              '${emergencyContact['name'] ?? 'N/A'} (${emergencyContact['relationship'] ?? 'N/A'})',
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
            Text(
              emergencyContact['phone'] ?? 'N/A',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: BauhausDesign.primary),
            ),
            const SizedBox(height: BauhausDesign.space3),
          ],
          if (conditions != null && conditions.isNotEmpty) ...[
            Text(
              'Medical Conditions',
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textMuted,
              ),
            ),
            Wrap(
              spacing: 8,
              children: conditions
                  .map(
                    (c) => Chip(
                      label: Text(c),
                      backgroundColor: BauhausDesign.warning.withValues(alpha: 0.1),
                      labelStyle: TextStyle(color: BauhausDesign.warning),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVisitHistoryCard(BuildContext context, dynamic viewModel) {
    final visits = viewModel.visitHistory;

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visit History',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausDesign.primary,
            ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          if (visits.isEmpty)
            const Text('No past visits recorded.')
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: visits.length > 3 ? 3 : visits.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final visit = visits[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.history, size: 20),
                  title: Text(visit.shiftDate),
                  subtitle: Text(
                    '${visit.shiftStartTime} - ${visit.shiftEndTime}',
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
