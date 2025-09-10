import 'dart:core';
import 'package:carenest/app/core/base/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class SignupModel extends ChangeNotifier implements VisibilityToggleModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController abnController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationCodeController =
      TextEditingController();

  // Multi-tenant related fields
  String _selectedRole = 'normal'; // 'admin' or 'normal'
  bool _isJoiningOrganization = false;
  bool _isCreatingOrganization = false;
  bool _isVisible = false;
  bool _isValid = false;

  @override
  bool get isVisible => _isVisible;

  @override
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  bool get isValid => _isValid;

  // Getters and setters for multi-tenant fields
  String get selectedRole => _selectedRole;
  set selectedRole(String value) {
    _selectedRole = value;
    notifyListeners();
  }

  bool get isJoiningOrganization => _isJoiningOrganization;
  set isJoiningOrganization(bool value) {
    _isJoiningOrganization = value;
    _isCreatingOrganization = false; // Can't do both
    notifyListeners();
  }

  bool get isCreatingOrganization => _isCreatingOrganization;
  set isCreatingOrganization(bool value) {
    _isCreatingOrganization = value;
    _isJoiningOrganization = false; // Can't do both
    notifyListeners();
  }

  void validateFields() {
    debugPrint(
        'email: ${emailController.text}\npassword: ${passwordController.text}\nconfirmPassword: ${confirmPasswordController.text}\nfirstName: ${firstNameController.text}\nlastName: ${lastNameController.text}\nabn: ${abnController.text} ${abnController.text.length}');
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    final isEmailValid = emailRegex.hasMatch(emailController.text);
    final isPasswordValid = passwordController.text.isNotEmpty;
    final isConfirmPasswordValid =
        confirmPasswordController.text == passwordController.text;
    final isFirstNameValid = firstNameController.text.isNotEmpty;
    final isLastNameValid = lastNameController.text.isNotEmpty;
    final isAbnValid =
        abnController.text.isNotEmpty && abnController.text.length == 11;
    debugPrint(
        'isEmailValid: $isEmailValid \n isPasswordValid: $isPasswordValid \n isConfirmPasswordValid: $isConfirmPasswordValid \n isFirstNameValid: $isFirstNameValid \n isLastNameValid: $isLastNameValid \n isAbnValid: $isAbnValid');
    // Additional validation for organization fields
    bool isOrganizationValid = true;
    if (_selectedRole == 'admin' && _isCreatingOrganization) {
      isOrganizationValid = organizationNameController.text.isNotEmpty;
    } else if (_isJoiningOrganization) {
      isOrganizationValid = organizationCodeController.text.isNotEmpty;
    }

    _isValid = isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        isFirstNameValid &&
        isLastNameValid &&
        isAbnValid &&
        isOrganizationValid;
    notifyListeners();
  }

  void isValidEmail(String input) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    _isValid = emailRegex.hasMatch(input);
    notifyListeners();
  }

  void isValidPassword(String input, String confirmPassword) {
    _isValid = input == confirmPassword;
    notifyListeners();
  }

  @override
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    abnController.dispose();
    organizationNameController.dispose();
    organizationCodeController.dispose();
    super.dispose();
  }
}
