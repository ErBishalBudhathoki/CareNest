import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/family_access_viewmodel.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyManagementView extends ConsumerStatefulWidget {
  final String? clientId;
  final String? clientName;

  const FamilyManagementView({
    super.key,
    this.clientId,
    this.clientName,
  });

  @override
  ConsumerState<FamilyManagementView> createState() =>
      _FamilyManagementViewState();
}

class _FamilyManagementViewState extends ConsumerState<FamilyManagementView> {
  String? get _resolvedClientId {
    final clientId = widget.clientId?.trim();
    if (clientId == null || clientId.isEmpty) return null;
    return clientId;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadFamilyMembers();
    });
  }

  Future<void> _loadFamilyMembers() async {
    final clientId = _resolvedClientId;
    if (clientId == null) {
      return;
    }

    await ref
        .read(familyAccessViewModelProvider.notifier)
        .getFamilyMembers(clientId: clientId);
  }

  bool _isFamilyActor(User user) {
    final tags = user.roles.map((role) => role.trim().toLowerCase()).toSet();
    return tags.contains('family');
  }

  bool _isClientOwner(User user) {
    final tags = user.roles.map((role) => role.trim().toLowerCase()).toSet();
    if (tags.contains('family')) return false;
    return tags.contains('client') || user.role == UserRole.client;
  }

  bool _canManageMembers(User? user, FamilyAccessState state) {
    if (user == null) return false;
    if (user.hasAdminAccess) return true;
    if (_isClientOwner(user)) return true;
    if (!_isFamilyActor(user)) return false;

    FamilyMember? actorMember;
    for (final member in state.members) {
      if (member.email.trim().toLowerCase() ==
          user.email.trim().toLowerCase()) {
        actorMember = member;
        break;
      }
    }

    return actorMember?.status == 'active' &&
        actorMember?.permissions.manageFamily == true;
  }

  String _relationshipLabel(String relationship) {
    if (relationship.trim().isEmpty) return 'Family';
    return relationship
        .trim()
        .split(RegExp(r'[\s_-]+'))
        .map((part) => part.isEmpty
            ? part
            : '${part[0].toUpperCase()}${part.substring(1).toLowerCase()}')
        .join(' ');
  }

  String _roleLabel(String role) {
    switch (role.trim().toLowerCase()) {
      case 'guardian':
        return 'Guardian';
      case 'viewer':
        return 'Viewer';
      default:
        return 'Family';
    }
  }

  FamilyPermissions _permissionsForRole(String role) {
    switch (role.trim().toLowerCase()) {
      case 'guardian':
        return const FamilyPermissions(
          viewAppointments: true,
          viewDocuments: true,
          viewInvoices: true,
          editProfile: true,
          approveServices: true,
          manageFamily: true,
          viewMessages: true,
          sendMessages: true,
          viewLocation: true,
          receiveNotifications: true,
        );
      case 'viewer':
        return const FamilyPermissions(
          viewAppointments: true,
          viewDocuments: false,
          viewInvoices: false,
          editProfile: false,
          approveServices: false,
          manageFamily: false,
          viewMessages: true,
          sendMessages: false,
          viewLocation: false,
          receiveNotifications: true,
        );
      default:
        return const FamilyPermissions(
          viewAppointments: true,
          viewDocuments: true,
          viewInvoices: true,
          editProfile: false,
          approveServices: false,
          manageFamily: false,
          viewMessages: true,
          sendMessages: true,
          viewLocation: true,
          receiveNotifications: true,
        );
    }
  }

  Future<String> _resolveActorEmail() async {
    final currentUser =
        await ref.read(currentUserProvider.future).catchError((_) {
      return null;
    });

    if (currentUser is User && currentUser.email.trim().isNotEmpty) {
      return currentUser.email.trim().toLowerCase();
    }

    final prefs = SharedPreferencesUtils();
    await prefs.init();
    return (prefs.getUserEmail() ?? 'unknown@carenest.local')
        .trim()
        .toLowerCase();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final normalized = status.trim().toLowerCase();
    late final Color background;
    late final Color foreground;
    late final String label;

    switch (normalized) {
      case 'active':
        background = BauhausDesign.success.withOpacity(0.14);
        foreground = BauhausDesign.success;
        label = 'Active';
        break;
      case 'inactive':
        background = BauhausDesign.error.withOpacity(0.14);
        foreground = BauhausDesign.error;
        label = 'Inactive';
        break;
      default:
        background = BauhausDesign.warning.withOpacity(0.14);
        foreground = BauhausDesign.warning;
        label = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
        border: Border.all(color: foreground.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _buildPermissionChip(String label, bool enabled) {
    final color = enabled ? BauhausDesign.primary : BauhausDesign.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space2,
      ),
      decoration: BoxDecoration(
        color: enabled
            ? BauhausDesign.primary.withOpacity(0.12)
            : BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusFull),
        border: Border.all(
          color: enabled
              ? BauhausDesign.primary.withOpacity(0.35)
              : BauhausDesign.neutral,
        ),
      ),
      child: Text(
        label,
        style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  List<Widget> _buildPermissionChips(FamilyPermissions permissions) {
    return [
      _buildPermissionChip('Appointments', permissions.viewAppointments),
      _buildPermissionChip('Documents', permissions.viewDocuments),
      _buildPermissionChip('Invoices', permissions.viewInvoices),
      _buildPermissionChip('Messages', permissions.viewMessages),
      _buildPermissionChip('Send Msg', permissions.sendMessages),
      _buildPermissionChip('Location', permissions.viewLocation),
      _buildPermissionChip('Approvals', permissions.approveServices),
      _buildPermissionChip('Manage Family', permissions.manageFamily),
      _buildPermissionChip('Alerts', permissions.receiveNotifications),
    ];
  }

  Future<void> _showInviteDialog() async {
    final clientId = _resolvedClientId;
    if (clientId == null) return;

    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    String selectedRelationship = 'guardian';
    String selectedRole = 'family';
    FamilyPermissions draftPermissions = _permissionsForRole(selectedRole);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          final inviteState = ref.watch(familyAccessViewModelProvider);

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              padding: const EdgeInsets.all(BauhausDesign.space5),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'INVITE FAMILY MEMBER',
                        style: BauhausDesign.getTextTheme(dialogContext)
                            .headlineMedium,
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        'Send a real account setup email so they can activate access with their own password.',
                        style: BauhausDesign.getTextTheme(dialogContext)
                            .bodyMedium
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                      const SizedBox(height: BauhausDesign.space5),
                      BauhausTextField(
                        controller: nameController,
                        label: 'Full Name',
                        hintText: 'Enter family member name',
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                                ? 'Name is required'
                                : null,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      BauhausTextField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter email address',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (email.isEmpty) return 'Email is required';
                          if (!email.contains('@'))
                            return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      _buildSelectField(
                        label: 'Relationship',
                        value: selectedRelationship,
                        items: const [
                          DropdownMenuItem(
                              value: 'guardian', child: Text('Guardian')),
                          DropdownMenuItem(
                              value: 'spouse', child: Text('Spouse')),
                          DropdownMenuItem(
                              value: 'parent', child: Text('Parent')),
                          DropdownMenuItem(
                              value: 'sibling', child: Text('Sibling')),
                          DropdownMenuItem(
                              value: 'child', child: Text('Child')),
                          DropdownMenuItem(
                              value: 'family', child: Text('Family')),
                          DropdownMenuItem(
                              value: 'other', child: Text('Other')),
                        ],
                        onChanged: (value) {
                          setDialogState(
                              () => selectedRelationship = value ?? 'family');
                        },
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      _buildSelectField(
                        label: 'Access Role',
                        value: selectedRole,
                        items: const [
                          DropdownMenuItem(
                              value: 'family', child: Text('Family')),
                          DropdownMenuItem(
                              value: 'guardian', child: Text('Guardian')),
                          DropdownMenuItem(
                              value: 'viewer', child: Text('Viewer')),
                        ],
                        onChanged: (value) {
                          setDialogState(() {
                            selectedRole = value ?? 'family';
                            draftPermissions =
                                _permissionsForRole(selectedRole);
                          });
                        },
                      ),
                      const SizedBox(height: BauhausDesign.space5),
                      Text(
                        'Permissions',
                        style: BauhausDesign.getTextTheme(dialogContext)
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      _buildPermissionToggleList(
                        permissions: draftPermissions,
                        onChanged: (nextPermissions) {
                          setDialogState(
                              () => draftPermissions = nextPermissions);
                        },
                      ),
                      const SizedBox(height: BauhausDesign.space5),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final isCompact = constraints.maxWidth < 420;
                          final buttonWidth =
                              isCompact ? double.infinity : 168.0;

                          final cancelButton = SizedBox(
                            width: buttonWidth,
                            child: BauhausActionButton(
                              text: 'Cancel',
                              backgroundColor: BauhausDesign.surfaceOffWhite,
                              textColor: BauhausDesign.textDark,
                              isFullWidth: true,
                              isSmall: true,
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                            ),
                          );

                          final sendInviteButton = SizedBox(
                            width: buttonWidth,
                            child: BauhausActionButton(
                              text: inviteState.isInviting
                                  ? 'Sending...'
                                  : 'Send Invite',
                              icon: inviteState.isInviting
                                  ? null
                                  : Icons.send_rounded,
                              variant: BauhausActionVariant.warning,
                              isFullWidth: true,
                              isSmall: true,
                              isLoading: inviteState.isInviting,
                              onPressed: inviteState.isInviting
                                  ? null
                                  : () async {
                                      if (!(formKey.currentState?.validate() ??
                                          false)) {
                                        return;
                                      }

                                      final actorEmail =
                                          await _resolveActorEmail();
                                      await ref
                                          .read(familyAccessViewModelProvider
                                              .notifier)
                                          .inviteFamilyMember(
                                            clientId: clientId,
                                            invitedBy: actorEmail,
                                            email: emailController.text.trim(),
                                            name: nameController.text.trim(),
                                            relationship: selectedRelationship,
                                            role: selectedRole,
                                            permissions: draftPermissions,
                                          );

                                      final updatedState = ref
                                          .read(familyAccessViewModelProvider);
                                      if (updatedState.error != null) {
                                        _showSnackBar(
                                          updatedState.error!,
                                          isError: true,
                                        );
                                        return;
                                      }

                                      if (!mounted) return;
                                      Navigator.of(dialogContext).pop();
                                      await _loadFamilyMembers();
                                      _showSnackBar(
                                        'Invitation sent to ${emailController.text.trim()}',
                                      );
                                    },
                            ),
                          );

                          if (isCompact) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                cancelButton,
                                const SizedBox(height: BauhausDesign.space4),
                                sendInviteButton,
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(child: cancelButton),
                              const SizedBox(width: BauhausDesign.space4),
                              Expanded(child: sendInviteButton),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectField({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: BauhausDesign.inputDecoration(''),
        ),
      ],
    );
  }

  Widget _buildPermissionToggleList({
    required FamilyPermissions permissions,
    required ValueChanged<FamilyPermissions> onChanged,
  }) {
    Widget tile(String label, bool value, FamilyPermissions nextValue) {
      return SwitchListTile.adaptive(
        contentPadding: EdgeInsets.zero,
        dense: true,
        title: Text(
          label,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        value: value,
        activeColor: BauhausDesign.primary,
        onChanged: (_) => onChanged(nextValue),
      );
    }

    return Column(
      children: [
        tile(
          'View appointments',
          permissions.viewAppointments,
          permissions.copyWith(
            viewAppointments: !permissions.viewAppointments,
          ),
        ),
        tile(
          'View documents',
          permissions.viewDocuments,
          permissions.copyWith(
            viewDocuments: !permissions.viewDocuments,
          ),
        ),
        tile(
          'View invoices',
          permissions.viewInvoices,
          permissions.copyWith(
            viewInvoices: !permissions.viewInvoices,
          ),
        ),
        tile(
          'View messages',
          permissions.viewMessages,
          permissions.copyWith(
            viewMessages: !permissions.viewMessages,
          ),
        ),
        tile(
          'Send messages',
          permissions.sendMessages,
          permissions.copyWith(
            sendMessages: !permissions.sendMessages,
          ),
        ),
        tile(
          'View live location',
          permissions.viewLocation,
          permissions.copyWith(
            viewLocation: !permissions.viewLocation,
          ),
        ),
        tile(
          'Approve services',
          permissions.approveServices,
          permissions.copyWith(
            approveServices: !permissions.approveServices,
          ),
        ),
        tile(
          'Manage family access',
          permissions.manageFamily,
          permissions.copyWith(
            manageFamily: !permissions.manageFamily,
          ),
        ),
        tile(
          'Receive notifications',
          permissions.receiveNotifications,
          permissions.copyWith(
            receiveNotifications: !permissions.receiveNotifications,
          ),
        ),
      ],
    );
  }

  Future<void> _showPermissionsDialog(FamilyMember member) async {
    final clientId = _resolvedClientId;
    if (clientId == null) return;

    FamilyPermissions draftPermissions = member.permissions;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              padding: const EdgeInsets.all(BauhausDesign.space5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'MANAGE PERMISSIONS',
                    style: BauhausDesign.getTextTheme(dialogContext)
                        .headlineMedium,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  Text(
                    '${member.name} can only do what is explicitly enabled here.',
                    style: BauhausDesign.getTextTheme(dialogContext)
                        .bodyMedium
                        ?.copyWith(color: BauhausDesign.textMuted),
                  ),
                  const SizedBox(height: BauhausDesign.space5),
                  Flexible(
                    child: SingleChildScrollView(
                      child: _buildPermissionToggleList(
                        permissions: draftPermissions,
                        onChanged: (nextPermissions) {
                          setDialogState(
                              () => draftPermissions = nextPermissions);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space5),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final saveButton = BauhausActionButton(
                        text: 'Save',
                        icon: Icons.save_outlined,
                        variant: BauhausActionVariant.secondary,
                        onPressed: () async {
                          final actorEmail = await _resolveActorEmail();
                          await ref
                              .read(familyAccessViewModelProvider.notifier)
                              .updatePermissions(
                                memberId: member.id,
                                clientId: clientId,
                                updatedBy: actorEmail,
                                permissions: draftPermissions,
                              );

                          final updatedState =
                              ref.read(familyAccessViewModelProvider);
                          if (updatedState.error != null) {
                            _showSnackBar(
                              updatedState.error!,
                              isError: true,
                            );
                            return;
                          }

                          if (!mounted) return;
                          Navigator.of(dialogContext).pop();
                          _showSnackBar(
                              'Permissions updated for ${member.name}');
                        },
                      );

                      if (constraints.maxWidth < 420) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.neutral,
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                            ),
                            const SizedBox(height: BauhausDesign.space3),
                            saveButton,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.neutral,
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(child: saveButton),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmStatusChange(
      FamilyMember member, String nextStatus) async {
    final clientId = _resolvedClientId;
    if (clientId == null) return;

    final isDeactivate = nextStatus == 'inactive';
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 560),
              decoration: BoxDecoration(
                color: BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(color: BauhausDesign.neutral, width: 2),
                boxShadow: const [BauhausDesign.shadowHard],
              ),
              padding: const EdgeInsets.all(BauhausDesign.space5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isDeactivate ? 'DEACTIVATE ACCESS' : 'REACTIVATE ACCESS',
                    style: BauhausDesign.getTextTheme(dialogContext)
                        .headlineMedium,
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  Text(
                    isDeactivate
                        ? 'This will immediately stop ${member.name} from using their family access account.'
                        : 'This will re-enable ${member.name}\'s family access account.',
                    style: BauhausDesign.getTextTheme(dialogContext)
                        .bodyMedium
                        ?.copyWith(color: BauhausDesign.textMuted),
                  ),
                  const SizedBox(height: BauhausDesign.space5),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final confirmButton = BauhausActionButton(
                        text: isDeactivate ? 'Deactivate' : 'Reactivate',
                        icon: isDeactivate
                            ? Icons.block_rounded
                            : Icons.restart_alt_rounded,
                        variant: isDeactivate
                            ? BauhausActionVariant.error
                            : BauhausActionVariant.success,
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                      );

                      if (constraints.maxWidth < 420) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.neutral,
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                            ),
                            const SizedBox(height: BauhausDesign.space3),
                            confirmButton,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.neutral,
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(child: confirmButton),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;

    if (!confirmed) return;

    final actorEmail = await _resolveActorEmail();
    await ref.read(familyAccessViewModelProvider.notifier).updateMemberStatus(
          memberId: member.id,
          clientId: clientId,
          status: nextStatus,
          updatedBy: actorEmail,
        );

    final updatedState = ref.read(familyAccessViewModelProvider);
    if (updatedState.error != null) {
      _showSnackBar(updatedState.error!, isError: true);
      return;
    }

    _showSnackBar(
      nextStatus == 'inactive'
          ? '${member.name} has been deactivated'
          : '${member.name} has been reactivated',
    );
  }

  Widget _buildHeroCard(FamilyAccessState state, bool canManageMembers) {
    final activeCount =
        state.members.where((member) => member.status == 'active').length;
    final pendingCount =
        state.members.where((member) => member.status == 'pending').length;
    final inactiveCount =
        state.members.where((member) => member.status == 'inactive').length;

    return BauhausCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.warning.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.warning.withOpacity(0.35),
                  ),
                ),
                child: const Icon(
                  Icons.family_restroom_outlined,
                  color: BauhausDesign.warning,
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keep families informed without losing control',
                      style: BauhausDesign.getTextTheme(context).headlineMedium,
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      'Every invite, permission change, activation, deactivation, and reactivation is stored in MongoDB and protected by authenticated access rules.',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: [
              _buildPermissionChip('Active $activeCount', true),
              _buildPermissionChip('Pending $pendingCount', pendingCount > 0),
              _buildPermissionChip(
                  'Inactive $inactiveCount', inactiveCount > 0),
              _buildPermissionChip(
                canManageMembers ? 'Manage Enabled' : 'View Only',
                canManageMembers,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(FamilyMember member,
      {required bool canManageMembers}) {
    final isInactive = member.status == 'inactive';
    final isPending = member.status == 'pending';

    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: BauhausDesign.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(
                    color: BauhausDesign.primary.withOpacity(0.25),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  member.name.isEmpty ? '?' : member.name[0].toUpperCase(),
                  style: BauhausDesign.getTextTheme(context)
                      .headlineMedium
                      ?.copyWith(
                        color: BauhausDesign.primary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: BauhausDesign.getTextTheme(context).titleLarge,
                    ),
                    const SizedBox(height: BauhausDesign.space1),
                    Text(
                      '${_relationshipLabel(member.relationship)} • ${_roleLabel(member.role)}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(color: BauhausDesign.textMuted),
                    ),
                    const SizedBox(height: BauhausDesign.space2),
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      text: member.email,
                    ),
                    if (member.updatedAt != null) ...[
                      const SizedBox(height: BauhausDesign.space1),
                      _buildInfoRow(
                        icon: Icons.history_toggle_off_rounded,
                        text:
                            'Updated ${member.updatedAt!.toLocal().toString().substring(0, 16)}',
                      ),
                    ],
                  ],
                ),
              ),
              _buildStatusBadge(member.status),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          Divider(color: BauhausDesign.neutral.withOpacity(0.25), height: 1),
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Permissions',
            style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Wrap(
            spacing: BauhausDesign.space2,
            runSpacing: BauhausDesign.space2,
            children: _buildPermissionChips(member.permissions),
          ),
          if (canManageMembers) ...[
            const SizedBox(height: BauhausDesign.space5),
            Row(
              children: [
                Expanded(
                  child: BauhausActionButton(
                    text: 'Manage Permissions',
                    icon: Icons.tune_rounded,
                    variant: BauhausActionVariant.secondary,
                    isSmall: true,
                    onPressed: () => _showPermissionsDialog(member),
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: BauhausActionButton(
                    text: isInactive
                        ? 'Reactivate'
                        : (isPending
                            ? 'Deactivate Invite'
                            : 'Deactivate Access'),
                    icon: isInactive
                        ? Icons.restart_alt_rounded
                        : Icons.block_rounded,
                    variant: isInactive
                        ? BauhausActionVariant.success
                        : BauhausActionVariant.error,
                    isSmall: true,
                    onPressed: () => _confirmStatusChange(
                      member,
                      isInactive ? 'active' : 'inactive',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: BauhausDesign.textMuted),
        const SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodyMedium,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(familyAccessViewModelProvider);
    final currentUser = ref.watch(currentUserProvider).valueOrNull;
    final canManageMembers = _canManageMembers(currentUser, state);
    final clientId = _resolvedClientId;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Family Access',
              style: BauhausDesign.getTextTheme(context)
                  .titleLarge
                  ?.copyWith(color: BauhausDesign.textDark),
            ),
            if ((widget.clientName ?? '').trim().isNotEmpty)
              Text(
                widget.clientName!.trim(),
                style: BauhausDesign.getTextTheme(context)
                    .bodySmall
                    ?.copyWith(color: BauhausDesign.textMuted),
              ),
          ],
        ),
        actions: [
          if (clientId != null && canManageMembers)
            Padding(
              padding: const EdgeInsets.only(right: BauhausDesign.space3),
              child: Center(
                child: BauhausIconButton(
                  icon: Icons.person_add_alt_1_rounded,
                  variant: BauhausActionVariant.warning,
                  onPressed: _showInviteDialog,
                  tooltip: 'Invite family member',
                ),
              ),
            ),
        ],
      ),
      body: clientId == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space6),
                child: BauhausEmptyState(
                  title: 'Client Context Required',
                  subtitle:
                      'Open Family Access from a specific client so the right records can be loaded.',
                  icon: Icons.person_search_rounded,
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadFamilyMembers,
              child: ListView(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                children: [
                  _buildHeroCard(state, canManageMembers),
                  const SizedBox(height: BauhausDesign.space4),
                  if (state.error != null) ...[
                    BauhausCard(
                      borderColor: BauhausDesign.error,
                      backgroundColor: BauhausDesign.error.withOpacity(0.08),
                      child: Text(
                        state.error!,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                              color: BauhausDesign.error,
                            ),
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                  ],
                  if (state.isLoading && state.members.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(BauhausDesign.space8),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.members.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: BauhausDesign.space8),
                      child: BauhausEmptyState(
                        title: 'No Family Members Yet',
                        subtitle: canManageMembers
                            ? 'Invite a family member to give them controlled access to appointments, messages, approvals, and live updates.'
                            : 'No family members have access for this client yet.',
                        icon: Icons.family_restroom_rounded,
                        actionLabel:
                            canManageMembers ? 'Invite Family Member' : null,
                        onAction: canManageMembers ? _showInviteDialog : null,
                      ),
                    )
                  else
                    ...state.members.map(
                      (member) => _buildMemberCard(
                        member,
                        canManageMembers: canManageMembers,
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
