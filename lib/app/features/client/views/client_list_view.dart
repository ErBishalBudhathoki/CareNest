import 'dart:io';

import 'package:carenest/app/core/providers/app_providers.dart'
    hide apiMethodProvider;
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/client/providers/client_provider.dart';
import 'package:carenest/app/features/invoice/widgets/bauhaus_date_range_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:carenest/app/features/realtime_portal/views/family_management_view.dart';
import 'package:carenest/app/features/stakeholders/views/care_team_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/business_name_dropdown_widget.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _ClientDeleteMode { cancel, soft, force }

/// Controllers for one editable NDIS category envelope in the plan dialog.
class _PlanCategoryDraft {
  final TextEditingController number;
  final TextEditingController name;
  final TextEditingController budget;

  _PlanCategoryDraft({String number = '', String name = '', String budget = ''})
    : number = TextEditingController(text: number),
      name = TextEditingController(text: name),
      budget = TextEditingController(text: budget);

  Map<String, dynamic> toJson() => {
    'categoryNumber': number.text.trim(),
    'name': name.text.trim(),
    'budget': double.tryParse(budget.text.trim()) ?? 0,
  };

  void dispose() {
    number.dispose();
    name.dispose();
    budget.dispose();
  }
}

enum _ClientListMode { active, history }

class ClientListView extends ConsumerStatefulWidget {
  const ClientListView({super.key});

