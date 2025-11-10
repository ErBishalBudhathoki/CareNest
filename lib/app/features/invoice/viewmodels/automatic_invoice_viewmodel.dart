import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/invoice/models/employee_selection_model.dart';
import 'package:flutter/foundation.dart';

/// Automatic Invoice Generation ViewModel
/// Handles automatic invoice generation for all employees and clients in an organization
class AutomaticInvoiceViewModel extends StateNotifier<AutomaticInvoiceState> {
  final Ref ref;
  final EnhancedInvoiceService _invoiceService;
  final ApiMethod _apiMethod;

  AutomaticInvoiceViewModel(this.ref, this._invoiceService, this._apiMethod)
      : super(AutomaticInvoiceState());

  /// Generate invoices automatically for all employees and clients
  Future<List<String>> generateAutomaticInvoices(
    BuildContext context, {
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
    bool validatePrices = true,
    bool allowPriceCapOverride = false,
    bool includeDetailedPricingInfo = true,
    bool applyTax = true,
    double taxRate = 0.00,
    bool includeExpenses = true,
    bool useAdminBankDetails = false,
    List<String>? selectedEmployeeEmails,
  }) async {
    try {
      // Update state to loading
      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
        currentStep: 'Fetching organization data...',
        progress: 0.0,
      );

      // Step 1: Fetch all employees for the organization
      state = state.copyWith(
        currentStep: 'Fetching employees...',
        progress: 0.1,
      );

      final employeesResponse =
          await _apiMethod.getOrganizationEmployees(organizationId);
      if (employeesResponse['success'] != true) {
        throw Exception(
            'Failed to fetch employees: ${employeesResponse['message']}');
      }

      final List<dynamic> employeesData = employeesResponse['employees'] ?? [];
      if (employeesData.isEmpty) {
        throw Exception('No employees found for this organization');
      }

      // Optionally filter employees to selected ones
      final List<dynamic> filteredEmployeesData = (selectedEmployeeEmails == null || selectedEmployeeEmails.isEmpty)
          ? employeesData
          : employeesData.where((e) => selectedEmployeeEmails.contains((e['email'] ?? '') as String)).toList();
      if (filteredEmployeesData.isEmpty) {
        throw Exception('No selected employees found to generate invoices');
      }

      // Step 2: Fetch all clients for the organization
      state = state.copyWith(
        currentStep: 'Fetching clients...',
        progress: 0.2,
      );

      final List<Map<String, dynamic>> clientsData =
          await _apiMethod.getClientsByOrganizationId(organizationId);
      if (clientsData.isEmpty) {
        throw Exception('No clients found for this organization');
      }

      // Step 3: Build employee-client relationships
      state = state.copyWith(
        currentStep: 'Building employee-client relationships...',
        progress: 0.3,
      );

      final List<Map<String, dynamic>> selectedEmployeesAndClients = [];
      int processedEmployees = 0;

      for (final employeeData in filteredEmployeesData) {
        final String employeeEmail = employeeData['email'] ?? '';
        if (employeeEmail.isEmpty) continue;

        // Update progress
        processedEmployees++;
        final progressStep =
            0.3 + (0.4 * processedEmployees / filteredEmployeesData.length);
        state = state.copyWith(
          currentStep:
              'Processing employee: ${employeeData['firstName']} ${employeeData['lastName']}',
          progress: progressStep,
        );

        // Get assignments for this employee
        final assignmentsResponse =
            await _apiMethod.getUserAssignments(employeeEmail);
        if (assignmentsResponse['success'] != true) {
          debugPrint(
              'Failed to get assignments for $employeeEmail: ${assignmentsResponse['message']}');
          continue;
        }

        final List<dynamic> assignments =
            assignmentsResponse['assignments'] ?? [];
        if (assignments.isEmpty) {
          debugPrint('No assignments found for employee: $employeeEmail');
          continue;
        }

        // Build clients list for this employee
        final List<Map<String, dynamic>> employeeClients = [];
        for (final assignment in assignments) {
          final String clientEmail = assignment['clientEmail'] ?? '';
          if (clientEmail.isEmpty) continue;

          // Find client details
          final clientDetails = clientsData.firstWhere(
            (client) => client['clientEmail'] == clientEmail,
            orElse: () => <String, dynamic>{},
          );

          if (clientDetails.isNotEmpty) {
            employeeClients.add({
              'id': clientDetails['_id'] ?? assignment['clientId'] ?? '',
              'email': clientEmail,
              'name': clientDetails['clientName'] ??
                  assignment['clientName'] ??
                  clientEmail,
              'organizationId': organizationId,
            });
          }
        }

        // Add employee-client pair if there are clients
        if (employeeClients.isNotEmpty) {
          selectedEmployeesAndClients.add({
            'employee': {
              'id': employeeData['_id']?.toString() ?? '',
              'email': employeeEmail,
              'name':
                  '${employeeData['firstName'] ?? ''} ${employeeData['lastName'] ?? ''}'
                      .trim(),
              'organizationId': organizationId,
            },
            'clients': employeeClients,
            'organizationId': organizationId,
          });
        }
      }

      if (selectedEmployeesAndClients.isEmpty) {
        throw Exception('No valid employee-client relationships found');
      }

      // Update state with found relationships
      state = state.copyWith(
        employeeClientPairs: selectedEmployeesAndClients,
        totalEmployees: filteredEmployeesData.length,
        totalClients: clientsData.length,
        validPairs: selectedEmployeesAndClients.length,
      );

      // Step 4: Generate invoices
      state = state.copyWith(
        currentStep: 'Generating invoices...',
        progress: 0.7,
      );

      final pdfPaths = await _invoiceService.generateInvoicesWithPricing(
        context,
        selectedEmployeesAndClients: selectedEmployeesAndClients,
        organizationId: organizationId,
        validatePrices: validatePrices,
        allowPriceCapOverride: allowPriceCapOverride,
        includeDetailedPricingInfo: includeDetailedPricingInfo,
        applyTax: applyTax,
        taxRate: taxRate,
        includeExpenses: includeExpenses,
        useAdminBankDetails: useAdminBankDetails,
        startDate: startDate,
        endDate: endDate,
      );

      // Step 5: Complete
      state = state.copyWith(
        isLoading: false,
        currentStep: 'Invoice generation completed',
        progress: 1.0,
        generatedPdfPaths: pdfPaths,
        invoices: _invoiceService.invoices,
        isCompleted: true,
      );

      // Update global providers
      ref.read(invoiceGenerationStateProvider.notifier).state = pdfPaths.isEmpty
          ? InvoiceGenerationState.error
          : InvoiceGenerationState.completed;
      ref.read(generatedInvoicePathsProvider.notifier).state = pdfPaths;

      return pdfPaths;
    } catch (e) {
      final errorMessage = e.toString();
      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        currentStep: 'Error occurred',
        progress: 0.0,
      );

