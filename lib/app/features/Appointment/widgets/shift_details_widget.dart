
import 'package:flutter/material.dart';

class ShiftDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> shiftData;

  const ShiftDetailsWidget({
    super.key,
    required this.shiftData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < shiftData['dateList'].length; i++)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${shiftData['dateList'][i]}'),
                  Text('Start Time: ${shiftData['startTimeList'][i]}'),
                  Text('End Time: ${shiftData['endTimeList'][i]}'),
                  Text('Break: ${shiftData['breakList'][i]}'),
                  if (shiftData['Time'] != null && i < shiftData['Time'].length)
                    Text('Time Worked: ${shiftData['Time'][i]}'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
