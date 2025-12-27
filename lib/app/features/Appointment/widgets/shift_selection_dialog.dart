
import 'package:flutter/material.dart';

Future<int?> showShiftSelectionDialog(
  BuildContext context,
  dynamic assignedClient, // Changed from List<dynamic> to dynamic
  String currentClientEmail, // Add parameter for current client
) async {
  return showDialog<int>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ShiftSelectionDialogContent(
        assignedClient: assignedClient,
        currentClientEmail: currentClientEmail, // Pass to dialog
      );
    },
  );
}

class ShiftSelectionDialogContent extends StatefulWidget {
  final dynamic assignedClient; // Changed from List<dynamic> to dynamic
  final String currentClientEmail;

  const ShiftSelectionDialogContent({
    required this.assignedClient,
    required this.currentClientEmail,
    super.key,
  });

  @override
  _ShiftSelectionDialogContentState createState() =>
      _ShiftSelectionDialogContentState();
}

class _ShiftSelectionDialogContentState
    extends State<ShiftSelectionDialogContent> {
  List<Map<String, dynamic>> allShifts = [];
  Set<String> completedShiftKeys = {};

  @override
  void initState() {
    super.initState();
    _processShifts();
  }

  void _processShifts() {
    allShifts = [];
    completedShiftKeys = {};

    // Handle the case where assignedClient is a Map instead of a List
    Map<String, dynamic> currentClient;

    if (widget.assignedClient is List) {
      // Find the current client's data in the list
      final clientList = widget.assignedClient as List<dynamic>;
      final foundClient = clientList.firstWhere(
        (client) => client['clientEmail'] == widget.currentClientEmail,
        orElse: () => null,
      );

      if (foundClient == null) {
        debugPrint('Current client not found in assigned clients list');
        return;
      }
      currentClient = foundClient;
    } else if (widget.assignedClient is Map) {
      // assignedClient is already a Map containing the current client's data
      currentClient = widget.assignedClient as Map<String, dynamic>;
    } else {
      debugPrint(
          'Invalid assignedClient data type: ${widget.assignedClient.runtimeType}');
      return;
    }

    // Process only the current client's time records
    List<dynamic> timeRecords = currentClient['timeRecords'] ?? [];
    for (var record in timeRecords) {
      if (record['date'] != null && record['startTime'] != null) {
        completedShiftKeys.add('${record['date']}_${record['startTime']}');
      }
    }

    // Check for the new 'schedule' array first
    if (currentClient['schedule'] != null && currentClient['schedule'] is List) {
      final scheduleList = currentClient['schedule'] as List;
      for (int i = 0; i < scheduleList.length; i++) {
        final schedule = scheduleList[i];
        final date = schedule['date'] as String?;
        final startTime = schedule['startTime'] as String?;
        final endTime = schedule['endTime'] as String?;
        final breakTime = schedule['break'] as String?;

        if (date != null && startTime != null) {
          String shiftKey = '${date}_$startTime';
          allShifts.add({
            'index': i,
            'date': date,
            'startTime': startTime,
            'endTime': endTime,
            'break': breakTime,
            'isCompleted': completedShiftKeys.contains(shiftKey),
            'key': shiftKey,
          });
        }
      }
    } else {
      // Fallback to legacy format with separate arrays
      List<String> dates = List<String>.from(currentClient['dateList'] ?? []);
      List<String> startTimes =
          List<String>.from(currentClient['startTimeList'] ?? []);
      List<String> endTimes =
          List<String>.from(currentClient['endTimeList'] ?? []);
      List<String> breaks = List<String>.from(currentClient['breakList'] ?? []);

      for (int i = 0; i < dates.length; i++) {
        String shiftKey = '${dates[i]}_${startTimes[i]}';
        allShifts.add({
          'index': i,
          'date': dates[i],
          'startTime': startTimes[i],
          'endTime': endTimes[i],
          'break': breaks[i],
          'isCompleted': completedShiftKeys.contains(shiftKey),
          'key': shiftKey,
        });
      }
    }

    // Sort shifts by date and time
    allShifts.sort((a, b) {
      int dateComparison = a['date'].compareTo(b['date']);
      if (dateComparison != 0) return dateComparison;
      return a['startTime'].compareTo(b['startTime']);
    });

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allShifts.isEmpty) {
      return AlertDialog(
        title: const Text('No Shifts Available'),
        content: const Text('No shifts found for this client.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Close'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: const Text('Select Shift'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: allShifts.length,
          itemBuilder: (context, index) {
            final shift = allShifts[index];
            final bool isCompleted = shift['isCompleted'] as bool;

            return Card(
              elevation: isCompleted ? 0 : 1,
              color: isCompleted ? Colors.grey.shade100 : Colors.white,
              child: ListTile(
                title: Text(
                  'Date: ${shift['date']}',
                  style: TextStyle(
                    color: isCompleted ? Colors.grey : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Time: ${shift['startTime']} - ${shift['endTime']}\n'
                  'Break: ${shift['break']}',
                  style: TextStyle(
                    color: isCompleted ? Colors.grey : Colors.black54,
                  ),
                ),
                enabled: !isCompleted,
                onTap: isCompleted
                    ? null
                    : () => Navigator.of(context).pop(shift['index']),
                trailing: isCompleted
                    ? const Icon(Icons.check_circle, color: Colors.grey)
                    : const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}