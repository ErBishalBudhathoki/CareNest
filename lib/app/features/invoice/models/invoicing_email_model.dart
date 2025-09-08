import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/base/base_model.dart';

class InvoicingEmailModel extends ChangeNotifier
    implements VisibilityToggleModel {
  bool _isVisible = false;
  @override
  get isVisible => _isVisible;

  @override
  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isValid = false;
  get isValid => _isValid;

  void isValidEmail(String input) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    _isValid = emailRegex.hasMatch(input);
    notifyListeners();
  }
}
