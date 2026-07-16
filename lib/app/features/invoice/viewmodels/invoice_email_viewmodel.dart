import 'package:flutter/foundation.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
class InvoiceEmailViewModel extends Notifier<int> {
  @override
  int build() => 0;

  bool isResponseReceived = false;
  bool isLoading = false;

  void setIsLoading(bool value) {
    isLoading = value;
    state = state + 1;
  }

  void setIsResponseReceived(bool value) {
    isResponseReceived = value;
    state = state + 1;
  }
}
