import 'dart:core';
import 'package:carenest/app/core/base/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangePasswordModel extends ChangeNotifier
    implements VisibilityToggleModel {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  get isVisible => _isNewPasswordVisible;

  // Separate getter for confirm password visibility (not part of interface)
  get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  @override
  set isVisible(value) {
    _isNewPasswordVisible = value;
    notifyListeners();
  }

  // Separate setter for confirm password visibility (not part of interface)
  set isConfirmPasswordVisible(value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }
}
