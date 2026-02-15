import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../viewmodels/client_invoice_viewmodel.dart';
import '../models/client_portal_models.dart';

class ClientInvoiceDetailView extends ConsumerWidget {
  final String invoiceId;

  const ClientInvoiceDetailView({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceState = ref.watch(clientInvoiceDetailProvider(invoiceId));
    final actionState = ref.watch(invoiceActionsViewModelProvider);

    // Listen for action success
    ref.listen<AsyncValue<void>>(invoiceActionsViewModelProvider, (previous, next) {
      final prevLoading = previous?.isLoading ?? false;
      if (next.hasValue && !next.hasError && prevLoading) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Action successful!'), backgroundColor: BauhausDesign.success),
        );
        // Refresh detail
        ref.invalidate(clientInvoiceDetailProvider(invoiceId));
        // Refresh list
        ref.invalidate(clientInvoicesProvider);
      }
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString()), backgroundColor: BauhausDesign.error),
        );
      }
    });

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: Text('INVOICE DETAIL', style: BauhausDesign.getTextTheme(context).headlineMedium),
        backgroundColor: BauhausDesign.surfaceWhite,
        iconTheme: const IconThemeData(color: BauhausDesign.neutral),
      ),
      body: invoiceState.when(
        data: (invoice) => _buildContent(context, ref, invoice, actionState.isLoading),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, ClientInvoice invoice, bool isLoading) {
    final status = invoice.workflow['status'] as String? ?? 'unknown';
    final isPending = status == 'pending_approval' || status == 'generated'; // Check logic
    // Usually 'pending_approval' is the status waiting for client.

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BauhausDesign.cardDecoration,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL', style: BauhausDesign.getTextTheme(context).labelLarge),
                    Text(
                      '\$${invoice.financialSummary['totalAmount']}',
                      style: GoogleFonts.oswald(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: BauhausDesign.primary,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status', style: BauhausDesign.getTextTheme(context).bodyMedium),
                    Text(
                      status.toUpperCase(),
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),

          // Line Items
          Text('ITEMS', style: BauhausDesign.getTextTheme(context).headlineMedium),
          const SizedBox(height: BauhausDesign.space2),
          ...(invoice.lineItems ?? []).map((item) => Container(
            margin: const EdgeInsets.only(bottom: BauhausDesign.space2),
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['description'] ?? 'Item', style: BauhausDesign.getTextTheme(context).bodyLarge),
                      Text('${item['quantity']} x \$${item['unitPrice']}', style: BauhausDesign.getTextTheme(context).labelSmall),
                    ],
                  ),
                ),
                Text('\$${item['total']}', style: BauhausDesign.getTextTheme(context).labelLarge),
              ],
            ),
          )),

          const SizedBox(height: BauhausDesign.space8),

          // Actions
          if (isPending) ...[
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              BauhausButton(
                text: 'APPROVE INVOICE',
                isFullWidth: true,
                backgroundColor: BauhausDesign.success,
                onPressed: () {
                  ref.read(invoiceActionsViewModelProvider.notifier).approve(invoice.id);
                },
              ),
              const SizedBox(height: BauhausDesign.space4),
              BauhausButton(
                text: 'DISPUTE INVOICE',
                isFullWidth: true,
                backgroundColor: BauhausDesign.error,
                onPressed: () => _showDisputeDialog(context, ref, invoice.id),
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _showDisputeDialog(BuildContext context, WidgetRef ref, String invoiceId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Dispute Invoice', style: GoogleFonts.oswald(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Please provide a reason for the dispute:', style: GoogleFonts.inter()),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: BauhausDesign.inputDecoration('Reason'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: BauhausDesign.neutral)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: BauhausDesign.error),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(invoiceActionsViewModelProvider.notifier).dispute(invoiceId, controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('SUBMIT DISPUTE'),
          ),
        ],
      ),
    );
  }
}
