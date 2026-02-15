import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/api_method.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository(ApiMethod());
});

class PaymentRepository {
  final ApiMethod _api;

  PaymentRepository(this._api);

  Future<Map<String, dynamic>> createPaymentIntent({
    required String invoiceId,
    required double amount,
    required String currency,
    required String clientEmail,
  }) async {
    final response = await _api.post('api/payments/create-intent', body: {
      'invoiceId': invoiceId,
      'amount': amount,
      'currency': currency,
      'clientEmail': clientEmail,
    });
    return response;
  }

  Future<Map<String, dynamic>> recordPayment({
    required String invoiceId,
    required double amount,
    required String method,
    String? reference,
    String? notes,
  }) async {
    final response = await _api.post('api/payments/record', body: {
      'invoiceId': invoiceId,
      'paymentData': {
        'amount': amount,
        'method': method,
        'reference': reference,
        'notes': notes,
      },
    });
    return response;
  }

  Future<Map<String, dynamic>> createCreditNote(Map<String, dynamic> data) async {
    final response = await _api.post('api/payments/credit-note', body: data);
    return response;
  }

  Future<Map<String, dynamic>> createStripeOnboardingLink(String organizationId) async {
    final response = await _api.post('api/payments/stripe/onboarding', body: {
      'organizationId': organizationId,
    });
    return response;
  }
}
