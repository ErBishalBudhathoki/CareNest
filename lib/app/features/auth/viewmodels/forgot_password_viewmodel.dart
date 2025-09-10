import 'package:carenest/app/shared/utils/encryption/encryption_utils.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/forgotPassword_model.dart';
import 'package:flutter/foundation.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordModel model = ForgotPasswordModel();
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: 'forgot_password_form_key');
  final TextEditingController emailController = TextEditingController();
  final ApiMethod apiMethod = ApiMethod();
  final SharedPreferencesUtils _sharedPrefs;

  ForgotPasswordViewModel(this._sharedPrefs);

  String? otp; // Property to hold the OTP
  String? verificationKey; // Property to hold the verification key
  bool _isLoading = false; // Loading state property

  /// Getter for loading state
  bool get isLoading => _isLoading;

  /// Sets the loading state and notifies listeners
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> resetPassword(
      BuildContext context, Function(Map<String, dynamic>) onSuccess) async {
    if (formKey.currentState!.validate()) {
      _setLoading(true); // Set loading to true when starting the request
      try {
        final encryptionKey = EncryptionUtils.generateEncryptionKey();
        debugPrint('Generated Encryption Key: $encryptionKey');
        await _sharedPrefs
            .saveEmailToSharedPreferences(model.emailController.text.trim());

        // Send password reset OTP email
        Map<String, dynamic> msg = await apiMethod.sendOTP(
            model.emailController.text.trim(), encryptionKey);
        debugPrint('Response: $msg');

        // Check the response and call the onSuccess callback if successful
        if (msg.containsKey('statusCode') && msg['statusCode'] == 200) {
          otp = msg['otp']; // Store the OTP
          verificationKey =
              msg['verificationKey']; // Store the verification key
          onSuccess(msg); // Call the callback with the response
        } else {
          showWarningDialog(context, "Error Sending OTP!");
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
  }

  showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Warning',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the warning dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    model.dispose(); // Dispose of the model's controllers
    super.dispose();
  }
}
