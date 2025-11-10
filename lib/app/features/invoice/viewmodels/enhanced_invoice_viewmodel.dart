import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/invoice_providers.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:flutter/foundation.dart';

/// Enhanced Invoice ViewModel
/// Task 5.6: Update invoice service with enhanced pricing integration
class EnhancedInvoiceViewModel extends StateNotifier<EnhancedInvoiceState> {
  final Ref ref;
  final EnhancedInvoiceService _invoiceService;

  EnhancedInvoiceViewModel(this.ref, this._invoiceService)
      : super(EnhancedInvoiceState());

  /// Generate invoices with enhanced pricing integration
  ///
  /// Parameters:
  /// - `selectedEmployeesAndClients`: Selection of employees and their clients to include.
  /// - `organizationId`: Optional organization context for pricing validation.
  /// - `validatePrices`: When true, performs pricing compliance checks.
  /// - `allowPriceCapOverride`: Allows overriding price caps via prompts.
  /// - `includeDetailedPricingInfo`: Adds pricing metadata to invoices.
  /// - `applyTax`: Whether to apply tax to totals.
  /// - `taxRate`: Tax percentage as a double (0–100 range typical).
  /// - `includeExpenses`: Include approved expenses in invoice generation.
  /// - `attachedPhotos`, `photoDescription`, `additionalAttachments`: Optional attachments.
  /// - `priceOverrides`: Optional map of item-specific price overrides.
  /// - `useAdminBankDetails`: Use admin bank details for invoices when true.
  /// - `startDate`, `endDate`: Optional date range to filter line items and expenses. If omitted,
  ///   the service defaults are used.
  Future<List<String>> generateInvoices(
    BuildContext context, {
    List<Map<String, dynamic>>? selectedEmployeesAndClients,
    String? organizationId,
    bool validatePrices = true,
    bool allowPriceCapOverride = false,
    bool includeDetailedPricingInfo = true,
    bool applyTax = true,
    required double taxRate,
    bool includeExpenses = true,
    List<File>? attachedPhotos,
    String? photoDescription,
    List<File>? additionalAttachments,
    Map<String, Map<String, dynamic>>? priceOverrides,
    bool useAdminBankDetails = false,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Update local state
      state = state.copyWith(isLoading: true, errorMessage: '');
      if (taxRate == null) {
        taxRate = 0.0;
      }
      // Validate date range if provided
      if (startDate != null && endDate != null) {
        if (endDate.isBefore(startDate)) {
          final msg = 'End date must be on or after start date';
          state = state.copyWith(isLoading: false, errorMessage: msg);
          ref.read(invoiceGenerationStateProvider.notifier).state =
              InvoiceGenerationState.error;
          ref.read(invoiceGenerationErrorProvider.notifier).state = msg;
          return [];
        }

        // Prevent excessively long periods (align with backend: max ~3 months)
        final diffDays = endDate.difference(startDate).inDays;
        if (diffDays > 93) { // ~3 months
          final msg = 'Selected period cannot exceed 3 months';
          state = state.copyWith(isLoading: false, errorMessage: msg);
          ref.read(invoiceGenerationStateProvider.notifier).state =
              InvoiceGenerationState.error;
          ref.read(invoiceGenerationErrorProvider.notifier).state = msg;
          return [];
        }

        // Optional: warn on future end dates (business-friendly safeguard)
        final now = DateTime.now();
        if (endDate.isAfter(now)) {
          final msg = 'End date cannot be in the future';
          state = state.copyWith(isLoading: false, errorMessage: msg);
          ref.read(invoiceGenerationStateProvider.notifier).state =
              InvoiceGenerationState.error;
          ref.read(invoiceGenerationErrorProvider.notifier).state = msg;
          return [];
        }
      }
      // The invoice service will handle updating the global state
      // through the providers, so we don't need to set it here
      debugPrint('in viewmodel taxRate: $taxRate');
      // Generate invoices with pricing integration
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
        attachedPhotos: attachedPhotos,
        photoDescription: photoDescription,
        additionalAttachments: additionalAttachments,
        priceOverrides: priceOverrides,
        useAdminBankDetails: useAdminBankDetails,
        startDate: startDate,
        endDate: endDate,
      );

      // Extract validation summary and items exceeding price cap from the invoices
      Map<String, dynamic> validationSummary = {};
      List<Map<String, dynamic>> itemsExceedingPriceCap = [];

      // Get validation data from the invoices
      final invoices = _invoiceService.invoices;
      for (final invoice in invoices) {
        // Check for validation data in each invoice
        if (invoice.containsKey('pricingValidation')) {
          final validation =
              invoice['pricingValidation'] as Map<String, dynamic>;
          // Collect validation data
          if (validation.containsKey('compliancePercentage')) {
            validationSummary['compliancePercentage'] =
                validation['compliancePercentage'];
          }
        }

        // Check for items exceeding price cap
        final lineItems = invoice['lineItems'] as List<dynamic>? ?? [];
        for (final item in lineItems) {
          if (item is Map<String, dynamic> && item['exceedsPriceCap'] == true) {
            itemsExceedingPriceCap.add({
              'clientName': invoice['clientName'],
              'ndisItemNumber': item['ndisItemNumber'],
              'description': item['description'],
              'price': item['price'],
              'priceCap': item['priceCap'],
              'difference': item['price'] != null && item['priceCap'] != null
                  ? (item['price'] - item['priceCap']).toStringAsFixed(2)
                  : '0.00',
            });
          }
        }
      }

      // Update state with generated invoices and validation data
      state = state.copyWith(
        isLoading: false,
        generatedPdfPaths: pdfPaths,
        invoices: _invoiceService.invoices,
        validationSummary: validationSummary,
        itemsExceedingPriceCap: itemsExceedingPriceCap,
      );

      // Update the invoice generation state
      ref.read(invoiceGenerationStateProvider.notifier).state = pdfPaths.isEmpty
          ? InvoiceGenerationState.error
          : InvoiceGenerationState.completed;

      // Store generated paths in provider
      ref.read(generatedInvoicePathsProvider.notifier).state = pdfPaths;

      return pdfPaths;
    } catch (e) {
      final errorMessage = e.toString();
      state = state.copyWith(isLoading: false, errorMessage: errorMessage);

      // Update the invoice generation state and error message
      ref.read(invoiceGenerationStateProvider.notifier).state =
          InvoiceGenerationState.error;
      ref.read(invoiceGenerationErrorProvider.notifier).state = errorMessage;

      return [];
    }
  }

  /// Send invoice emails with enhanced error handling
  /// Returns a boolean indicating success or failure
  Future<bool> sendInvoiceEmails(
      String pdfPath, String email, String genKey) async {
    try {
      // Update local state
      state = state.copyWith(isLoading: true, errorMessage: '');

      // The invoice service will handle updating the global state
      // through the providers, so we don't need to set it here

      final success = await _invoiceService.sendInvoiceEmails(
        pdfPath,
        email,
        genKey,
      );

      // Log result
      debugPrint('Email sending result: $success');

      // Update local state based on result
      state = state.copyWith(isLoading: false, emailSent: success);

      return success;
    } catch (e) {
      final errorMessage = e.toString();
      debugPrint('Exception in sendInvoiceEmails: $errorMessage');

      // Update local state
      state = state.copyWith(isLoading: false, errorMessage: errorMessage);

      // The invoice service will handle updating the global state
      // for errors, so we don't need to set it here

      return false;
    }
  }

  /// Reset the state
  void reset() {
    state = EnhancedInvoiceState();
    ref.read(invoiceGenerationStateProvider.notifier).state =
        InvoiceGenerationState.initial;
    ref.read(invoiceGenerationErrorProvider.notifier).state = '';
    ref.read(generatedInvoicePathsProvider.notifier).state = [];
  }
}

