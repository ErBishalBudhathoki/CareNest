import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

void popUpClientDetails(BuildContext context, String message, String title) {
  if (message == "Success") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message,
              style: ModernSaasDesign.headlineSmall.copyWith(
                color: ModernSaasDesign.textPrimary,
              )),
          content: Text(
            '$title details added successfully',
            style: ModernSaasDesign.bodyLarge.copyWith(
              color: ModernSaasDesign.textPrimary,
              height: 1.5,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ModernSaasDesign.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK',
                    style: TextStyle(
                        color: ModernSaasDesign.textOnPrimary, fontSize: 16)))
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message,
              style: ModernSaasDesign.headlineSmall.copyWith(
                color: ModernSaasDesign.error,
              )),
          content: Text(
            'Failed or data already added for $title',
            style: ModernSaasDesign.bodyLarge.copyWith(
              color: ModernSaasDesign.textPrimary,
              height: 1.5,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ModernSaasDesign.error,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK',
                    style: TextStyle(
                        color: ModernSaasDesign.textOnPrimary, fontSize: 16)))
          ],
        );
      },
    );
  }
}
