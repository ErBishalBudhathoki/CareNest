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
      body: {'invoiceId': invoiceId, 'organizationId': organizationId},
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

  /// Disconnect the organisation's linked Stripe account.
  Future<Map<String, dynamic>> disconnectStripe(String organizationId) async {
    return _api.post(
      'api/payments/disconnect',
      body: {'organizationId': organizationId},
    );
  }

  Future<Map<String, dynamic>> getSubscriptionStatus(
    String organizationId,
  ) async {
    return _api.get(
      'api/billing/entitlements?organizationId=${Uri.encodeQueryComponent(organizationId)}',
    );
  }

  /// DEV ONLY: clears the organisation's entitlement so the subscription gate
  /// can be re-tested.
  Future<Map<String, dynamic>> resetSubscription(String organizationId) async {
    return _api.post(
      'api/billing/entitlements/reset',
      body: {'organizationId': organizationId},
    );
  }

  /// Verify a Google Play subscription purchase server-side.
  Future<Map<String, dynamic>> verifyGooglePurchase({
    required String organizationId,
    required String purchaseToken,
    required String productId,
    required String subscriptionId,
  }) async {
    return _api.post(
      'api/billing/entitlements/verify/google',
      body: {
        'organizationId': organizationId,
        'purchaseToken': purchaseToken,
        'productId': productId,
        'subscriptionId': subscriptionId,
      },
    );
  }

  /// Verify an Apple App Store subscription purchase server-side.
  Future<Map<String, dynamic>> verifyApplePurchase({
    required String organizationId,
    required String transactionJws,
    String? productId,
  }) async {
    return _api.post(
      'api/billing/entitlements/verify/apple',
      body: {
        'organizationId': organizationId,
        'transactionJws': transactionJws,
        'productId': ?productId,
      },
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
        'consentIp': ?consentIp,
        'consentUserAgent': ?consentUserAgent,
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

  String _dashboardQuery(String organizationId, [Map<String, String>? extra]) {
    final params = {'organizationId': organizationId, ...?extra}.entries
        .map(
          (e) =>
              '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}',
        )
        .join('&');
    return params;
  }

  /// In-app Stripe revenue dashboard (all org-scoped, manage_billing-gated).
  Future<Map<String, dynamic>> getDashboardOverview(
    String organizationId,
  ) async {
    return _api.get(
      'api/billing/dashboard/overview?${_dashboardQuery(organizationId)}',
    );
  }

  Future<Map<String, dynamic>> getDashboardBalance(
    String organizationId,
  ) async {
    return _api.get(
      'api/billing/dashboard/balance?${_dashboardQuery(organizationId)}',
    );
  }

  Future<Map<String, dynamic>> getDashboardPayouts(
    String organizationId, {
    int limit = 20,
  }) async {
    return _api.get(
      'api/billing/dashboard/payouts?${_dashboardQuery(organizationId, {'limit': '$limit'})}',
    );
  }

  Future<Map<String, dynamic>> getDashboardRevenue(
    String organizationId, {
    int days = 30,
  }) async {
    return _api.get(
      'api/billing/dashboard/revenue?${_dashboardQuery(organizationId, {'days': '$days'})}',
    );
  }

  Future<Map<String, dynamic>> getDashboardPayments(
    String organizationId, {
    int limit = 20,
  }) async {
    return _api.get(
      'api/billing/dashboard/payments?${_dashboardQuery(organizationId, {'limit': '$limit'})}',
    );
  }

  Future<Map<String, dynamic>> getDashboardRisk(String organizationId) async {
    return _api.get(
      'api/billing/dashboard/risk?${_dashboardQuery(organizationId)}',
    );
  }

  /// DEV ONLY: full or partial refund. The backend rejects unless
  /// ENABLE_INAPP_REFUNDS=true (never set in production).
  Future<Map<String, dynamic>> issueDashboardRefund({
    required String organizationId,
    required String invoiceId,
    double? amount,
  }) async {
    return _api.post(
      'api/billing/dashboard/refund',
      body: {
        'organizationId': organizationId,
        'invoiceId': invoiceId,
        'amount': ?amount,
      },
    );
  }
}
