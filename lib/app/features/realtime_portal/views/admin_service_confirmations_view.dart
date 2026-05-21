import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/client_portal/models/client_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Provider to fetch completed service history (pings the actual endpoint)
final adminClientServiceHistoryProvider = FutureProvider.family.autoDispose<List<ServiceHistory>, String>((ref, clientId) async {
  final api = ref.read(apiMethodProvider);
  final response = await api.getServiceHistory(clientId: clientId);
  if (response['success'] == true && response['data'] is List) {
    final rawList = response['data'] as List;
    return rawList.map((item) => ServiceHistory.fromJson(item)).toList();
  }
  return [];
});

/// Provider to fetch detailed service confirmation on click
final serviceConfirmationDetailsProvider = FutureProvider.family.autoDispose<ServiceConfirmation?, String>((ref, appointmentId) async {
  final api = ref.read(apiMethodProvider);
  final response = await api.getServiceConfirmation(appointmentId: appointmentId);
  if (response['success'] == true && response['data'] != null) {
    return ServiceConfirmation.fromJson(response['data']);
  }
  return null;
});

class AdminServiceConfirmationsView extends ConsumerWidget {
  final String clientId;
  final String clientName;

  const AdminServiceConfirmationsView({
    super.key,
    required this.clientId,
    required this.clientName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(adminClientServiceHistoryProvider(clientId));

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Text(
          'Service Confirmation Ledger',
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
            onPressed: () => ref.invalidate(adminClientServiceHistoryProvider(clientId)),
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Ledger',
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
          // Context strip
          _buildClientContextStrip(context),

          Expanded(
            child: historyState.when(
              loading: () => const Center(child: BauhausLoadingState()),
              error: (error, _) => Center(
                child: BauhausErrorState(
                  title: 'Unable to Load Ledger',
                  message: error.toString(),
                  onRetry: () => ref.invalidate(adminClientServiceHistoryProvider(clientId)),
                ),
              ),
              data: (history) {
                if (history.isEmpty) {
                  return const Center(
                    child: BauhausEmptyState(
                      title: 'No Completed Shifts Yet',
                      message: 'Confirmations will appear here once the client submits feedback for a completed shift.',
                    ),
                  );
                }

                // Filter to only those with confirmations (or show all with status badges)
                return ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: history.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const BauhausSectionHeader(
                        title: 'COMPLETED SHIFTS & VERIFICATIONS',
                        subtitle: 'Tap any shift to inspect digital signatures, task checklists, and ratings.',
                      );
                    }

                    final service = history[index - 1];
                    return _AdminServiceHistoryCard(
                      service: service,
                      clientId: clientId,
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

  Widget _buildClientContextStrip(BuildContext context) {
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
            clientName,
            style: GoogleFonts.oswald(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: BauhausDesign.primary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Client ID: $clientId',
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
}

class _AdminServiceHistoryCard extends ConsumerWidget {
  final ServiceHistory service;
  final String clientId;

  const _AdminServiceHistoryCard({
    required this.service,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasVerification = service.rating > 0;

    return Container(
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  child: Text(
                    service.date,
                    style: GoogleFonts.shareTechMono(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: hasVerification
                        ? BauhausDesign.success.withOpacity(0.2)
                        : BauhausDesign.warning.withOpacity(0.2),
                    border: Border.all(
                      color: hasVerification ? BauhausDesign.success : BauhausDesign.warning,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
                  ),
                  child: Text(
                    hasVerification ? 'VERIFIED' : 'PENDING CLIENT',
                    style: BauhausDesign.neoMonoStyle(
                      context,
                      color: hasVerification ? BauhausDesign.success : BauhausDesign.warning,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              service.serviceName.toUpperCase(),
              style: GoogleFonts.oswald(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: BauhausDesign.textDark,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${service.startTime} - ${service.endTime} • Worker: ${service.workerName}',
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontSm,
                color: BauhausDesign.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasVerification) ...[
              const SizedBox(height: BauhausDesign.space3),
              Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < service.rating ? Icons.star : Icons.star_border,
                        size: 20,
                        color: BauhausDesign.accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  if (service.feedback != null && service.feedback!.isNotEmpty)
                    Expanded(
                      child: Text(
                        '"${service.feedback}"',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          fontStyle: FontStyle.italic,
                          color: BauhausDesign.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ],
            const SizedBox(height: BauhausDesign.space4),
            Row(
              children: [
                Expanded(
                  child: BauhausActionButton(
                    onPressed: () => _showConfirmationDetailsBottomSheet(context, ref),
                    text: hasVerification ? 'INSPECT VERIFICATION' : 'VIEW DETAILS',
                    icon: Icons.visibility,
                    variant: hasVerification ? BauhausActionVariant.primary : BauhausActionVariant.ghost,
                    isSmall: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDetailsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausDesign.surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(BauhausDesign.radiusLg)),
      ),
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final detailState = ref.watch(serviceConfirmationDetailsProvider(service.serviceId));

          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: detailState.when(
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
                      // Bottom sheet drag handle / header
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: BauhausDesign.space3),
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
                              icon: const Icon(Icons.close_rounded, color: BauhausDesign.neutral),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: BauhausDesign.neutral, height: 1.5, thickness: 1.5),

                      Padding(
                        padding: const EdgeInsets.all(BauhausDesign.space5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Summary Section
                            _buildSummaryItem('Worker', service.workerName),
                            _buildSummaryItem('Service', service.serviceName),
                            _buildSummaryItem('Date/Time', '${service.date} • ${service.startTime} - ${service.endTime}'),
                            const SizedBox(height: BauhausDesign.space4),

                            // Rating Section
                            Text(
                              'CLIENT RATING',
                              style: BauhausDesign.neoMonoStyle(context, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            Container(
                              padding: const EdgeInsets.all(BauhausDesign.space4),
                              decoration: BauhausDesign.cardDecoration,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        index < (confirmation.rating ?? 0) ? Icons.star : Icons.star_border,
                                        size: 28,
                                        color: BauhausDesign.accent,
                                      ),
                                    ),
                                  ),
                                  if (confirmation.feedback != null && confirmation.feedback!.isNotEmpty) ...[
                                    const SizedBox(height: BauhausDesign.space3),
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
                              style: BauhausDesign.neoMonoStyle(context, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            if (confirmation.checklist == null || confirmation.checklist!.isEmpty)
                              Text(
                                'No tasks configured for this shift.',
                                style: GoogleFonts.inter(color: BauhausDesign.textMuted),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  color: BauhausDesign.surfaceWhite,
                                  border: Border.all(color: BauhausDesign.neutral, width: 2),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: confirmation.checklist!.length,
                                  separatorBuilder: (_, __) => Divider(color: BauhausDesign.neutral, height: 1),
                                  itemBuilder: (context, idx) {
                                    final item = confirmation.checklist![idx];
                                    final completed = item.completed ?? false;
                                    return ListTile(
                                      leading: Icon(
                                        completed ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                                        color: completed ? BauhausDesign.success : BauhausDesign.textMuted,
                                      ),
                                      title: Text(
                                        item.item,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          decoration: completed ? TextDecoration.lineThrough : null,
                                          color: completed ? BauhausDesign.textMuted : BauhausDesign.textDark,
                                        ),
                                      ),
                                      trailing: item.required
                                          ? Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: BauhausDesign.primaryBlue.withOpacity(0.1),
                                                border: Border.all(color: BauhausDesign.primaryBlue, width: 1),
                                              ),
                                              child: Text(
                                                'REQ',
                                                style: GoogleFonts.shareTechMono(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                  color: BauhausDesign.primaryBlue,
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
                              style: BauhausDesign.neoMonoStyle(context, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            const SizedBox(height: BauhausDesign.space2),
                            Container(
                              padding: const EdgeInsets.all(BauhausDesign.space4),
                              decoration: BauhausDesign.cardDecoration,
                              width: double.infinity,
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.draw_rounded, size: 36, color: BauhausDesign.neutral),
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

                            // Incidents Section (if any reported)
                            if (confirmation.incidents != null && confirmation.incidents!.isNotEmpty) ...[
                              Text(
                                'SHIFTS ALERTS / INCIDENTS',
                                style: BauhausDesign.neoMonoStyle(context, fontWeight: FontWeight.bold, fontSize: 11, color: BauhausDesign.warning),
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              ...confirmation.incidents!.map((incident) => Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(BauhausDesign.space4),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.warning.withOpacity(0.1),
                                  border: Border.all(color: BauhausDesign.warning, width: 2),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.warning_amber_rounded, color: BauhausDesign.warning),
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
                              )),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom + BauhausDesign.space5),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.inter(fontSize: 14, color: BauhausDesign.textDark),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold, color: BauhausDesign.textMuted),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
