import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/payment_repository.dart';

final paymentViewModelProvider = StateNotifierProvider<PaymentViewModel, AsyncValue<void>>((ref) {
  final repository = ref.watch(paymentRepositoryProvider);
  return PaymentViewModel(repository);
});

class PaymentViewModel extends StateNotifier<AsyncValue<void>> {
  final PaymentRepository _repository;

  PaymentViewModel(this._repository) : super(const AsyncValue.data(null));

  Future<void> createPaymentIntent({
    required String invoiceId,
    required double amount,
    required String currency,
    required String clientEmail,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createPaymentIntent(
        invoiceId: invoiceId,
        amount: amount,
        currency: currency,
        clientEmail: clientEmail,
      );
      
      if (result['clientSecret'] != null) {
        state = const AsyncValue.data(null);
        // In a real app, we would return the clientSecret to the UI to initialize Stripe Elements
      } else {
         throw Exception(result['message'] ?? 'Failed to create payment intent');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> recordPayment({
    required String invoiceId,
    required double amount,
    required String method,
    String? reference,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.recordPayment(
        invoiceId: invoiceId,
        amount: amount,
        method: method,
        reference: reference,
        notes: notes,
      );
      
      if (result['success'] == true) {
        state = const AsyncValue.data(null);
      } else {
        throw Exception(result['message'] ?? 'Failed to record payment');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> issueCreditNote(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createCreditNote(data);
      if (result['success'] == true) {
        state = const AsyncValue.data(null);
      } else {
         throw Exception(result['message'] ?? 'Failed to issue credit note');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String?> createOnboardingLink(String organizationId) async {
    try {
      final result = await _repository.createStripeOnboardingLink(organizationId);
      if (result['success'] == true && result['url'] != null) {
        return result['url'] as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
