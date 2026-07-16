import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/forgotPassword_model.dart';
import 'package:carenest/app/features/auth/widgets/enhanced_auth_dialog.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;

class ForgotPasswordViewModel extends Notifier<bool> {
  final ForgotPasswordModel model = ForgotPasswordModel();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: 'forgot_password_form_key');
  final TextEditingController emailController = TextEditingController();
  late final ApiMethod apiMethod;
  late final SharedPreferencesUtils _sharedPrefs;

  @override
  bool build() {
    apiMethod = ref.watch(app_providers.apiMethodProvider);
    _sharedPrefs = ref.watch(app_providers.sharedPreferencesProvider);
    ref.onDispose(() {
      emailController.dispose();
      model.dispose();
    });
    return false;
  }

  /// Getter for loading state
  bool get isLoading => state;

  /// Sets the loading state and notifies listeners
  void _setLoading(bool loading) {
    state = loading;
  }

  Future<void> resetPassword(BuildContext context,
      Future<void> Function(Map<String, dynamic>) onSuccess) async {
    _setLoading(true); // Set loading to true when starting the request
    try {
      await _sharedPrefs
          .saveEmailToSharedPreferences(model.emailController.text.trim());

      // Send password reset OTP email
      final msg = await apiMethod.sendOTP(model.emailController.text.trim());
      debugPrint('Response: $msg');

      final isSuccess = msg['success'] == true || msg['statusCode'] == 200;
      if (isSuccess) {
        await onSuccess(msg);
      } else {
        await showWarningDialog(
          context,
          msg['message']?.toString() ?? "Error Sending OTP!",
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((e).toString()),
        ),
      );
    } finally {
      _setLoading(false); // Set loading to false when request completes
    }
  }

  Future<void> showWarningDialog(BuildContext context, String message) async {
    await EnhancedAuthDialog.showErrorDialog(
      context,
      title: 'Warning',
      message: message,
      actionLabel: 'OK',
    );
  }


}
