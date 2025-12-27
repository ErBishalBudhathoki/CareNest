import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_detail_viewmodel.dart';
import 'package:carenest/app/features/invoice/services/invoice_share_service.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/loading_indicator.dart';
import 'package:carenest/app/shared/utils/pdf/pdf_viewer.dart';
import 'package:intl/intl.dart';

class InvoiceDetailView extends ConsumerStatefulWidget {
  final String invoiceId;
  final String organizationId;

  const InvoiceDetailView({
    super.key,
    required this.invoiceId,
    required this.organizationId,
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
      ref
          .read(invoiceDetailViewModelProvider.notifier)
          .loadInvoiceDetails(widget.invoiceId, widget.organizationId);
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
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

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
    final state = ref.watch(invoiceDetailViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: const Text(
          'Invoice Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (state.invoice != null) ...[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () => _shareInvoice(state.invoice!),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'delete':
                    _deleteInvoice(state.invoice!);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete Invoice'),
                    ],
                  ),
                ),
              ],
            ),
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
    if (state.isLoading) {
      return const Center(
        child: LoadingIndicator(
          message: 'Loading invoice details...',
        ),
      );
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading invoice',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(invoiceDetailViewModelProvider.notifier)
                    .loadInvoiceDetails(
                        widget.invoiceId, widget.organizationId);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.invoice == null) {
      return const Center(
        child: Text('Invoice not found'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvoiceHeader(state.invoice!),
          const SizedBox(height: 24),
          _buildClientInformation(state.invoice!),
          const SizedBox(height: 24),
          _buildInvoiceDetails(state.invoice!),
          const SizedBox(height: 24),
          _buildFinancialSummary(state.invoice!),
          const SizedBox(height: 24),
          _buildStatusInformation(state.invoice!),
          const SizedBox(height: 24),
          _buildActionButtons(state.invoice!),
        ],
      ),
    );
  }

  Widget _buildInvoiceHeader(InvoiceListModel invoice) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppColors.colorPrimary,
              AppColors.colorPrimary.withValues(alpha: 0.8)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _buildStatusChip(invoice.status),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Total Amount',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            Text(
              '\$${invoice.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'paid':
        chipColor = Colors.green;
        break;
      case 'pending':
        chipColor = Colors.orange;
        break;
      case 'overdue':
        chipColor = Colors.red;
        break;
      case 'sent':
        chipColor = Colors.blue;
        break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildClientInformation(InvoiceListModel invoice) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: AppColors.colorPrimary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Client Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Name', invoice.clientName),
            _buildInfoRow('Email', invoice.clientEmail),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceDetails(InvoiceListModel invoice) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: AppColors.colorPrimary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Invoice Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Invoice Number', invoice.invoiceNumber),
            _buildInfoRow('Invoice Type', invoice.invoiceType),
            _buildInfoRow('Issue Date',
                DateFormat('MMM dd, yyyy').format(invoice.issueDate)),
            _buildInfoRow(
                'Due Date', DateFormat('MMM dd, yyyy').format(invoice.dueDate)),
            _buildInfoRow('Created',
                DateFormat('MMM dd, yyyy HH:mm').format(invoice.createdAt)),
            _buildInfoRow('Last Updated',
                DateFormat('MMM dd, yyyy HH:mm').format(invoice.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummary(InvoiceListModel invoice) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: AppColors.colorPrimary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Financial Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFinancialRow('Subtotal', invoice.subtotalAmount),
            _buildFinancialRow('Tax Amount', invoice.taxAmount),
            const Divider(),
            _buildFinancialRow('Total Amount', invoice.totalAmount,
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusInformation(InvoiceListModel invoice) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: AppColors.colorPrimary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Status Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Invoice Status', invoice.status),
            _buildInfoRow('Payment Status', invoice.paymentStatus),
            _buildInfoRow('Delivery Status', invoice.deliveryStatus),
            if (invoice.shareableLink != null)
              _buildInfoRow('Shareable Link', 'Available'),
            if (invoice.pdfPath != null)
              _buildInfoRow('PDF Document', 'Available'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(InvoiceListModel invoice) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.colorPrimary,
              ),
            ),
            const SizedBox(height: 16),
            // View Invoice Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _viewInvoice(invoice),
                icon: const Icon(Icons.visibility),
                label: const Text('View Invoice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _shareInvoice(invoice),
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _deleteInvoice(invoice),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(String label, double amount,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? AppColors.colorPrimary : Colors.grey,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? AppColors.colorPrimary : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _shareInvoice(InvoiceListModel invoice) async {
    final shareMethod =
        await InvoiceShareService.showShareOptionsDialog(context);

    if (shareMethod != null) {
      final invoiceService = ref.read(invoiceManagementServiceProvider);
      final shareService = InvoiceShareService(invoiceService);

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sharing invoice ${invoice.invoiceNumber}...'),
          backgroundColor: AppColors.colorPrimary,
          duration: const Duration(seconds: 2),
        ),
      );

      final result = await shareService.shareInvoice(
        invoice: invoice,
        organizationId: widget.organizationId,
        method: ShareMethod.pdf,
      );

      // Hide loading and show result
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Invoice shared'),
          backgroundColor:
              result['success'] == true ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _deleteInvoice(InvoiceListModel invoice) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Invoice'),
          content: Text(
            'Are you sure you want to delete invoice ${invoice.invoiceNumber}? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deleting invoice ${invoice.invoiceNumber}...'),
          backgroundColor: Colors.red,
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
          const SnackBar(
            content: Text('Invoice deleted successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate back after successful deletion
        Navigator.of(context).pop();
      } catch (e) {
        // Hide loading and show error
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete invoice: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _viewInvoice(InvoiceListModel invoice) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Loading invoice ${invoice.invoiceNumber}...'),
          backgroundColor: AppColors.colorPrimary,
          duration: const Duration(seconds: 2),
        ),
      );

      // Use the invoice share service to check for existing PDF or regenerate
      final invoiceService = ref.read(invoiceManagementServiceProvider);
      final shareService = InvoiceShareService(invoiceService);

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
              content:
                  Text('PDF regenerated for invoice ${invoice.invoiceNumber}'),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        // Navigate to PDF viewer
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewPage(
              pdfPath: result['pdfPath'],
            ),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Failed to load invoice PDF'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Hide loading and show error
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error viewing invoice: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
