import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/app/shared/widgets/bauhaus_time_picker.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/features/sil/viewmodels/sil_viewmodels.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

/// SIL management hub (Phase 4): properties, quotes and rosters of care.
class SILDashboardView extends ConsumerStatefulWidget {
  const SILDashboardView({super.key});

  @override
  ConsumerState<SILDashboardView> createState() => _SILDashboardViewState();
}

class _SILDashboardViewState extends ConsumerState<SILDashboardView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  List<Patient> _clients = const [];
  bool _clientsLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(silPropertiesViewModelProvider.notifier).load();
      ref.read(silQuoteViewModelProvider.notifier).load();
      _loadClients();
    });
  }

  Future<void> _loadClients() async {
    setState(() => _clientsLoading = true);
    try {
      final api = ref.read(app_providers.apiMethodProvider);
      final clients = await api.fetchClientData();
      if (mounted) setState(() => _clients = clients);
    } catch (_) {
      // Client list is only needed for create dialogs; ignore failures.
    } finally {
      if (mounted) setState(() => _clientsLoading = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIL Management'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Properties'),
            Tab(text: 'Quotes'),
            Tab(text: 'Rosters of Care'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _PropertiesTab(clients: _clients),
          _QuotesTab(clients: _clients, clientsLoading: _clientsLoading),
          const _RostersOfCareTab(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Properties
// ---------------------------------------------------------------------------

class _PropertiesTab extends ConsumerWidget {
  const _PropertiesTab({required this.clients});
  final List<Patient> clients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(silPropertiesViewModelProvider);

    return Scaffold(
      body: state.isLoading && state.properties.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.properties.isEmpty
          ? const _EmptyState(
              icon: Icons.home_work_outlined,
              message: 'No SIL properties yet.',
            )
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(silPropertiesViewModelProvider.notifier).load(),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.properties.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final property = state.properties[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.home_work_outlined),
                      title: Text(property.name),
                      subtitle: Text(
                        '${property.propertyType} · ${property.rooms.length} rooms · '
                        '${property.active ? 'active' : 'inactive'}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).pushNamed(
                        Routes.silPropertyDetail,
                        arguments: {
                          'propertyId': property.id,
                          'propertyName': property.name,
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Property'),
        onPressed: () => _showCreatePropertyDialog(context, ref),
      ),
    );
  }

  Future<void> _showCreatePropertyDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final roomsController = TextEditingController(text: '1');
    String propertyType = 'house';
    String designCategory = 'basic';

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('New SIL property'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: propertyType,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: const ['house', 'townhouse', 'apartment', 'group_home', 'other']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => propertyType = v ?? 'house'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: designCategory,
                  decoration: const InputDecoration(labelText: 'SIL design category'),
                  items: const [
                    'basic',
                    'basic_vacancy',
                    'improved_liveability',
                    'robust',
                    'fully_accessible',
                    'high_physical_support',
                    'high_intensity_ventilation',
                    'custom',
                  ].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (v) => setState(() => designCategory = v ?? 'basic'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: roomsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Number of rooms'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final roomCount = int.tryParse(roomsController.text.trim()) ?? 1;
                final rooms = List.generate(
                  roomCount,
                  (i) => {'roomId': 'room-${i + 1}', 'label': 'Room ${i + 1}'},
                );
                final ok = await ref
                    .read(silPropertiesViewModelProvider.notifier)
                    .createProperty({
                  'name': nameController.text.trim(),
                  'propertyType': propertyType,
                  'silDesignCategory': designCategory,
                  'rooms': rooms,
                  'bedrooms': roomCount,
                  'maxOccupancy': roomCount,
                });
                if (dialogContext.mounted) Navigator.of(dialogContext).pop(ok);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );

    if (created != true && context.mounted) {
      final error = ref.read(silPropertiesViewModelProvider).error;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Quotes
// ---------------------------------------------------------------------------

class _QuotesTab extends ConsumerWidget {
  const _QuotesTab({required this.clients, required this.clientsLoading});
  final List<Patient> clients;
  final bool clientsLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(silQuoteViewModelProvider);

    return Scaffold(
      body: state.isLoading && state.quotes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.quotes.isEmpty
          ? const _EmptyState(
              icon: Icons.request_quote_outlined,
              message: 'No SIL quotes yet.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.quotes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final quote = state.quotes[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.request_quote_outlined),
                    title: Text('Quote ${quote.id.substring(0, quote.id.length.clamp(0, 8))}'),
                    subtitle: Text(
                      '${quote.status} · \$${quote.totals.weeklyAmount.toStringAsFixed(2)}/wk',
                    ),
                    trailing: _QuoteActions(quote: quote),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Quote'),
        onPressed: clientsLoading || clients.isEmpty
            ? null
            : () => _showCreateQuoteDialog(context, ref),
      ),
    );
  }

  Future<void> _showCreateQuoteDialog(BuildContext context, WidgetRef ref) async {
    String? clientId = clients.first.id;
    final supportController = TextEditingController();
    final hoursController = TextEditingController(text: '1');
    final priceController = TextEditingController();
    String fundingType = 'plan_managed';
    final selectedDays = <String>{};
    TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 15, minute: 0);

    String fmt(TimeOfDay t) =>
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('New SIL quote'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: clientId,
                  decoration: const InputDecoration(labelText: 'Client'),
                  items: clients
                      .where((c) => c.id != null)
                      .map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(
                              c.clientName ??
                                  '${c.clientFirstName ?? ''} ${c.clientLastName ?? ''}'.trim(),
                            ),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => clientId = v),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: fundingType,
                  decoration: const InputDecoration(labelText: 'Funding type'),
                  items: const ['ndia_managed', 'plan_managed', 'self_managed']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => fundingType = v ?? 'plan_managed'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: supportController,
                  decoration: const InputDecoration(
                    labelText: 'Support item number',
                    hintText: '01_011_0107_1_1',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: hoursController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Hours per week'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Unit price'),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Agreed weekly pattern',
                    style: Theme.of(dialogContext).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      .map(
                        (d) => FilterChip(
                          label: Text(d),
                          selected: selectedDays.contains(d),
                          onSelected: (on) => setState(
                            () => on ? selectedDays.add(d) : selectedDays.remove(d),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final t = await showBauhausTimePicker(
                            context: dialogContext,
                            initialTime: startTime,
                          );
                          if (t != null) setState(() => startTime = t);
                        },
                        child: Text('Start ${fmt(startTime)}'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final t = await showBauhausTimePicker(
                            context: dialogContext,
                            initialTime: endTime,
                          );
                          if (t != null) setState(() => endTime = t);
                        },
                        child: Text('End ${fmt(endTime)}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final quote = await ref.read(silQuoteViewModelProvider.notifier).create({
                  'clientId': clientId,
                  'fundingType': fundingType,
                  'lines': [
                    {
                      'supportNumber': supportController.text.trim(),
                      'hoursPerWeek':
                          double.tryParse(hoursController.text.trim()) ?? 0,
                      'unitPrice': double.tryParse(priceController.text.trim()) ?? 0,
                      'days': selectedDays.toList(),
                      'startTime': fmt(startTime),
                      'endTime': fmt(endTime),
                    },
                  ],
                });
                if (dialogContext.mounted) Navigator.of(dialogContext).pop(quote != null);
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );

    if (created != true && context.mounted) {
      final error = ref.read(silQuoteViewModelProvider).error;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }
}

class _QuoteActions extends ConsumerWidget {
  const _QuoteActions({required this.quote});
  final SILQuote quote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      onSelected: (action) async {
        final notifier = ref.read(silQuoteViewModelProvider.notifier);
        if (action == 'accept') {
          // A quote whose lines breach an NDIS price cap cannot be accepted
          // (server returns 409 PRICE_VALIDATION_FAILED). Report the outcome:
          // silently swallowing it left the officer with no feedback and no
          // way to tell an accepted quote from a rejected one.
          final ok = await notifier.accept(quote.id);
          if (context.mounted) {
            final error = ref.read(silQuoteViewModelProvider).error;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  ok
                      ? 'Quote accepted.'
                      : (error ?? 'Quote could not be accepted.'),
                ),
                backgroundColor:
                    ok ? null : Theme.of(context).colorScheme.error,
              ),
            );
          }
        } else if (action == 'convert') {
          final roc = await notifier.convert(quote.id);
          if (roc != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Converted to roster of care.')),
            );
          }
        }
      },
      itemBuilder: (context) => [
        if (quote.status == 'sent' || quote.status == 'draft')
          const PopupMenuItem(value: 'accept', child: Text('Accept')),
        if (quote.status == 'accepted')
          const PopupMenuItem(value: 'convert', child: Text('Convert to RoC')),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Rosters of care
// ---------------------------------------------------------------------------

class _RostersOfCareTab extends ConsumerStatefulWidget {
  const _RostersOfCareTab();

  @override
  ConsumerState<_RostersOfCareTab> createState() => _RostersOfCareTabState();
}

class _RostersOfCareTabState extends ConsumerState<_RostersOfCareTab> {
  List<SILRosterOfCare> _rosters = const [];
  bool _loading = true;
  bool _invoicing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(silRepositoryProvider);
      final rosters = await repo.getRostersOfCare();
      if (mounted) setState(() => _rosters = rosters);
    } catch (_) {
      if (mounted) setState(() => _rosters = const []);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  /// Materialise this RoC's agreed weekly pattern into that week's shifts, then
  /// open the roster builder for the property so staff can be assigned in one
  /// place (see docs/SIL_MANAGEMENT_SPEC.md §7).
  Future<void> _planAndStaff(SILRosterOfCare roc) async {
    final now = DateTime.now();
    final picked = await showBauhausDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked == null || !mounted) return;

    final monday = DateTime(picked.year, picked.month, picked.day)
        .subtract(Duration(days: (picked.weekday + 6) % 7));
    final weekIso = monday.toIso8601String().split('T').first;

    try {
      final repo = ref.read(silRepositoryProvider);
      final result = await repo.materializeRosterOfCareShifts(
        roc.id,
        weekStarting: weekIso,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Planned ${result.created} shift(s)'
            '${result.skipped > 0 ? ' · ${result.skipped} already existed' : ''}.',
          ),
        ),
      );
      final propertyId = roc.propertyId;
      if (propertyId != null && propertyId.isNotEmpty) {
        Navigator.of(context).pushNamed(
          Routes.silRoster,
          arguments: {
            'propertyId': propertyId,
            'propertyName': 'SIL property',
            'weekStarting': monday.toIso8601String(),
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_rosters.isEmpty) {
      return const _EmptyState(
        icon: Icons.assignment_outlined,
        message: 'No rosters of care yet.\nAccept a quote and convert it.',
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: _rosters.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final roc = _rosters[index];
              final billable =
                  roc.status == 'active' || roc.status == 'under_review';
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.assignment_outlined),
                  title: Text(
                    'RoC ${roc.id.substring(0, roc.id.length.clamp(0, 8))}',
                  ),
                  subtitle: Text(
                    '${roc.status} · ${roc.supports.length} supports · review ${roc.reviewSchedule.cadence}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.event_available_outlined),
                        tooltip: billable
                            ? 'Plan week & assign staff'
                            : 'Only an active roster of care can be planned',
                        onPressed: billable ? () => _planAndStaff(roc) : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.receipt_long_outlined),
                        tooltip: billable
                            ? 'Generate invoice'
                            : 'Only an active roster of care can be invoiced',
                        onPressed: billable && !_invoicing
                            ? () => _showInvoiceDialog(roc)
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (_invoicing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(minHeight: 2),
            ),
        ],
      ),
    );
  }

  /// Prompt for a billing period (defaulting to the current week) and bill the
  /// roster of care, then surface the resulting invoice. See
  /// docs/SIL_MANAGEMENT_SPEC.md section 7.
  Future<void> _showInvoiceDialog(SILRosterOfCare roc) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var range = DateTimeRange(
      start: today,
      end: today.add(const Duration(days: 6)),
    );
    DateTime? dueDate;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('Generate invoice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Billing period'),
                subtitle: Text(
                  '${_formatDate(range.start)} → ${_formatDate(range.end)}',
                ),
                trailing: const Icon(Icons.date_range_outlined),
                onTap: () async {
                  final picked = await showBauhausDateRangePicker(
                    context: dialogContext,
                    initialStart: range.start,
                    initialEnd: range.end,
                    firstDate: DateTime(now.year - 3),
                    lastDate: DateTime(now.year + 3),
                  );
                  if (picked != null) setState(() => range = picked);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Due date (optional)'),
                subtitle: Text(
                  dueDate == null
                      ? 'Default: 30 days after the period'
                      : _formatDate(dueDate!),
                ),
                trailing: const Icon(Icons.event_outlined),
                onTap: () async {
                  final picked = await showBauhausDatePicker(
                    context: dialogContext,
                    initialDate: dueDate ?? range.end,
                    firstDate: range.start,
                    lastDate: DateTime(now.year + 5),
                  );
                  if (picked != null) setState(() => dueDate = picked);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    setState(() => _invoicing = true);
    try {
      final invoice = await ref
          .read(silRepositoryProvider)
          .invoiceRosterOfCare(
            roc.id,
            from: _formatDate(range.start),
            to: _formatDate(range.end),
            dueDate: dueDate == null ? null : _formatDate(dueDate!),
          );
      if (!mounted) return;
      final route = invoice.billing;
      final routeLabel = route == null
          ? ''
          : route.isClaim
          ? ' · NDIA claim (CSV)'
          : ' · ${route.recipientType == 'plan_manager' ? 'plan manager' : 'participant'} PDF';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice ${invoice.invoiceNumber} created$routeLabel'),
          action: invoice.invoiceId.isEmpty
              ? null
              : SnackBarAction(
                  label: 'View',
                  onPressed: () => _openInvoice(invoice.invoiceId),
                ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate invoice: $e')),
      );
    } finally {
      if (mounted) setState(() => _invoicing = false);
    }
  }

  void _openInvoice(String invoiceId) {
    final organizationId =
        ref.read(app_providers.organizationIdProvider) ?? '';
    Navigator.of(context).pushNamed(
      Routes.invoiceDetails,
      arguments: {
        'invoiceId': invoiceId,
        'organizationId': organizationId,
      },
    );
  }

  String _formatDate(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }
}

// ---------------------------------------------------------------------------
// Shared
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
