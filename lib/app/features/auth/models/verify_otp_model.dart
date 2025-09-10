import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/encryption/encryption_utils.dart';
import 'package:flutter/foundation.dart';

class VerifyOTPModel {
  final ApiMethod apiMethod = ApiMethod();

  Future<Map<String, dynamic>> verifyOTP(String enteredOTP, String otpGenerated,
      String encryptVerificationKey, BuildContext context) async {
    try {
      debugPrint("Before+++Entered otp: $enteredOTP,\n "
          "flutter user encryption key: ${EncryptionUtils.encryptionKey!},\n"
          "otp generated: $otpGenerated,\n"
          "encryption verification key: $encryptVerificationKey\n");

      Map<String, dynamic> msg = await apiMethod.verifyOTP(
        enteredOTP,
        EncryptionUtils.encryptionKey!,
        otpGenerated,
        encryptVerificationKey,
      );

      debugPrint("After+++Entered otp: $enteredOTP ,\n "
          "flutter user encryption key: ${EncryptionUtils.encryptionKey!},\n"
          "otp generated: $otpGenerated,\n"
          "encryption verification key: $encryptVerificationKey\n");

      return msg;
    } catch (e) {
      debugPrint(e.toString());
      return {'statusCode': -1, 'message': e.toString()};
    }
  }
}
