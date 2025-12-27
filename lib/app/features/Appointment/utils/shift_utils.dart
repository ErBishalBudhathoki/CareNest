bool isShiftCompleted(Map<String, dynamic> shift, List<dynamic> timeRecords) {
  if (timeRecords.isEmpty) return false;

  String shiftKey = '${shift['date']}_${shift['startTime']}';

  return timeRecords.any((record) {
    String recordKey = '${record['date']}_${record['startTime']}';
    return recordKey == shiftKey;
  });
}
