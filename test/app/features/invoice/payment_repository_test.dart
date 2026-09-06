import 'package:carenest/app/features/invoice/repositories/payment_repository.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiMethod extends Mock implements ApiMethod {
  String? lastEndpoint;
  Map<String, dynamic>? lastBody;

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    lastEndpoint = endpoint;
    return {'success': true};
  }

  @override
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    lastEndpoint = endpoint;
    lastBody = body;
    return {'success': true};
  }

  @override
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    lastEndpoint = endpoint;
    return {'success': true};
  }
}

void main() {
  late MockApiMethod api;
  late PaymentRepository repository;

  setUp(() {
    api = MockApiMethod();
    repository = PaymentRepository(api);
  });

  test('requests the backend Stripe Connect onboarding route', () async {
    await repository.createStripeOnboardingLink('org-1');

    expect(api.lastEndpoint, 'api/payments/onboarding-link');
    expect(api.lastBody, {'organizationId': 'org-1'});
  });

  test('requests Stripe Connect status for the encoded organization', () async {
    await repository.getStripeConnectStatus('org/1');

    expect(
      api.lastEndpoint,
      'api/payments/connect-status?organizationId=org%2F1',
    );
  });

  test('does not send client-controlled invoice payment fields', () async {
    await repository.createPaymentIntent(
      invoiceId: 'invoice-1',
      organizationId: 'org-1',
    );

    expect(api.lastEndpoint, 'api/payments/create-intent');
    expect(api.lastBody, {
      'invoiceId': 'invoice-1',
      'organizationId': 'org-1',
    });
  });

  test('requests subscription status from the billing entitlement route', () async {
    await repository.getSubscriptionStatus('org-1');
    expect(api.lastEndpoint, 'api/billing/entitlements?organizationId=org-1');
  });

  test('creates a hosted checkout grant with the invoice and organization', () async {
    await repository.createHostedCheckoutGrant(
      organizationId: 'org-1',
      invoiceId: 'inv-1',
      ttlMinutes: 60,
    );
    expect(api.lastEndpoint, 'api/billing/hosted-checkout/grant');
    expect(api.lastBody, {
      'organizationId': 'org-1',
      'invoiceId': 'inv-1',
      'ttlMinutes': 60,
    });
  });

  test('creates a recurring agreement with consent', () async {
    await repository.createRecurringAgreement(
      organizationId: 'org-1',
      invoiceId: 'inv-1',
      frequency: 'monthly',
      consentAccepted: true,
    );
    expect(api.lastEndpoint, 'api/billing/recurring-agreements');
    expect(api.lastBody, {
      'organizationId': 'org-1',
      'invoiceId': 'inv-1',
      'frequency': 'monthly',
      'consentAccepted': true,
    });
  });

  test('cancels a recurring agreement', () async {
    await repository.cancelRecurringAgreement(
      organizationId: 'org-1',
      agreementId: 'agr-1',
      reason: 'No longer needed',
    );
    expect(
      api.lastEndpoint,
      'api/billing/recurring-agreements/agr-1?organizationId=org-1&reason=No%20longer%20needed',
    );
  });

  test('starts Stripe OAuth for an existing account', () async {
    await repository.startStripeOAuth('org-1');
    expect(api.lastEndpoint, 'api/billing/connect/oauth/start');
    expect(api.lastBody, {'organizationId': 'org-1'});
  });
}
