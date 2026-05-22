import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/invoice/services/enhanced_invoice_service.dart';
import 'package:carenest/app/features/invoice/utils/invoice_data_processor.dart';
import 'package:carenest/app/features/invoice/utils/invoice_helpers.dart';
import 'package:carenest/app/features/invoice/repositories/invoice_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

/// Provider for ApiMethod
final apiMethodProvider = Provider((ref) {
  return ref.read(app_providers.apiMethodProvider);
});

/// Provider for InvoiceRepository
final invoiceRepositoryProvider = Provider((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  return InvoiceRepository(apiMethod);
});

/// Provider for InvoiceHelpers
final invoiceHelpersProvider = Provider((ref) {
  return InvoiceHelpers();
});

/// Provider for InvoiceDataProcessor
final invoiceDataProcessorProvider = Provider((ref) {
  return InvoiceDataProcessor(ref);
});

/// Provider for EnhancedInvoiceService
final enhancedInvoiceServiceProvider = Provider((ref) {
  final apiMethod = ref.watch(apiMethodProvider);
  return EnhancedInvoiceService(ref, apiMethod);
});

/// State provider for tracking invoice generation process
final invoiceGenerationStateProvider =
    StateProvider<InvoiceGenerationState>((ref) {
  return InvoiceGenerationState.initial;
});

/// Enum for tracking invoice generation state
enum InvoiceGenerationState {
  initial,
  loading,
  pricePrompting,
  generating,
  completed,
  error,
}

/// Provider for invoice generation error message
final invoiceGenerationErrorProvider = StateProvider<String>((ref) {
  return '';
});

/// Provider for generated invoice paths
final generatedInvoicePathsProvider = StateProvider<List<String>>((ref) {
  return [];
});
