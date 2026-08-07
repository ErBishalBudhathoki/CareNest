import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_detail_viewmodel.dart';
import 'package:carenest/app/features/invoice/services/invoice_share_service.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:carenest/app/features/invoice/models/invoice_model.dart';
import 'package:carenest/app/features/invoice/views/widgets/payment_actions_widget.dart';
import 'package:intl/intl.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class InvoiceDetailView extends ConsumerStatefulWidget {
  final String invoiceId;
  final String organizationId;
  final Map<String, dynamic>? initialInvoiceData;

  const InvoiceDetailView({
    super.key,
    required this.invoiceId,
    required this.organizationId,
    this.initialInvoiceData,
  });

  @override
  ConsumerState<InvoiceDetailView> createState() => _InvoiceDetailViewState();
}

class _InvoiceDetailViewState extends ConsumerState<InvoiceDetailView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Load invoice details when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(invoiceDetailViewModelProvider.notifier);
      if (widget.initialInvoiceData != null) {
        try {
          final fallback = InvoiceListModel.fromJson(
            widget.initialInvoiceData!,
          );
          notifier.setInitialInvoice(fallback);
        } catch (_) {
          // Ignore malformed fallback snapshot and continue with backend fetch.
        }
      }
      notifier.loadInvoiceDetails(widget.invoiceId, widget.organizationId);
    });
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _startAnimations();
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(invoiceDetailViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      appBar: AppBar(
        title: Text(
          l10n.invoiceDetailsTitle,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: BauhausDesign.textDark,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        surfaceTintColor: Colors.transparent, // Disable surface tint
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        actions: [
          if (state.invoice != null) ...[
            BauhausIconButton(
              icon: Icons.share_outlined,
              onPressed: () => _shareInvoice(state.invoice!),
              variant: BauhausActionVariant.ghost,
            ),
            const SizedBox(width: 8),
            BauhausIconButton(
              icon: Icons.delete_outline,
              onPressed: () => _deleteInvoice(state.invoice!),
              variant: BauhausActionVariant.danger,
              isSmall: true,
            ),
            const SizedBox(width: 16),
          ],
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: _buildBody(state),
        ),
      ),
    );
  }

  Widget _buildBody(InvoiceDetailState state) {
    final l10n = AppLocalizations.of(context)!;
    if (state.isLoading && state.invoice == null) {
      return Center(
        child: BauhausLoadingState(message: l10n.loadingInvoiceDetails),
      );
    }

    if (state.error != null && state.invoice == null) {
      return BauhausErrorState(
        title: l10n.errorLoadingInvoice,
        description: state.error!,
        onRetry: () {
          ref
              .read(invoiceDetailViewModelProvider.notifier)
              .loadInvoiceDetails(widget.invoiceId, widget.organizationId);
        },
      );
    }

    if (state.invoice == null) {
      return BauhausEmptyState(
        title: l10n.invoiceNotFound,
        message: l10n.requestedInvoiceNotFound,
        icon: Icons.receipt_long_outlined,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.warning != null && state.warning!.trim().isNotEmpty) ...[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
              padding: const EdgeInsets.all(BauhausDesign.space3),
              decoration: BoxDecoration(
                color: BauhausDesign.warning.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.warning, width: 1.5),
              ),
              child: Text(
                state.warning!,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          _buildInvoiceHeader(state.invoice!),
          const SizedBox(height: BauhausDesign.space4),
          _buildClientInformation(state.invoice!),
          const SizedBox(height: BauhausDesign.space4),
          _buildInvoiceDetails(state.invoice!),
          const SizedBox(height: BauhausDesign.space4),
          _buildFinancialSummary(state.invoice!),
          const SizedBox(height: BauhausDesign.space4),
          _buildStatusInformation(state.invoice!),
          const SizedBox(height: BauhausDesign.space4),
          _buildPaymentActions(state.invoice!),
          const SizedBox(height: BauhausDesign.space4),
          _buildActionButtons(state.invoice!),
          // Add extra padding at bottom
          const SizedBox(height: BauhausDesign.space12),
        ],
      ),
    );
  }

  Widget _buildInvoiceHeader(InvoiceListModel invoice) {
    final l10n = AppLocalizations.of(context)!;
    return BauhausCard(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          color: BauhausDesign
              .primary, // Use solid color instead of gradient for Bauhaus style
          border: Border.all(color: BauhausDesign.neutral, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    invoice.invoiceNumber,
                    style: BauhausDesign.getTextTheme(context).headlineMedium
                        ?.copyWith(
                          color: BauhausDesign.surfaceWhite,
                          fontWeight: FontWeight.w800,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space2),
                _buildStatusChip(invoice.status),
              ],
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              l10n.totalAmountLabel,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                color: BauhausDesign.surfaceWhite.withOpacity(0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              l10n.priceDisplay(
                l10n.currencySymbol,
                invoice.totalAmount.toStringAsFixed(2),
              ),
              style: BauhausDesign.getTextTheme(context).displayMedium
                  ?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final l10n = AppLocalizations.of(context)!;
    BauhausChipVariant variant;
    String label;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'paid':
        variant = BauhausChipVariant.success;
        label = l10n.paid;
        icon = Icons.check_circle_outline;
        break;
      case 'pending':
        variant = BauhausChipVariant.warning;
        label = l10n.pending;
        icon = Icons.pending_outlined;
        break;
      case 'overdue':
        variant = BauhausChipVariant.error;
        label = l10n.overdue;
        icon = Icons.warning_amber_rounded;
        break;
      case 'sent':
        variant = BauhausChipVariant.secondary;
        label = l10n.sent;
        icon = Icons.send_outlined;
        break;
      default:
        variant = BauhausChipVariant.outlined;
        label = status.toUpperCase();
        icon = Icons.info_outline;
    }

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusPill),
        border: Border.all(color: BauhausDesign.neutral, width: 1.5),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: BauhausChip(label: label, variant: variant, icon: icon),
    );
  }

  Widget _buildClientInformation(InvoiceListModel invoice) {
    final l10n = AppLocalizations.of(context)!;
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: l10n.clientInformationTitle,
            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          ),
          _buildInfoRow(l10n.nameLabel, invoice.clientName),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(l10n.emailLabel, invoice.clientEmail),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails(InvoiceListModel invoice) {
    final l10n = AppLocalizations.of(context)!;
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: l10n.invoiceDetailsTitle,
            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          ),
          _buildInfoRow(l10n.invoiceNumberLabel, invoice.invoiceNumber),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(l10n.invoiceTypeLabel, invoice.invoiceType),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(
            l10n.issueDateLabel,
            DateFormat.yMMMd(l10n.localeName).format(invoice.issueDate),
          ),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(
            l10n.dueDateLabel,
            DateFormat.yMMMd(l10n.localeName).format(invoice.dueDate),
          ),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(
            l10n.createdLabel,
            DateFormat.yMMMd(
              l10n.localeName,
            ).add_jm().format(invoice.createdAt),
          ),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(
            l10n.lastUpdatedLabel,
            DateFormat.yMMMd(
              l10n.localeName,
            ).add_jm().format(invoice.updatedAt),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSummary(InvoiceListModel invoice) {
    final l10n = AppLocalizations.of(context)!;
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: l10n.financialSummaryTitle,
            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          ),
          _buildFinancialRow(l10n.subtotalLabel, invoice.subtotalAmount),
          _buildFinancialRow(l10n.taxAmountLabel, invoice.taxAmount),
          const Divider(height: 24, thickness: 1),
          _buildFinancialRow(
            l10n.totalAmountLabel,
            invoice.totalAmount,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInformation(InvoiceListModel invoice) {
    final l10n = AppLocalizations.of(context)!;
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: l10n.statusInformationTitle,
            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          ),
          _buildInfoRow(l10n.invoiceStatusLabel, invoice.status),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(l10n.paymentStatusLabel, invoice.paymentStatus),
          const Divider(color: BauhausDesign.neutral, thickness: 1),
          _buildInfoRow(l10n.deliveryStatusLabel, invoice.deliveryStatus),
          if (invoice.shareableLink != null) ...[
            const Divider(color: BauhausDesign.neutral, thickness: 1),
            _buildInfoRow(l10n.shareableLinkLabel, l10n.availableLabel),
          ],
          if (invoice.pdfPath != null) ...[
            const Divider(color: BauhausDesign.neutral, thickness: 1),
            _buildInfoRow(l10n.pdfDocumentLabel, l10n.availableLabel),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentActions(InvoiceListModel invoice) {
    // Map InvoiceListModel to InvoiceModel for the widget (or update widget to accept ListModel)
    // For now, we construct a temporary model or adapt the widget.
    // Adapting is cleaner, but let's wrap it here.
    final invoiceModel = InvoiceModel.empty().copyWith(
      invoiceNumber: invoice.invoiceNumber,
      totalAmount: invoice.totalAmount,
      payment: invoice.payment,
    );

    return BauhausCard(
      padding: EdgeInsets.zero, // Widget has its own padding/decoration
      child: PaymentActionsWidget(invoice: invoiceModel, invoiceId: invoice.id),
    );
  }

  Widget _buildActionButtons(InvoiceListModel invoice) {
    final l10n = AppLocalizations.of(context)!;
    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: l10n.actionsTitle,
            padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
          ),
          SizedBox(
            width: double.infinity,
            child: BauhausActionButton(
              onPressed: () => _viewInvoice(invoice),
              icon: Icons.visibility_outlined,
              text: l10n.viewInvoiceButton,
              isFullWidth: true,
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  onPressed: () => _shareInvoice(invoice),
                  icon: Icons.share_outlined,
                  text: l10n.share,
                  variant: BauhausActionVariant.secondary,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: BauhausActionButton(
                  onPressed: () => _deleteInvoice(invoice),
                  icon: Icons.delete_outline,
                  text: l10n.delete,
                  variant: BauhausActionVariant.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: BauhausDesign.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(
    String label,
    double amount, {
    bool isTotal = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? BauhausDesign.primary : BauhausDesign.textMuted,
            ),
          ),
          Text(
            l10n.priceDisplay(l10n.currencySymbol, amount.toStringAsFixed(2)),
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? BauhausDesign.primary : BauhausDesign.textDark,
            ),
          ),
        ],
      ),
    );
  }

  void _shareInvoice(InvoiceListModel invoice) async {
    final shareMethod = await InvoiceShareService.showShareOptionsDialog(
      context,
    );

    if (shareMethod != null) {
      final invoiceService = ref.read(invoiceManagementServiceProvider);
      final shareService = InvoiceShareService(
        invoiceService,
        apiMethod: ref.read(app_providers.apiMethodProvider),
      );

      final l10n = AppLocalizations.of(context)!;
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.sharingInvoiceMessage(invoice.invoiceNumber)),
          backgroundColor: BauhausDesign.primary,
          duration: const Duration(seconds: 2),
        ),
      );

      final result = await shareService.shareInvoice(
        invoice: invoice,
        organizationId: widget.organizationId,
        method: shareMethod,
      );

      // Show loading and show result
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? l10n.invoiceSharedSuccess),
          backgroundColor: result['success'] == true
              ? BauhausDesign.success
              : BauhausDesign.error,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _deleteInvoice(InvoiceListModel invoice) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(
            l10n.deleteInvoiceConfirmTitle,
            style: BauhausDesign.getTextTheme(context).titleLarge,
          ),
          content: Text(
            l10n.deleteInvoiceConfirmMessage(invoice.invoiceNumber),
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                l10n.cancel,
                style: BauhausDesign.getTextTheme(context).labelLarge,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: BauhausDesign.error),
              child: Text(
                l10n.delete,
                style: BauhausDesign.getTextTheme(
                  context,
                ).labelLarge?.copyWith(color: BauhausDesign.error),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.deletingInvoiceMessage),
          backgroundColor: BauhausDesign.error,
          duration: const Duration(seconds: 2),
        ),
      );

      try {
        await ref
            .read(invoiceDetailViewModelProvider.notifier)
            .deleteInvoice(invoice.id, widget.organizationId);

        // Hide loading and show success
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.invoiceDeletedSuccess),
            backgroundColor: BauhausDesign.success,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate back after successful deletion
        Navigator.of(context).pop();
      } catch (e) {
        // Hide loading and show error
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.invoiceDeleteError(e.toString())),
            backgroundColor: BauhausDesign.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _viewInvoice(InvoiceListModel invoice) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.loadingInvoiceMessage(invoice.invoiceNumber)),
          backgroundColor: BauhausDesign.primary,
          duration: const Duration(seconds: 2),
        ),
      );

      // Use the invoice share service to check for existing PDF or regenerate
      final invoiceService = ref.read(invoiceManagementServiceProvider);
      final shareService = InvoiceShareService(
        invoiceService,
        apiMethod: ref.read(app_providers.apiMethodProvider),
      );

      // Generate PDF for viewing (this now checks for existing files first)
      final result = await shareService.generatePdfForViewing(
        invoice,
        widget.organizationId,
      );

      // Hide loading
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (result['success'] == true && result['pdfPath'] != null) {
        // Show appropriate message based on whether PDF was found locally or regenerated
        final wasRegenerated = result['regenerated'] == true;
        if (wasRegenerated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pdfRegeneratedMessage(invoice.invoiceNumber)),
              backgroundColor: BauhausDesign.warning,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        debugPrint('🚀 InvoiceDetailView: Navigating to PDF Viewer');
        debugPrint(
          '🚀 InvoiceDetailView: Invoice has ${invoice.receiptUrls.length} receipt URLs',
        );
        debugPrint('🚀 InvoiceDetailView: URLs: ${invoice.receiptUrls}');

        // Navigate to PDF viewer
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewPage(
              pdfPath: result['pdfPath'],
              receiptUrls: invoice.receiptUrls,
            ),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? l10n.pdfLoadError),
            backgroundColor: BauhausDesign.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Hide loading and show error
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pdfViewError(e.toString())),
          backgroundColor: BauhausDesign.error,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
