import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';

void popUpClientDetails(
  BuildContext context,
  String message,
  String title, {
  String? detailMessage,
}) {
  if (message == "Success") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(message,
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: BauhausDesign.textDark,
                      )),
          content: Text(
            detailMessage ?? '$title details added successfully',
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  height: 1.5,
                ),
          ),
          actions: [
            BauhausActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'OK',
              variant: BauhausActionVariant.primary,
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(message,
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: BauhausDesign.error,
                      )),
          content: Text(
            detailMessage ?? 'Failed or data already added for $title',
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  color: BauhausDesign.textDark,
                  height: 1.5,
                ),
          ),
          actions: [
            BauhausActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'OK',
              variant: BauhausActionVariant.primary,
            )
          ],
        );
      },
    );
  }
}
