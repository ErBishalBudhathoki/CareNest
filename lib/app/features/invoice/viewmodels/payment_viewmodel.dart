import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/payment_repository.dart';
import '../services/stripe_payment_service.dart';

final paymentViewModelProvider = AsyncNotifierProvider<PaymentViewModel, void>(
  PaymentViewModel.new,
);

final stripeConnectStatusProvider = FutureProvider.autoDispose
    .family<bool, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getStripeConnectStatus(organizationId);
      if (result['success'] != true) {
        throw Exception(result['message'] ?? 'Failed to check Stripe status');
      }
      return result['detailsSubmitted'] == true &&
          result['chargesEnabled'] == true &&
          result['payoutsEnabled'] == true;
    });

final organizationSubscriptionProvider = FutureProvider.autoDispose
    .family<String, String>((ref, organizationId) async {
      final result = await ref
          .watch(paymentRepositoryProvider)
          .getSubscriptionStatus(organizationId);
      if (result['success'] != true) {
        throw Exception(result['message'] ?? 'Failed to check subscription status');
      }
      return result['status'] as String? ?? 'none';
    });

class PaymentViewModel extends AsyncNotifier<void> {
  late final PaymentRepository _repository;
  final StripePaymentService _stripePaymentService =
      const StripePaymentService();

  @override
  FutureOr<void> build() {
    _repository = ref.watch(paymentRepositoryProvider);
    return null;
  }

  Future<void> payInvoice({
    required String invoiceId,
    required String organizationId,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _repository.createPaymentIntent(
        invoiceId: invoiceId,
        organizationId: organizationId,
      );

      final clientSecret = result['clientSecret'] as String?;
      final publishableKey = result['publishableKey'] as String?;
      final connectedAccountId = result['connectedAccountId'] as String?;
      if (clientSecret == null ||
          publishableKey == null ||
          connectedAccountId == null) {
        throw Exception(result['message'] ?? 'Failed to create payment intent');
      }
      await _stripePaymentService.presentInvoicePaymentSheet(
        clientSecret: clientSecret,
        publishableKey: publishableKey,
        connectedAccountId: connectedAccountId,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> recordPayment({
    required String invoiceId,
    required double amount,
    required String method,
    String? reference,
    String? notes,
  }) async {
    state = const AsyncLoading();
    try {
      final result = await _repository.recordPayment(
        invoiceId: invoiceId,
        amount: amount,
        method: method,
        reference: reference,
        notes: notes,
      );

      if (result['success'] == true) {
        state = const AsyncData(null);
      } else {
        throw Exception(result['message'] ?? 'Failed to record payment');
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> issueCreditNote(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    try {
      final result = await _repository.createCreditNote(data);
      if (result['success'] == true) {
        state = const AsyncData(null);
      } else {
        throw Exception(result['message'] ?? 'Failed to issue credit note');
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<String> createOnboardingLink(String organizationId) async {
    try {
      final result = await _repository.createStripeOnboardingLink(
        organizationId,
      );
      if (result['success'] == true && result['url'] != null) {
        return result['url'] as String;
      }
      throw Exception(
        result['message'] ?? 'Failed to generate Stripe onboarding link',
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
