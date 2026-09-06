import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/features/invoice/repositories/payment_repository.dart';
import 'package:carenest/app/features/invoice/viewmodels/payment_viewmodel.dart';
import 'package:carenest/app/features/invoice/models/invoice_model.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class RecurringPaymentService {
  const RecurringPaymentService();

  Future<String> createAgreement({
    required PaymentRepository repository,
    required String organizationId,
    required String invoiceId,
    required String frequency,
    required bool consentAccepted,
    String? consentIp,
    String? consentUserAgent,
  }) async {
    final result = await repository.createRecurringAgreement(
      organizationId: organizationId,
      invoiceId: invoiceId,
      frequency: frequency,
      consentAccepted: consentAccepted,
      consentIp: consentIp,
      consentUserAgent: consentUserAgent,
    );
    final url = result['setupSessionUrl'] as String?;
    if (url == null || url.isEmpty) {
      throw StateError('Recurring agreement setup URL is missing');
    }
    return url;
  }

  Future<void> cancelAgreement({
    required PaymentRepository repository,
    required String organizationId,
    required String agreementId,
    String? reason,
  }) async {
    await repository.cancelRecurringAgreement(
      organizationId: organizationId,
      agreementId: agreementId,
      reason: reason,
    );
  }
}

class RecurringConsentDialog extends ConsumerStatefulWidget {
  final InvoiceModel invoice;
  final String invoiceId;
  final String organizationId;

  const RecurringConsentDialog({
    super.key,
    required this.invoice,
    required this.invoiceId,
    required this.organizationId,
  });

  @override
  ConsumerState<RecurringConsentDialog> createState() =>
      _RecurringConsentDialogState();
}

class _RecurringConsentDialogState extends ConsumerState<RecurringConsentDialog> {
  String _frequency = 'monthly';
  bool _consentChecked = false;
  bool _loading = false;

  String _frequencyLabel(AppLocalizations l10n, String frequency) {
    switch (frequency) {
      case 'weekly':
        return l10n.recurringPaymentFrequencyWeekly;
      case 'fortnightly':
        return l10n.recurringPaymentFrequencyFortnightly;
      default:
        return l10n.recurringPaymentFrequencyMonthly;
    }
  }

  String _buildConsentText(AppLocalizations l10n) {
    final orgName = ref.read(organizationProvider).currentOrganization?.name ?? 'this organization';
    final invoiceNumber = widget.invoice.invoiceNumber;
    final amount = NumberFormat.simpleCurrency(
      locale: 'en_AU',
      name: 'AUD',
    ).format(widget.invoice.totalAmount);
    return l10n.recurringPaymentSubtitle(
      orgName,
      _frequencyLabel(l10n, _frequency),
      invoiceNumber,
      amount,
    );
  }

  Future<void> _handleAccept() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _loading = true);
    try {
      final service = RecurringPaymentService();
      final url = await service.createAgreement(
        repository: ref.read(paymentRepositoryProvider),
        organizationId: widget.organizationId,
        invoiceId: widget.invoiceId,
        frequency: _frequency,
        consentAccepted: true,
        consentUserAgent: 'CareNest/${Platform.operatingSystem}',
      );
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.recurringPaymentTitle),
          content: Text(l10n.recurringPaymentSetupReady),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.recurringPaymentCancelButton),
            ),
            TextButton(
              onPressed: () async {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Text(l10n.recurringPaymentSetupUrlHint(url)),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.recurringPaymentError)),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.recurringPaymentTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _buildConsentText(l10n),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _frequency,
            decoration: const InputDecoration(labelText: 'Frequency'),
            items: ['weekly', 'fortnightly', 'monthly']
                .map((f) => DropdownMenuItem(value: f, child: Text(_frequencyLabel(l10n, f))))
                .toList(),
            onChanged: (value) => setState(() => _frequency = value ?? 'monthly'),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _consentChecked,
            onChanged: (value) => setState(() => _consentChecked = value ?? false),
            title: Text(l10n.recurringPaymentConsentCheckbox),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _loading ? null : () => Navigator.pop(context),
          child: Text(l10n.recurringPaymentCancelButton),
        ),
        ElevatedButton(
          onPressed: (_loading || !_consentChecked) ? null : _handleAccept,
          style: ElevatedButton.styleFrom(
            backgroundColor: BauhausTheme.blue,
            foregroundColor: BauhausTheme.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: _loading
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: BauhausTheme.white))
              : Text(l10n.recurringPaymentAcceptButton),
        ),
      ],
    );
  }
}
