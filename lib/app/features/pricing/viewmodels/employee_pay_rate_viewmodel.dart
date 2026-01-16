import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/backend/api_method.dart';

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

class EmployeePayRateViewModel extends StateNotifier<EmployeePayRateState> {
  final ApiMethod _apiMethod;
  final String organizationId;

  EmployeePayRateViewModel(this._apiMethod, this.organizationId)
      : super(EmployeePayRateState()) {
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    state = EmployeePayRateState(isLoading: true);
    try {
      final response = await _apiMethod.getOrganizationEmployees(organizationId);
      if (response['success'] == true) {
        final List<dynamic> data = response['employees'];
        final employees = data.map((e) => User.fromJson(e)).toList();
        state = EmployeePayRateState(employees: employees, isLoading: false);
      } else {
        state = EmployeePayRateState(
            isLoading: false, error: response['message'] ?? 'Failed to load employees');
      }
    } catch (e) {
      state = EmployeePayRateState(isLoading: false, error: e.toString());
    }
  }
}

final employeePayRateViewModelProvider = StateNotifierProvider.family<
    EmployeePayRateViewModel, EmployeePayRateState, String>((ref, organizationId) {
  return EmployeePayRateViewModel(ApiMethod(), organizationId);
});
