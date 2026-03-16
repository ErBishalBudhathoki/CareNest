import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/training_compliance/providers/training_compliance_providers.dart';
import 'package:carenest/app/features/training_compliance/models/certification.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AdminCertificationAuditView extends ConsumerStatefulWidget {
  const AdminCertificationAuditView({super.key});

  @override
  ConsumerState<AdminCertificationAuditView> createState() =>
      _AdminCertificationAuditViewState();
}

class _AdminCertificationAuditViewState
    extends ConsumerState<AdminCertificationAuditView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load all pending certifications
      ref
          .read(certificationsViewModelProvider.notifier)
          .loadCertifications(status: 'pending_approval');
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(certificationsViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.certificationAuditTitle,
            style: BauhausDesign.getTextTheme(context).headlineLarge),
        backgroundColor: BauhausDesign.surfaceLight,
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 2),
        ),
      ),
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : state.certifications.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noCertificationsFound,
                    style: BauhausDesign.getTextTheme(context).bodyLarge,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  itemCount: state.certifications.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: BauhausDesign.space3),
                  itemBuilder: (context, index) {
                    final cert = state.certifications[index];
                    return _buildAuditCard(context, cert);
                  },
                ),
    );
  }

  Widget _buildAuditCard(BuildContext context, Certification cert) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BauhausDesign.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cert.name,
                  style: BauhausDesign.getTextTheme(context).headlineLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3,
                    vertical: BauhausDesign.space1),
                decoration: BoxDecoration(
                  color: BauhausDesign.warning,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                ),
                child: Text(
                  cert.status.toUpperCase(),
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text('User ID: ${cert.userId}',
              style: BauhausDesign.getTextTheme(context).bodyMedium),
          Text(AppLocalizations.of(context)!.issuerLabel(cert.issuer),
              style: BauhausDesign.getTextTheme(context).bodyMedium),
          Text(
              AppLocalizations.of(context)!.expiresLabel(
                  DateFormat('dd MMM yyyy').format(cert.expiryDate)),
              style: BauhausDesign.getTextTheme(context).bodyMedium),
          if (cert.certificationNumber != null &&
              cert.certificationNumber!.isNotEmpty)
            Text('Certification No: ${cert.certificationNumber}',
                style: BauhausDesign.getTextTheme(context).bodyMedium),
          if (cert.notes != null)
            Text(AppLocalizations.of(context)!.notesDetailLabel(cert.notes!),
                style: BauhausDesign.getTextTheme(context)
                    .bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic)),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                child: BauhausButton(
                  text: 'View File',
                  icon: Icons.visibility,
                  backgroundColor: BauhausDesign.secondary,
                  onPressed: () async {
                    final uri = Uri.parse(cert.fileUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Could not launch file URL')));
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: BauhausButton(
                  text: 'Reject',
                  backgroundColor: BauhausDesign.error,
                  onPressed: () => _showAuditDialog(context, cert, 'rejected'),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: BauhausButton(
                  text: 'Approve',
                  backgroundColor: BauhausDesign.success,
                  onPressed: () => _showAuditDialog(context, cert, 'active'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAuditDialog(
      BuildContext context, Certification cert, String status) {
    final actionLabel = status == 'active' ? 'Approve' : 'Reject';
    final notesController = TextEditingController();
    final numberController =
        TextEditingController(text: cert.certificationNumber ?? '');
    DateTime? expiryDate = cert.expiryDate;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            side: const BorderSide(color: BauhausDesign.neutral, width: 2)),
        title: Text('$actionLabel Certification',
            style: BauhausDesign.getTextTheme(context).headlineLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to mark this as $actionLabel?',
                style: BauhausDesign.getTextTheme(context).bodyMedium),
            const SizedBox(height: BauhausDesign.space3),
            TextFormField(
              controller: numberController,
              decoration: BauhausDesign.inputDecoration('').copyWith(
                  labelText: 'Certification / NDIS Check Number (Optional)'),
            ),
            const SizedBox(height: BauhausDesign.space3),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate:
                      expiryDate ?? DateTime.now().add(const Duration(days: 365)),
                  firstDate: DateTime.now().subtract(const Duration(days: 3650)),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                );
                if (date != null) {
                  setState(() => expiryDate = date);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.backgroundLight,
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      expiryDate == null
                          ? AppLocalizations.of(context)!.selectExpiryDate
                          : DateFormat('dd MMM yyyy').format(expiryDate!),
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: BauhausDesign.space3),
            TextFormField(
              controller: notesController,
              decoration: BauhausDesign.inputDecoration('')
                  .copyWith(labelText: 'Audit Notes (Optional)'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancelButton,
                style: BauhausDesign.getTextTheme(context)
                    .labelLarge
                    ?.copyWith(color: BauhausDesign.textDark)),
          ),
          BauhausButton(
            text: 'Confirm',
            backgroundColor: status == 'active'
                ? BauhausDesign.success
                : BauhausDesign.error,
            onPressed: () async {
              // We need to add auditCertification to viewmodel first
              final repo = ref.read(trainingComplianceRepositoryProvider);
              try {
                await repo.auditCertification(
                    cert.id!,
                    status,
                    notesController.text,
                    certificationNumber: numberController.text.trim().isEmpty
                        ? null
                        : numberController.text.trim(),
                    expiryDate: expiryDate,
                  );
                if (context.mounted) {
                  Navigator.pop(context);
                  // Refresh list
                  ref
                      .read(certificationsViewModelProvider.notifier)
                      .loadCertifications(status: 'pending_approval');
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
          ),
        ],
      ),
      ),
    );
  }
}
