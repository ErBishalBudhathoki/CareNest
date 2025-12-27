import 'package:flutter/material.dart';

void popUpClientDetails(BuildContext context, String message, String title) {
  if (message == "Success") {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                color: const Color(0xFF1F2937),
              )),
          content: Text(
            '$title details added successfully',
            style: const TextStyle(fontSize: 16).copyWith(
              color: const Color(0xFF1F2937),
              height: 1.5,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16)))
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                color: Colors.red,
              )),
          content: Text(
            'Failed or data already added for $title',
            style: const TextStyle(fontSize: 16).copyWith(
              color: const Color(0xFF1F2937),
              height: 1.5,
              fontFamily: 'Lato',
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16)))
          ],
        );
      },
    );
  }
}
