import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyOTPViewModel extends Notifier<void> {
  final TextEditingController pinController = TextEditingController();
  @override
  void build() {
    ref.onDispose(() => pinController.dispose());
  }


}
