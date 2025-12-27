import 'package:carenest/app/features/auth/models/verify_otp_model.dart';
import 'package:flutter/material.dart';

class VerifyOTPViewModel extends ChangeNotifier {
  final VerifyOTPModel model = VerifyOTPModel();
  final TextEditingController pinController = TextEditingController();
  // Create a unique key for each instance
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'verify_otp_form_key');
  String? errorMessage;
  Map<String, dynamic>? response;

  Future<void> verifyOTP(
      String enteredOTP,
      String otpGenerated,
      String encryptVerificationKey,
      BuildContext context,
      Function(String) showWarning) async {
    response = await model.verifyOTP(
        enteredOTP, otpGenerated, encryptVerificationKey, context);
    if (response?['statusCode'] != 200) {
      showWarning(response?['message'] ?? "Error Verifying OTP!");
      notifyListeners();
    } else if (response?['statusCode'] == 200) {
      showWarning(response?['message'] ?? "OTP verified");
      notifyListeners();
    } else {
      showWarning(response?['message'] ?? "Error Verifying OTP!");
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
