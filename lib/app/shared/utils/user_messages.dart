import 'package:flutter/foundation.dart';

/// Converts raw technical exceptions / Play Billing errors into short,
/// user-understandable messages. The original error is logged for debugging.
String friendlyErrorMessage(
  Object? error, {
  String fallback = 'Something went wrong. Please try again.',
}) {
  final raw = error?.toString() ?? '';
  if (raw.isNotEmpty) {
    debugPrint('[user-message] raw error: $raw');
  }
  final lower = raw.toLowerCase();

  if (lower.isEmpty) return fallback;

  if (lower.contains('organization data') ||
      lower.contains('organisation data') ||
      lower.contains('organization is unavailable')) {
    return 'We could not load your organisation. Please reopen the screen and try again.';
  }

  if (lower.contains('already') && lower.contains('own')) {
    return 'You already have an active subscription. Tap RESTORE PURCHASES to activate it.';
  }

  if (lower.contains('billingresponse') ||
      lower.contains('purchase_error') ||
      lower.contains('billing')) {
    return 'The Play Store could not complete the request. Please try again in a moment.';
  }

  if (lower.contains('itemunavailable') ||
      lower.contains('item_unavailable') ||
      lower.contains('not configured') ||
      lower.contains('unavailable')) {
    return 'Subscriptions are temporarily unavailable. Please try again later.';
  }

  if (lower.contains('socket') ||
      lower.contains('network') ||
      lower.contains('timeout') ||
      lower.contains('connection') ||
      lower.contains('failed host lookup')) {
    return 'We could not reach the server. Check your connection and try again.';
  }

  if (lower.contains('verif') || lower.contains('entitlement')) {
    return 'We could not confirm your purchase yet. Tap RESTORE PURCHASES to try again.';
  }

  return fallback;
}

/// Friendly message for Stripe Connect / onboarding failures.
String friendlyStripeError(
  Object? error, {
  String fallback = 'We could not start Stripe setup. Please try again.',
}) {
  final raw = error?.toString() ?? '';
  if (raw.isNotEmpty) {
    debugPrint('[user-message] raw stripe error: $raw');
  }
  final lower = raw.toLowerCase();

  if (lower.contains('permission') || lower.contains('admin')) {
    return 'You do not have permission to manage payments for this organisation.';
  }
  if (lower.contains('subscription') || lower.contains('402')) {
    return 'An active subscription is required to connect Stripe.';
  }
  if (lower.contains('socket') ||
      lower.contains('network') ||
      lower.contains('timeout') ||
      lower.contains('connection')) {
    return 'We could not reach the server. Check your connection and try again.';
  }
  return fallback;
}
