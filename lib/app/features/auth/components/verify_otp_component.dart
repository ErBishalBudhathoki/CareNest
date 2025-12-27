import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/utils/encryption/encryption_utils.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPView extends ConsumerStatefulWidget {
  final String otpGenerated;
  final String encryptVerificationKey;
  const VerifyOTPView({
    super.key,
    required this.otpGenerated,
    required this.encryptVerificationKey,
  });
//EncryptionUtils.encryptionKey,
  @override
  ConsumerState<VerifyOTPView> createState() {
    return _VerifyOTPState();
  }
}

class _VerifyOTPState extends ConsumerState<VerifyOTPView> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey =
      GlobalKey<FormState>(debugLabel: 'verify_otp_component_form_key');
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'verify_otp_component_scaffold_key');

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController textEditingController = TextEditingController();

    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(AppDimens.padding),
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  SizedBox(height: context.height * 0.023),
                  const Text(
                    'Verify OTP!',
                    style: TextStyle(
                      color: AppColors.colorFontAccent,
                      fontSize: AppDimens.fontSizeXXMax,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: context.height * 0.023),
                  const Text(
                    'Is this really you?',
                    style: TextStyle(
                      fontSize: AppDimens.fontSizeNormal,
                      color: AppColors.colorFontPrimary,
                    ),
                  ),
                  SizedBox(height: context.height * 0.023),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Pinput(
                          length: 6,
                          controller: pinController,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        ButtonWidget(
                          buttonText: 'Verify',
                          buttonColor: AppColors.colorPrimary,
                          textColor: Colors.white,
                          onPressed: () async {
                            debugPrint('Verify button pressed');
                            var response = await _verifyOTP(
                              pinController.text,
                              widget.otpGenerated,
                            );
                            if (response.containsKey('statusCode')) {
                              if (response['statusCode'] == 200) {
                                Navigator.push(
                                  _scaffoldKey.currentContext!,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePasswordView(),
                                  ),
                                );
                              } else if (response['statusCode'] == 500) {
                                showWarningDialog("Error Verifying OTP!");
                              } else {
                                debugPrint('Error at Server');
                                showWarningDialog(
                                    "Error at verifying otp code!");
                                Navigator.of(_scaffoldKey.currentContext!,
                                        rootNavigator: true)
                                    .pop();
                              }
                            } else {
                              debugPrint('Error at Server');
                              Navigator.of(_scaffoldKey.currentContext!,
                                      rootNavigator: true)
                                  .pop();
                            }
                          },
                        ),
                      ]),
                ])))));
  }

  showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Warning',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensure the column takes minimal space
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

  ApiMethod apiMethod = ApiMethod();
  Future<Map<String, dynamic>> _verifyOTP(
      //check line 259 onwards in server side code
      String enteredOTP,
      otpGenerated) async {
    try {
      debugPrint("Before+++Entered otp: $enteredOTP,\n "
          "flutter user encryption key: ${EncryptionUtils.encryptionKey!},\n"
          "otp generated: ${widget.otpGenerated},\n"
          "encryption verification key: ${widget.encryptVerificationKey}\n");

      Map<String, dynamic> msg = await apiMethod.verifyOTP(
        enteredOTP, //user otp
        EncryptionUtils.encryptionKey!, //user verification key
        widget.otpGenerated,
        widget.encryptVerificationKey,
      );
      debugPrint("After+++Entered otp: $enteredOTP ,\n "
          "flutter user encryption key: ${EncryptionUtils.encryptionKey!},\n"
          "otp generated: ${widget.otpGenerated},\n"
          "encryption verification key: ${widget.encryptVerificationKey}\n");

      return msg;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      // Catch any errors that might occur due to the context issue
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((e).toString()),
        ),
      );
      // Return an error map with appropriate keys and values
      return {
        'statusCode': -1, // or another value indicating an error
        'message': e.toString(),
        'stackTrace': stackTrace.toString(),
      };
    }
  }
}
