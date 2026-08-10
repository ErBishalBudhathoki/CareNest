import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../viewmodels/client_invoice_viewmodel.dart';
import '../models/client_portal_models.dart';
import 'client_invoice_detail_view.dart';
import 'package:intl/intl.dart';

class ClientInvoiceListView extends ConsumerStatefulWidget {
  final bool isFamilyViewer;

  const ClientInvoiceListView({super.key, this.isFamilyViewer = false});

  @override
  ConsumerState<ClientInvoiceListView> createState() =>
      _ClientInvoiceListViewState();
}

class _ClientInvoiceListViewState extends ConsumerState<ClientInvoiceListView> {
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _statusFilters = [
    {'value': 'all', 'label': 'All', 'icon': Icons.list},
    {'value': 'pending', 'label': 'Pending', 'icon': Icons.pending_outlined},
    {
      'value': 'approved',
      'label': 'Approved',
      'icon': Icons.check_circle_outline,
    },
    {'value': 'paid', 'label': 'Paid', 'icon': Icons.paid_outlined},
    {
      'value': 'overdue',
      'label': 'Overdue',
      'icon': Icons.warning_amber_outlined,
    },
    {
      'value': 'disputed',
      'label': 'Disputed',
      'icon': Icons.report_problem_outlined,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClientInvoice> _filterInvoices(List<ClientInvoice> invoices) {
    var filtered = invoices;

    if (_selectedFilter != 'all') {
      filtered = filtered.where((invoice) {
        final status = (invoice.workflow['status'] as String? ?? '')
            .toLowerCase();
        return status == _selectedFilter;
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((invoice) {
        final number = invoice.invoiceNumber.toLowerCase();
        final amount =
            invoice.financialSummary['totalAmount']?.toString() ?? '';
        return number.contains(_searchQuery.toLowerCase()) ||
            amount.contains(_searchQuery);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final invoicesState = ref.watch(clientInvoicesProvider);

    return Column(
      children: [
        _buildFilterBar(context),
        Expanded(
          child: invoicesState.when(
            data: (invoices) {
              final filteredInvoices = _filterInvoices(invoices);

              if (filteredInvoices.isEmpty) {
                return _buildEmptyState(context, invoices.isEmpty);
              }

              return _buildInvoiceList(context, filteredInvoices);
            },
            loading: () => const Center(child: BauhausLoadingState()),
            error: (e, _) => Center(
              child: BauhausErrorState(
                title: 'Error Loading Invoices',
                message: e.toString(),
                onRetry: () => ref.invalidate(clientInvoicesProvider),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          BauhausSearchBar(
            controller: _searchController,
            hintText: 'Search invoices...',
            onChanged: (value) {
              setState(() => _searchQuery = value);
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
              });
            },
          ),
          const SizedBox(height: BauhausDesign.space3),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _statusFilters.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: BauhausDesign.space2),
              itemBuilder: (context, index) {
                final filter = _statusFilters[index];
                final isSelected = _selectedFilter == filter['value'];

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedFilter = filter['value'] as String);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space3,
                      vertical: BauhausDesign.space2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? BauhausDesign.primary
                          : BauhausDesign.surfaceWhite,
                      borderRadius: BorderRadius.circular(
                        BauhausDesign.radiusSm,
                      ),
                      border: Border.all(
                        color: isSelected
                            ? BauhausDesign.primary
                            : BauhausDesign.neutral,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? const [BauhausDesign.shadowHardXs]
                          : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          filter['icon'] as IconData,
                          size: 16,
                          color: isSelected
                              ? BauhausDesign.surfaceWhite
                              : BauhausDesign.textMuted,
                        ),
                        const SizedBox(width: BauhausDesign.space1),
                        Text(
                          filter['label'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? BauhausDesign.surfaceWhite
                                : BauhausDesign.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isNoData) {
    return BauhausEmptyState(
      title: isNoData ? 'No Invoices Yet' : 'No Matching Invoices',
      message: isNoData
          ? 'Your invoices will appear here once generated.'
          : 'Try adjusting your search or filter criteria.',
      icon: Icons.receipt_long_outlined,
    );
  }

  Widget _buildInvoiceList(BuildContext context, List<ClientInvoice> invoices) {
    return RefreshIndicator(
      color: BauhausDesign.primary,
      backgroundColor: BauhausDesign.surfaceWhite,
      onRefresh: () async => ref.invalidate(clientInvoicesProvider),
      child: ListView.separated(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        itemCount: invoices.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: BauhausDesign.space3),
        itemBuilder: (context, index) {
          final invoice = invoices[index];
          return _InvoiceCard(invoice: invoice);
        },
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  final ClientInvoice invoice;

  const _InvoiceCard({required this.invoice});

  List<Color> _getStatusColors(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return [BauhausDesign.success, BauhausDesign.success];
      case 'paid':
        return [BauhausDesign.success, BauhausDesign.success];
      case 'overdue':
        return [BauhausDesign.error, BauhausDesign.error];
      case 'disputed':
        return [BauhausDesign.warning, BauhausDesign.warning];
      case 'pending_approval':
      case 'pending':
        return [BauhausDesign.secondary, BauhausDesign.secondary];
      default:
        return [BauhausDesign.neutral, BauhausDesign.neutral];
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
      case 'pending':
        return Icons.pending_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = invoice.workflow['status'] as String? ?? 'Unknown';
    final total = invoice.financialSummary['totalAmount'] ?? 0.0;
    final dueDate = invoice.financialSummary['dueDate'];
    final statusColors = _getStatusColors(status);
    final bgColor = statusColors[0];

    return BauhausCard(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ClientInvoiceDetailView(invoiceId: invoice.id),
          ),
        );
      },
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.receipt,
                        color: BauhausDesign.surfaceWhite,
                        size: 18,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Flexible(
                        child: Text(
                          invoice.invoiceNumber,
                          style: GoogleFonts.oswald(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.surfaceWhite,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space2,
                    vertical: BauhausDesign.space1,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(status),
                        color: BauhausDesign.surfaceWhite,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: BauhausDesign.surfaceWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AMOUNT DUE',
                          style: BauhausDesign.getTextTheme(context).labelSmall
                              ?.copyWith(color: BauhausDesign.textMuted),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: GoogleFonts.oswald(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.primary,
                          ),
                        ),
                      ],
                    ),
                    if (dueDate != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'DUE DATE',
                            style: BauhausDesign.getTextTheme(context)
                                .labelSmall
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(dueDate),
                            style: BauhausDesign.getTextTheme(
                              context,
                            ).bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3,
                    vertical: BauhausDesign.space2,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausDesign.backgroundLight,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(
                      color: BauhausDesign.neutral.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: BauhausDesign.textMuted,
                        size: 14,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        'Tap to view details',
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';
    try {
      final DateTime parsedDate = DateTime.parse(date.toString());
      return DateFormat('MMM d, yyyy').format(parsedDate);
    } catch (_) {
      return date.toString();
    }
  }
}
