import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_list_viewmodel.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/loading_indicator.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class InvoiceListView extends ConsumerStatefulWidget {
  final String organizationId;
  final String userEmail;

  const InvoiceListView({
    Key? key,
    required this.organizationId,
    required this.userEmail,
  }) : super(key: key);

  @override
  ConsumerState<InvoiceListView> createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends ConsumerState<InvoiceListView> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  String _statusFilter = 'all';

  @override
  void initState() {
    super.initState();
    // Load invoices when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(invoiceListViewModelProvider.notifier)
          .loadInvoices(widget.organizationId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceListState = ref.watch(invoiceListViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: const Text(
          'Invoices',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              ref
                  .read(invoiceListViewModelProvider.notifier)
                  .loadInvoices(widget.organizationId);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: _buildInvoiceList(invoiceListState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to invoice generation
          Navigator.pushNamed(
            context,
            '/enhancedInvoiceGeneration',
            arguments: {
              'userEmail': widget.userEmail,
              'organizationId': widget.organizationId,
            },
          );
        },
        backgroundColor: AppColors.colorPrimary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search invoices...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: AppColors.colorPrimary),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              _filterInvoices();
            },
          ),
          const SizedBox(height: 12),
          // Status filter
          Row(
            children: [
              const Text('Status: ',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              Expanded(
                child: DropdownButton<String>(
                  value: _statusFilter,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('All')),
                    DropdownMenuItem(value: 'draft', child: Text('Draft')),
                    DropdownMenuItem(value: 'sent', child: Text('Sent')),
                    DropdownMenuItem(value: 'paid', child: Text('Paid')),
                    DropdownMenuItem(value: 'overdue', child: Text('Overdue')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _statusFilter = value ?? 'all';
                    });
                    _filterInvoices();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(InvoiceListState state) {
    if (state.isLoading) {
      return const Center(child: LoadingIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading invoices',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(invoiceListViewModelProvider.notifier)
                    .loadInvoices(widget.organizationId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorPrimary,
              ),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    final filteredInvoices = _getFilteredInvoices(state.invoices);

    if (filteredInvoices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isNotEmpty || _statusFilter != 'all'
                  ? 'No invoices match your filters'
                  : 'No invoices found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty || _statusFilter != 'all'
                  ? 'Try adjusting your search or filters'
                  : 'Create your first invoice to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredInvoices.length,
      itemBuilder: (context, index) {
        final invoice = filteredInvoices[index];
        return _buildInvoiceCard(invoice);
      },
    );
  }

  Widget _buildInvoiceCard(InvoiceListModel invoice) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          _viewInvoiceDetails(invoice);
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildStatusChip(invoice.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                invoice.clientName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Due: ${DateFormat('MMM dd, yyyy').format(invoice.dueDate)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${invoice.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share, size: 20),
                        onPressed: () => _shareInvoice(invoice),
                        tooltip: 'Share',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete,
                            size: 20, color: Colors.red),
                        onPressed: () => _deleteInvoice(invoice),
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'paid':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        break;
      case 'sent':
        backgroundColor = Colors.blue.shade100;
        textColor = Colors.blue.shade800;
        break;
      case 'overdue':
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        break;
      case 'draft':
      default:
        backgroundColor = Colors.grey.shade100;
        textColor = Colors.grey.shade800;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  List<InvoiceListModel> _getFilteredInvoices(List<InvoiceListModel> invoices) {
    return invoices.where((invoice) {
      final matchesSearch = _searchQuery.isEmpty ||
          invoice.invoiceNumber
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          invoice.clientName.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus = _statusFilter == 'all' ||
          invoice.status.toLowerCase() == _statusFilter.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();
  }

  void _filterInvoices() {
    // Trigger rebuild to apply filters
    setState(() {});
  }

  void _viewInvoiceDetails(InvoiceListModel invoice) {
    // Navigate to invoice details view
    Navigator.pushNamed(
      context,
      Routes.invoiceDetails,
      arguments: {
        'invoiceId': invoice.id,
        'organizationId': widget.organizationId,
      },
    );
  }

  void _shareInvoice(InvoiceListModel invoice) {
    ref
        .read(invoiceListViewModelProvider.notifier)
        .shareInvoice(invoice.id, widget.organizationId);
  }

  void _deleteInvoice(InvoiceListModel invoice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Invoice'),
          content: Text(
            'Are you sure you want to delete invoice ${invoice.invoiceNumber}? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(invoiceListViewModelProvider.notifier)
                    .deleteInvoice(invoice.id, widget.organizationId);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
