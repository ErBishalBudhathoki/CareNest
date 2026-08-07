import 'dart:typed_data';

import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/services/invoice_share_service.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_detail_viewmodel.dart'
    as invoice_providers;
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/config/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../viewmodels/client_invoice_viewmodel.dart';
import '../models/client_portal_models.dart';
import 'package:intl/intl.dart';

class ClientInvoiceDetailView extends ConsumerWidget {
  final String invoiceId;

  const ClientInvoiceDetailView({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceState = ref.watch(clientInvoiceDetailProvider(invoiceId));
    final actionState = ref.watch(invoiceActionsViewModelProvider);

    ref.listen<AsyncValue<void>>(invoiceActionsViewModelProvider, (
      previous,
      next,
    ) {
      final prevLoading = previous?.isLoading ?? false;
      if (next.hasValue && !next.hasError && prevLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Action successful!'),
            backgroundColor: BauhausDesign.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
          ),
        );
        ref.invalidate(clientInvoiceDetailProvider(invoiceId));
        ref.invalidate(clientInvoicesProvider);
      }
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: BauhausDesign.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            ),
          ),
        );
      }
    });

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
          'INVOICE DETAIL',
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
      body: invoiceState.when(
        data: (invoice) =>
            _buildContent(context, ref, invoice, actionState.isLoading),
        loading: () => const Center(child: BauhausLoadingState()),
        error: (e, _) => Center(
          child: BauhausErrorState(
            title: 'Error Loading Invoice',
            message: e.toString(),
            onRetry: () =>
                ref.invalidate(clientInvoiceDetailProvider(invoiceId)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
    bool isLoading,
  ) {
    final status = invoice.workflow['status'] as String? ?? 'unknown';
    final isPending = status == 'pending_approval' || status == 'generated';
    final actionPanelReserve = isPending ? 220.0 : 0.0;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            BauhausDesign.space4,
            BauhausDesign.space4,
            BauhausDesign.space4,
            BauhausDesign.space4 + actionPanelReserve,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusHeader(context, invoice, status),
              const SizedBox(height: BauhausDesign.space4),
              _buildAmountCard(context, invoice),
              const SizedBox(height: BauhausDesign.space4),
              _buildInfoCard(context, invoice),
              const SizedBox(height: BauhausDesign.space4),
              _buildPdfActionsCard(context, ref, invoice),
              const SizedBox(height: BauhausDesign.space4),
              _buildReceiptsSection(context, ref, invoice),
              if ((invoice.lineItems ?? []).isNotEmpty) ...[
                const SizedBox(height: BauhausDesign.space6),
                _buildLineItemsSection(context, invoice),
              ],
            ],
          ),
        ),
        if (isPending)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildActionButtons(context, ref, invoice, isLoading),
          ),
      ],
    );
  }

  Widget _buildStatusHeader(
    BuildContext context,
    ClientInvoice invoice,
    String status,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
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
              _getStatusIcon(status),
              color: BauhausDesign.surfaceWhite,
              size: 28,
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.invoiceNumber,
                  style: GoogleFonts.oswald(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.surfaceWhite,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status.toUpperCase().replaceAll('_', ' '),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.surfaceWhite.withOpacity(0.9),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard(BuildContext context, ClientInvoice invoice) {
    final total = _toDouble(invoice.financialSummary['totalAmount']);
    final subtotal = _toDouble(invoice.financialSummary['subtotal']);
    final tax = _toDouble(
      invoice.financialSummary['tax'] ?? invoice.financialSummary['taxAmount'],
    );

    return BauhausCard(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: BauhausDesign.neutral,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(BauhausDesign.radiusMd),
                topRight: Radius.circular(BauhausDesign.radiusMd),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'TOTAL AMOUNT',
                  style: BauhausDesign.getTextTheme(context).labelSmall
                      ?.copyWith(
                        color: BauhausDesign.surfaceWhite.withOpacity(0.7),
                        letterSpacing: 1.5,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: GoogleFonts.oswald(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.surfaceWhite,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                _buildAmountRow(context, 'Subtotal', subtotal),
                const SizedBox(height: BauhausDesign.space2),
                _buildAmountRow(context, 'Tax', tax),
                const Divider(height: BauhausDesign.space4, thickness: 1),
                _buildAmountRow(context, 'Total', total, isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(
    BuildContext context,
    String label,
    double amount, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
            color: isBold ? BauhausDesign.textDark : BauhausDesign.textMuted,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, ClientInvoice invoice) {
    final dueDate = invoice.financialSummary['dueDate'];
    final createdAt = invoice.workflow['createdAt'];
    final description = invoice.workflow['description'] as String?;

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE DETAILS',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textMuted,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildInfoRow(
            context,
            Icons.calendar_today_outlined,
            'Due Date',
            _formatDate(dueDate),
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildInfoRow(
            context,
            Icons.schedule_outlined,
            'Created',
            _formatDate(createdAt),
          ),
          if (description != null && description.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space3),
            _buildInfoRow(
              context,
              Icons.description_outlined,
              'Description',
              description,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPdfActionsCard(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
  ) {
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE PDF',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textMuted,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: 'VIEW PDF',
                  icon: Icons.picture_as_pdf_outlined,
                  isFullWidth: true,
                  variant: BauhausActionVariant.primary,
                  onPressed: () => _viewInvoicePdf(context, ref, invoice),
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: BauhausActionButton(
                  text: 'DOWNLOAD PDF',
                  icon: Icons.download_outlined,
                  isFullWidth: true,
                  variant: BauhausActionVariant.neutral,
                  onPressed: () => _downloadInvoicePdf(context, ref, invoice),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptsSection(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
  ) {
    final receiptUrlsAsync = ref.watch(
      clientInvoiceReceiptUrlsProvider(invoice.id),
    );

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RECEIPTS',
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
              color: BauhausDesign.textMuted,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          receiptUrlsAsync.when(
            data: (urls) {
              if (urls.isEmpty) {
                return Text(
                  'No receipts attached to this invoice.',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                );
              }

              return Column(
                children: urls.asMap().entries.map((entry) {
                  final index = entry.key;
                  final url = entry.value;
                  final isLast = index == urls.length - 1;

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: isLast ? 0 : BauhausDesign.space2,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceWhite,
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(BauhausDesign.space2),
                            decoration: BoxDecoration(
                              color: BauhausDesign.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                BauhausDesign.radiusSm,
                              ),
                            ),
                            child: const Icon(
                              Icons.receipt_long,
                              color: BauhausDesign.primary,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: Text(
                              'Receipt ${index + 1}',
                              style: BauhausDesign.getTextTheme(context)
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          BauhausActionButton(
                            text: 'VIEW',
                            icon: Icons.open_in_new,
                            variant: BauhausActionVariant.neutral,
                            onPressed: () => _openReceiptInApp(context, url),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  'Loading receipts...',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                ),
              ],
            ),
            error: (_, _) => Text(
              'Unable to load receipts right now.',
              style: BauhausDesign.getTextTheme(
                context,
              ).bodyMedium?.copyWith(color: BauhausDesign.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: BauhausDesign.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(color: BauhausDesign.primary.withOpacity(0.3)),
          ),
          child: Icon(icon, color: BauhausDesign.primary, size: 18),
        ),
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

  Widget _buildLineItemsSection(BuildContext context, ClientInvoice invoice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: 'LINE ITEMS',
          subtitle: '${invoice.lineItems?.length ?? 0} items',
        ),
        const SizedBox(height: BauhausDesign.space3),
        ...(invoice.lineItems ?? []).asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == (invoice.lineItems?.length ?? 0) - 1;

          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : BauhausDesign.space2),
            child: _buildLineItemCard(context, item),
          );
        }),
      ],
    );
  }

  Widget _buildLineItemCard(BuildContext context, Map<String, dynamic> item) {
    final itemNumber =
        (item['supportItemNumber'] ??
                item['itemNumber'] ??
                item['ndisItemNumber'])
            ?.toString()
            .trim();
    final description =
        (item['description'] ??
                item['supportItemName'] ??
                item['itemName'] ??
                item['serviceName'] ??
                'Support Item')
            .toString()
            .trim();

    final quantity = _toDouble(item['quantity']);
    final hoursWorked = _toDouble(item['hoursWorked'] ?? item['hours']);
    final effectiveHours = hoursWorked > 0
        ? hoursWorked
        : (quantity > 0 ? quantity : 0);
    final unitPrice = _toDouble(
      item['unitPrice'] ?? item['price'] ?? item['rate'],
    );
    final total = _toDouble(
      item['total'] ??
          item['totalPrice'] ??
          item['amount'] ??
          (effectiveHours > 0 ? effectiveHours * unitPrice : 0),
    );
    final unit = (item['unit'] ?? 'hr').toString().trim();
    final subtitle = effectiveHours > 0
        ? '${effectiveHours.toStringAsFixed(effectiveHours % 1 == 0 ? 0 : 2)} $unit x \$${unitPrice.toStringAsFixed(2)}'
        : '\$${unitPrice.toStringAsFixed(2)} each';

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space1,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              border: Border.all(
                color: BauhausDesign.secondary.withOpacity(0.3),
              ),
            ),
            child: Center(
              child: Text(
                (itemNumber != null && itemNumber.isNotEmpty)
                    ? itemNumber
                    : (effectiveHours > 0
                          ? '${effectiveHours.toStringAsFixed(effectiveHours % 1 == 0 ? 0 : 2)}h'
                          : '-'),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: BauhausDesign.getTextTheme(context).labelMedium
                    ?.copyWith(
                      color: BauhausDesign.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).labelSmall?.copyWith(color: BauhausDesign.textMuted),
                ),
                if (effectiveHours > 0) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Hours Worked: ${effectiveHours.toStringAsFixed(effectiveHours % 1 == 0 ? 0 : 2)}',
                    style: BauhausDesign.getTextTheme(context).labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: GoogleFonts.oswald(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: BauhausDesign.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
    bool isLoading,
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
            if (isLoading)
              const Center(child: BauhausLoadingState())
            else ...[
              BauhausActionButton(
                text: 'APPROVE INVOICE',
                icon: Icons.check_circle_outline,
                isFullWidth: true,
                variant: BauhausActionVariant.success,
                onPressed: () {
                  ref
                      .read(invoiceActionsViewModelProvider.notifier)
                      .approve(invoice.id);
                },
              ),
              const SizedBox(height: BauhausDesign.space3),
              BauhausActionButton(
                text: 'DISPUTE INVOICE',
                icon: Icons.report_problem_outlined,
                isFullWidth: true,
                variant: BauhausActionVariant.error,
                onPressed: () => _showDisputeDialog(context, ref, invoice.id),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDisputeDialog(
    BuildContext context,
    WidgetRef ref,
    String invoiceId,
  ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          side: const BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        title: Text(
          'Dispute Invoice',
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please provide a reason for the dispute:',
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
            const SizedBox(height: BauhausDesign.space4),
            TextField(
              controller: controller,
              decoration: BauhausDesign.inputDecoration('Reason for dispute'),
              maxLines: 3,
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
              backgroundColor: BauhausDesign.error,
              foregroundColor: BauhausDesign.surfaceWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref
                    .read(invoiceActionsViewModelProvider.notifier)
                    .dispute(invoiceId, controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('SUBMIT DISPUTE'),
          ),
        ],
      ),
    );
  }

  Future<void> _viewInvoicePdf(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
  ) async {
    final pdfResult = await _prepareInvoicePdf(context, ref, invoice);
    if (pdfResult == null || pdfResult['pdfPath'] == null || !context.mounted) {
      return;
    }

    final receiptUrls = await ref.read(
      clientInvoiceReceiptUrlsProvider(invoice.id).future,
    );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewPage(
          pdfPath: pdfResult['pdfPath'],
          receiptUrls: receiptUrls,
        ),
      ),
    );
  }

  Future<void> _downloadInvoicePdf(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
  ) async {
    final pdfResult = await _prepareInvoicePdf(context, ref, invoice);
    if (pdfResult == null || pdfResult['pdfPath'] == null || !context.mounted) {
      return;
    }

    try {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        [XFile(pdfResult['pdfPath'].toString())],
        subject: 'Invoice ${invoice.invoiceNumber}',
        text: 'Invoice ${invoice.invoiceNumber} PDF',
        sharePositionOrigin: box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      );

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF ready. Choose Files/Downloads to save a copy.'),
          backgroundColor: BauhausDesign.success,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading PDF: $e'),
          backgroundColor: BauhausDesign.error,
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> _prepareInvoicePdf(
    BuildContext context,
    WidgetRef ref,
    ClientInvoice invoice,
  ) async {
    final organizationId = _resolveOrganizationId(ref);
    if (organizationId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Organization is missing. Please refresh or sign in again.',
          ),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return null;
    }

    final invoiceService = ref.read(
      invoice_providers.invoiceManagementServiceProvider,
    );
    final shareService = InvoiceShareService(
      invoiceService,
      apiMethod: ref.read(app_providers.apiMethodProvider),
    );

    final normalizedInvoice = _toInvoiceListModel(invoice, organizationId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preparing PDF for ${invoice.invoiceNumber}...'),
        backgroundColor: BauhausDesign.primary,
        duration: const Duration(seconds: 2),
      ),
    );

    try {
      final result = await shareService.generatePdfForViewing(
        normalizedInvoice,
        organizationId,
      );

      if (!context.mounted) return null;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (result['success'] != true || result['pdfPath'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Unable to load invoice PDF'),
            backgroundColor: BauhausDesign.error,
          ),
        );
        return null;
      }

      return result;
    } catch (e) {
      if (!context.mounted) return null;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error preparing invoice PDF: $e'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return null;
    }
  }

  String _resolveOrganizationId(WidgetRef ref) {
    final fromProvider = ref.read(app_providers.organizationIdProvider);
    if (fromProvider != null && fromProvider.trim().isNotEmpty) {
      return fromProvider.trim();
    }

    final prefs = ref.read(app_providers.sharedPreferencesProvider);
    final fromPrefs = prefs.getOrganizationId();
    if (fromPrefs != null && fromPrefs.trim().isNotEmpty) {
      return fromPrefs.trim();
    }

    return '';
  }

  InvoiceListModel _toInvoiceListModel(
    ClientInvoice invoice,
    String organizationId,
  ) {
    final createdAt = _parseDateTime(
      invoice.workflow['createdAt'] ?? invoice.workflow['updatedAt'],
    );
    final dueDate = _parseDateTime(invoice.financialSummary['dueDate']);

    return InvoiceListModel(
      id: invoice.id,
      invoiceNumber: invoice.invoiceNumber,
      organizationId: organizationId,
      clientName: 'Client',
      clientEmail: '',
      issueDate: createdAt,
      dueDate: dueDate,
      totalAmount: _toDouble(invoice.financialSummary['totalAmount']),
      taxAmount: _toDouble(
        invoice.financialSummary['taxAmount'] ??
            invoice.financialSummary['tax'],
      ),
      subtotalAmount: _toDouble(invoice.financialSummary['subtotal']),
      status: (invoice.workflow['status'] ?? 'generated').toString(),
      paymentStatus: (invoice.workflow['paymentStatus'] ?? 'pending')
          .toString(),
      deliveryStatus: (invoice.workflow['deliveryStatus'] ?? 'pending')
          .toString(),
      invoiceType: (invoice.workflow['invoiceType'] ?? 'standard').toString(),
      createdAt: createdAt,
      updatedAt: _parseDateTime(
        invoice.workflow['updatedAt'] ?? invoice.workflow['createdAt'],
      ),
    );
  }

  DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value == null) return DateTime.now();
    return DateTime.tryParse(value.toString()) ?? DateTime.now();
  }

  Future<void> _openReceiptInApp(BuildContext context, String url) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _SecureReceiptViewerPage(receiptUrl: url),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return BauhausDesign.success;
      case 'paid':
        return BauhausDesign.success;
      case 'overdue':
        return BauhausDesign.error;
      case 'disputed':
        return BauhausDesign.warning;
      case 'pending_approval':
      case 'generated':
        return BauhausDesign.secondary;
      default:
        return BauhausDesign.neutral;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle_outline;
      case 'paid':
        return Icons.paid_outlined;
      case 'overdue':
        return Icons.warning_amber_outlined;
      case 'disputed':
        return Icons.report_problem_outlined;
      case 'pending_approval':
      case 'generated':
        return Icons.pending_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';
    try {
      final DateTime parsedDate = DateTime.parse(date.toString());
      return DateFormat('MMMM d, yyyy').format(parsedDate);
    } catch (_) {
      return date.toString();
    }
  }

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '').trim()) ?? 0.0;
    }
    return 0.0;
  }
}

