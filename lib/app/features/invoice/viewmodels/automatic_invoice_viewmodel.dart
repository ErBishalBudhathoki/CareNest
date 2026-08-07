import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Automatic Invoice Generation ViewModel
/// Handles automatic invoice generation for all employees and clients in an organization
class AutomaticInvoiceViewModel extends Notifier<AutomaticInvoiceState> {
  @override
  late final Ref ref;
  late final EnhancedInvoiceService _invoiceService;
  late final ApiMethod _apiMethod;

  @override
  AutomaticInvoiceState build() {
    _invoiceService = ref.watch(enhancedInvoiceServiceProvider);
    _apiMethod = ref.read(app_providers.apiMethodProvider);

    return AutomaticInvoiceState();
  }

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

    List<String>? selectedEmployeeEmails,
    List<String>? selectedClientEmails,
    String? invoiceType,
  }) async {
    try {
      final l10n = AppLocalizations.of(context)!;
      // Update state to loading
      state = state.copyWith(
        isLoading: true,
        errorMessage: '',
        currentStep: l10n.fetchingOrgDataStep,
        progress: 0.0,
        isCompleted: false,
        generatedPdfPaths: const <String>[],
        invoices: const <Map<String, dynamic>>[],
        employeeClientPairs: const <Map<String, dynamic>>[],
        totalEmployees: 0,
        totalClients: 0,
        validPairs: 0,
      );

      // Step 1: Fetch all employees for the organization
      state = state.copyWith(
        currentStep: l10n.fetchingEmployeesStep,
        progress: 0.1,
      );

      final employeesResponse = await _apiMethod.getOrganizationEmployees(
        organizationId,
      );
      if (employeesResponse['success'] != true) {
        final statusCode = employeesResponse['statusCode']?.toString() ?? '';
        final message = employeesResponse['message']?.toString() ?? '';
        if (statusCode == '401' ||
            message.toLowerCase().contains('authentication')) {
          throw Exception('AUTH_REQUIRED_401');
        }
        if (statusCode == '403' ||
            message.toLowerCase().contains('permission')) {
          throw Exception('AUTH_FORBIDDEN_403');
        }
        throw Exception(l10n.failedToFetchEmployeesError(message));
      }

      final List<dynamic> employeesData = employeesResponse['employees'] ?? [];
      if (employeesData.isEmpty) {
        throw Exception(l10n.noEmployeesFoundError);
      }

      // Optionally filter employees to selected ones
      final List<dynamic> filteredEmployeesData =
          (selectedEmployeeEmails == null || selectedEmployeeEmails.isEmpty)
          ? employeesData
          : employeesData
                .where(
                  (e) => selectedEmployeeEmails.contains(
                    (e['email'] ?? '') as String,
                  ),
                )
                .toList();
      if (filteredEmployeesData.isEmpty) {
        throw Exception(l10n.noSelectedEmployeesError);
      }

      // Step 2: Fetch all clients for the organization
      state = state.copyWith(
        currentStep: l10n.fetchingClientsStep,
        progress: 0.2,
      );

      final List<Map<String, dynamic>> clientsData = await _apiMethod
          .getClientsByOrganizationId(organizationId);
      if (clientsData.isEmpty) {
        throw Exception(l10n.noClientsFoundError);
      }

      // Filter clients to selected ones
      final List<Map<String, dynamic>> filteredClientsData =
          (selectedClientEmails == null || selectedClientEmails.isEmpty)
          ? clientsData
          : clientsData
                .where(
                  (c) => selectedClientEmails.contains(
                    (c['clientEmail'] ?? '') as String,
                  ),
                )
                .toList();
      if (filteredClientsData.isEmpty) {
        throw Exception('No selected clients found in the organization.');
      }

      // Step 3: Build employee-client relationships
      state = state.copyWith(
        currentStep: l10n.buildingRelationshipsStep,
        progress: 0.3,
      );

      final List<Map<String, dynamic>> selectedEmployeesAndClients = [];
      int processedEmployees = 0;
      int assignmentLookups = 0;
      int assignmentAuthFailures = 0;
      int assignmentForbiddenFailures = 0;
      int assignmentOtherFailures = 0;

      for (final employeeData in filteredEmployeesData) {
        final String employeeEmail = employeeData['email'] ?? '';
        if (employeeEmail.isEmpty) continue;
        assignmentLookups++;

        // Update progress
        processedEmployees++;
        final progressStep =
            0.3 + (0.4 * processedEmployees / filteredEmployeesData.length);
        state = state.copyWith(
          currentStep: l10n.processingEmployeeStep(
            '${employeeData['firstName'] ?? ''} ${employeeData['lastName'] ?? ''}',
          ),
          progress: progressStep,
        );

        // Get assignments for this employee
        final assignmentsResponse = await _apiMethod.getUserAssignments(
          employeeEmail,
        );
        if (assignmentsResponse['success'] != true) {
          final statusCode =
              (assignmentsResponse['status_code'] ??
                      assignmentsResponse['statusCode'])
                  ?.toString();
          final failureMessage =
              assignmentsResponse['message']?.toString().toLowerCase() ?? '';
          if (statusCode == '401' ||
              failureMessage.contains('authentication') ||
              failureMessage.contains('missing_token') ||
              failureMessage.contains('unauthorized')) {
            assignmentAuthFailures++;
          } else if (statusCode == '403' ||
              failureMessage.contains('permission') ||
              failureMessage.contains('forbidden')) {
            assignmentForbiddenFailures++;
          } else {
            assignmentOtherFailures++;
          }
          debugPrint(
            l10n.failedToGetAssignmentsLog(
              employeeEmail,
              assignmentsResponse['message']?.toString() ?? '',
            ),
          );
          continue;
        }

        final List<dynamic> assignments =
            assignmentsResponse['assignments'] ?? [];
        if (assignments.isEmpty) {
          debugPrint(l10n.noAssignmentsFoundLog(employeeEmail));
          continue;
        }

        // Build clients list for this employee
        final List<Map<String, dynamic>> employeeClients = [];
        for (final assignment in assignments) {
          final String clientEmail = assignment['clientEmail'] ?? '';
          if (clientEmail.isEmpty) continue;

          // Find client details
          final clientDetails = filteredClientsData.firstWhere(
            (client) => client['clientEmail'] == clientEmail,
            orElse: () => <String, dynamic>{},
          );

          if (clientDetails.isNotEmpty) {
            employeeClients.add({
              'id': clientDetails['_id'] ?? assignment['clientId'] ?? '',
              'email': clientEmail,
              'name':
                  clientDetails['clientName'] ??
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
        if (assignmentLookups > 0 &&
            assignmentAuthFailures == assignmentLookups) {
          throw Exception('AUTH_REQUIRED_401');
        }
        if (assignmentLookups > 0 &&
            assignmentForbiddenFailures == assignmentLookups) {
          throw Exception('AUTH_FORBIDDEN_403');
        }
        if (assignmentLookups > 0 &&
            assignmentOtherFailures == assignmentLookups) {
          throw Exception('ASSIGNMENTS_UNAVAILABLE');
        }
        throw Exception(l10n.noValidRelationshipsError);
      }

      // Update state with found relationships
      state = state.copyWith(
        employeeClientPairs: selectedEmployeesAndClients,
        totalEmployees: filteredEmployeesData.length,
        totalClients: filteredClientsData.length,
        validPairs: selectedEmployeesAndClients.length,
      );

      // Step 4: Generate invoices
      state = state.copyWith(
        currentStep: l10n.generatingInvoicesStep,
        progress: 0.7,
      );

      // Determine which invoice types to generate.
      // 'both' means we generate employee invoices first, then client invoices.
      final effectiveType = (invoiceType ?? 'employee').toLowerCase();
      final List<String> typesToGenerate = effectiveType == 'both'
          ? ['employee', 'client']
          : [effectiveType];

      final List<String> allPdfPaths = [];
      final List<Map<String, dynamic>> allInvoices = [];

      for (int i = 0; i < typesToGenerate.length; i++) {
        final currentType = typesToGenerate[i];
        final progressBase = 0.7 + (0.25 * i / typesToGenerate.length);

        state = state.copyWith(
          currentStep: typesToGenerate.length > 1
              ? '${l10n.generatingInvoicesStep} (${currentType == 'employee' ? 'Employee' : 'Client'})'
              : l10n.generatingInvoicesStep,
          progress: progressBase,
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
          useAdminBankDetails: currentType == 'client' ? true : false,
          startDate: startDate,
          endDate: endDate,
          invoiceType: currentType,
        );

        allPdfPaths.addAll(pdfPaths);
        allInvoices.addAll(_invoiceService.invoices);
      }

      // Step 5: Complete
      state = state.copyWith(
        isLoading: false,
        currentStep: l10n.generationCompletedStep,
        progress: 1.0,
        generatedPdfPaths: allPdfPaths,
        invoices: allInvoices,
        isCompleted: true,
      );

      // Update global providers
      ref
          .read(invoiceGenerationStateProvider.notifier)
          .state = allPdfPaths.isEmpty
          ? InvoiceGenerationState.error
          : InvoiceGenerationState.completed;
      ref.read(generatedInvoicePathsProvider.notifier).state = allPdfPaths;

      return allPdfPaths;
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      final errorMessage = _mapAutomaticInvoiceError(e, l10n);
      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
        currentStep: l10n.errorOccurredStep,
        progress: 0.0,
      );

      // Update global providers
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.error;
      ref.read(invoiceGenerationErrorProvider.notifier).state = errorMessage;

      return [];
    }
  }

  String _stripExceptionPrefix(String input) {
    var value = input.trim();
    while (value.startsWith('Exception: ')) {
      value = value.substring('Exception: '.length).trim();
    }
    return value;
  }

  String _mapAutomaticInvoiceError(Object error, AppLocalizations l10n) {
    final raw = _stripExceptionPrefix(error.toString());
    final lower = raw.toLowerCase();

    if (raw == l10n.noEmployeesFoundError ||
        raw == l10n.noClientsFoundError ||
        raw == l10n.noValidRelationshipsError ||
        raw == l10n.noSelectedEmployeesError) {
      return raw;
    }

    if (lower.contains('auth_required_401') ||
        lower.contains('missing_token') ||
        lower.contains('unauthorized') ||
        lower.contains('authentication failed') ||
        lower.contains('401')) {
      return 'Session expired. Please sign in again, then retry generating invoices.';
    }

    if (lower.contains('auth_forbidden_403') || lower.contains('403')) {
      return 'You do not have permission to generate invoices for this organization.';
    }

    if (lower.contains('no clients found') ||
        lower.contains('clients_fetch_failed') ||
        lower.contains('failed to get clients') ||
        lower.contains('404')) {
      return '${l10n.noClientsFoundError}. Add at least one client and try again.';
    }

    if (lower.contains('no employees found')) {
      return '${l10n.noEmployeesFoundError}. Add at least one employee and try again.';
    }

    if (lower.contains('no valid employee-client relationships found') ||
        lower.contains('no assignments found')) {
      return '${l10n.noValidRelationshipsError}. Assign clients to employees, then retry.';
    }

    if (lower.contains('assignments_unavailable') ||
        lower.contains('failed to load user assignments')) {
      return 'Unable to load employee-client assignments right now. Please try again shortly.';
    }

    if (lower.contains('bank_details_required') ||
        lower.contains('bank_details_not_found') ||
        lower.contains('bank details')) {
      return 'Bank details are missing or incomplete. Configure bank details, then generate invoices again.';
    }

    if (lower.contains('route not found')) {
      return 'Required invoice service endpoint is unavailable right now. Please try again shortly.';
    }

    if (lower.contains('route_not_found_clients')) {
      return 'Client service endpoint is unavailable right now. Please try again shortly.';
    }

    if (lower.contains('server_error_') ||
        lower.contains('internal server error') ||
        lower.contains('500')) {
      return 'Server error occurred while preparing invoices. Please try again shortly.';
    }

    if (lower.contains('socketexception') ||
        lower.contains('connection') ||
        lower.contains('network') ||
        lower.contains('timed out')) {
      return 'Network issue while loading invoice data. Check your internet connection and retry.';
    }

    return raw;
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
  late final bool isLoading;
  late final String errorMessage;
  late final String currentStep;
  late final double progress;
  final List<Map<String, dynamic>> employeeClientPairs;
  late final int totalEmployees;
  late final int totalClients;
  late final int validPairs;
  late final List<String> generatedPdfPaths;
  final List<Map<String, dynamic>> invoices;
  late final bool isCompleted;

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
    NotifierProvider<AutomaticInvoiceViewModel, AutomaticInvoiceState>(
      AutomaticInvoiceViewModel.new,
    );
