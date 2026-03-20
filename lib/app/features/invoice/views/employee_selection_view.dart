import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/models/employee_selection_model.dart';
import 'package:carenest/app/features/invoice/viewmodels/employee_selection_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

/// Bauhaus-styled Employee Selection View
/// Implements bold geometric forms with high contrast design
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

    // Show error messages in snackbar
    if (state.errorMessage.isNotEmpty && state.employees.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.errorMessage,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.surfaceLight,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            backgroundColor: BauhausDesign.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              side: const BorderSide(color: BauhausDesign.neutral, width: 2),
            ),
            margin: const EdgeInsets.all(BauhausDesign.space4),
          ),
        );
        ref
            .read(
                employeeSelectionViewModelProvider(widget.organizationId ?? '')
                    .notifier)
            .clearErrorMessage();
      });
    }

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildAppBar(),
      body: _buildBody(state),
      bottomNavigationBar: _buildBottomBar(state),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: BauhausDesign.surfaceLight,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: BauhausDesign.backgroundLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(color: BauhausDesign.neutral, width: 1.5),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: BauhausDesign.textDark,
            size: 16,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.selectEmployeesAndClients,
            style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            AppLocalizations.of(context)!.chooseEmpAndClientsDesc,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.neutral,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: Container(
          height: 4,
          color: BauhausDesign.neutral,
        ),
      ),
    );
  }

  Widget _buildBody(EmployeeSelectionState state) {
    if (state.isLoading && state.employees.isEmpty) {
      return _buildLoadingState();
    }

    if (state.errorMessage.isNotEmpty && state.employees.isEmpty) {
      return _buildErrorState(state.errorMessage);
    }

    if (state.employees.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: state.employees.length,
      itemBuilder: (context, index) {
        final employee = state.employees[index];
        return _buildEmployeeCard(employee);
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Geometric loading container
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space6),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  decoration: BoxDecoration(
                    color: BauhausDesign.secondary,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border:
                        Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: BauhausDesign.surfaceLight,
                      strokeWidth: 3,
                    ),
                  ),
                ),
                const SizedBox(height: BauhausDesign.space4),
                Text(
                  AppLocalizations.of(context)!.loadingEmployeesAndClients,
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.error,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: BauhausDesign.surfaceLight,
                  size: 32,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                AppLocalizations.of(context)!.errorLoadingEmployees,
                style:
                    BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                errorMessage,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.neutral,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space6),
              BauhausButton(
                text: AppLocalizations.of(context)!.retryButton,
                icon: Icons.refresh_rounded,
                backgroundColor: BauhausDesign.primary,
                onPressed: () {
                  ref
                      .read(employeeSelectionViewModelProvider(
                              widget.organizationId ?? '')
                          .notifier)
                      .fetchEmployees();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [BauhausDesign.shadowHard],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                  boxShadow: const [BauhausDesign.shadowHardSm],
                ),
                child: const Icon(
                  Icons.people_outline_rounded,
                  color: BauhausDesign.surfaceLight,
                  size: 32,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              Text(
                AppLocalizations.of(context)!.noEmployeesFound,
                style:
                    BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                AppLocalizations.of(context)!.noEmployeesAvailableDesc,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.neutral,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(EmployeeSelectionModel employee) {
    final isSelected = employee.isSelected;

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Container(
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(
            color: isSelected ? BauhausDesign.primary : BauhausDesign.neutral,
            width: 2,
          ),
          boxShadow: const [BauhausDesign.shadowHard],
        ),
        child: Column(
          children: [
            // Employee header with selection
            InkWell(
              onTap: () {
                ref
                    .read(employeeSelectionViewModelProvider(
                            widget.organizationId ?? '')
                        .notifier)
                    .toggleEmployeeSelection(employee.id);

                if (!employee.isSelected &&
                    !employee.hasLoadedClients &&
                    !employee.isLoadingClients) {
                  ref
                      .read(employeeSelectionViewModelProvider(
                              widget.organizationId ?? '')
                          .notifier)
                      .fetchClientsForEmployee(employee.email);
                }
              },
              borderRadius: BorderRadius.circular(
                math.max(0.0, BauhausDesign.radiusMd - 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Row(
                  children: [
                    // Avatar with geometric styling
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? BauhausDesign.primary
                            : BauhausDesign.secondary,
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusSm),
                        border: Border.all(
                            color: BauhausDesign.neutral, width: 1.5),
                        boxShadow: const [BauhausDesign.shadowHardSm],
                      ),
                      child: Center(
                        child: Text(
                          employee.name.isNotEmpty
                              ? employee.name[0].toUpperCase()
                              : 'U',
                          style: BauhausDesign.getTextTheme(context)
                              .headlineLarge
                              ?.copyWith(
                                color: BauhausDesign.surfaceLight,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyLarge
                                ?.copyWith(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            employee.email,
                            style: BauhausDesign.getTextTheme(context)
                                .bodySmall
                                ?.copyWith(
                                  color: BauhausDesign.neutral,
                                ),
                          ),
                        ],
                      ),
                    ),
                    // Selection indicator
                    _buildSelectionIndicator(isSelected),
                  ],
                ),
              ),
            ),
            // Client list if employee is selected
            if (employee.isSelected) ...[
              Container(
                height: 2,
                color: BauhausDesign.neutral,
              ),
              _buildClientList(employee),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color:
            isSelected ? BauhausDesign.primary : BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2,
        ),
        boxShadow: isSelected ? const [BauhausDesign.shadowHardXs] : null,
      ),
      child: isSelected
          ? const Icon(
              Icons.check_rounded,
              color: BauhausDesign.surfaceLight,
              size: 18,
            )
          : null,
    );
  }

  Widget _buildClientList(EmployeeSelectionModel employee) {
    if (employee.isLoadingClients) {
      return Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              child: const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: BauhausDesign.surfaceLight,
                  strokeWidth: 2,
                ),
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Text(
              AppLocalizations.of(context)!.loadingClientsText,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.neutral,
                  ),
            ),
          ],
        ),
      );
    }

    if (employee.hasLoadedClients && employee.clients.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.backgroundLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(
                color: BauhausDesign.neutral.withOpacity(0.3), width: 1.5),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: BauhausDesign.neutral,
                size: 20,
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.noClientsAssignedText,
                  style:
                      BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                            color: BauhausDesign.neutral,
                          ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.neutral,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
            ),
            child: Text(
              AppLocalizations.of(context)!.selectClientsHeader,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textLight,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space3),
          ...employee.clients
              .map((client) => _buildClientTile(employee, client)),
        ],
      ),
    );
  }

  Widget _buildClientTile(EmployeeSelectionModel employee, ClientModel client) {
    final isSelected = client.isSelected;

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space2),
      child: InkWell(
        onTap: () {
          ref
              .read(employeeSelectionViewModelProvider(
                      widget.organizationId ?? '')
                  .notifier)
              .toggleClientSelection(employee.email, client.id);
        },
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        child: Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: isSelected
                ? BauhausDesign
                    .accent // Removed opacity to match design requirement
                : BauhausDesign.backgroundLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
            border: Border.all(
              color: isSelected
                  ? BauhausDesign.accent
                  : BauhausDesign.neutral.withOpacity(0.3),
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: isSelected ? const [BauhausDesign.shadowHardXs] : null,
          ),
          child: Row(
            children: [
              // Client avatar
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color:
                      isSelected ? BauhausDesign.accent : BauhausDesign.success,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_rounded,
                    color: BauhausDesign.textDark,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: isSelected
                                ? Colors.white
                                : BauhausDesign.textDark, // White when selected
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      client.email,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: isSelected
                                ? Colors.white.withOpacity(0.9)
                                : BauhausDesign.neutral, // White when selected
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              // Selection indicator
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isSelected
                      ? BauhausDesign.accent
                      : BauhausDesign.surfaceLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusXs),
                  border: Border.all(
                    color: isSelected
                        ? BauhausDesign.neutral
                        : BauhausDesign.neutral.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        color: BauhausDesign.textDark,
                        size: 14,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(EmployeeSelectionState state) {
    final hasSelectedClients = state.employees.any((employee) =>
        employee.isSelected &&
        employee.clients.any((client) => client.isSelected));

    final selectedEmployeesCount =
        state.employees.where((e) => e.isSelected).length;
    final selectedClientsCount = state.employees
        .where((e) => e.isSelected)
        .expand((e) => e.clients.where((c) => c.isSelected))
        .length;

    return Container(
      padding: EdgeInsets.only(
        left: BauhausDesign.space4,
        right: BauhausDesign.space4,
        top: BauhausDesign.space4,
        bottom: BauhausDesign.space4 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: const Border(
          top: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: BauhausDesign.neutral.withOpacity(0.1),
            blurRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: BauhausDesign.space2,
                  runSpacing: BauhausDesign.space2,
                  children: [
                    // Stats badges
                    _buildStatsBadge(
                      '$selectedEmployeesCount',
                      AppLocalizations.of(context)!
                          .employeeCount(selectedEmployeesCount),
                      BauhausDesign.secondary,
                    ),
                    _buildStatsBadge(
                      '$selectedClientsCount',
                      AppLocalizations.of(context)!
                          .clientCount(selectedClientsCount),
                      BauhausDesign.success,
                    ),
                  ],
                ),
                if (hasSelectedClients) ...[
                  const SizedBox(height: BauhausDesign.space2),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: BauhausDesign.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: BauhausDesign.neutral, width: 1),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Text(
                        AppLocalizations.of(context)!
                            .readyToGenerateInvoiceText,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.success,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          BauhausButton(
            text: AppLocalizations.of(context)!.continueButton,
            icon: Icons.arrow_forward_rounded,
            backgroundColor: hasSelectedClients
                ? BauhausDesign.primary
                : BauhausDesign.neutral.withOpacity(0.3),
            textColor: hasSelectedClients
                ? BauhausDesign.surfaceLight
                : BauhausDesign.neutral,
            onPressed: hasSelectedClients ? _navigateToInvoiceGeneration : null,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBadge(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space3,
        vertical: BauhausDesign.space1,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count,
            style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w500,
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
        'userEmail': widget
            .email, // Use 'userEmail' to match main.dart if applicable? No, main.dart uses 'userEmail'
        'organizationId': widget.organizationId,
        'organizationName': widget.organizationName,
        'selectedEmployeesAndClients': selectedData,
      },
    );
  }
}