  @override
  ConsumerState<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends ConsumerState<ClientListView> {
  final Set<String> _activatingClientKeys = <String>{};
  final Set<String> _adminActivatingClientKeys = <String>{};
  _ClientListMode _selectedListMode = _ClientListMode.active;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadClients();
    });
  }

  Future<void> _loadClients({_ClientListMode? mode}) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.init();

    final providerOrganizationId = ref.read(organizationIdProvider);
    final storedOrganizationId = prefs.getOrganizationId();
    final organizationId = (providerOrganizationId ?? storedOrganizationId)
        ?.trim();

    if (organizationId != null && organizationId.isNotEmpty) {
      final targetMode = mode ?? _selectedListMode;
      if (targetMode == _ClientListMode.history) {
        await ref
            .read(clientProvider.notifier)
            .fetchDeletedClientsByOrganization(organizationId);
      } else {
        await ref
            .read(clientProvider.notifier)
            .fetchClientsByOrganization(organizationId);
      }
    }
  }

  Future<void> _switchListMode(_ClientListMode mode) async {
    if (_selectedListMode == mode) return;
    setState(() => _selectedListMode = mode);
    await _loadClients(mode: mode);
  }

  Future<Map<String, String>?> _getRequiredUserContext() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.init();

    final userEmail = await prefs.getUserEmailFromSharedPreferences();
    final organizationId = prefs.getOrganizationId();

    if (userEmail == null ||
        userEmail.isEmpty ||
        organizationId == null ||
        organizationId.isEmpty) {
      if (!mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.sessionDataMissing),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return null;
    }

    return {'userEmail': userEmail, 'organizationId': organizationId};
  }

  /// Dispose dialog controllers only after the route's exit animation. A
  /// TextField still depends on its controller while the dialog is animating
  /// out; disposing immediately triggers Flutter's `_dependents.isEmpty`
  /// assertion.
  void _disposeAfterDialog(List<VoidCallback> disposers) {
    Future<void>.delayed(const Duration(milliseconds: 500), () {
      for (final dispose in disposers) {
        dispose();
      }
    });
  }

  double _dialogWidth(
    BuildContext context, {
    double maxWidth = 760,
    double horizontalMargin = 24,
  }) {
    final available =
        MediaQuery.of(context).size.width - (horizontalMargin * 2);
    return available > maxWidth ? maxWidth : available;
  }

  Future<bool> _showBauhausConfirmDialog({
    required String title,
    required String message,
    required IconData icon,
    required String confirmText,
    Color headerColor = BauhausDesign.primary,
    BauhausActionVariant confirmVariant = BauhausActionVariant.primary,
  }) async {
    final colorScheme = Theme.of(context).colorScheme;
    final headerForeground = headerColor == BauhausDesign.error
        ? colorScheme.onError
        : headerColor == BauhausDesign.secondary
        ? colorScheme.onSecondary
        : colorScheme.onPrimary;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Container(
            width: _dialogWidth(dialogContext, maxWidth: 520),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 3,
              ),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space4,
                    vertical: BauhausDesign.space3,
                  ),
                  decoration: BoxDecoration(
                    color: headerColor,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: headerForeground, size: 22),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                          style: BauhausDesign.getTextTheme(dialogContext)
                              .titleMedium
                              ?.copyWith(
                                color: headerForeground,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Text(
                    message,
                    style: BauhausDesign.getTextTheme(dialogContext).bodyMedium
                        ?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BauhausDesign.space4,
                    0,
                    BauhausDesign.space4,
                    BauhausDesign.space4,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BauhausActionButton(
                          text: 'Cancel',
                          variant: BauhausActionVariant.secondary,
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: BauhausActionButton(
                          text: confirmText,
                          variant: confirmVariant,
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result == true;
  }

  Future<_ClientDeleteMode> _showDeleteClientModeDialog(Patient client) async {
    final result = await showDialog<_ClientDeleteMode>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Container(
            width: _dialogWidth(dialogContext, maxWidth: 560),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 3,
              ),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space4,
                    vertical: BauhausDesign.space3,
                  ),
                  decoration: BoxDecoration(
                    color: BauhausDesign.error,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_forever_outlined,
                        color: Theme.of(context).colorScheme.onError,
                        size: 22,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          'DELETE CLIENT'.toUpperCase(),
                          style: BauhausDesign.getTextTheme(dialogContext)
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(
                                  dialogContext,
                                ).colorScheme.onError,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Text(
                    'Choose delete type for ${client.displayName}.\n\nDelete: hides client and deactivates access for 90 days.\nForce Delete: permanently removes client data.',
                    style: BauhausDesign.getTextTheme(dialogContext).bodyMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BauhausDesign.space4,
                    0,
                    BauhausDesign.space4,
                    BauhausDesign.space4,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.secondary,
                              onPressed: () => Navigator.of(
                                dialogContext,
                              ).pop(_ClientDeleteMode.cancel),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Delete (90 Days)',
                              variant: BauhausActionVariant.warning,
                              onPressed: () => Navigator.of(
                                dialogContext,
                              ).pop(_ClientDeleteMode.soft),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      SizedBox(
                        width: double.infinity,
                        child: BauhausActionButton(
                          text: 'Force Delete',
                          variant: BauhausActionVariant.error,
                          onPressed: () => Navigator.of(
                            dialogContext,
                          ).pop(_ClientDeleteMode.force),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result ?? _ClientDeleteMode.cancel;
  }

  Future<void> _showEditClientDialog(
    Patient client, {
    bool restoreAfterSave = false,
  }) async {
    if (client.id == null || client.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            restoreAfterSave
                ? 'Cannot update this deleted client because ID is missing.'
                : 'Cannot edit this client because ID is missing.',
          ),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    final firstNameController = TextEditingController(
      text: client.clientFirstName ?? '',
    );
    final lastNameController = TextEditingController(
      text: client.clientLastName ?? '',
    );
    final phoneController = TextEditingController(
      text: client.clientPhone ?? '',
    );
    final addressController = TextEditingController(
      text: client.clientAddress ?? '',
    );
    final cityController = TextEditingController(text: client.clientCity ?? '');
    final stateController = TextEditingController(
      text: client.clientState ?? '',
    );
    final zipController = TextEditingController(text: client.clientZip ?? '');
    final ndisNumberController = TextEditingController(
      text: client.ndisNumber ?? '',
    );
    String selectedFundingType = client.fundingType ?? 'plan_managed';
    String selectedBusinessName = client.businessName?.trim() ?? '';
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;
    final dialogTitle = restoreAfterSave
        ? 'UPDATE & RESTORE CLIENT'
        : 'EDIT CLIENT';
    final dialogColor = restoreAfterSave
        ? BauhausDesign.warning
        : BauhausDesign.secondary;
    final dialogForeground = dialogColor == BauhausDesign.secondary
        ? Theme.of(context).colorScheme.onSecondary
        : Theme.of(context).colorScheme.onPrimary;
    final saveButtonText = restoreAfterSave ? 'Update & Restore' : 'Save';
    final saveButtonVariant = restoreAfterSave
        ? BauhausActionVariant.warning
        : BauhausActionVariant.primary;
    final saveErrorPrefix = restoreAfterSave
        ? 'Failed to restore client'
        : 'Failed to update client';

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
              child: Container(
                width: _dialogWidth(dialogContext, maxWidth: 760),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 3,
                  ),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space3,
                      ),
                      decoration: BoxDecoration(
                        color: dialogColor,
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            restoreAfterSave
                                ? Icons.restore_from_trash_rounded
                                : Icons.edit_note_rounded,
                            color: dialogForeground,
                            size: 22,
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                          Expanded(
                            child: Text(
                              dialogTitle,
                              style: BauhausDesign.getTextTheme(dialogContext)
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onError,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(dialogContext).size.height * 0.62,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(BauhausDesign.space4),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: BauhausTextField(
                                      controller: firstNameController,
                                      label: 'First name',
                                      validator: (v) =>
                                          (v == null || v.trim().isEmpty)
                                          ? 'Required'
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: BauhausDesign.space3),
                                  Expanded(
                                    child: BauhausTextField(
                                      controller: lastNameController,
                                      label: 'Last name',
                                      validator: (v) =>
                                          (v == null || v.trim().isEmpty)
                                          ? 'Required'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: phoneController,
                                label: 'Phone',
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: addressController,
                                label: 'Address',
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: BauhausTextField(
                                      controller: cityController,
                                      label: 'City',
                                    ),
                                  ),
                                  const SizedBox(width: BauhausDesign.space3),
                                  Expanded(
                                    child: BauhausTextField(
                                      controller: stateController,
                                      label: 'State',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'BUSINESS INFORMATION',
                                  style:
                                      BauhausDesign.getTextTheme(
                                        dialogContext,
                                      ).labelMedium?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.7,
                                      ),
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              BusinessNameDropdown(
                                organizationId: ref.read(
                                  organizationIdProvider,
                                ),
                                initialValue: selectedBusinessName.isEmpty
                                    ? null
                                    : selectedBusinessName,
                                onChanged: (selectedValue) {
                                  if (selectedValue == 'Select Business Name') {
                                    selectedBusinessName = '';
                                  } else {
                                    selectedBusinessName = selectedValue;
                                  }
                                },
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: zipController,
                                label: 'Postcode',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'NDIS',
                                  style:
                                      BauhausDesign.getTextTheme(
                                        dialogContext,
                                      ).labelMedium?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.7,
                                      ),
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space1),
                              BauhausTextField(
                                controller: ndisNumberController,
                                label: 'NDIS number',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              DropdownButtonFormField<String>(
                                initialValue: selectedFundingType,
                                decoration: const InputDecoration(
                                  labelText: 'Funding type',
                                  border: OutlineInputBorder(),
                                ),
                                items:
                                    const [
                                          'ndia_managed',
                                          'plan_managed',
                                          'self_managed',
                                          'combination',
                                        ]
                                        .map(
                                          (t) => DropdownMenuItem(
                                            value: t,
                                            child: Text(t),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (v) => setDialogState(
                                  () =>
                                      selectedFundingType = v ?? 'plan_managed',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        BauhausDesign.space4,
                        0,
                        BauhausDesign.space4,
                        BauhausDesign.space4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.secondary,
                              onPressed: isSaving
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: BauhausActionButton(
                              text: saveButtonText,
                              variant: saveButtonVariant,
                              isLoading: isSaving,
                              onPressed: isSaving
                                  ? null
                                  : () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }
                                      final userContext =
                                          await _getRequiredUserContext();
                                      if (userContext == null) return;
                                      if (!dialogContext.mounted) return;

                                      setDialogState(() => isSaving = true);
                                      try {
                                        final notifier = ref.read(
                                          clientProvider.notifier,
                                        );
                                        final response = restoreAfterSave
                                            ? await notifier.restoreClient(
                                                clientId: client.id!,
                                                clientFirstName:
                                                    firstNameController.text
                                                        .trim(),
                                                clientLastName:
                                                    lastNameController.text
                                                        .trim(),
                                                clientPhone: phoneController
                                                    .text
                                                    .trim(),
                                                clientAddress: addressController
                                                    .text
                                                    .trim(),
                                                clientCity: cityController.text
                                                    .trim(),
                                                clientState: stateController
                                                    .text
                                                    .trim(),
                                                clientZip: zipController.text
                                                    .trim(),
                                                businessName:
                                                    selectedBusinessName.trim(),
                                                userEmail:
                                                    userContext['userEmail']!,
                                                organizationId:
                                                    userContext['organizationId']!,
                                              )
                                            : await notifier.updateClient(
                                                clientId: client.id!,
                                                clientFirstName:
                                                    firstNameController.text
                                                        .trim(),
                                                clientLastName:
                                                    lastNameController.text
                                                        .trim(),
                                                clientPhone: phoneController
                                                    .text
                                                    .trim(),
                                                clientAddress: addressController
                                                    .text
                                                    .trim(),
                                                clientCity: cityController.text
                                                    .trim(),
                                                clientState: stateController
                                                    .text
                                                    .trim(),
                                                clientZip: zipController.text
                                                    .trim(),
                                                businessName:
                                                    selectedBusinessName.trim(),
                                                userEmail:
                                                    userContext['userEmail']!,
                                                organizationId:
                                                    userContext['organizationId']!,
                                                ndisNumber: ndisNumberController
                                                    .text
                                                    .trim(),
                                                fundingType:
                                                    selectedFundingType,
                                              );

                                        if (!mounted || !context.mounted)
                                          return;
                                        if (dialogContext.mounted) {
                                          Navigator.of(dialogContext).pop();
                                        }
                                        final message =
                                            response['message']?.toString() ??
                                            (restoreAfterSave
                                                ? 'Client restored successfully. Activate account again to allow login.'
                                                : 'Client updated successfully');
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(message),
                                            backgroundColor:
                                                BauhausDesign.success,
                                          ),
                                        );
                                        if (restoreAfterSave) {
                                          setState(
                                            () => _selectedListMode =
                                                _ClientListMode.active,
                                          );
                                          await _loadClients(
                                            mode: _ClientListMode.active,
                                          );
                                        } else {
                                          await _loadClients();
                                        }
                                      } catch (e) {
                                        if (!mounted || !context.mounted)
                                          return;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '$saveErrorPrefix: $e',
                                            ),
                                            backgroundColor:
                                                BauhausDesign.error,
                                          ),
                                        );
                                      } finally {
                                        if (mounted && dialogContext.mounted) {
                                          setDialogState(
                                            () => isSaving = false,
                                          );
                                        }
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    ndisNumberController.dispose();
  }

  Future<void> _showNdisPlanDialog(Patient client) async {
    final userContext = await _getRequiredUserContext();
    if (userContext == null || !mounted) return;

    final api = ref.read(apiMethodProvider);
    final organizationId = userContext['organizationId']!;
    final userEmail = userContext['userEmail']!;

    Map<String, dynamic> plan = {};
    try {
      final details = await api.getClientDetails(
        client.clientEmail ?? '',
        clientId: client.id,
        organizationId: organizationId,
      );
      final data = details?['data'];
      if (data is Map) {
        final candidate =
            data['plan'] ??
            (data['client'] is Map ? data['client']['plan'] : null);
        if (candidate is Map) plan = Map<String, dynamic>.from(candidate);
      }
    } catch (_) {
      // A missing plan is a valid starting state; the user can enter it now.
    }
    if (!mounted) return;

    final budgetController = TextEditingController(
      text: plan['totalBudget']?.toString() ?? '',
    );
    final documentUrlController = TextEditingController(
      text: plan['documentUrl']?.toString() ?? '',
    );
    final documentNameController = TextEditingController(
      text: plan['documentName']?.toString() ?? '',
    );
    final notesController = TextEditingController(
      text: plan['notes']?.toString() ?? '',
    );
    final categoryDrafts = <_PlanCategoryDraft>[];
    for (final raw in (plan['categories'] as List<dynamic>? ?? [])) {
      if (raw is! Map) continue;
      categoryDrafts.add(
        _PlanCategoryDraft(
          number: raw['categoryNumber']?.toString() ?? '',
          name: raw['name']?.toString() ?? '',
          budget: raw['budget']?.toString() ?? '',
        ),
      );
    }
    DateTime? startDate = DateTime.tryParse(
      plan['startDate']?.toString() ?? '',
    );
    DateTime? endDate = DateTime.tryParse(plan['endDate']?.toString() ?? '');
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;
    String? errorText;
    String? uploadWarning;
    PlatformFile? planFile;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final l10n = AppLocalizations.of(dialogContext);
            Future<void> pickDate({required bool isStart}) async {
              final now = DateTime.now();
              final initial = (isStart ? startDate : endDate) ?? now;
              final picked = await showBauhausDatePicker(
                context: dialogContext,
                initialDate: initial,
                firstDate: DateTime(now.year - 5),
                lastDate: DateTime(now.year + 10),
              );
              if (picked == null) return;
              setDialogState(() {
                if (isStart) {
                  startDate = picked;
                } else {
                  endDate = picked;
                }
              });
            }

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,
              ),
              child: Container(
                width: _dialogWidth(dialogContext, maxWidth: 640),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 3,
                  ),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space3,
                      ),
                      color: BauhausDesign.warning,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 22,
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                          Expanded(
                            child: Text(
                              l10n?.ndisPlanTitle(client.displayName) ??
                                  'NDIS Plan',
                              style: BauhausDesign.getTextTheme(dialogContext)
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(BauhausDesign.space4),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                l10n?.ndisPlanDescription ??
                                    'The plan period and budget gate NDIA-managed invoices.',
                                style: BauhausDesign.getTextTheme(
                                  dialogContext,
                                ).bodySmall,
                              ),
                              const SizedBox(height: BauhausDesign.space4),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => pickDate(isStart: true),
                                      icon: const Icon(Icons.event_outlined),
                                      label: Text(
                                        startDate == null
                                            ? (l10n?.planStart ?? 'Plan start')
                                            : (l10n?.planStartDate(
                                                    _formatShortDate(startDate),
                                                  ) ??
                                                  'Start ${_formatShortDate(startDate)}'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: BauhausDesign.space3),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () => pickDate(isStart: false),
                                      icon: const Icon(
                                        Icons.event_available_outlined,
                                      ),
                                      label: Text(
                                        endDate == null
                                            ? (l10n?.planEnd ?? 'Plan end')
                                            : (l10n?.planEndDate(
                                                    _formatShortDate(endDate),
                                                  ) ??
                                                  'End ${_formatShortDate(endDate)}'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: BauhausDesign.space4),
                              TextFormField(
                                controller: budgetController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: InputDecoration(
                                  labelText:
                                      l10n?.planBudget ??
                                      'Total plan budget (AUD)',
                                  prefixText: '\$ ',
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return null;
                                  }
                                  final parsed = double.tryParse(value);
                                  if (parsed == null || parsed < 0) {
                                    return l10n?.planBudgetInvalid ??
                                        'Enter a valid non-negative amount';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: BauhausDesign.space4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      l10n?.planCategoryBudgets ??
                                          'Category budgets (optional)',
                                      style: BauhausDesign.getTextTheme(
                                        dialogContext,
                                      ).titleSmall,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: isSaving
                                        ? null
                                        : () => setDialogState(
                                            () => categoryDrafts.add(
                                              _PlanCategoryDraft(),
                                            ),
                                          ),
                                    icon: const Icon(Icons.add, size: 18),
                                    label: Text(
                                      l10n?.planAddCategory ?? 'Add category',
                                    ),
                                  ),
                                ],
                              ),
                              for (final draft in categoryDrafts)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: BauhausDesign.space2,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 64,
                                        child: TextField(
                                          controller: draft.number,
                                          decoration: InputDecoration(
                                            labelText:
                                                l10n?.planCategoryNumber ??
                                                'Cat',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: BauhausDesign.space2,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: draft.name,
                                          decoration: InputDecoration(
                                            labelText:
                                                l10n?.planCategoryName ??
                                                'Category name',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: BauhausDesign.space2,
                                      ),
                                      SizedBox(
                                        width: 104,
                                        child: TextField(
                                          controller: draft.budget,
                                          keyboardType:
                                              const TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                          decoration: InputDecoration(
                                            labelText:
                                                l10n?.planCategoryAmount ??
                                                'Budget',
                                            prefixText: '\$ ',
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        tooltip:
                                            l10n?.planRemoveCategory ??
                                            'Remove category',
                                        onPressed: isSaving
                                            ? null
                                            : () => setDialogState(
                                                () => categoryDrafts.remove(
                                                  draft,
                                                ),
                                              ),
                                        icon: const Icon(Icons.delete_outline),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: BauhausDesign.space4),
                              TextFormField(
                                controller: documentNameController,
                                decoration: InputDecoration(
                                  labelText:
                                      l10n?.planDocumentName ??
                                      'Plan document name (optional)',
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              TextFormField(
                                controller: documentUrlController,
                                decoration: InputDecoration(
                                  labelText:
                                      l10n?.planDocumentUrl ??
                                      'Plan document URL (optional)',
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              OutlinedButton.icon(
                                onPressed: isSaving
                                    ? null
                                    : () async {
                                        final result =
                                            await FilePicker.pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: const [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ],
                                            );
                                        final file = result?.files.single;
                                        if (file == null) return;
                                        setDialogState(() {
                                          planFile = file;
                                          documentNameController.text =
                                              file.name;
                                        });
                                      },
                                icon: const Icon(Icons.upload_file_outlined),
                                label: Text(
                                  planFile == null
                                      ? (l10n?.planAttachDocument ??
                                            'Attach plan document')
                                      : (l10n?.planSelectedFile(
                                              planFile!.name,
                                            ) ??
                                            'Selected: ${planFile!.name}'),
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              TextFormField(
                                controller: notesController,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  labelText:
                                      l10n?.planNotes ?? 'Notes (optional)',
                                ),
                              ),
                              if (errorText != null) ...[
                                const SizedBox(height: BauhausDesign.space3),
                                Text(
                                  errorText!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        BauhausDesign.space4,
                        0,
                        BauhausDesign.space4,
                        BauhausDesign.space4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              text: l10n?.planCancel ?? 'Cancel',
                              variant: BauhausActionVariant.secondary,
                              onPressed: isSaving
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: BauhausActionButton(
                              text: l10n?.planSave ?? 'Save Plan',
                              variant: BauhausActionVariant.primary,
                              isLoading: isSaving,
                              onPressed: isSaving
                                  ? null
                                  : () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }
                                      setDialogState(() {
                                        isSaving = true;
                                        errorText = null;
                                      });

                                      String? uploadedPlanUrl;
                                      if (planFile?.path != null) {
                                        try {
                                          final storageRef = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                'ndis_plans/$organizationId/'
                                                '${client.id}/'
                                                '${DateTime.now().millisecondsSinceEpoch}_'
                                                '${planFile!.name}',
                                              );
                                          await storageRef.putFile(
                                            File(planFile!.path!),
                                          );
                                          uploadedPlanUrl = await storageRef
                                              .getDownloadURL();
                                        } catch (e) {
                                          // The budget/period is more important
                                          // than the attachment: keep saving the
                                          // plan and warn that the file failed.
                                          uploadWarning =
                                              l10n?.planUploadFailed('$e') ??
                                              'Failed to upload the plan document: $e';
                                          uploadedPlanUrl = null;
                                        }
                                      }

                                      final response = await api
                                          .updateClientPlan(
                                            clientId: client.id!,
                                            organizationId: organizationId,
                                            userEmail: userEmail,
                                            startDate: startDate,
                                            endDate: endDate,
                                            totalBudget:
                                                budgetController.text
                                                    .trim()
                                                    .isEmpty
                                                ? 0
                                                : double.tryParse(
                                                    budgetController.text
                                                        .trim(),
                                                  ),
                                            categories: categoryDrafts
                                                .map((draft) => draft.toJson())
                                                .where(
                                                  (category) =>
                                                      (category['categoryNumber']
                                                              as String)
                                                          .isNotEmpty,
                                                )
                                                .toList(),
                                            documentUrl:
                                                uploadedPlanUrl ??
                                                documentUrlController.text
                                                    .trim(),
                                            documentName:
                                                planFile?.name ??
                                                documentNameController.text
                                                    .trim(),
                                            notes: notesController.text.trim(),
                                          );
                                      if (!dialogContext.mounted) return;
                                      if (response['success'] == true ||
                                          response['data'] != null) {
                                        Navigator.of(dialogContext).pop();
                                        ScaffoldMessenger.of(
                                          this.context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              uploadWarning == null
                                                  ? (l10n?.planUpdated ??
                                                        'NDIS plan updated.')
                                                  : 'NDIS plan updated. $uploadWarning',
                                            ),
                                            backgroundColor:
                                                uploadWarning == null
                                                ? BauhausDesign.success
                                                : BauhausDesign.warning,
                                          ),
                                        );
                                      } else {
                                        setDialogState(() {
                                          isSaving = false;
                                          errorText =
                                              response['message']?.toString() ??
                                              response['error']?.toString() ??
                                              (l10n?.planSaveFailed ??
                                                  'Failed to update the NDIS plan.');
                                        });
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    _disposeAfterDialog([
      budgetController.dispose,
      documentUrlController.dispose,
      documentNameController.dispose,
      notesController.dispose,
      for (final draft in categoryDrafts) draft.dispose,
    ]);
  }

  Future<void> _confirmDeleteClient(Patient client) async {
    if (client.id == null || client.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.cannotDeleteClientMissingId),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    final deleteMode = await _showDeleteClientModeDialog(client);
    if (deleteMode == _ClientDeleteMode.cancel) return;
    final forceDelete = deleteMode == _ClientDeleteMode.force;

    final userContext = await _getRequiredUserContext();
    if (userContext == null) return;

    try {
      final response = await ref
          .read(clientProvider.notifier)
          .deleteClient(
            clientId: client.id!,
            userEmail: userContext['userEmail']!,
            organizationId: userContext['organizationId']!,
            forceDelete: forceDelete,
          );
      if (!mounted) return;
      final message =
          response['message']?.toString() ?? 'Client deleted successfully';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: BauhausDesign.success,
        ),
      );
      await _loadClients();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete client: $e'),
          backgroundColor: BauhausDesign.error,
        ),
      );
    }
  }

  String _formatShortDate(DateTime? value) {
    if (value == null) return '-';
    final local = value.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    return '$day/$month/${local.year}';
  }

  Future<void> _confirmRestoreClient(Patient client) async {
    if (client.id == null || client.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.cannotRestoreClientMissingId),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    final confirmed = await _showBauhausConfirmDialog(
      title: 'Restore Client?',
      message:
          'This will move ${client.displayName} back to the active client list.\n\nYou must activate the client account again before app login is allowed.',
      icon: Icons.restore_from_trash_outlined,
      headerColor: BauhausDesign.warning,
      confirmText: 'Restore',
      confirmVariant: BauhausActionVariant.warning,
    );

    if (!confirmed || !mounted) return;

    final userContext = await _getRequiredUserContext();
    if (userContext == null) return;

    try {
      final response = await ref
          .read(clientProvider.notifier)
          .restoreClient(
            clientId: client.id!,
            userEmail: userContext['userEmail']!,
            organizationId: userContext['organizationId']!,
          );
      if (!mounted) return;
      final message =
          response['message']?.toString() ??
          'Client restored successfully. Activate account again to allow login.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() => _selectedListMode = _ClientListMode.active);
      await _loadClients(mode: _ClientListMode.active);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to restore client: $e'),
          backgroundColor: BauhausDesign.error,
        ),
      );
    }
  }

  String _activationKeyForClient(Patient client) {
    final id = client.id?.trim();
    if (id != null && id.isNotEmpty) {
      return id;
    }
    return client.clientEmail.trim().toLowerCase();
  }

  void _showActivationProgressSnackBar(String email) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = colorScheme.onSecondary;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(minutes: 1),
          backgroundColor: BauhausDesign.secondary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          ),
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  'Sending activation email to $email...',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: foregroundColor),
                ),
              ),
            ],
          ),
        ),
      );
  }

  void _showClientActionSnackBar({
    required String message,
    required bool isError,
  }) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final backgroundColor = isError
        ? BauhausDesign.error
        : BauhausDesign.success;
    final foregroundColor = isError
        ? Theme.of(context).colorScheme.onError
        : Theme.of(context).colorScheme.onSecondary;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          ),
          content: Row(
            children: [
              Icon(icon, color: foregroundColor),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  message,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: foregroundColor),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildActivationBadge(Patient client) {
    String label;
    Color backgroundColor;
    Color foregroundColor;
    IconData icon;

    if (client.isActivated) {
      label = 'Activated';
      backgroundColor = BauhausDesign.success.withValues(alpha: 0.14);
      foregroundColor = BauhausDesign.success;
      icon = Icons.verified_rounded;
    } else if (client.activationPending == true) {
      label = 'Pending';
      backgroundColor = BauhausDesign.warning.withValues(alpha: 0.14);
      foregroundColor = BauhausDesign.warning;
      icon = Icons.schedule_rounded;
    } else {
      label = 'Not Activated';
      backgroundColor = Theme.of(context).colorScheme.surfaceContainer;
      foregroundColor = Theme.of(context).colorScheme.onSurfaceVariant;
      icon = Icons.person_outline_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: foregroundColor.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: foregroundColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _activateClientAccount(Patient client) async {
    final key = _activationKeyForClient(client);
    if (_activatingClientKeys.contains(key)) return;

    final confirmed = await _showBauhausConfirmDialog(
      title: 'Activate Client Account?',
      message: client.activationPending == true
          ? 'This will resend the account setup email to ${client.clientEmail}.\n\nStatus stays Pending until the client sets a password using the link.'
          : 'This will send an account setup email to ${client.clientEmail}.',
      icon: Icons.lock_open_rounded,
      headerColor: BauhausDesign.secondary,
      confirmText: 'Activate',
      confirmVariant: BauhausActionVariant.primary,
    );

    if (!confirmed || !mounted) return;

    setState(() => _activatingClientKeys.add(key));
    await Future<void>.delayed(Duration.zero);
    _showActivationProgressSnackBar(client.clientEmail);

    try {
      final response = await ref
          .read(clientProvider.notifier)
          .activateClient(client.clientEmail);
      final message =
          response['message']?.toString() ??
          'Activation email sent. Status will remain Pending until setup is completed.';
      _showClientActionSnackBar(message: message, isError: false);
      await _loadClients();
    } catch (e) {
      _showClientActionSnackBar(
        message: 'Failed to activate ${client.clientEmail}: $e',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _activatingClientKeys.remove(key));
      }
    }
  }

  Future<void> _markClientActivatedByAdmin(Patient client) async {
    final clientId = client.id?.trim();
    if (clientId == null || clientId.isEmpty) {
      _showClientActionSnackBar(
        message: 'Client ID is missing. Unable to apply admin activation.',
        isError: true,
      );
      return;
    }

    final key = _activationKeyForClient(client);
    if (_adminActivatingClientKeys.contains(key)) return;

    final confirmed = await _showBauhausConfirmDialog(
      title: 'Mark Client Activated?',
      message:
          'This will mark ${client.displayName} as activated immediately without requiring client login.',
      icon: Icons.admin_panel_settings_outlined,
      headerColor: BauhausDesign.warning,
      confirmText: 'Mark Activated',
      confirmVariant: BauhausActionVariant.warning,
    );

    if (!confirmed || !mounted) return;

    final userContext = await _getRequiredUserContext();
    if (userContext == null) return;

    setState(() => _adminActivatingClientKeys.add(key));

    try {
      final response = await ref
          .read(clientProvider.notifier)
          .markClientActivatedByAdmin(
            clientId: clientId,
            userEmail: userContext['userEmail']!,
            organizationId: userContext['organizationId']!,
          );
      final message =
          response['message']?.toString() ??
          'Client marked as activated by admin.';
      _showClientActionSnackBar(message: message, isError: false);
      await _loadClients();
    } catch (e) {
      _showClientActionSnackBar(
        message: 'Failed to mark ${client.clientEmail} as activated: $e',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _adminActivatingClientKeys.remove(key));
      }
    }
  }

  Widget _buildListModeToggle() {
    final isHistory = _selectedListMode == _ClientListMode.history;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        BauhausDesign.space4,
        BauhausDesign.space3,
        BauhausDesign.space4,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: BauhausActionButton(
              text: 'Active Clients',
              variant: isHistory
                  ? BauhausActionVariant.secondary
                  : BauhausActionVariant.primary,
              isSmall: true,
              onPressed: () => _switchListMode(_ClientListMode.active),
            ),
          ),
          SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: BauhausActionButton(
              text: 'History',
              variant: isHistory
                  ? BauhausActionVariant.warning
                  : BauhausActionVariant.secondary,
              isSmall: true,
              onPressed: () => _switchListMode(_ClientListMode.history),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientState = ref.watch(clientProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.clients,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: BauhausDesign.space4),
            child: BauhausActionButton(
              text: l10n.addButton,
              icon: Icons.add,
              isSmall: true,
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.addClientDetails);
                _loadClients();
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildListModeToggle(),
          Expanded(child: _buildBody(clientState)),
        ],
      ),
    );
  }

  Widget _buildBody(ClientState state) {
    final l10n = AppLocalizations.of(context)!;
    final isHistoryMode = _selectedListMode == _ClientListMode.history;

    if (state.isLoading) {
      return BauhausLoadingState(
        message: isHistoryMode
            ? 'Loading client history...'
            : l10n.loadingClients,
      );
    }

    if (state.error != null) {
      return Center(
        child: BauhausErrorState(
          title: l10n.oopsTitle,
          message: state.error ?? l10n.somethingWentWrong,
          onRetry: _loadClients,
        ),
      );
    }

    if (state.clients.isEmpty) {
      return Center(
        child: BauhausEmptyState(
          title: isHistoryMode
              ? 'No Client History Found'
              : l10n.noClientsFoundTitle,
          subtitle: isHistoryMode
              ? 'Soft-deleted clients will appear here for restoration.'
              : l10n.noClientsFoundSubtitle,
          icon: Icons.people_outline,
          actionLabel: isHistoryMode
              ? 'View Active Clients'
              : l10n.addClientButton,
          onAction: () async {
            if (isHistoryMode) {
              await _switchListMode(_ClientListMode.active);
              return;
            }
            await Navigator.pushNamed(context, Routes.addClientDetails);
            _loadClients();
          },
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          ...state.clients.map((client) => _buildClientCard(context, client)),
        ],
      ),
    );
  }

  Widget _buildClientCard(BuildContext context, Patient client) {
    final isHistoryMode = _selectedListMode == _ClientListMode.history;
    final isActivating = _activatingClientKeys.contains(
      _activationKeyForClient(client),
    );
    final isAdminActivating = _adminActivatingClientKeys.contains(
      _activationKeyForClient(client),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: BauhausDesign.space4),
      child: BauhausCard(
        padding: EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  ),
                  child: Icon(
                    Icons.person,
                    color: BauhausDesign.secondary,
                    size: 24,
                  ),
                ),
                SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              client.displayName,
                              style: BauhausDesign.getTextTheme(context)
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),
                          ),
                          SizedBox(width: BauhausDesign.space2),
                          _buildActivationBadge(client),
                        ],
                      ),
                      SizedBox(height: BauhausDesign.space1),
                      Text(
                        client.clientEmail,
                        style: BauhausDesign.getTextTheme(context).bodyMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: BauhausDesign.space4),
              child: Divider(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.2),
                height: 1,
              ),
            ),
            if (client.clientPhone != null && client.clientPhone!.isNotEmpty)
              _buildInfoRow(context, Icons.phone_outlined, client.clientPhone!),
            if (client.clientPhone != null && client.clientPhone!.isNotEmpty)
              SizedBox(height: BauhausDesign.space2),
            if (client.clientAddress != null &&
                client.clientAddress!.isNotEmpty)
              _buildInfoRow(
                context,
                Icons.location_on_outlined,
                '${client.clientAddress}, ${client.clientCity ?? ''}',
              ),
            if (client.businessName != null && client.businessName!.isNotEmpty)
              SizedBox(height: BauhausDesign.space2),
            if (client.businessName != null && client.businessName!.isNotEmpty)
              _buildInfoRow(
                context,
                Icons.business_outlined,
                client.businessName!,
              ),
            if (isHistoryMode) ...[
              SizedBox(height: BauhausDesign.space2),
              _buildInfoRow(
                context,
                Icons.history_rounded,
                'Deleted: ${_formatShortDate(client.deletedAt)} · Purge: ${_formatShortDate(client.purgeAfter)}',
              ),
            ],
            SizedBox(height: BauhausDesign.space4),
            Divider(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
              height: 1,
            ),
            SizedBox(height: BauhausDesign.space4),
            if (isHistoryMode) ...[
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Restore',
                      icon: Icons.restore_rounded,
                      variant: BauhausActionVariant.warning,
                      isSmall: true,
                      onPressed: () => _confirmRestoreClient(client),
                    ),
                  ),
                  SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Update & Restore',
                      icon: Icons.edit_note_rounded,
                      variant: BauhausActionVariant.secondary,
                      isSmall: true,
                      onPressed: () =>
                          _showEditClientDialog(client, restoreAfterSave: true),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Edit',
                      icon: Icons.edit_outlined,
                      variant: BauhausActionVariant.secondary,
                      isSmall: true,
                      onPressed: () => _showEditClientDialog(client),
                    ),
                  ),
                  SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: BauhausActionButton(
                      text: 'Delete',
                      icon: Icons.delete_outline,
                      variant: BauhausActionVariant.error,
                      isSmall: true,
                      onPressed: () => _confirmDeleteClient(client),
                    ),
                  ),
                ],
              ),
              SizedBox(height: BauhausDesign.space3),
              BauhausActionButton(
                text: 'NDIS Plan',
                icon: Icons.account_balance_wallet_outlined,
                variant: BauhausActionVariant.warning,
                isSmall: true,
                isFullWidth: true,
                onPressed: () => _showNdisPlanDialog(client),
              ),
              SizedBox(height: BauhausDesign.space3),
              BauhausActionButton(
                text: 'Family Access',
                icon: Icons.family_restroom_outlined,
                variant: BauhausActionVariant.warning,
                isSmall: true,
                isFullWidth: true,
                onPressed: () => _openFamilyAccess(client),
              ),
              SizedBox(height: BauhausDesign.space3),
              BauhausActionButton(
                text: 'Care Team',
                icon: Icons.diversity_3_outlined,
                variant: BauhausActionVariant.primary,
                isSmall: true,
                isFullWidth: true,
                onPressed: () => _openCareTeam(client),
              ),
            ],
            if (!isHistoryMode && !client.isActivated) ...[
              SizedBox(height: BauhausDesign.space4),
              Divider(
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.2),
                height: 1,
              ),
              SizedBox(height: BauhausDesign.space4),
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: isActivating
                          ? 'Sending Activation...'
                          : (client.activationPending == true
                                ? 'Resend Activation Email'
                                : 'Activate Client Account'),
                      icon: isActivating ? null : Icons.lock_open,
                      variant: BauhausActionVariant.secondary,
                      isSmall: true,
                      isLoading: isActivating,
                      onPressed: (isActivating || isAdminActivating)
                          ? null
                          : () => _activateClientAccount(client),
                    ),
                  ),
                  SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: BauhausActionButton(
                      text: isAdminActivating
                          ? 'Marking Activated...'
                          : 'Mark Activated (Admin)',
                      icon: isAdminActivating
                          ? null
                          : Icons.admin_panel_settings_outlined,
                      variant: BauhausActionVariant.warning,
                      isSmall: true,
                      isLoading: isAdminActivating,
                      onPressed: (isActivating || isAdminActivating)
                          ? null
                          : () => _markClientActivatedByAdmin(client),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _openFamilyAccess(Patient client) {
    final clientId = client.id?.trim();
    if (clientId == null || clientId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.clientIdMissingUnableToOpenFamilyAccess),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FamilyManagementView(
          clientId: clientId,
          clientName: client.displayName,
        ),
      ),
    );
  }

  void _openCareTeam(Patient client) {
    final clientId = client.id?.trim();
    if (clientId == null || clientId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.clientIdMissingUnableToOpenCareTeam),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            CareTeamView(clientId: clientId, clientName: client.displayName),
      ),
    );
  }
}
