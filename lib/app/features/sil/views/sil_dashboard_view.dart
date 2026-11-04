import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:carenest/app/shared/widgets/bauhaus_time_picker.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/features/sil/viewmodels/sil_viewmodels.dart';
import 'package:carenest/app/features/sil/utils/roc_invoice_idempotency.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.silManagement,
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).colorScheme.onPrimary,
                unselectedLabelColor: Theme.of(
                  context,
                ).colorScheme.onPrimary.withValues(alpha: 0.65),
                indicatorColor: Theme.of(context).colorScheme.onPrimary,
                indicatorWeight: 4,
                labelStyle: BauhausDesign.getTextTheme(
                  context,
                ).labelLarge?.copyWith(fontWeight: FontWeight.w800),
                unselectedLabelStyle: BauhausDesign.getTextTheme(
                  context,
                ).labelLarge?.copyWith(fontWeight: FontWeight.w600),
                tabs: [
                  Tab(text: l10n.silTabProperties),
                  Tab(text: l10n.silTabQuotes),
                  Tab(text: l10n.silTabRostersOfCare),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _PropertiesTab(clients: _clients),
          _QuotesTab(clients: _clients, clientsLoading: _clientsLoading),
          _RostersOfCareTab(clients: _clients),
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: state.isLoading && state.properties.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.properties.isEmpty
          ? _EmptyState(
              icon: Icons.home_work_outlined,
              message: l10n.silNoProperties,
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
                        '${property.propertyType} · '
                        '${l10n.silRoomsCount(property.rooms.length)} · '
                        '${property.active ? l10n.silStatusActive : l10n.silStatusInactive}',
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
        label: Text(l10n.silPropertyFABLabel),
        onPressed: () => _showCreatePropertyDialog(context, ref),
      ),
    );
  }

  Future<void> _showCreatePropertyDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final roomsController = TextEditingController(text: '1');
    String propertyType = 'house';
    String designCategory = 'basic';

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: Text(l10n.silNewProperty),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: l10n.silPropertyName),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: propertyType,
                  decoration: InputDecoration(labelText: l10n.silPropertyType),
                  items: const ['house', 'townhouse', 'apartment', 'group_home', 'other']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => propertyType = v ?? 'house'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: designCategory,
                  decoration: InputDecoration(labelText: l10n.silDesignCategory),
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
                  decoration: InputDecoration(labelText: l10n.silNumberOfRooms),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancel),
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
              child: Text(l10n.silCreate),
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: state.isLoading && state.quotes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.quotes.isEmpty
          ? _EmptyState(
              icon: Icons.request_quote_outlined,
              message: l10n.silNoQuotes,
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
                    title: Text(
                      l10n.silQuoteTitle(
                        quote.id.substring(0, quote.id.length.clamp(0, 8)),
                      ),
                    ),
                    subtitle: Text(
                      '${quote.status} · '
                      '${l10n.silWeeklyShort(quote.totals.weeklyAmount.toStringAsFixed(2))}',
                    ),
                    trailing: _QuoteActions(quote: quote),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: Text(l10n.silQuoteFABLabel),
        onPressed: clientsLoading || clients.isEmpty
            ? null
            : () => _showCreateQuoteDialog(context, ref),
      ),
    );
  }

  Future<void> _showCreateQuoteDialog(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
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
          title: Text(l10n.silNewQuote),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: clientId,
                  decoration: InputDecoration(labelText: l10n.client),
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
                  decoration: InputDecoration(labelText: l10n.silFundingType),
                  items: const ['ndia_managed', 'plan_managed', 'self_managed']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => fundingType = v ?? 'plan_managed'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: supportController,
                  decoration: InputDecoration(
                    labelText: l10n.silSupportItemNumber,
                    // Example NDIS support-item number: a data value, not prose.
                    hintText: '01_011_0107_1_1',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: hoursController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: l10n.silHoursPerWeek),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: l10n.silUnitPrice),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.silWeeklyPattern,
                    style: Theme.of(dialogContext).textTheme.labelLarge,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  // Day abbreviations double as the API `days` values
                  // ('Mon'..'Sun'), so they stay untranslated.
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
                        child: Text(l10n.silStart(fmt(startTime))),
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
                        child: Text(l10n.silEnd(fmt(endTime))),
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
              child: Text(l10n.cancel),
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
              child: Text(l10n.silCreate),
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

  Future<void> _showAcceptanceDialog(
    BuildContext context,
    WidgetRef ref,
    SILQuote quote,
    AppLocalizations l10n,
  ) async {
    final nameCtrl = TextEditingController();
    final boardCtrl = TextEditingController();
    String selectedRole = 'participant';
    bool confirmed = false;

    final accepted = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.silQuoteAcceptAction),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.silSignIntro,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const ValueKey('sil_quote_signatory_name_field'),
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.silSignatoryName,
                    hintText: l10n.silSignatoryNameHint,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (_) => setDialogState(() {}),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  key: const ValueKey('sil_quote_signatory_role_dropdown'),
                  value: selectedRole,
                  decoration: InputDecoration(
                    labelText: l10n.silSignatoryRole,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: [
                    DropdownMenuItem(value: 'participant', child: Text(l10n.silRoleParticipant)),
                    DropdownMenuItem(value: 'guardian', child: Text(l10n.silRoleGuardian)),
                    DropdownMenuItem(value: 'plan_manager', child: Text(l10n.silRolePlanManager)),
                    DropdownMenuItem(value: 'provider', child: Text(l10n.silRoleProviderRep)),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedRole = val);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const ValueKey('sil_quote_board_lodging_field'),
                  controller: boardCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.silBoardLodgingLabel,
                    hintText: l10n.silBoardLodgingHint,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  key: const ValueKey('sil_quote_consent_checkbox'),
                  contentPadding: EdgeInsets.zero,
                  value: confirmed,
                  onChanged: (val) => setDialogState(() => confirmed = val ?? false),
                  title: Text(
                    l10n.silDigitalConsentConfirm,
                    style: const TextStyle(fontSize: 12),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              key: const ValueKey('sil_quote_sign_accept_button'),
              onPressed: (confirmed && nameCtrl.text.trim().isNotEmpty)
                  ? () => Navigator.of(ctx).pop(true)
                  : null,
              child: Text(l10n.silSignAndAccept),
            ),
          ],
        ),
      ),
    );

    if (accepted != true || !context.mounted) return;

    final notifier = ref.read(silQuoteViewModelProvider.notifier);
    final ok = await notifier.accept(
      quote.id,
      signedBy: nameCtrl.text.trim(),
      signatoryRole: selectedRole,
      signatureData: 'e-signed_${nameCtrl.text.trim()}_${DateTime.now().millisecondsSinceEpoch}',
      boardAndLodgingWeekly: double.tryParse(boardCtrl.text.trim()),
    );

    if (context.mounted) {
      final error = ref.read(silQuoteViewModelProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok
                ? l10n.silQuoteAcceptedServiceAgreement
                : (error ?? l10n.silQuoteNotAccepted),
          ),
          backgroundColor: ok ? null : Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<String>(
      onSelected: (action) async {
        final notifier = ref.read(silQuoteViewModelProvider.notifier);
        if (action == 'accept') {
          // Milestone 6.1: Show digital e-signature acceptance modal
          await _showAcceptanceDialog(context, ref, quote, l10n);
        } else if (action == 'convert') {
          final roc = await notifier.convert(quote.id);
          if (roc != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.silConvertedToRoC)),
            );
          }
        }
      },
      itemBuilder: (context) => [
        if (quote.status == 'sent' || quote.status == 'draft')
          PopupMenuItem(value: 'accept', child: Text(l10n.silQuoteAcceptAction)),
        if (quote.status == 'accepted')
          PopupMenuItem(value: 'convert', child: Text(l10n.silQuoteConvertAction)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Rosters of care
// ---------------------------------------------------------------------------

class _RostersOfCareTab extends ConsumerStatefulWidget {
  const _RostersOfCareTab({required this.clients});

  final List<Patient> clients;

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

  static String _shortId(String id) => id.length <= 8 ? id : id.substring(0, 8);

  /// Human label for the participant whose roster this is. Falls back to the
  /// roster id when the client list has not loaded or the client is unknown.
  String _clientLabel(SILRosterOfCare roc) {
    for (final client in widget.clients) {
      if (client.id != null && client.id == roc.clientId) {
        return client.displayName;
      }
    }
    return AppLocalizations.of(context)!.silRoCFallbackId(_shortId(roc.id));
  }

  /// Resolve the SIL property name for a roster, so the roster screen is titled
  /// with the real property instead of a placeholder.
  String _propertyName(String? propertyId) {
    final fallback = AppLocalizations.of(context)!.silPropertyFallback;
    if (propertyId == null || propertyId.isEmpty) return fallback;
    final properties = ref.read(silPropertiesViewModelProvider).properties;
    for (final property in properties) {
      if (property.id == propertyId) return property.name;
    }
    return fallback;
  }

  /// A roster can only be planned when at least one support carries an agreed
  /// weekly pattern (days + start/end time); otherwise materialising produces
  /// no shifts.
  bool _hasPattern(SILRosterOfCare roc) => roc.supports.any(
    (s) =>
        s.days.isNotEmpty && s.startTime.isNotEmpty && s.endTime.isNotEmpty,
  );

  /// Materialise this RoC's agreed weekly pattern into that week's shifts, then
  /// open the roster builder for the property so staff can be assigned in one
  /// place (see docs/SIL_MANAGEMENT_SPEC.md §7).
  Future<void> _planAndStaff(SILRosterOfCare roc) async {
    final l10n = AppLocalizations.of(context)!;
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
            '${l10n.silPlannedShiftsDone(result.created)}'
            '${result.skipped > 0 ? ' · ${l10n.silSkippedShifts(result.skipped)}' : ''}.',
          ),
        ),
      );
      final propertyId = roc.propertyId;
      if (propertyId == null || propertyId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.silRoCNoProperty)),
        );
        return;
      }
      Navigator.of(context).pushNamed(
        Routes.silRoster,
        arguments: {
          'propertyId': propertyId,
          'propertyName': _propertyName(propertyId),
          'weekStarting': monday.toIso8601String(),
          // Land straight on the assign list for the week just planned.
          'autoBuild': true,
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  /// Transition a draft RoC to active status. Enforces Milestone 4.2 Consent Gate:
  /// blocks with a consent dialog if no active signed Service Agreement exists.
  Future<void> _activateRosterOfCare(SILRosterOfCare roc) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final repo = ref.read(silRepositoryProvider);
      await repo.updateRosterOfCare(roc.id, {'status': 'active'});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.silRoCActivated)),
      );
      _load();
    } on SILConsentRequiredException catch (e) {
      if (!mounted) return;
      _showConsentRequiredDialog(roc, e.message);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  /// Displays the Milestone 4.2 Consent Gate dialog with participant details
  /// and allows entering an auditable justification note for Emergency Consent Bypass.
  Future<void> _showConsentRequiredDialog(
    SILRosterOfCare roc,
    String errorMessage,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _ConsentBypassDialog(
        errorMessage: errorMessage,
        onBypass: (reason) async {
          try {
            final repo = ref.read(silRepositoryProvider);
            await repo.updateRosterOfCare(roc.id, {
              'status': 'active',
              'bypassConsent': true,
              'bypassReason': reason,
            });
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.silBypassDone)),
            );
            _load();
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$e')),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_rosters.isEmpty) {
      return _EmptyState(
        icon: Icons.assignment_outlined,
        message: l10n.silNoRoCs,
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
              final plannable = billable && _hasPattern(roc);
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.assignment_outlined),
                  title: Text(_clientLabel(roc)),
                  subtitle: Text(
                    l10n.silRoCSubtitle(
                      _shortId(roc.id),
                      roc.status,
                      roc.supports.length,
                      roc.reviewSchedule.cadence,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Milestone 4.2 Consent Gate: Activate button for draft RoCs
                      if (roc.status == 'draft')
                        IconButton(
                          icon: const Icon(Icons.check_circle_outline, color: Colors.teal),
                          tooltip: l10n.silActivateRoCTooltip,
                          onPressed: () => _activateRosterOfCare(roc),
                        ),
                      IconButton(
                        icon: const Icon(Icons.event_available_outlined),
                        tooltip: plannable
                            ? l10n.silPlanWeekTooltip
                            : !billable
                            ? l10n.silPlanNotBillable
                            : l10n.silPlanNoPattern,
                        onPressed: plannable ? () => _planAndStaff(roc) : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.receipt_long_outlined),
                        tooltip: billable
                            ? l10n.silGenerateInvoiceTooltip
                            : l10n.silInvoiceNotBillable,
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
    final l10n = AppLocalizations.of(context)!;
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
          title: Text(l10n.silInvoiceDialogTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.silBillingPeriod),
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
                title: Text(l10n.silDueDateOptional),
                subtitle: Text(
                  dueDate == null
                      ? l10n.silDueDateDefault
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
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.generate),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true) return;

    setState(() => _invoicing = true);
    try {
      final idempotencyKey = buildRocInvoiceIdempotencyKey(
        rocId: roc.id,
        from: range.start,
        to: range.end,
      );
      final invoice = await ref
          .read(silRepositoryProvider)
          .invoiceRosterOfCare(
            roc.id,
            from: _formatDate(range.start),
            to: _formatDate(range.end),
            dueDate: dueDate == null ? null : _formatDate(dueDate!),
            idempotencyKey: idempotencyKey,
          );
      if (!mounted) return;
      await _showInvoiceReadyDialog(context, invoice);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.silInvoiceFailed(e.toString()))),
      );
    } finally {
      if (mounted) setState(() => _invoicing = false);
    }
  }

  /// Milestone 7.3: show the freshly generated invoice with View / Dispatch
  /// actions. The dispatch action emails the PDF to the recipient resolved on
  /// the participant's record.
  Future<void> _showInvoiceReadyDialog(
    BuildContext context,
    SILRosterOfCareInvoice invoice,
  ) async {
    final invoiceL10n = AppLocalizations.of(context)!;
    final route = invoice.billing;
    final routeLabel = route == null
        ? ''
        : route.isClaim
        ? invoiceL10n.silRouteNdiaClaim
        : route.recipientType == 'plan_manager'
        ? invoiceL10n.silRoutePlanManagerPdf
        : invoiceL10n.silRouteParticipantPdf;
    final replayNote =
        invoice.isIdempotentReplay == true ? ' · ${invoiceL10n.silReplayBadge}' : '';

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(invoiceL10n.silInvoiceReadyTitle),
        content: Text(
          '${invoiceL10n.silInvoiceCreated(invoice.invoiceNumber)}$routeLabel$replayNote',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(invoiceL10n.close),
          ),
          if (invoice.invoiceId.isNotEmpty) ...[
            OutlinedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _openInvoice(invoice.invoiceId);
              },
              child: Text(invoiceL10n.silViewAction),
            ),
            FilledButton(
              key: const ValueKey('sil_invoice_dispatch_button'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _dispatchInvoice(invoice);
              },
              child: Text(invoiceL10n.silDispatchAction),
            ),
          ],
        ],
      ),
    );
  }

  /// Milestone 7.3: dispatch the invoice to the resolved recipient (plan
  /// manager or participant) via the SIL dispatch endpoint.
  Future<void> _dispatchInvoice(SILRosterOfCareInvoice invoice) async {
    final dispatchL10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(dispatchL10n.silDispatchConfirmTitle(invoice.invoiceNumber)),
        content: Text(dispatchL10n.silDispatchConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(dispatchL10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(dispatchL10n.silDispatchSend),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final result = await ref
        .read(silRosterOfCareViewModelProvider.notifier)
        .dispatchInvoice(invoice.invoiceId, dispatchMethod: 'email');
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    if (result == null) {
      final error =
          ref.read(silRosterOfCareViewModelProvider).error ??
          dispatchL10n.silDispatchError;
      messenger.showSnackBar(
        SnackBar(content: Text(dispatchL10n.silDispatchFailed(error))),
      );
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(dispatchL10n.silDispatchSuccess(invoice.invoiceNumber)),
      ),
    );
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
// Milestone 4.2 Consent Gate Dialog
// ---------------------------------------------------------------------------

class _ConsentBypassDialog extends StatefulWidget {
  final String errorMessage;
  final ValueChanged<String> onBypass;

  const _ConsentBypassDialog({
    required this.errorMessage,
    required this.onBypass,
  });

  @override
  State<_ConsentBypassDialog> createState() => _ConsentBypassDialogState();
}

class _ConsentBypassDialogState extends State<_ConsentBypassDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.gavel_outlined, color: Colors.orange),
          const SizedBox(width: 8),
          Text(l10n.silConsentRequiredTitle),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.errorMessage),
          const SizedBox(height: 12),
          Text(
            l10n.silConsentRequiredSubtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            l10n.silEmergencyBypass,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: l10n.silBypassReasonHint,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade800,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            final reason = _controller.text.trim();
            if (reason.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.silBypassReasonHint)),
              );
              return;
            }
            Navigator.of(context).pop();
            widget.onBypass(reason);
          },
          child: Text(l10n.silEmergencyBypass),
        ),
      ],
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
