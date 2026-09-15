import 'package:flutter/material.dart';
import 'package:carenest/app/core/utils/navigation.dart';
import 'package:carenest/app/features/organization/views/subscription_view.dart';

/// True when a backend response indicates the organisation needs an active
/// subscription (HTTP 402 / SUBSCRIPTION_REQUIRED).
bool isSubscriptionRequired(Map<String, dynamic> response) {
  if (response['statusCode']?.toString() == '402') return true;
  if (response['code']?.toString() == 'SUBSCRIPTION_REQUIRED') return true;
  final message = response['message']?.toString().toLowerCase() ?? '';
  return message.contains('active carenest subscription');
}

DateTime? _lastPromptAt;

/// Pushes the subscription screen once per short window when a paywalled
/// request is rejected, so the user can act instead of only seeing an error.
void maybePromptSubscriptionRequired(Map<String, dynamic> response) {
  if (!isSubscriptionRequired(response)) return;

  final now = DateTime.now();
  if (_lastPromptAt != null &&
      now.difference(_lastPromptAt!) < const Duration(seconds: 5)) {
    return;
  }
  _lastPromptAt = now;

  final navigator = navigatorKey.currentState;
  if (navigator == null) return;

  navigator.push(
    MaterialPageRoute<void>(builder: (_) => const SubscriptionView()),
  );
}
