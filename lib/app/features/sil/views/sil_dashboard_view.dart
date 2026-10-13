import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/client/models/client_model.dart';
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
          await notifier.accept(quote.id);
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
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _rosters.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final roc = _rosters[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: Text('RoC ${roc.id.substring(0, roc.id.length.clamp(0, 8))}'),
              subtitle: Text(
                '${roc.status} · ${roc.supports.length} supports · review ${roc.reviewSchedule.cadence}',
              ),
            ),
          );
        },
      ),
    );
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
