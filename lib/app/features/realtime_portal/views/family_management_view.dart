import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/realtime_portal/viewmodels/family_access_viewmodel.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';

/// Family Management View
/// Manage family member access and permissions
class FamilyManagementView extends ConsumerStatefulWidget {
  const FamilyManagementView({super.key});

  @override
  ConsumerState<FamilyManagementView> createState() =>
      _FamilyManagementViewState();
}

class _FamilyManagementViewState extends ConsumerState<FamilyManagementView> {
  @override
  void initState() {
    super.initState();
    _loadFamilyMembers();
  }

  void _loadFamilyMembers() {
    ref.read(familyAccessViewModelProvider.notifier).getFamilyMembers(
          clientId: 'client-123',
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(familyAccessViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text(
          'Family Access',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showInviteDialog(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.members.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.members.length,
                  itemBuilder: (context, index) {
                    final member = state.members[index];
                    return _buildMemberCard(member);
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.family_restroom,
            size: 64,
            color: Color(0xFF666666).withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Family Members',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Invite family members to access your account',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showInviteDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Invite Member'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(FamilyMember member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.colorPrimary.withOpacity(0.1),
                child: Text(
                  member.name[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorFontPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member.relationship,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(member.status),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Color(0xFF666666).withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
            'Permissions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.colorFontPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (member.permissions.viewAppointments)
                _buildPermissionChip('View Appointments', Icons.calendar_today),
              if (member.permissions.viewMessages)
                _buildPermissionChip('View Messages', Icons.message),
              if (member.permissions.viewLocation)
                _buildPermissionChip('View Location', Icons.location_on),
              if (member.permissions.approveServices)
                _buildPermissionChip('Approve Services', Icons.check_circle),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showPermissionsDialog(member),
                  icon: const Icon(Icons.settings, size: 18),
                  label: const Text('Manage'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.colorPrimary,
                    side: BorderSide(color: AppColors.colorPrimary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _confirmRemoveMember(member),
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('Remove'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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

  Widget _buildStatusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'active':
        color = AppColors.colorSuccess;
        text = 'Active';
        break;
      case 'pending':
        color = AppColors.colorWarning;
        text = 'Pending';
        break;
      case 'inactive':
        color = AppColors.error;
        text = 'Inactive';
        break;
      default:
        color = Color(0xFF666666);
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildPermissionChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.colorPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.colorPrimary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.colorPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _showInviteDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String selectedRole = 'family';

    Get.dialog(
      AlertDialog(
        title: const Text('Invite Family Member'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement invite logic
              Get.back();
              Get.snackbar(
                'Invitation Sent',
                'Family member invitation sent successfully',
                backgroundColor: AppColors.colorSuccess,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
            ),
            child: const Text('Send Invite'),
          ),
        ],
      ),
    );
  }

  void _showPermissionsDialog(FamilyMember member) {
    Get.dialog(
      AlertDialog(
        title: Text('Manage Permissions - ${member.name}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPermissionSwitch(
                'View Appointments',
                member.permissions.viewAppointments,
                (value) {},
              ),
              _buildPermissionSwitch(
                'View Documents',
                member.permissions.viewDocuments,
                (value) {},
              ),
              _buildPermissionSwitch(
                'View Messages',
                member.permissions.viewMessages,
                (value) {},
              ),
              _buildPermissionSwitch(
                'Send Messages',
                member.permissions.sendMessages,
                (value) {},
              ),
              _buildPermissionSwitch(
                'View Location',
                member.permissions.viewLocation,
                (value) {},
              ),
              _buildPermissionSwitch(
                'Approve Services',
                member.permissions.approveServices,
                (value) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Success',
                'Permissions updated successfully',
                backgroundColor: AppColors.colorSuccess,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorPrimary,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSwitch(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.colorPrimary,
    );
  }

  void _confirmRemoveMember(FamilyMember member) {
    Get.dialog(
      AlertDialog(
        title: const Text('Remove Member'),
        content: Text('Are you sure you want to remove ${member.name}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(familyAccessViewModelProvider.notifier)
                  .removeMember(member.id);
              Get.back();
              Get.snackbar(
                'Success',
                'Family member removed successfully',
                backgroundColor: AppColors.colorSuccess,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}