      // Update global providers
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.error;
      ref.read(invoiceGenerationErrorProvider.notifier).state = errorMessage;

      return [];
    }
  }

  /// Reset the state
  void reset() {
    state = AutomaticInvoiceState();
    ref.read(invoiceGenerationStateProvider.notifier).state =
        InvoiceGenerationState.initial;
    ref.read(invoiceGenerationErrorProvider.notifier).state = '';
    ref.read(generatedInvoicePathsProvider.notifier).state = [];
  }

  /// Get summary statistics
  Map<String, dynamic> getSummary() {
    return {
      'totalEmployees': state.totalEmployees,
      'totalClients': state.totalClients,
      'validPairs': state.validPairs,
      'generatedInvoices': state.generatedPdfPaths.length,
      'isCompleted': state.isCompleted,
    };
  }
}

/// State class for AutomaticInvoiceViewModel
class AutomaticInvoiceState {
  final bool isLoading;
  final String errorMessage;
  final String currentStep;
  final double progress;
  final List<Map<String, dynamic>> employeeClientPairs;
  final int totalEmployees;
  final int totalClients;
  final int validPairs;
  final List<String> generatedPdfPaths;
  final List<Map<String, dynamic>> invoices;
  final bool isCompleted;

  AutomaticInvoiceState({
    this.isLoading = false,
    this.errorMessage = '',
    this.currentStep = '',
    this.progress = 0.0,
    this.employeeClientPairs = const [],
    this.totalEmployees = 0,
    this.totalClients = 0,
    this.validPairs = 0,
    this.generatedPdfPaths = const [],
    this.invoices = const [],
    this.isCompleted = false,
  });

  AutomaticInvoiceState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? currentStep,
    double? progress,
    List<Map<String, dynamic>>? employeeClientPairs,
    int? totalEmployees,
    int? totalClients,
    int? validPairs,
    List<String>? generatedPdfPaths,
    List<Map<String, dynamic>>? invoices,
    bool? isCompleted,
  }) {
    return AutomaticInvoiceState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
      progress: progress ?? this.progress,
      employeeClientPairs: employeeClientPairs ?? this.employeeClientPairs,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      totalClients: totalClients ?? this.totalClients,
      validPairs: validPairs ?? this.validPairs,
      generatedPdfPaths: generatedPdfPaths ?? this.generatedPdfPaths,
      invoices: invoices ?? this.invoices,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Provider for AutomaticInvoiceViewModel
final automaticInvoiceViewModelProvider =
    StateNotifierProvider<AutomaticInvoiceViewModel, AutomaticInvoiceState>(
        (ref) {
  final invoiceService = ref.watch(enhancedInvoiceServiceProvider);
  final apiMethod = ApiMethod();
  return AutomaticInvoiceViewModel(ref, invoiceService, apiMethod);
});
