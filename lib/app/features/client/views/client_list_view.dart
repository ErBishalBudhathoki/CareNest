import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/client/providers/client_provider.dart';
import 'package:carenest/app/features/realtime_portal/views/family_management_view.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/business_name_dropdown_widget.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _ClientDeleteMode { cancel, soft, force }

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
        const SnackBar(
          content: Text('Session data missing. Please log in again.'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return null;
    }

    return {'userEmail': userEmail, 'organizationId': organizationId};
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
    final headerForeground =
        ThemeData.estimateBrightnessForColor(headerColor) == Brightness.dark
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.textDark;

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
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 3),
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
                        color: BauhausDesign.neutral,
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
                    style: BauhausDesign.getTextTheme(
                      dialogContext,
                    ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
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
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 3),
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
                  decoration: const BoxDecoration(
                    color: BauhausDesign.error,
                    border: Border(
                      bottom: BorderSide(
                        color: BauhausDesign.neutral,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_forever_outlined,
                        color: BauhausDesign.surfaceWhite,
                        size: 22,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          'DELETE CLIENT'.toUpperCase(),
                          style: BauhausDesign.getTextTheme(dialogContext)
                              .titleMedium
                              ?.copyWith(
                                color: BauhausDesign.surfaceWhite,
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
    String selectedBusinessName = client.businessName?.trim() ?? '';
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;
    final dialogTitle = restoreAfterSave
        ? 'UPDATE & RESTORE CLIENT'
        : 'EDIT CLIENT';
    final dialogColor = restoreAfterSave
        ? BauhausDesign.warning
        : BauhausDesign.secondary;
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
                  color: BauhausDesign.surfaceWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 3),
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
                        border: const Border(
                          bottom: BorderSide(
                            color: BauhausDesign.neutral,
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
                            color: BauhausDesign.surfaceWhite,
                            size: 22,
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                          Expanded(
                            child: Text(
                              dialogTitle,
                              style: BauhausDesign.getTextTheme(dialogContext)
                                  .titleMedium
                                  ?.copyWith(
                                    color: BauhausDesign.surfaceWhite,
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
                                        color: BauhausDesign.textDark,
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
                                              );

                                        if (!mounted || !context.mounted) return;
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
                                        if (!mounted || !context.mounted) return;
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
  }

  Future<void> _confirmDeleteClient(Patient client) async {
    if (client.id == null || client.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot delete this client because ID is missing.'),
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
        const SnackBar(
          content: Text('Cannot restore this client because ID is missing.'),
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
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    BauhausDesign.surfaceWhite,
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  'Sending activation email to $email...',
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.surfaceWhite),
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
              Icon(icon, color: BauhausDesign.surfaceWhite),
              const SizedBox(width: BauhausDesign.space2),
              Expanded(
                child: Text(
                  message,
                  style: BauhausDesign.getTextTheme(
                    context,
                  ).bodyMedium?.copyWith(color: BauhausDesign.surfaceWhite),
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
      backgroundColor = BauhausDesign.neutral.withValues(alpha: 0.14);
      foregroundColor = BauhausDesign.textMuted;
      icon = Icons.person_outline_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.clients,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
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
                                    color: BauhausDesign.textDark,
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
                        style: BauhausDesign.getTextTheme(
                          context,
                        ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: BauhausDesign.space4),
              child: Divider(
                color: BauhausDesign.neutral.withValues(alpha: 0.2),
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
            Divider(color: BauhausDesign.neutral.withValues(alpha: 0.2), height: 1),
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
                text: 'Family Access',
                icon: Icons.family_restroom_outlined,
                variant: BauhausActionVariant.warning,
                isSmall: true,
                isFullWidth: true,
                onPressed: () => _openFamilyAccess(client),
              ),
            ],
            if (!isHistoryMode && !client.isActivated) ...[
              SizedBox(height: BauhausDesign.space4),
              Divider(color: BauhausDesign.neutral.withValues(alpha: 0.2), height: 1),
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
        Icon(icon, size: 16, color: BauhausDesign.textMuted),
        SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(
              context,
            ).bodyMedium?.copyWith(color: BauhausDesign.textDark),
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
        const SnackBar(
          content: Text('Client ID is missing. Unable to open Family Access.'),
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
}
