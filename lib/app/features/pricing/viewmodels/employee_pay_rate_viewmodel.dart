import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class EmployeePayRateState {
  final bool isLoading;
  final String? error;
  final List<User> employees;

  EmployeePayRateState({
    this.isLoading = false,
    this.error,
    this.employees = const [],
  });
}

class EmployeePayRateViewModel extends Notifier<EmployeePayRateState> {
  EmployeePayRateViewModel(this.organizationId);
  final String organizationId;
  late final ApiMethod _apiMethod;

  @override
  EmployeePayRateState build() {
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    return EmployeePayRateState();
  }

  Future<void> fetchEmployees({bool showLoading = true}) async {
    if (showLoading) {
      state = EmployeePayRateState(
        isLoading: true,
        employees: state.employees,
      );
    }
    try {
      final response =
          await _apiMethod.getOrganizationEmployees(organizationId);
      if (response['success'] == true) {
        final List<dynamic> data =
            response['employees'] as List<dynamic>? ?? [];
        final employees = data
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .where(_isEmployeeRecord)
            .map((e) => User.fromJson(e))
            .toList()
          ..sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        state = EmployeePayRateState(employees: employees, isLoading: false);
      } else {
        state = EmployeePayRateState(
            isLoading: false,
            error: response['message'] ?? 'Failed to load employees');
      }
    } catch (e) {
      state = EmployeePayRateState(isLoading: false, error: e.toString());
    }
  }

  bool _isEmployeeRecord(Map<String, dynamic> user) {
    final roleTags = <String>{};

    final role = user['role']?.toString().toLowerCase().trim();
    if (role != null && role.isNotEmpty) roleTags.add(role);

    final orgRole = user['organizationRole']?.toString().toLowerCase().trim();
    if (orgRole != null && orgRole.isNotEmpty) roleTags.add(orgRole);

    final roles = user['roles'];
    if (roles is List) {
      for (final entry in roles) {
        final tag = entry.toString().toLowerCase().trim();
        if (tag.isNotEmpty) roleTags.add(tag);
      }
    }

    final clientId = user['clientId']?.toString().trim();
    if (clientId != null && clientId.isNotEmpty) {
      return false;
    }

    if (roleTags.contains('client') || roleTags.contains('family')) {
      return false;
    }

    return true;
  }
}

final employeePayRateViewModelProvider = NotifierProvider.family<EmployeePayRateViewModel, EmployeePayRateState, String>(EmployeePayRateViewModel.new);
