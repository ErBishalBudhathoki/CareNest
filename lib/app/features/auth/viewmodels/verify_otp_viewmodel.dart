import 'package:flutter/material.dart';

class VerifyOTPViewModel extends ChangeNotifier {
  final TextEditingController pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
