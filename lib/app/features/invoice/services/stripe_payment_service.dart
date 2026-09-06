import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentService {
  const StripePaymentService();

  Future<void> presentInvoicePaymentSheet({
    required String clientSecret,
    required String publishableKey,
    required String connectedAccountId,
  }) async {
    if (publishableKey.isEmpty || connectedAccountId.isEmpty) {
      throw StateError('Stripe payment configuration is incomplete');
    }

    Stripe.publishableKey = publishableKey;
    Stripe.stripeAccountId = connectedAccountId;
    try {
      await Stripe.instance.applySettings();
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'CareNest invoice payment',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } finally {
      Stripe.stripeAccountId = null;
      await Stripe.instance.applySettings();
    }
  }
}
