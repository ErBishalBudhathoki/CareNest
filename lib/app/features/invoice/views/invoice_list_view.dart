import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/invoice_list_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_list_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:intl/intl.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class InvoiceListView extends ConsumerStatefulWidget {
  final String organizationId;
  final String userEmail;

  const InvoiceListView({
    super.key,
    required this.organizationId,
    required this.userEmail,
  });

  @override
  ConsumerState<InvoiceListView> createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends ConsumerState<InvoiceListView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInvoices();
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _loadInvoices();
    }
  }

  void _loadInvoices() {
    final invoiceType = _tabController.index == 0 ? 'client' : 'employee';
    ref.read(invoiceListViewModelProvider.notifier).loadInvoices(
          widget.organizationId,
          invoiceType: invoiceType,
        );
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceListState = ref.watch(invoiceListViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceWhite,
      appBar: AppBar(
        title: Text(
          l10n.allInvoices,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w800,
              ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceWhite,
        surfaceTintColor: Colors.transparent, // Disable surface tint
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: BauhausDesign.textDark,
                unselectedLabelColor: BauhausDesign.textMuted,
                indicatorColor: BauhausDesign.primary,
                indicatorWeight: 4,
                labelStyle:
                    BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                unselectedLabelStyle:
                    BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                tabs: const [
                  Tab(text: 'Client Invoices'),
                  Tab(text: 'Employee Invoices'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: BauhausDesign.textDark),
            onPressed: _loadInvoices,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(l10n),
          Expanded(
            child: _buildInvoiceList(invoiceListState, l10n),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: BauhausDesign.primary,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/enhancedInvoiceGeneration',
                arguments: {
                  'userEmail': widget.userEmail,
                  'organizationId': widget.organizationId,
                },
              );
            },
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            child: const Icon(Icons.add, color: BauhausDesign.surfaceWhite),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      color: BauhausDesign.surfaceWhite,
      child: Column(
        children: [
          BauhausSearchBar(
            controller: _searchController,
            hintText: l10n.searchInvoices,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
              _filterInvoices();
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
              });
              _filterInvoices();
            },
          ),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Text(
                l10n.statusLabel,
                style:
                    BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
              ),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceWhite,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(color: BauhausDesign.neutral, width: 2),
                    boxShadow: const [BauhausDesign.shadowHardSm],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _statusFilter,
                      isExpanded: true,
                      dropdownColor: BauhausDesign.surfaceWhite,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: BauhausDesign.textDark),
                      items: [
                        DropdownMenuItem(
                            value: 'all', child: Text(l10n.statusAll)),
                        DropdownMenuItem(
                            value: 'draft', child: Text(l10n.statusDraft)),
                        DropdownMenuItem(
                            value: 'sent', child: Text(l10n.statusSent)),
                        DropdownMenuItem(
                            value: 'paid', child: Text(l10n.statusPaid)),
                        DropdownMenuItem(
                            value: 'overdue', child: Text(l10n.statusOverdue)),
                      ],
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                      onChanged: (value) {
                        setState(() {
                          _statusFilter = value ?? 'all';
                        });
                        _filterInvoices();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(InvoiceListState state, AppLocalizations l10n) {
    if (state.isLoading) {
      return Center(
        child: BauhausLoadingState(
          message: l10n.loadingInvoices,
        ),
      );
    }

    if (state.error != null) {
      return BauhausErrorState(
        title: l10n.errorLoadingInvoices,
        message: state.error!,
        onRetry: () {
          ref
              .read(invoiceListViewModelProvider.notifier)
              .loadInvoices(widget.organizationId);
        },
      );
    }

    final filteredInvoices = _getFilteredInvoices(state.invoices);

    if (filteredInvoices.isEmpty) {
      return BauhausEmptyState(
        title: l10n.noInvoicesFound,
        message: l10n.createFirstInvoice,
        icon: Icons.receipt_long,
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: filteredInvoices.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: BauhausDesign.space3),
      itemBuilder: (context, index) {
        final invoice = filteredInvoices[index];
        return _buildInvoiceCard(invoice, l10n);
      },
    );
  }

  Widget _buildInvoiceCard(InvoiceListModel invoice, AppLocalizations l10n) {
    return BauhausCard(
      onTap: () => _viewInvoiceDetails(invoice),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  invoice.invoiceNumber,
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              _buildStatusChip(invoice.status, l10n),
            ],
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            invoice.clientName,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Text(
            '${l10n.dueLabel}: ${DateFormat.yMMMd(l10n.localeName).format(invoice.dueDate)}',
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.priceDisplay(l10n.currencySymbol,
                    invoice.totalAmount.toStringAsFixed(2)),
                style:
                    BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: BauhausDesign.primary,
                        ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (invoice.status.toLowerCase() != 'paid') ...[
                    BauhausActionButton(
                      onPressed: () => _markAsPaid(invoice),
                      icon: Icons.check_circle,
                      variant: BauhausActionVariant.ghost,
                      textColor: BauhausDesign.success,
                      isSmall: true,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                  ],
                  BauhausActionButton(
                    onPressed: () => _shareInvoice(invoice),
                    icon: Icons.share,
                    variant: BauhausActionVariant.ghost,
                    isSmall: true,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  BauhausActionButton(
                    onPressed: () => _deleteInvoice(invoice, l10n),
                    icon: Icons.delete_outline,
                    variant: BauhausActionVariant.ghost,
                    textColor: BauhausDesign.error,
                    isSmall: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _markAsPaid(InvoiceListModel invoice) {
    ref.read(invoiceListViewModelProvider.notifier).markAsPaid(
          invoice.id,
          widget.organizationId,
          invoice.totalAmount,
          updatedBy: widget.userEmail,
        );
  }

  Widget _buildStatusChip(String status, AppLocalizations l10n) {
    BauhausChipVariant variant;
    IconData icon;
    String label;

    switch (status.toLowerCase()) {
      case 'paid':
        variant = BauhausChipVariant.success;
        icon = Icons.check_circle_outline;
        label = l10n.statusPaid;
        break;
      case 'sent':
        variant = BauhausChipVariant.secondary;
        icon = Icons.send_outlined;
        label = l10n.statusSent;
        break;
      case 'overdue':
        variant = BauhausChipVariant.error;
        icon = Icons.warning_amber_rounded;
        label = l10n.statusOverdue;
        break;
      case 'draft':
      default:
        variant = BauhausChipVariant.neutral;
        icon = Icons.edit_note;
        label = l10n.statusDraft;
        break;
    }

    return BauhausChip(
      label: label,
      icon: icon,
      variant: variant,
      isSmall: true,
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
    setState(() {});
  }

  void _viewInvoiceDetails(InvoiceListModel invoice) {
    Navigator.pushNamed(
      context,
      Routes.invoiceDetails,
      arguments: {
        'invoiceId': invoice.id,
        'organizationId': widget.organizationId,
        'invoiceData': invoice.toJson(),
      },
    );
  }

  void _shareInvoice(InvoiceListModel invoice) {
    ref
        .read(invoiceListViewModelProvider.notifier)
        .shareInvoice(invoice.id, widget.organizationId);
  }

  void _deleteInvoice(InvoiceListModel invoice, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(
            l10n.deleteInvoice,
            style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          content: Text(
            l10n.deleteInvoiceConfirm(invoice.invoiceNumber),
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                l10n.cancel,
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(invoiceListViewModelProvider.notifier)
                    .deleteInvoice(invoice.id, widget.organizationId);
              },
              child: Text(
                l10n.delete,
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      color: BauhausDesign.error,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
