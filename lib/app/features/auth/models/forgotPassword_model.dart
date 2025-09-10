import 'dart:core';
import 'package:carenest/app/core/base/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordModel extends ChangeNotifier
    implements VisibilityToggleModel {
  final TextEditingController emailController = TextEditingController();
  bool _isValid = false;
  bool _isVisible = false;

  bool get isValid => _isValid;

  void isValidEmail(String input) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    _isValid = emailRegex.hasMatch(input);
    notifyListeners();
  }

  @override
  bool get isVisible => _isVisible;

  @override
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  @override
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
