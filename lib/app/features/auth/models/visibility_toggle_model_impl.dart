import 'package:carenest/app/core/base/base_model.dart';
import 'package:flutter/material.dart';

class VisibilityToggleModelImpl extends ChangeNotifier
    implements VisibilityToggleModel {
  bool _isVisible = false;

  @override
  bool get isVisible => _isVisible;

  @override
  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }
}
