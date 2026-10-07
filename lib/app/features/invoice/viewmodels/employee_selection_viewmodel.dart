import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/employee_selection_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class EmployeeSelectionViewModel extends Notifier<EmployeeSelectionState> {
  final String organizationId;
  late ApiMethod _apiMethod;

  EmployeeSelectionViewModel(this.organizationId);

  @override
  EmployeeSelectionState build() {
    _apiMethod = ref.watch(app_providers.apiMethodProvider);
    return EmployeeSelectionState();
  }

  /// Fetch employees for the organization
  Future<void> fetchEmployees() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');

      final response = await _apiMethod.getOrganizationEmployees(
        organizationId,
      );

      if (response['success'] == true && response['employees'] != null) {
        final List<dynamic> employeesData = response['employees'];
        final List<EmployeeSelectionModel> employees = employeesData.map((
          employee,
        ) {
          return EmployeeSelectionModel(
            id: employee['_id']?.toString() ?? '',
            email: employee['email'] ?? '',
            name:
                '${employee['firstName'] ?? ''} ${employee['lastName'] ?? ''}'
                    .trim()
                    .isEmpty
                ? employee['email'] ?? 'Unknown'
                : '${employee['firstName'] ?? ''} ${employee['lastName'] ?? ''}'
                      .trim(),
            photoUrl: employee['photoUrl'],
          );
        }).toList();

        state = state.copyWith(employees: employees, isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response['message'] ?? 'Failed to load employees',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading employees: $e',
      );
    }
  }

  /// Resolves a client's display name from an assignment row.
  ///
  /// `getUserAssignments` returns the assignment fields plus a joined
  /// `clientDetails` object. It has never carried a `clientName` field, so
  /// reading only `assignment['clientName']` left the name null and fell
  /// through to the email, which is why both the heading and the subtitle
  /// rendered the address. Prefer an explicit name, then the joined
  /// first/last pair, then business name, and only then the email.
  @visibleForTesting
  static String resolveClientName(Map<String, dynamic> assignment) {
    var email = assignment['clientEmail']?.toString() ?? '';

    final direct = assignment['clientName']?.toString() ?? '';
    if (direct.trim().isNotEmpty) return direct.trim();

    // The backend $unwinds the lookup, so clientDetails can arrive as a Map or
    // as a single-element List depending on driver/version.
    Map<String, dynamic>? details;
    final raw = assignment['clientDetails'];
    if (raw is Map) {
      details = Map<String, dynamic>.from(raw);
    } else if (raw is List && raw.isNotEmpty && raw.first is Map) {
      details = Map<String, dynamic>.from(raw.first as Map);
    }

    // Prefer the joined address when the assignment itself did not carry one.
    if (email.isEmpty && details != null) {
      email = details['clientEmail']?.toString() ?? '';
    }

    if (details != null) {
      final joined = details['clientName']?.toString() ?? '';
      if (joined.trim().isNotEmpty) return joined.trim();

      final full = [
        details['clientFirstName']?.toString() ?? '',
        details['clientLastName']?.toString() ?? '',
      ].join(' ').trim();
      if (full.isNotEmpty) return full;
    }

    // Some payloads flatten the client fields onto the assignment itself.
    final flat = [
      assignment['clientFirstName']?.toString() ?? '',
      assignment['clientLastName']?.toString() ?? '',
    ].join(' ').trim();
    if (flat.isNotEmpty) return flat;

    final business = assignment['businessName']?.toString().trim() ?? '';
    if (business.isNotEmpty) return business;

    return email.isEmpty ? 'Unknown' : email;
  }

  /// Toggle employee selection
  void toggleEmployeeSelection(String employeeId) {
    final updatedEmployees = state.employees.map((employee) {
      if (employee.id == employeeId) {
        return employee.copyWith(isSelected: !employee.isSelected);
      }
      return employee;
    }).toList();

    state = state.copyWith(employees: updatedEmployees);
  }

  /// Fetch clients for a selected employee
  Future<void> fetchClientsForEmployee(String employeeEmail) async {
    try {
      // Set loading state for specific employee only
      final updatedEmployeesLoading = state.employees.map((employee) {
        if (employee.email == employeeEmail) {
          return employee.copyWith(isLoadingClients: true);
        }
        return employee;
      }).toList();

      state = state.copyWith(
        employees: updatedEmployeesLoading,
        errorMessage: '',
      );

      final response = await _apiMethod.getUserAssignments(employeeEmail);

      if (response['success'] == true && response['assignments'] != null) {
        final List<dynamic> assignmentsData = response['assignments'];
        final List<ClientModel> clients = assignmentsData.map((assignment) {
          final email = assignment['clientEmail']?.toString() ?? '';
          return ClientModel(
            id: assignment['clientId']?.toString() ?? '',
            email: email,
            name: resolveClientName(assignment),
          );
        }).toList();

        // Update the employee with their clients and stop loading
        final updatedEmployees = state.employees.map((employee) {
          if (employee.email == employeeEmail) {
            return employee.copyWith(
              clients: clients,
              isLoadingClients: false,
              hasLoadedClients: true,
            );
          }
          return employee;
        }).toList();

        state = state.copyWith(employees: updatedEmployees);
      } else {
        // Stop loading for this employee and mark as loaded (even if no clients)
        final updatedEmployees = state.employees.map((employee) {
          if (employee.email == employeeEmail) {
            return employee.copyWith(
              isLoadingClients: false,
              hasLoadedClients: true,
            );
          }
          return employee;
        }).toList();

        state = state.copyWith(
          employees: updatedEmployees,
          errorMessage:
              response['message'] ?? 'No clients found for this employee',
        );
      }
    } catch (e) {
      // Stop loading for this employee on error
      final updatedEmployees = state.employees.map((employee) {
        if (employee.email == employeeEmail) {
          return employee.copyWith(
            isLoadingClients: false,
            hasLoadedClients: true,
          );
        }
        return employee;
      }).toList();

      state = state.copyWith(
        employees: updatedEmployees,
        errorMessage: 'Error loading clients: $e',
      );
    }
  }

  /// Toggle client selection for an employee
  void toggleClientSelection(String employeeEmail, String clientId) {
    final updatedEmployees = state.employees.map((employee) {
      if (employee.email == employeeEmail) {
        final updatedClients = employee.clients.map((client) {
          if (client.id == clientId) {
            return client.copyWith(isSelected: !client.isSelected);
          }
          return client;
        }).toList();
        return employee.copyWith(clients: updatedClients);
      }
      return employee;
    }).toList();

    state = state.copyWith(employees: updatedEmployees);
  }

  /// Get selected employees and clients
  List<Map<String, dynamic>> getSelectedEmployeesAndClients() {
    final List<Map<String, dynamic>> result = [];

    for (final employee in state.employees) {
      if (employee.isSelected) {
        final selectedClients = employee.clients
            .where((client) => client.isSelected)
            .map(
              (client) => {
                'id': client.id,
                'email': client.email,
                'name': client.name,
                'organizationId':
                    organizationId, // Include organizationId in each client
              },
            )
            .toList();

        if (selectedClients.isNotEmpty) {
          result.add({
            'employee': {
              'id': employee.id,
              'email': employee.email,
              'name': employee.name,
            },
            'clients': selectedClients,
            'organizationId':
                organizationId, // Include organizationId at the top level
          });
        }
      }
    }

    return result;
  }

  /// Clear error message
  void clearErrorMessage() {
    state = state.copyWith(errorMessage: '');
  }
}

/// State class for EmployeeSelectionViewModel
class EmployeeSelectionState {
  final bool isLoading;
  final String errorMessage;
  final List<EmployeeSelectionModel> employees;

  EmployeeSelectionState({
    this.isLoading = false,
    this.errorMessage = '',
    this.employees = const [],
  });

  EmployeeSelectionState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<EmployeeSelectionModel>? employees,
  }) {
    return EmployeeSelectionState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      employees: employees ?? this.employees,
    );
  }
}

/// Provider for EmployeeSelectionViewModel
final employeeSelectionViewModelProvider =
    NotifierProvider.family<
      EmployeeSelectionViewModel,
      EmployeeSelectionState,
      String
    >(EmployeeSelectionViewModel.new);