class _SecureReceiptViewerPage extends ConsumerStatefulWidget {
  final String receiptUrl;

  const _SecureReceiptViewerPage({required this.receiptUrl});

  @override
  ConsumerState<_SecureReceiptViewerPage> createState() =>
      _SecureReceiptViewerPageState();
}

class _SecureReceiptViewerPageState
    extends ConsumerState<_SecureReceiptViewerPage> {
  Uint8List? _fileBytes;
  bool _isLoading = true;
  String? _error;
  String _contentType = '';
  String _resolvedUrl = '';

  @override
  void initState() {
    super.initState();
    _loadReceipt();
  }

  Future<void> _loadReceipt() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final api = ref.read(app_providers.apiMethodProvider);
      _resolvedUrl = _normalizeReceiptUrl(widget.receiptUrl);
      final response = await api.getRawUrl(
        _resolvedUrl,
        timeout: const Duration(seconds: 20),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load receipt (HTTP ${response.statusCode})');
      }

      if (!mounted) return;
      setState(() {
        _fileBytes = response.bodyBytes;
        _contentType = response.headers['content-type'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _normalizeReceiptUrl(String rawUrl) {
    final clean = rawUrl.trim().replaceAll('`', '');
    if (clean.isEmpty) return clean;

    final uri = Uri.tryParse(clean);
    if (uri == null) return clean;

    final isPrivateR2ApiHost = AppConfig.isPrivateR2StorageHost(uri.host);
    final isFilesDownloadProxy = uri.path.contains('/files/download');

    if (isFilesDownloadProxy) return clean;
    if (isPrivateR2ApiHost || AppConfig.isPrivateR2StorageUrl(clean)) {
      return AppConfig.buildFilesProxyUrl(clean);
    }

    return clean;
  }

  bool get _isImage {
    if (_contentType.toLowerCase().startsWith('image/')) return true;
    final lower = _resolvedUrl.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.bmp');
  }

  @override
  Widget build(BuildContext context) {
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
          'RECEIPT',
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: BauhausLoadingState());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: BauhausErrorState(
            title: 'Unable To Load Receipt',
            message: _error!,
            onRetry: _loadReceipt,
          ),
        ),
      );
    }

    if (_fileBytes == null || _fileBytes!.isEmpty) {
      return const Center(
        child: BauhausEmptyState(
          title: 'Receipt Not Available',
          message: 'No receipt data was returned for this file.',
          icon: Icons.receipt_long_outlined,
        ),
      );
    }

    if (!_isImage) {
      return const Center(
        child: BauhausEmptyState(
          title: 'Preview Not Supported',
          message:
              'This receipt format cannot be previewed inline yet. Upload receipts as images for in-app preview.',
          icon: Icons.insert_drive_file_outlined,
        ),
      );
    }

    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 5.0,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: BauhausDesign.surfaceWhite,
        child: Image.memory(
          _fileBytes!,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => const Center(
            child: BauhausEmptyState(
              title: 'Preview Failed',
              message: 'Could not render this receipt image.',
              icon: Icons.broken_image_outlined,
            ),
          ),
        ),
      ),
    );
  }
}
