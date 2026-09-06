import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepository(ref.read(app_providers.apiMethodProvider));
});

class PaymentRepository {
  final ApiMethod _api;

  PaymentRepository(this._api);

  Future<Map<String, dynamic>> createPaymentIntent({
    required String invoiceId,
    required String organizationId,
  }) async {
    final response = await _api.post(
      'api/payments/create-intent',
      body: {
        'invoiceId': invoiceId,
        'organizationId': organizationId,
      },
    );
    return response;
  }

  Future<Map<String, dynamic>> recordPayment({
    required String invoiceId,
    required double amount,
    required String method,
    String? reference,
    String? notes,
  }) async {
    final response = await _api.post(
      'api/payments/record',
      body: {
        'invoiceId': invoiceId,
        'paymentData': {
          'amount': amount,
          'method': method,
          'reference': reference,
          'notes': notes,
        },
      },
    );
    return response;
  }

  Future<Map<String, dynamic>> createCreditNote(
    Map<String, dynamic> data,
  ) async {
    final response = await _api.post('api/payments/credit-note', body: data);
    return response;
  }

  Future<Map<String, dynamic>> createStripeOnboardingLink(
    String organizationId,
  ) async {
    final response = await _api.post(
      'api/payments/onboarding-link',
      body: {'organizationId': organizationId},
    );
    return response;
  }

  Future<Map<String, dynamic>> getStripeConnectStatus(
    String organizationId,
  ) async {
    return _api.get(
      'api/payments/connect-status?organizationId=${Uri.encodeQueryComponent(organizationId)}',
    );
  }

  Future<Map<String, dynamic>> getSubscriptionStatus(
    String organizationId,
  ) async {
    return _api.get(
      'api/billing/entitlements?organizationId=${Uri.encodeQueryComponent(organizationId)}',
    );
  }

  Future<Map<String, dynamic>> createHostedCheckoutGrant({
    required String organizationId,
    required String invoiceId,
    int ttlMinutes = 1440,
  }) async {
    return _api.post(
      'api/billing/hosted-checkout/grant',
      body: {
        'organizationId': organizationId,
        'invoiceId': invoiceId,
        'ttlMinutes': ttlMinutes,
      },
    );
  }

  Future<Map<String, dynamic>> createRecurringAgreement({
    required String organizationId,
    required String invoiceId,
    required String frequency,
    required bool consentAccepted,
    String? consentIp,
    String? consentUserAgent,
  }) async {
    return _api.post(
      'api/billing/recurring-agreements',
      body: {
        'organizationId': organizationId,
        'invoiceId': invoiceId,
        'frequency': frequency,
        'consentAccepted': consentAccepted,
        if (consentIp != null) 'consentIp': consentIp,
        if (consentUserAgent != null) 'consentUserAgent': consentUserAgent,
      },
    );
  }

  Future<Map<String, dynamic>> cancelRecurringAgreement({
    required String organizationId,
    required String agreementId,
    String? reason,
  }) async {
    return _api.delete(
      'api/billing/recurring-agreements/$agreementId?organizationId=${Uri.encodeQueryComponent(organizationId)}&reason=${Uri.encodeQueryComponent(reason ?? 'Canceled from app')}',
    );
  }

  Future<Map<String, dynamic>> startStripeOAuth(String organizationId) async {
    return _api.post(
      'api/billing/connect/oauth/start',
      body: {'organizationId': organizationId},
    );
  }
}
