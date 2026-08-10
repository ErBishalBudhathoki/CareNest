import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/family_access_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/client/providers/client_provider.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class AdminFamilyManagementView extends ConsumerStatefulWidget {
  final String clientId;

  const AdminFamilyManagementView({super.key, required this.clientId});

  @override
  ConsumerState<AdminFamilyManagementView> createState() =>
      _AdminFamilyManagementViewState();
}

class _AdminFamilyManagementViewState
    extends ConsumerState<AdminFamilyManagementView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _selectedRelation = 'relative';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(familyAccessViewModelProvider.notifier)
          .getFamilyMembers(clientId: widget.clientId);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(familyAccessViewModelProvider);
    final textTheme = BauhausDesign.getTextTheme(context);
    final clientState = ref.watch(clientProvider);
    final client = clientState.clients.firstWhere(
      (c) => c.id == widget.clientId,
      orElse: () => clientState.clients.first,
    );

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.warning,
        title: Text(
          'FAMILY ADMINISTRATION',
          style: textTheme.headlineMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildClientHeader(client),
          Expanded(
            child: state.isLoading
                ? const Center(child: BauhausLoadingState())
                : _buildMembersList(state),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: BauhausDesign.textDark,
        onPressed: () => _showAddMemberDialog(),
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: const Text(
          'ADD MEMBER',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildClientHeader(dynamic client) {
    final textTheme = BauhausDesign.getTextTheme(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Managing Access For:',
            style: textTheme.labelSmall?.copyWith(
              color: BauhausDesign.textDark.withValues(alpha: 0.6),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            client.displayName,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: BauhausDesign.primary,
            ),
          ),
          Text(
            client.clientEmail,
            style: textTheme.bodySmall?.copyWith(color: BauhausDesign.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList(FamilyAccessState state) {
    if (state.members.isEmpty) {
      return Center(
        child: BauhausEmptyState(
          title: 'No Family Members',
          message: 'This client has no family members linked yet.',
          icon: Icons.family_restroom_rounded,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: state.members.length,
      separatorBuilder: (_, _) => const SizedBox(height: BauhausDesign.space3),
      itemBuilder: (context, index) {
        final member = state.members[index];
        return Container(
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 1.5),
            boxShadow: const [BauhausDesign.shadowHardSm],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(
              member.name.isNotEmpty ? member.name : member.email,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: BauhausDesign.textDark,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (member.name.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    member.email,
                    style: TextStyle(
                      color: BauhausDesign.textDark.withValues(alpha: 0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildBadge(
                      member.relationship.toUpperCase(),
                      BauhausDesign.secondary,
                    ),
                    const SizedBox(width: 8),
                    _buildBadge(
                      member.status.toUpperCase(),
                      member.status == 'active'
                          ? BauhausDesign.success
                          : BauhausDesign.warning,
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: BauhausDesign.error,
              ),
              onPressed: () => _confirmRemoveMember(member),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        ),
        title: const Text(
          'ADD FAMILY MEMBER',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedRelation,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
              items: ['relative', 'guardian', 'friend', 'other']
                  .map(
                    (r) => DropdownMenuItem(
                      value: r,
                      child: Text(r.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedRelation = val!),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.primary,
            ),
            onPressed: () {
              if (_emailController.text.isNotEmpty &&
                  _nameController.text.isNotEmpty) {
                final prefs = ref.read(app_providers.sharedPreferencesProvider);
                final invitedBy = prefs.getUserEmail() ?? 'admin@system.com';

                ref
                    .read(familyAccessViewModelProvider.notifier)
                    .inviteFamilyMember(
                      clientId: widget.clientId,
                      invitedBy: invitedBy,
                      email: _emailController.text,
                      name: _nameController.text,
                      role: 'family',
                      relationship: _selectedRelation,
                      permissions: const FamilyPermissions(
                        viewAppointments: true,
                        viewDocuments: true,
                        viewInvoices: true,
                        editProfile: false,
                        approveServices: true,
                        manageFamily: false,
                        viewMessages: true,
                        sendMessages: true,
                        viewLocation: true,
                        receiveNotifications: true,
                      ),
                    );
                _emailController.clear();
                _nameController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text(
              'INVITE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmRemoveMember(FamilyMember member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'REMOVE MEMBER?',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Text(
          'Are you sure you want to remove access for ${member.email}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(familyAccessViewModelProvider.notifier)
                  .updateMemberStatus(
                    clientId: widget.clientId,
                    memberId: member.id,
                    status: 'removed',
                  );
              Navigator.pop(context);
            },
            child: const Text(
              'REMOVE',
              style: TextStyle(
                color: BauhausDesign.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
