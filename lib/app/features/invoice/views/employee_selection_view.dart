import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/employee_selection_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_components.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';

class EmployeeSelectionView extends ConsumerStatefulWidget {
  final String email;
  final String? organizationId;
  final String? organizationName;

  const EmployeeSelectionView({
    Key? key,
    required this.email,
    this.organizationId,
    this.organizationName,
  }) : super(key: key);

  @override
  ConsumerState<EmployeeSelectionView> createState() =>
      _EmployeeSelectionViewState();
}

class _EmployeeSelectionViewState extends ConsumerState<EmployeeSelectionView> {
  @override
  void initState() {
    super.initState();
    // Fetch employees when the view is initialized
    if (widget.organizationId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(employeeSelectionViewModelProvider(widget.organizationId!)
                .notifier)
            .fetchEmployees();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref
        .watch(employeeSelectionViewModelProvider(widget.organizationId ?? ''));

    // Show error messages in snackbar if employees are already loaded
    if (state.errorMessage.isNotEmpty && state.employees.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 3),
          ),
        );
        // Clear the error message after showing
        ref
            .read(
                employeeSelectionViewModelProvider(widget.organizationId ?? '')
                    .notifier)
            .clearErrorMessage();
      });
    }

    return Scaffold(
      backgroundColor: ModernSaasDesign.background,
      appBar: AppBar(
        title: Text(
          'Select Employees & Clients',
          style: ModernSaasDesign.headlineMedium.copyWith(
            color: ModernSaasDesign.textOnPrimary,
          ),
        ),
        backgroundColor: ModernSaasDesign.primary,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: ModernSaasDesign.textOnPrimary,
        ),
      ),
      body: state.isLoading && state.employees.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ModernSaasDesign.primary),
                  ),
                  SizedBox(height: ModernSaasDesign.space4),
                  Text(
                    'Loading employees and clients...',
                    style: ModernSaasDesign.bodyMedium,
                  ),
                ],
              ),
            )
          : state.errorMessage.isNotEmpty && state.employees.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: ModernSaasDesign.error,
                        size: 64,
                      ),
                      SizedBox(height: ModernSaasDesign.space4),
                      Text(
                        'Error Loading Employees',
                        style: ModernSaasDesign.headlineSmall.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                      SizedBox(height: ModernSaasDesign.space2),
                      Text(
                        state.errorMessage,
                        style: ModernSaasDesign.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : state.employees.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            color: ModernSaasDesign.textSecondary,
                            size: 64,
                          ),
                          SizedBox(height: ModernSaasDesign.space4),
                          Text(
                            'No Employees Found',
                            style: ModernSaasDesign.headlineSmall,
                          ),
                          SizedBox(height: ModernSaasDesign.space2),
                          Text(
                            'There are no employees available to select for invoice generation.',
                            style: ModernSaasDesign.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : _buildEmployeeList(state),
      bottomNavigationBar: _buildBottomBar(state),
    );
  }

  Widget _buildEmployeeList(EmployeeSelectionState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      itemCount: state.employees.length,
      itemBuilder: (context, index) {
        final employee = state.employees[index];
        return _buildEmployeeCard(employee);
      },
    );
  }

  Widget _buildEmployeeCard(EmployeeSelectionModel employee) {
    return Card(
      margin: const EdgeInsets.only(bottom: ModernSaasDesign.space2),
      elevation: 0,
      color: ModernSaasDesign.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
        side: BorderSide(
          color: ModernSaasDesign.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Employee header with checkbox
          ListTile(
            leading: CircleAvatar(
              backgroundColor: ModernSaasDesign.primary,
              child: Text(
                employee.name.isNotEmpty ? employee.name[0].toUpperCase() : 'U',
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              employee.name,
              style: ModernSaasDesign.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: ModernSaasDesign.textPrimary,
              ),
            ),
            subtitle: Text(
              employee.email,
              style: ModernSaasDesign.bodySmall.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
            ),
            trailing: Checkbox(
              value: employee.isSelected,
              activeColor: ModernSaasDesign.primary,
              onChanged: (value) {
                ref
                    .read(employeeSelectionViewModelProvider(
                            widget.organizationId ?? '')
                        .notifier)
                    .toggleEmployeeSelection(employee.id);

                // If employee is selected and hasn't loaded clients yet, fetch them
                if (value == true &&
                    !employee.hasLoadedClients &&
                    !employee.isLoadingClients) {
                  ref
                      .read(employeeSelectionViewModelProvider(
                              widget.organizationId ?? '')
                          .notifier)
                      .fetchClientsForEmployee(employee.email);
                }
              },
            ),
          ),
          // Client list if employee is selected
          if (employee.isSelected) _buildClientList(employee),
        ],
      ),
    );
  }

  Widget _buildClientList(EmployeeSelectionModel employee) {
    // Show loading indicator only for this specific employee
    if (employee.isLoadingClients) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Loading clients...', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    // Show message if no clients found after loading
    if (employee.hasLoadedClients && employee.clients.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.info_outline, color: Colors.grey, size: 32),
              SizedBox(height: 8),
              Text(
                'No clients assigned to this employee',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Show clients list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Clients',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: employee.clients.length,
          itemBuilder: (context, index) {
            final client = employee.clients[index];
            return Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space2,
                  vertical: ModernSaasDesign.space1),
              decoration: BoxDecoration(
                color: client.isSelected
                    ? ModernSaasDesign.primaryLight.withValues(alpha: 0.1)
                    : ModernSaasDesign.surfaceVariant,
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
                border: Border.all(
                  color: client.isSelected
                      ? ModernSaasDesign.primary
                      : ModernSaasDesign.border,
                  width: 1,
                ),
              ),
              child: CheckboxListTile(
                title: Text(
                  client.name,
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    color: ModernSaasDesign.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  client.email,
                  style: ModernSaasDesign.bodySmall.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                ),
                value: client.isSelected,
                activeColor: ModernSaasDesign.primary,
                checkColor: ModernSaasDesign.textOnPrimary,
                onChanged: (value) {
                  ref
                      .read(employeeSelectionViewModelProvider(
                              widget.organizationId ?? '')
                          .notifier)
                      .toggleClientSelection(employee.email, client.id);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomBar(EmployeeSelectionState state) {
    final hasSelectedClients = state.employees.any((employee) =>
        employee.isSelected &&
        employee.clients.any((client) => client.isSelected));

    return Container(
      padding: EdgeInsets.only(
        left: ModernSaasDesign.space4,
        right: ModernSaasDesign.space4,
        top: ModernSaasDesign.space4,
        bottom: ModernSaasDesign.space4 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        boxShadow: ModernSaasDesign.shadowLg,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.employees.where((e) => e.isSelected).length} employees selected',
                  style: ModernSaasDesign.bodyLarge.copyWith(
                    color: ModernSaasDesign.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (hasSelectedClients)
                  Text(
                    'Ready to generate invoice',
                    style: ModernSaasDesign.bodySmall.copyWith(
                      color: ModernSaasDesign.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: ModernSaasDesign.space4),
          Container(
            decoration: BoxDecoration(
              gradient:
                  hasSelectedClients ? ModernSaasDesign.primaryGradient : null,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusLg),
              boxShadow: hasSelectedClients ? ModernSaasDesign.shadowMd : null,
            ),
            child: ElevatedButton.icon(
              onPressed:
                  hasSelectedClients ? _navigateToInvoiceGeneration : null,
              icon: const Icon(Icons.arrow_forward_rounded, size: 20),
              label: Text(
                'Continue',
                style: ModernSaasDesign.labelLarge.copyWith(
                  color: ModernSaasDesign.textOnPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: hasSelectedClients
                    ? Colors.transparent
                    : ModernSaasDesign.neutral300,
                foregroundColor: hasSelectedClients
                    ? ModernSaasDesign.textOnPrimary
                    : ModernSaasDesign.textTertiary,
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space6,
                  vertical: ModernSaasDesign.space4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusLg),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToInvoiceGeneration() {
    final viewModel = ref.read(
        employeeSelectionViewModelProvider(widget.organizationId ?? '')
            .notifier);
    final selectedData = viewModel.getSelectedEmployeesAndClients();

    Navigator.of(context).pushNamed(
      Routes.enhancedInvoiceGeneration,
      arguments: {
        'email': widget.email,
        'genKey': widget.organizationId,
        'organizationName': widget.organizationName,
        'selectedEmployeesAndClients': selectedData,
      },
    );
  }
}
