import 'package:carenest/app/core/utils/Services/signup_result.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/auth/models/signup_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;

class SignupViewModel extends Notifier<int> {
  final SignupModel model = SignupModel();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var ins;
  dynamic result;
  late final ApiMethod apiMethod;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  int build() {
    apiMethod = ref.watch(app_providers.apiMethodProvider);
    _firebaseAuthService = FirebaseAuthService();
    return 0;
  }

  void notifyListeners() {
    state = state + 1;
  }

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

  void prefillOrganizationCode(String organizationCode) {
    model.organizationCodeController.text = organizationCode;
    model.isJoiningOrganization = true;
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
          // Determine if creating organization (admin role)
          bool isOwner =
              model.selectedRole == 'admin' && model.isCreatingOrganization;
          String? orgName =
              isOwner ? model.organizationNameController.text : null;

          // If joining organization, verify the code first
          String? organizationId;
          String? organizationCode;

          if (model.isJoiningOrganization && !isOwner) {
            debugPrint("DEBUG: Verifying organization code...");
            var verifyResult = await apiMethod.verifyOrganizationCode(
              model.organizationCodeController.text,
            );
            if (verifyResult['success'] == true) {
              organizationId = verifyResult['organizationId'];
              organizationCode = model.organizationCodeController.text;
              _organizationId = verifyResult['organizationId'];
              _organizationName = verifyResult['organizationName'];
              _organizationCode = model.organizationCodeController.text;
            } else {
              return SignupResult(
                success: false,
                title: "Error",
                message: verifyResult['message'] ?? "Invalid organization code",
                surfaceColor: Colors.red,
              );
            }
          }

          // Step 1: Call backend /register — backend creates Firebase user via Admin SDK
          debugPrint("DEBUG: Calling backend register endpoint...");
          debugPrint("DEBUG: isOwner: $isOwner");
          debugPrint("DEBUG: organizationName: $orgName");
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
            organizationName: orgName,
            isOwner: isOwner,
          );
          debugPrint('DEBUG: MongoDB user creation result: $success');

          if (success.containsKey('error')) {
            debugPrint("DEBUG: Backend registration failed!");

            String errorMessage = success['error'] ?? "Unknown error occurred";
            return SignupResult(
              success: false,
              title: "Error",
              message: errorMessage,
              surfaceColor: Colors.red,
            );
          } else if (success.containsKey('success') ||
              success.containsKey('userId')) {
            debugPrint("DEBUG: Backend registration successful!");

            // Extract organization info from response if available
            final data = success['data'] ?? success;
            debugPrint("DEBUG: Response data: $data");
            if (data is Map) {
              _organizationId = data['organizationId']?.toString();
              _organizationCode = data['organizationCode']?.toString() ??
                  data['organization']?['code']?.toString();
              _organizationName = data['organizationName']?.toString() ??
                  data['organization']?['name']?.toString();
              debugPrint(
                  "DEBUG: Extracted orgId: $_organizationId, orgCode: $_organizationCode, orgName: $_organizationName");
            }

            final signupEmail = model.emailController.text.trim();
            String message =
                'Account created. Check $signupEmail for a verification link before signing in.';

            try {
              await _sendFirebaseVerificationEmail(
                email: signupEmail,
                password: model.passwordController.text.trim(),
              );
            } catch (verificationError) {
              debugPrint(
                  'DEBUG: Non-fatal verification email send failure: $verificationError');
              message =
                  'Account created. Please sign in and request email verification from Settings.';
            }
            return SignupResult(
              success: true,
              title: "Success",
              message: message,
              surfaceColor: Colors.green,
            );
          } else {
            debugPrint(
                "DEBUG: User signup failed - unexpected response format");
            return SignupResult(
              success: false,
              title: "Error",
              message: "Failed to signup user - invalid response",
              surfaceColor: Colors.red,
            );
          }
        } else {
          return SignupResult(
            success: false,
            title: "Error",
            message: "Passwords do not match",
            surfaceColor: Colors.red,
          );
        }
      } else {
        return SignupResult(
          success: false,
          title: "Error",
          message: "Form is not valid",
          surfaceColor: Colors.red,
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _sendFirebaseVerificationEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null && credential.user!.emailVerified != true) {
        await _firebaseAuthService.sendEmailVerification();
      }
    } finally {
      await _firebaseAuthService.signOut();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    model.dispose();
    
  }
}
