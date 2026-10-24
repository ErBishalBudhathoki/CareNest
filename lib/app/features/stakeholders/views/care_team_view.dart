import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/stakeholders/models/stakeholder_models.dart';
import 'package:carenest/app/features/stakeholders/viewmodels/stakeholder_viewmodel.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Client care team (Phase 5): plan manager, support coordinator, nominee and
/// family, with funding-type routing.
class CareTeamView extends ConsumerStatefulWidget {
  const CareTeamView({
    super.key,
    required this.clientId,
    required this.clientName,
  });

  final String clientId;
  final String clientName;

  @override
  ConsumerState<CareTeamView> createState() => _CareTeamViewState();
}

class _CareTeamViewState extends ConsumerState<CareTeamView> {
  static const _types = [
    'plan_manager',
    'support_coordinator',
    'nominee',
    'family',
    'other',
  ];

  static const _fundingTypes = [
    'ndia_managed',
    'plan_managed',
    'self_managed',
    'combination',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(careTeamViewModelProvider(widget.clientId).notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(careTeamViewModelProvider(widget.clientId));

    return Scaffold(
      appBar: AppBar(title: Text('Care team · ${widget.clientName}')),
      body: state.isLoading && state.careTeam == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref
                  .read(careTeamViewModelProvider(widget.clientId).notifier)
                  .load(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildFundingType(context, state),
                  const SizedBox(height: 16),
                  Text('Care network',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        state.error!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  if ((state.careTeam?.careTeam ?? []).isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'No stakeholders linked yet.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ...state.careTeam!.careTeam.map(_buildEntry),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add_alt_1),
        label: Text(AppLocalizations.of(context)!.add),
        onPressed: () => _showAddSheet(state),
      ),
    );
  }

  Widget _buildFundingType(BuildContext context, CareTeamState state) {
    final current = state.careTeam?.fundingType ?? 'plan_managed';
    return Card(
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet_outlined),
        title: Text(AppLocalizations.of(context)!.fundingType),
        subtitle: Text(current),
        trailing: DropdownButton<String>(
          value: _fundingTypes.contains(current) ? current : null,
          underline: const SizedBox.shrink(),
          items: _fundingTypes
              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              .toList(),
          onChanged: (value) async {
            if (value == null) return;
            // Funding type is applied when linking; update via a re-link of the
            // primary stakeholder is avoided — instead persist through a link
            // call on any existing entry, or defer until next link.
            final entries = state.careTeam?.careTeam ?? [];
            final notifier =
                ref.read(careTeamViewModelProvider(widget.clientId).notifier);
            if (entries.isNotEmpty) {
              await notifier.link(
                stakeholderId: entries.first.stakeholder.id,
                role: entries.first.linkRole,
                isPrimary: entries.first.isPrimary,
                fundingType: value,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.linkAStakeholderToSetFundingType),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildEntry(CareTeamEntry entry) {
    final s = entry.stakeholder;
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(_iconFor(s.type), color: theme.colorScheme.primary),
        title: Text(s.name),
        subtitle: Text(
          '${_labelFor(s.type)}'
          '${s.company.isNotEmpty ? ' · ${s.company}' : ''}'
          '${s.email.isNotEmpty ? '\n${s.email}' : ''}',
        ),
        isThreeLine: s.email.isNotEmpty,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (entry.isPrimary)
              Chip(
                label: Text(AppLocalizations.of(context)!.primary),
                backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                side: BorderSide(color: theme.colorScheme.primary),
              ),
            IconButton(
              tooltip: 'Unlink',
              icon: const Icon(Icons.link_off),
              onPressed: () => ref
                  .read(careTeamViewModelProvider(widget.clientId).notifier)
                  .unlink(s.id),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddSheet(CareTeamState state) async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.link),
              title: Text(AppLocalizations.of(context)!.linkExistingStakeholder),
              enabled: state.allStakeholders.isNotEmpty,
              onTap: () => Navigator.of(sheetContext).pop('link'),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: Text(AppLocalizations.of(context)!.createNewStakeholder),
              onTap: () => Navigator.of(sheetContext).pop('create'),
            ),
          ],
        ),
      ),
    );

    if (!mounted || action == null) return;
    if (action == 'link') {
      await _showLinkDialog(state);
    } else {
      await _showCreateDialog();
    }
  }

  Future<void> _showLinkDialog(CareTeamState state) async {
    final available = state.allStakeholders;
    if (available.isEmpty) return;
    String? stakeholderId = available.first.id;
    bool isPrimary = false;
    String? role = available.first.type;

    final linked = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.linkStakeholder),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: stakeholderId,
                decoration: const InputDecoration(labelText: 'Stakeholder'),
                items: available
                    .map((s) => DropdownMenuItem(
                          value: s.id,
                          child: Text('${s.name} (${_labelFor(s.type)})'),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => stakeholderId = v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: role,
                decoration: const InputDecoration(labelText: 'Role on plan'),
                items: _types
                    .map((t) => DropdownMenuItem(value: t, child: Text(_labelFor(t))))
                    .toList(),
                onChanged: (v) => setState(() => role = v),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: isPrimary,
                title: Text(AppLocalizations.of(context)!.primaryContact),
                onChanged: (v) => setState(() => isPrimary = v ?? false),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            FilledButton(
              onPressed: () async {
                final ok = await ref
                    .read(careTeamViewModelProvider(widget.clientId).notifier)
                    .link(
                      stakeholderId: stakeholderId!,
                      role: role,
                      isPrimary: isPrimary,
                    );
                if (dialogContext.mounted) Navigator.of(dialogContext).pop(ok);
              },
              child: Text(AppLocalizations.of(context)!.link),
            ),
          ],
        ),
      ),
    );

    if (linked == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.stakeholderLinked)),
      );
    }
  }

  Future<void> _showCreateDialog() async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final companyController = TextEditingController();
    String type = 'plan_manager';

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.newStakeholder),
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
                  initialValue: type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: _types
                      .map((t) => DropdownMenuItem(value: t, child: Text(_labelFor(t))))
                      .toList(),
                  onChanged: (v) => setState(() => type = v ?? 'other'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            FilledButton(
              onPressed: () async {
                final ok = await ref
                    .read(careTeamViewModelProvider(widget.clientId).notifier)
                    .createStakeholder({
                  'name': nameController.text.trim(),
                  'type': type,
                  'email': emailController.text.trim(),
                  'company': companyController.text.trim(),
                });
                if (dialogContext.mounted) Navigator.of(dialogContext).pop(ok);
              },
              child: Text(AppLocalizations.of(context)!.create),
            ),
          ],
        ),
      ),
    );

    if (created == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.stakeholderCreatedLinkToClient)),
      );
    }
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'plan_manager':
        return Icons.account_balance_outlined;
      case 'support_coordinator':
        return Icons.support_agent;
      case 'nominee':
        return Icons.gavel_outlined;
      case 'family':
        return Icons.family_restroom_outlined;
      default:
        return Icons.person_outline;
    }
  }

  String _labelFor(String type) {
    switch (type) {
      case 'plan_manager':
        return 'Plan manager';
      case 'support_coordinator':
        return 'Support coordinator';
      case 'nominee':
        return 'Nominee';
      case 'family':
        return 'Family';
      default:
        return 'Other';
    }
  }
}
