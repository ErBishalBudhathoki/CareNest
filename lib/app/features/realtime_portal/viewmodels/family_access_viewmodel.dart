import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:carenest/app/features/realtime_portal/repositories/realtime_portal_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

/// State for family access management
class FamilyAccessState {
  final bool isLoading;
  final String? error;
  final List<FamilyMember> members;
  final FamilyMember? selectedMember;
  final List<AccessAuditLog> auditLogs;
  final FamilyInvitation? pendingInvitation;
  final bool isInviting;

  FamilyAccessState({
    this.isLoading = false,
    this.error,
    this.members = const [],
    this.selectedMember,
    this.auditLogs = const [],
    this.pendingInvitation,
    this.isInviting = false,
  });

  FamilyAccessState copyWith({
    bool? isLoading,
    String? error,
    List<FamilyMember>? members,
    FamilyMember? selectedMember,
    List<AccessAuditLog>? auditLogs,
    FamilyInvitation? pendingInvitation,
    bool? isInviting,
  }) {
    return FamilyAccessState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      members: members ?? this.members,
      selectedMember: selectedMember ?? this.selectedMember,
      auditLogs: auditLogs ?? this.auditLogs,
      pendingInvitation: pendingInvitation ?? this.pendingInvitation,
      isInviting: isInviting ?? this.isInviting,
    );
  }
}

class FamilyAccessViewModel extends StateNotifier<FamilyAccessState> {
  final RealtimePortalRepository _repository;

  FamilyAccessViewModel(this._repository) : super(FamilyAccessState());

  String _cleanErrorMessage(Object error) {
    var message = error.toString().trim();
    while (message.startsWith('Exception: ')) {
      message = message.substring('Exception: '.length).trim();
    }
    return message;
  }

  /// Invite family member
  Future<void> inviteFamilyMember({
    required String clientId,
    required String invitedBy,
    required String email,
    required String name,
    required String role,
    required FamilyPermissions permissions,
    String? relationship,
  }) async {
    state = state.copyWith(isInviting: true, error: null);

    try {
      final invitation = await _repository.inviteFamilyMember(
        clientId: clientId,
        invitedBy: invitedBy,
        email: email,
        name: name,
        relationship: relationship ?? 'family',
        role: role,
        permissions: permissions,
      );

      state = state.copyWith(
        isInviting: false,
        pendingInvitation: invitation,
      );
    } catch (e) {
      debugPrint('Error inviting family member: $e');
      state = state.copyWith(
        isInviting: false,
        error: _cleanErrorMessage(e),
      );
    }
  }

