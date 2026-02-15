import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/forgotPassword_model.dart';

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

  Future<void> resetPassword(
      BuildContext context, Function(Map<String, dynamic>) onSuccess) async {
    _setLoading(true); // Set loading to true when starting the request
    try {
      await _sharedPrefs
          .saveEmailToSharedPreferences(model.emailController.text.trim());

      // Send password reset OTP email
      final msg = await apiMethod.sendOTP(model.emailController.text.trim());
      debugPrint('Response: $msg');

      final isSuccess = msg['success'] == true || msg['statusCode'] == 200;
      if (isSuccess) {
        onSuccess(msg);
      } else {
        showWarningDialog(
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

  showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(
                color: BauhausDesign.neutral,
                width: 2,
              ),
              boxShadow: const [
                BauhausDesign.shadowHard,
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: BauhausDesign.warning.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(BauhausDesign.radiusMd - 2),
                      topRight: Radius.circular(BauhausDesign.radiusMd - 2),
                    ),
                    border: const Border(
                      bottom: BorderSide(
                        color: BauhausDesign.neutral,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: BauhausDesign.warning,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(
                            color: BauhausDesign.neutral,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.warning_rounded,
                          color: BauhausDesign.surfaceWhite,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Warning',
                        style: BauhausDesign.getTextTheme(context)
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    message,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          height: 1.5,
                        ),
                  ),
                ),

                // Action Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: BauhausActionButton(
                    text: 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    variant: BauhausActionVariant.primary,
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
          ),
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
