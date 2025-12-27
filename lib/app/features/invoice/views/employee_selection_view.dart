import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/employee_selection_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';

class EmployeeSelectionView extends ConsumerStatefulWidget {
  final String email;
  final String? organizationId;
  final String? organizationName;

  const EmployeeSelectionView({
    super.key,
    required this.email,
    this.organizationId,
    this.organizationName,
  });

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
      backgroundColor: ModernInvoiceDesign.background,
      appBar: AppBar(
        title: Text(
          'Select Employees & Clients',
          style: ModernInvoiceDesign.displaySmall.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: ModernInvoiceDesign.primary,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: state.isLoading && state.employees.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ModernInvoiceDesign.primary),
                  ),
                  SizedBox(height: ModernInvoiceDesign.space4),
                  Text(
                    'Loading employees and clients...',
                    style: ModernInvoiceDesign.bodyMedium,
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
                        color: ModernInvoiceDesign.error,
                        size: 64,
                      ),
                      SizedBox(height: ModernInvoiceDesign.space4),
                      Text(
                        'Error Loading Employees',
                        style: ModernInvoiceDesign.displaySmall.copyWith(
                          color: ModernInvoiceDesign.textSecondary,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: ModernInvoiceDesign.space2),
                      Text(
                        state.errorMessage,
                        style: ModernInvoiceDesign.bodyMedium,
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
                            color: ModernInvoiceDesign.textSecondary,
                            size: 64,
                          ),
                          SizedBox(height: ModernInvoiceDesign.space4),
                          Text(
                            'No Employees Found',
                            style: ModernInvoiceDesign.displaySmall,
                          ),
                          SizedBox(height: ModernInvoiceDesign.space2),
                          Text(
                            'There are no employees available to select for invoice generation.',
                            style: ModernInvoiceDesign.bodyMedium,
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
      padding: const EdgeInsets.all(ModernInvoiceDesign.space4),
      itemCount: state.employees.length,
      itemBuilder: (context, index) {
        final employee = state.employees[index];
        return _buildEmployeeCard(employee);
      },
    );
  }

  Widget _buildEmployeeCard(EmployeeSelectionModel employee) {
    return Container(
      margin: const EdgeInsets.only(bottom: ModernInvoiceDesign.space2),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
        boxShadow: ModernInvoiceDesign.shadowSm,
        border: Border.all(
          color: ModernInvoiceDesign.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Employee header with checkbox
          ListTile(
            leading: CircleAvatar(
              backgroundColor: ModernInvoiceDesign.primary,
              child: Text(
                employee.name.isNotEmpty ? employee.name[0].toUpperCase() : 'U',
                style: ModernInvoiceDesign.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              employee.name,
              style: ModernInvoiceDesign.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: ModernInvoiceDesign.textPrimary,
              ),
            ),
            subtitle: Text(
              employee.email,
              style: ModernInvoiceDesign.bodySmall.copyWith(
                color: ModernInvoiceDesign.textSecondary,
              ),
            ),
            trailing: Checkbox(
              value: employee.isSelected,
              activeColor: ModernInvoiceDesign.primary,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Clients',
            style: ModernInvoiceDesign.bodyLarge
                .copyWith(fontWeight: FontWeight.bold),
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
                  horizontal: ModernInvoiceDesign.space2,
                  vertical: ModernInvoiceDesign.space1),
              decoration: BoxDecoration(
                color: client.isSelected
                    ? ModernInvoiceDesign.primary.withOpacity(0.1)
                    : ModernInvoiceDesign.surface,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                border: Border.all(
                  color: client.isSelected
                      ? ModernInvoiceDesign.primary
                      : ModernInvoiceDesign.border,
                  width: 1,
                ),
              ),
              child: CheckboxListTile(
                title: Text(
                  client.name,
                  style: ModernInvoiceDesign.bodyMedium.copyWith(
                    color: ModernInvoiceDesign.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  client.email,
                  style: ModernInvoiceDesign.bodySmall.copyWith(
                    color: ModernInvoiceDesign.textSecondary,
                  ),
                ),
                value: client.isSelected,
                activeColor: ModernInvoiceDesign.primary,
                checkColor: Colors.white,
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
        left: ModernInvoiceDesign.space4,
        right: ModernInvoiceDesign.space4,
        top: ModernInvoiceDesign.space4,
        bottom:
            ModernInvoiceDesign.space4 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.surface,
        boxShadow: ModernInvoiceDesign.shadowLg,
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
                  style: ModernInvoiceDesign.bodyLarge.copyWith(
                    color: ModernInvoiceDesign.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (hasSelectedClients)
                  Text(
                    'Ready to generate invoice',
                    style: ModernInvoiceDesign.bodySmall.copyWith(
                      color: ModernInvoiceDesign.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: ModernInvoiceDesign.space4),
          Container(
            decoration: BoxDecoration(
              gradient: hasSelectedClients
                  ? ModernInvoiceDesign.primaryGradient
                  : null,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusLg),
              boxShadow:
                  hasSelectedClients ? ModernInvoiceDesign.shadowMd : null,
              color: hasSelectedClients ? null : ModernInvoiceDesign.neutral300,
            ),
            child: ElevatedButton.icon(
              onPressed:
                  hasSelectedClients ? _navigateToInvoiceGeneration : null,
              icon: const Icon(Icons.arrow_forward_rounded, size: 20),
              label: Text(
                'Continue',
                style: ModernInvoiceDesign.labelLarge.copyWith(
                  color: hasSelectedClients
                      ? Colors.white
                      : ModernInvoiceDesign.textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: hasSelectedClients
                    ? Colors.white
                    : ModernInvoiceDesign.textTertiary,
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: ModernInvoiceDesign.space6,
                  vertical: ModernInvoiceDesign.space4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernInvoiceDesign.radiusLg),
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
