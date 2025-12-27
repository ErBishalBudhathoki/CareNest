import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DialogUtils {
  static void showWarningDialog(
      BuildContext context, String message, String alertMessageTitle,
      {VoidCallback? onOkPressed}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            title: Center(
              child: Text(
                alertMessageTitle,
                style: alertMessageTitle == 'Success'
                    ? const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)
                    : const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                        color: Colors.red,
                      ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  alertMessageTitle == 'Success'
                      ? 'assets/lottieAnimationJSON/loading_horizontal_line.json'
                      : 'assets/lottieAnimationJSON/warning.json',
                  height: 120,
                  width: 200,
                ),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the warning dialog
                  if (onOkPressed != null) {
                    onOkPressed();
                  }
                },
              ),
            ],
          );
        },
      );
    });
  }
}