  /// Get family members
  Future<void> getFamilyMembers({
    required String clientId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final members = await _repository.getFamilyMembers(
        clientId: clientId,
      );

      state = state.copyWith(
        isLoading: false,
        members: members,
      );
    } catch (e) {
      debugPrint('Error getting family members: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Update member permissions
  Future<void> updatePermissions({
    required String memberId,
    required String clientId,
    required String updatedBy,
    required FamilyPermissions permissions,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updatedMember = await _repository.updatePermissions(
        clientId: clientId,
        memberId: memberId,
        permissions: permissions,
        updatedBy: updatedBy,
      );

      // Update member in list
      final updatedMembers = state.members.map((member) {
        if (member.id == memberId) {
          return updatedMember;
        }
        return member;
      }).toList();

      state = state.copyWith(
        isLoading: false,
        members: updatedMembers,
        selectedMember: updatedMember,
      );
    } catch (e) {
      debugPrint('Error updating permissions: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> updateMemberStatus({
    required String memberId,
    required String clientId,
    required String status,
    String? updatedBy,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updatedMember = await _repository.updateFamilyMemberStatus(
        clientId: clientId,
        memberId: memberId,
        status: status,
        updatedBy: updatedBy,
      );

      final updatedMembers = state.members.map((member) {
        if (member.id == memberId) {
          return updatedMember;
        }
        return member;
      }).toList();

      state = state.copyWith(
        isLoading: false,
        members: updatedMembers,
        selectedMember: updatedMember,
      );
    } catch (e) {
      debugPrint('Error updating family member status: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Get access audit log
  Future<void> getAccessLog({
    required String clientId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final logs = await _repository.getAccessLog(
        clientId: clientId,
        startDate: startDate,
        endDate: endDate,
      );

      state = state.copyWith(
        isLoading: false,
        auditLogs: logs,
      );
    } catch (e) {
      debugPrint('Error getting access log: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Select member for detail view
  void selectMember(FamilyMember member) {
    state = state.copyWith(selectedMember: member);
  }

  /// Toggle permission
  void togglePermission(String memberId, String clientId, String updatedBy,
      String permissionName) {
    final member = state.members.firstWhere((m) => m.id == memberId);
    final currentPermissions = member.permissions;

    // Toggle the specific permission field
    FamilyPermissions updatedPermissions;
    switch (permissionName) {
      case 'viewAppointments':
        updatedPermissions = currentPermissions.copyWith(
          viewAppointments: !currentPermissions.viewAppointments,
        );
        break;
      case 'viewDocuments':
        updatedPermissions = currentPermissions.copyWith(
          viewDocuments: !currentPermissions.viewDocuments,
        );
        break;
      case 'viewInvoices':
        updatedPermissions = currentPermissions.copyWith(
          viewInvoices: !currentPermissions.viewInvoices,
        );
        break;
      case 'editProfile':
        updatedPermissions = currentPermissions.copyWith(
          editProfile: !currentPermissions.editProfile,
        );
        break;
      case 'approveServices':
        updatedPermissions = currentPermissions.copyWith(
          approveServices: !currentPermissions.approveServices,
        );
        break;
      case 'manageFamily':
        updatedPermissions = currentPermissions.copyWith(
          manageFamily: !currentPermissions.manageFamily,
        );
        break;
      case 'viewMessages':
        updatedPermissions = currentPermissions.copyWith(
          viewMessages: !currentPermissions.viewMessages,
        );
        break;
      case 'sendMessages':
        updatedPermissions = currentPermissions.copyWith(
          sendMessages: !currentPermissions.sendMessages,
        );
        break;
      case 'viewLocation':
        updatedPermissions = currentPermissions.copyWith(
          viewLocation: !currentPermissions.viewLocation,
        );
        break;
      case 'receiveNotifications':
        updatedPermissions = currentPermissions.copyWith(
          receiveNotifications: !currentPermissions.receiveNotifications,
        );
        break;
      default:
        return;
    }

    // Update in backend
    updatePermissions(
      memberId: memberId,
      clientId: clientId,
      updatedBy: updatedBy,
      permissions: updatedPermissions,
    );
  }

  /// Check if member has permission
  bool hasPermission(String memberId, String permissionName) {
    try {
      final member = state.members.firstWhere((m) => m.id == memberId);
      final permissions = member.permissions;

      switch (permissionName) {
        case 'viewAppointments':
          return permissions.viewAppointments;
        case 'viewDocuments':
          return permissions.viewDocuments;
        case 'viewInvoices':
          return permissions.viewInvoices;
        case 'editProfile':
          return permissions.editProfile;
        case 'approveServices':
          return permissions.approveServices;
        case 'manageFamily':
          return permissions.manageFamily;
        case 'viewMessages':
          return permissions.viewMessages;
        case 'sendMessages':
          return permissions.sendMessages;
        case 'viewLocation':
          return permissions.viewLocation;
        case 'receiveNotifications':
          return permissions.receiveNotifications;
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Get members by role
  List<FamilyMember> getMembersByRole(String role) {
    return state.members.where((member) => member.role == role).toList();
  }

  /// Get active members
  List<FamilyMember> getActiveMembers() {
    return state.members.where((member) => member.status == 'active').toList();
  }

  /// Clear pending invitation
  void clearPendingInvitation() {
    state = state.copyWith(pendingInvitation: null);
  }

  /// Reset state
  void reset() {
    state = FamilyAccessState();
  }
}

/// Provider for family access viewmodel
final familyAccessViewModelProvider =
    StateNotifierProvider<FamilyAccessViewModel, FamilyAccessState>((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  final repository = RealtimePortalRepository(apiMethod);
  return FamilyAccessViewModel(repository);
});
