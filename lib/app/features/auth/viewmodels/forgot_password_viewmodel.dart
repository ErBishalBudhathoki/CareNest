import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/forgotPassword_model.dart';
import 'package:carenest/app/features/auth/widgets/enhanced_auth_dialog.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordModel model = ForgotPasswordModel();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: 'forgot_password_form_key');
  final TextEditingController emailController = TextEditingController();
  final ApiMethod apiMethod;
  final SharedPreferencesUtils _sharedPrefs;

  ForgotPasswordViewModel(this._sharedPrefs, this.apiMethod);

  bool _isLoading = false; // Loading state property

  /// Getter for loading state
  bool get isLoading => _isLoading;

  /// Sets the loading state and notifies listeners
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
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

  @override
  void dispose() {
    emailController.dispose();
    model.dispose(); // Dispose of the model's controllers
    super.dispose();
  }
}
