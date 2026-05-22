// Business and Invoice Providers - Business management and invoicing
//
// Contains providers for business management and invoice-related viewmodels.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:carenest/app/features/invoice/viewmodels/invoice_email_viewmodel.dart';
import 'package:carenest/app/features/business/viewmodels/add_business_viewmodel.dart';
import 'package:carenest/app/features/invoice/viewmodels/line_items_viewmodel.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

// ==================== INVOICE EMAIL ====================

// Invoice email view model provider with autoDispose
final invoiceEmailViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return InvoiceEmailViewModel();
});

// ==================== BUSINESS ====================

// Add business view model provider with autoDispose
final addBusinessViewModelProvider = ChangeNotifierProvider.autoDispose<AddBusinessViewModel>((ref) {
  return AddBusinessViewModel(ref);
});

// ==================== LINE ITEMS ====================

// Line item view model provider for support items management
final lineItemViewModelProvider = StateNotifierProvider<LineItemViewModel, List<Map<String, dynamic>>>((ref) {
  return LineItemViewModel(ref.read(apiMethodProvider));
});
