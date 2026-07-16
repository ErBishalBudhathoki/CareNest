import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Base state for controllers using Riverpod
abstract class BaseState {
  const BaseState();
}

/// Loading state mixin
mixin LoadingState {
  bool get isLoading;
}

/// Error state mixin
mixin ErrorState {
  String? get error;
}

/// Base controller using Riverpod 3.x Notifier
abstract class BaseController<T extends BaseState> extends Notifier<T> {
  void initData();
  void onViewReady();
  void disposeData();

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