/// State class for EnhancedInvoiceViewModel
class EnhancedInvoiceState {
  final bool isLoading;
  final String errorMessage;
  final List<String> generatedPdfPaths;
  final List<Map<String, dynamic>> invoices;
  final bool emailSent;
  final Map<String, dynamic> validationSummary;
  final List<Map<String, dynamic>> itemsExceedingPriceCap;

  EnhancedInvoiceState({
    this.isLoading = false,
    this.errorMessage = '',
    this.generatedPdfPaths = const [],
    this.invoices = const [],
    this.emailSent = false,
    this.validationSummary = const {},
    this.itemsExceedingPriceCap = const [],
  });

  EnhancedInvoiceState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<String>? generatedPdfPaths,
    List<Map<String, dynamic>>? invoices,
    bool? emailSent,
    Map<String, dynamic>? validationSummary,
    List<Map<String, dynamic>>? itemsExceedingPriceCap,
  }) {
    return EnhancedInvoiceState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      generatedPdfPaths: generatedPdfPaths ?? this.generatedPdfPaths,
      invoices: invoices ?? this.invoices,
      emailSent: emailSent ?? this.emailSent,
      validationSummary: validationSummary ?? this.validationSummary,
      itemsExceedingPriceCap:
          itemsExceedingPriceCap ?? this.itemsExceedingPriceCap,
    );
  }

  /// Check if validation data is available
  bool get hasValidationData => validationSummary.isNotEmpty;

  /// Get compliance percentage
  double get compliancePercentage {
    if (validationSummary.containsKey('compliancePercentage')) {
      final value = validationSummary['compliancePercentage'];
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 100.0;
      if (value is num) return value.toDouble();
    }
    return 100.0;
  }

  /// Check if there are non-compliant items
  bool get hasNonCompliantItems => itemsExceedingPriceCap.isNotEmpty;
}

/// Provider for EnhancedInvoiceViewModel
final enhancedInvoiceViewModelProvider =
    StateNotifierProvider<EnhancedInvoiceViewModel, EnhancedInvoiceState>(
        (ref) {
  final invoiceService = ref.watch(enhancedInvoiceServiceProvider);
  return EnhancedInvoiceViewModel(ref, invoiceService);
});
