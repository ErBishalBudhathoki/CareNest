
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';

import 'package:carenest/app/features/auth/models/changePassword_model.dart';
import 'package:carenest/app/shared/utils/encryption/encryption_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  // Create a unique key for each instance
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: 'change_password_form_key');
  String _user = '';
  //late dynamic _email = '';
  late dynamic _password = '';
  late dynamic _confirmPassword = '';
  //String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  //set email(String email) => _email = email;
  set password(String password) => _password = password;
  set confirmPassword(String confirmPassword) =>
      _confirmPassword = confirmPassword;
  String get user => _user;
  ValueNotifier<bool> get passwordVisibleNotifier =>
      ValueNotifier<bool>(model.isVisible);
  ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  ValueNotifier<bool> get confirmPasswordVisibleNotifier =>
      ValueNotifier<bool>(model.isConfirmPasswordVisible);

  // Use the model's controllers
  ChangePasswordModel model = ChangePasswordModel();
  TextEditingController get newPasswordController =>
      model.newPasswordController;
  TextEditingController get confirmPasswordController =>
      model.confirmNewPasswordController;

  void validatePasswords() {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Check for password strength
    if (newPassword.length < 8) {
      errorNotifier.value = 'Password must be at least 8 characters long';
      return;
    }
    if (!RegExp(r'[A-Z]').hasMatch(newPassword)) {
      errorNotifier.value =
          'Password must contain at least one uppercase letter';
      return;
    }
    if (!RegExp(r'[a-z]').hasMatch(newPassword)) {
      errorNotifier.value =
          'Password must contain at least one lowercase letter';
      return;
    }
    if (!RegExp(r'[0-9]').hasMatch(newPassword)) {
      errorNotifier.value = 'Password must contain at least one number';
      return;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPassword)) {
      errorNotifier.value =
          'Password must contain at least one special character';
      return;
    }
    if (newPassword != confirmPassword) {
      errorNotifier.value = 'Passwords do not match';
      return;
    }

    // If all checks pass
    errorNotifier.value = null; // Clear any previous error messages
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null; // Return null if validation passes
  }

  set user(String value) => _user = value;

  ChangePasswordViewModel(Ref ref) {
    //  _email = email;
    _password = password;
    _confirmPassword = confirmPassword;
  }

  //get set methods for email and password

  // create the user object from json input
  ChangePasswordViewModel.fromJson(Map<String, dynamic> json) {
    // _email = json['email'] as String;
    _password = json['password'] as String;
    _confirmPassword = json['confirmPassword'] as String;
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['email'] = _email as String;
    data['password'] = _password as String;
    data['confirmPassword'] = _confirmPassword as String;
    return data;
  }

  ApiMethod apiMethod = ApiMethod();

  Future<Map<String, dynamic>?> changePassword(String password,
      String confirmPassword, BuildContext context, WidgetRef ref) async {
    try {
      if (model.confirmNewPasswordController.text !=
          model.newPasswordController.text) {
        throw Exception('Passwords must match'); // Handle mismatch error
      }

      // Encrypt the password with the generated salt
      EncryptionUtils encryptionUtils = EncryptionUtils();
      Uint8List salt = encryptionUtils.generateSalt();
      if (confirmPassword.trim().isEmpty) {
        debugPrint("Password field is empty!");
      } else {
        debugPrint("Password: $confirmPassword");
      }

      debugPrint("pass: $confirmPassword");
      var hashedPasswordWithSalt = encryptionUtils
          .encryptPasswordWithArgon2andSalt(confirmPassword.trim(), salt);
      // Now use read to get the SharedPreferencesUtils instance:

      final prefsUtils = ref.read(sharedPreferencesProvider);
      final email = await prefsUtils.getUserEmailFromSharedPreferences();

      // Send the hashed password and email to the server
      final res =
          await apiMethod.changePassword(hashedPasswordWithSalt, email!);
      debugPrint('Response: $res');
      return res;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      // Show error message
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

  Uint8List generateSalt({int length = 32}) {
    var random = Random.secure();
    return Uint8List.fromList(
        List.generate(length, (_) => random.nextInt(256)));
  }
}
