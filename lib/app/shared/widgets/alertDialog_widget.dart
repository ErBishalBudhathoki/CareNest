import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Container(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ModernSaasDesign.textPrimary),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "Checking details...",
              overflow: TextOverflow.ellipsis,
              style: ModernSaasDesign.bodyLarge,
            ),
          ),
        ],
      ),
    ),
  );
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
