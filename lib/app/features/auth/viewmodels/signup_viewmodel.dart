import 'package:carenest/app/core/utils/Services/signupResult.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carenest/app/features/auth/models/signup_model.dart';
import 'package:flutter/foundation.dart';

class SignupViewModel extends ChangeNotifier {
  final SignupModel model = SignupModel();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var ins;
  dynamic result;
  ApiMethod apiMethod = ApiMethod();

  // Loading state property
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Sets the loading state and notifies listeners
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Organization-related properties
  String? _organizationId;
  String? _organizationName;
  String? _organizationCode;

  // Getters for organization properties
  String? get organizationId => _organizationId;
  String? get organizationName => _organizationName;
  String? get organizationCode => _organizationCode;

  // Setters for organization properties
  set organizationId(String? value) {
    _organizationId = value;
    notifyListeners();
  }

  set organizationName(String? value) {
    _organizationName = value;
    notifyListeners();
  }

  set organizationCode(String? value) {
    _organizationCode = value;
    notifyListeners();
  }

  Future<SignupResult> signup(
      BuildContext context, GlobalKey<FormState> formKey) async {
    debugPrint('SignupViewModel.signup');
    _setLoading(true);

    try {
      if (formKey.currentState!.validate()) {
        if (model.passwordController.text ==
            model.confirmPasswordController.text) {
          // try {
          // UserCredential userCredential =
          //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //   email: model.emailController.text,
          //   password: model.passwordController.text,
          // );

          // await FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(userCredential.user?.uid)
          //     .set({
          //   'email': model.emailController.text,
          // });

          // Handle multi-tenant signup
          String? organizationId;
          String? organizationCode;

          // If creating organization (admin role)
          // Handle organization creation or joining
          if (model.selectedRole == 'admin' && model.isCreatingOrganization) {
            debugPrint("DEBUG: Starting organization creation...");
            debugPrint(
                "DEBUG: Organization name: ${model.organizationNameController.text}");
            debugPrint("DEBUG: Owner email: ${model.emailController.text}");

            var orgResult = await apiMethod.createOrganization(
              model.organizationNameController.text,
              model.emailController.text,
            );
            debugPrint("DEBUG: Organization creation result: ${orgResult}");
            debugPrint(
                "DEBUG: Organization result type: ${orgResult.runtimeType}");
            debugPrint("DEBUG: Organization result keys: ${orgResult.keys}");

            // Check if organization creation was successful
            // Success response contains organizationId and organizationCode
            // Error response contains 'error' key
            if (orgResult.containsKey('error')) {
              debugPrint(
                  "DEBUG: Organization creation failed with error: ${orgResult['error']}");
              return SignupResult(
                success: false,
                title: "Error",
                message: orgResult['error'] ?? "Failed to create organization",
                backgroundColor: AppColors.colorWarning,
              );
            } else if (orgResult.containsKey('organizationId') &&
                orgResult.containsKey('organizationCode')) {
              debugPrint("DEBUG: Organization created successfully!");
              organizationId = orgResult['organizationId'];
              organizationCode = orgResult['organizationCode'];
              // Set the properties for access in the view
              _organizationId = orgResult['organizationId'];
              _organizationName = model.organizationNameController.text;
              _organizationCode = orgResult['organizationCode'];
              debugPrint("DEBUG: Organization ID: $organizationId");
              debugPrint("DEBUG: Organization Code: $organizationCode");
            } else {
              debugPrint(
                  "DEBUG: Organization creation failed - unexpected response format");
              debugPrint(
                  "DEBUG: Expected 'organizationId' and 'organizationCode' keys but got: ${orgResult.keys}");
              return SignupResult(
                success: false,
                title: "Error",
                message: "Failed to create organization - invalid response",
                backgroundColor: AppColors.colorWarning,
              );
            }
          }
          // If joining organization
          else if (model.isJoiningOrganization) {
            var verifyResult = await apiMethod.verifyOrganizationCode(
              model.organizationCodeController.text,
            );
            if (verifyResult['success'] == true) {
              organizationId = verifyResult['organizationId'];
              organizationCode = model.organizationCodeController.text;
              // Set the properties for access in the view
              _organizationId = verifyResult['organizationId'];
              _organizationName = verifyResult['organizationName'];
              _organizationCode = model.organizationCodeController.text;
            } else {
              return SignupResult(
                success: false,
                title: "Error",
                message: verifyResult['message'] ?? "Invalid organization code",
                backgroundColor: AppColors.colorWarning,
              );
            }
          }

          debugPrint("DEBUG: Starting user signup...");
          debugPrint("DEBUG: Organization ID for signup: $organizationId");
          debugPrint("DEBUG: Organization Code for signup: $organizationCode");

          var success = await apiMethod.signupUser(
            model.firstNameController.text,
            model.lastNameController.text,
            model.emailController.text,
            model.passwordController.text,
            model.abnController.text,
            model.selectedRole,
            organizationId: organizationId,
            organizationCode: organizationCode,
          );
          debugPrint('DEBUG: User signup result: $success');
          debugPrint('DEBUG: User signup result type: ${success.runtimeType}');
          debugPrint('DEBUG: User signup result keys: ${success.keys}');

          if (success.containsKey('error')) {
            debugPrint("DEBUG: User signup failed!");
            String errorMessage = success['error'] ?? "Unknown error occurred";
            debugPrint("DEBUG: Error message: $errorMessage");
            return SignupResult(
              success: false,
              title: "Error",
              message: errorMessage,
              backgroundColor: AppColors.colorWarning,
            );
          } else if (success.containsKey('userId') ||
              success.containsKey('message')) {
            debugPrint("DEBUG: User signup successful!");
            String message = success['message'] ?? "Signup successful";
            return SignupResult(
              success: true,
              title: "Success",
              message: message,
              backgroundColor: AppColors.colorPrimary,
            );
          } else {
            debugPrint(
                "DEBUG: User signup failed - unexpected response format");
            debugPrint(
                "DEBUG: Expected 'userId' or 'message' keys but got: ${success.keys}");
            return SignupResult(
              success: false,
              title: "Error",
              message: "Failed to signup user - invalid response",
              backgroundColor: AppColors.colorWarning,
            );
          }
        } else {
          return SignupResult(
            success: false,
            title: "Error",
            message: "Passwords do not match",
            backgroundColor: AppColors.colorWarning,
          );
        }
      } else {
        return SignupResult(
          success: false,
          title: "Error",
          message: "Form is not valid",
          backgroundColor: AppColors.colorWarning,
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    model.dispose(); // Dispose of the model's controllers
    super.dispose();
  }
}
