import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class InvoiceHelpers {
  Map<String, String> itemMap = {
    'Default': 'Item Map',
  };

  /// Finds the day of the week for a list of date strings.
  List<String> findDayOfWeek(List<String> dateList) {
    final daysOfWeek = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return dateList.map((date) {
      final dayOfWeekIndex = DateTime.parse(date).weekday;
      return daysOfWeek[dayOfWeekIndex - 1];
    }).toList();
  }

  String _sanitizeTimeString(String timeStr) {
    // Handle null or empty strings
    if (timeStr == null || timeStr.isEmpty) {
      debugPrint('Warning: Empty time string provided to _sanitizeTimeString');
      return '12:00 AM'; // Default time
    }
    
    // Remove any text after "at" if present
    if (timeStr.contains(' at ')) {
      timeStr = timeStr.split(' at ')[0].trim();
      debugPrint('Removed "at" and text after it: "$timeStr"');
    }
    
    // Try multiple regex patterns to extract time
    // Pattern 1: Standard time with AM/PM (e.g., "6:00 AM", "3:45 PM")
    final standardTimeRegex = RegExp(r'\b(\d{1,2}:\d{2}(:\d{2})?(\s*[AaPp][Mm]?)?)\b');
    final standardMatch = standardTimeRegex.firstMatch(timeStr);
    
    if (standardMatch != null && standardMatch.group(1) != null) {
      final result = standardMatch.group(1)!.trim();
      debugPrint('Extracted standard time: "$result"');
      return result;
    }
    
    // Pattern 2: Just hours with AM/PM (e.g., "6 AM", "3 PM")
    final hoursWithAmPmRegex = RegExp(r'\b(\d{1,2}\s*[AaPp][Mm]?)\b');
    final hoursWithAmPmMatch = hoursWithAmPmRegex.firstMatch(timeStr);
    
    if (hoursWithAmPmMatch != null && hoursWithAmPmMatch.group(1) != null) {
      final result = hoursWithAmPmMatch.group(1)!.trim();
      debugPrint('Extracted hours with AM/PM: "$result"');
      return result;
    }
    
    // Pattern 3: 24-hour format (e.g., "14:30", "06:45")
    final militaryTimeRegex = RegExp(r'\b([01]?\d|2[0-3]):[0-5]\d\b');
    final militaryMatch = militaryTimeRegex.firstMatch(timeStr);
    
    if (militaryMatch != null && militaryMatch.group(0) != null) {
      final result = militaryMatch.group(0)!.trim();
      debugPrint('Extracted 24-hour format: "$result"');
      return result;
    }
    
    // Pattern 4: Just numeric hours (e.g., "6", "14")
    final justHoursRegex = RegExp(r'\b(\d{1,2})\b');
    final justHoursMatch = justHoursRegex.firstMatch(timeStr);
    
    if (justHoursMatch != null && justHoursMatch.group(1) != null) {
      final hours = justHoursMatch.group(1)!.trim();
      final result = '$hours:00';
      debugPrint('Extracted just hours and added minutes: "$result"');
      return result;
    }
    
    // If all regex attempts fail, fall back to character filtering
    debugPrint('Falling back to character filtering for: "$timeStr"');
    var buffer = StringBuffer();
    for (var rune in timeStr.runes) {
      if ((rune >= 48 && rune <= 57) || // 0-9
          (rune == 58) || // :
          (rune == 32) || // space
          (rune >= 65 && rune <= 90) || // A-Z (for AM/PM)
          (rune >= 97 && rune <= 122)) { // a-z (for am/pm)
        buffer.write(String.fromCharCode(rune));
      }
    }
    final result = buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
    debugPrint('Character filtering result: "$result"');
    return result;
  }

  DateTime _parseSanitizedTime(String timeStr) {
    try {
      // First, check if the string contains "at" and extract the time part before it
      if (timeStr.contains(" at ")) {
        final parts = timeStr.split(" at ");
        timeStr = parts[0].trim();
        debugPrint('Extracted time part before "at": "$timeStr"');
      }
      
      // Then sanitize the time string
      final sanitizedTimeStr = _sanitizeTimeString(timeStr);
      debugPrint('Sanitized time string: "$sanitizedTimeStr"');
      
      // Try to parse with jm format (e.g., "6:00 AM")
      try {
        return DateFormat.jm().parse(sanitizedTimeStr);
      } catch (e) {
        // If that fails, try with Hm format (e.g., "06:00")
        try {
          return DateFormat('H:mm').parse(sanitizedTimeStr);
        } catch (e2) {
          // If that fails too, try with just hour format (e.g., "6")
          try {
            final hour = int.parse(sanitizedTimeStr.replaceAll(RegExp(r'[^0-9]'), ''));
            return DateTime(1970, 1, 1, hour % 24, 0);
          } catch (e3) {
            throw Exception('Failed to parse time with multiple formats');
          }
        }
      }
    } catch (e) {
      debugPrint('Error parsing time "$timeStr": $e');
      // Return a default time as fallback
      return DateFormat.jm().parse("12:00 AM");
    }
  }

  /// Gets the time period based on the provided time string.
  String getTimePeriod(String timeStr) {
    if (timeStr.isEmpty) return "Unknown";
    DateTime time = _parseSanitizedTime(timeStr);
    int currentHour = time.hour;
    if (currentHour >= 6 && currentHour < 12) return "Morning";
    if (currentHour >= 12 && currentHour < 18) return "Daytime";
    if (currentHour >= 18 && currentHour < 21) return "Evening";
    return "Night";
  }

  /// Calculates total hours worked based on start and end times.
  List<double> calculateTotalHours(List<String> startTimeList,
      List<String> endTimeList, List<String> timeList) {
    List<double> totalHours = [];
    for (int i = 0; i < startTimeList.length; i++) {
      try {
        debugPrint('Processing hours for index $i');
        
        // If timeList has a value at this index, try to use it directly
        if (i < timeList.length && timeList[i].isNotEmpty) {
          try {
            debugPrint('Using timeList value: "${timeList[i]}"');
            double hours = hoursFromTimeString(timeList[i]);
            debugPrint('Successfully parsed hours from timeList: $hours');
            totalHours.add(hours);
            continue; // Skip to next iteration
          } catch (e) {
            debugPrint('Error parsing time from timeList "${timeList[i]}": $e');
            // Fall through to the start/end time calculation
          }
        }
        
        // If we get here, either timeList didn't have a value or parsing failed
        debugPrint('Calculating hours from start/end times: "${startTimeList[i]}" to "${endTimeList[i]}"');
        
        try {
          // Try using hoursBetweenPerListItem which has multiple fallback methods
          double hours = hoursBetweenPerListItem(startTimeList[i], endTimeList[i]);
          debugPrint('Successfully calculated hours using hoursBetweenPerListItem: $hours');
          totalHours.add(hours);
        } catch (e2) {
          debugPrint('Error using hoursBetweenPerListItem: $e2');
          
          // Last resort: try direct calculation with _parseSanitizedTime
          try {
            DateTime startTime = _parseSanitizedTime(startTimeList[i]);
            DateTime endTime = _parseSanitizedTime(endTimeList[i]);
            double hoursWorked = endTime.difference(startTime).inMinutes / 60.0;
            
            // Handle overnight shifts
            if (hoursWorked < 0) {
              debugPrint('Detected overnight shift in direct calculation');
              hoursWorked += 24;
            }
            
            debugPrint('Successfully calculated hours using direct method: $hoursWorked');
            totalHours.add(hoursWorked);
          } catch (e3) {
            debugPrint('All calculation methods failed for index $i: $e3');
            totalHours.add(0.0); // Default fallback
          }
        }
      } catch (e) {
        debugPrint('Unexpected error calculating hours for index $i: $e');
        // Add a default value in case of error
        totalHours.add(0.0);
      }
    }
    return totalHours;
  }

  /// Gets the rate based on the day of the week and holidays.
  List<double> getRate(List<String> dayOfWeek, List<String> holidays) {
    List<double> rates = [];
    for (String day in dayOfWeek) {
      if (holidays.contains(day)) {
        rates.add(50.0); // Example rate for holidays
      } else if (day == 'Saturday' || day == 'Sunday') {
        rates.add(40.0); // Example rate for weekends
      } else {
        rates.add(30.0); // Example rate for weekdays
      }
    }
    return rates;
  }

  /// Gets the start and end dates of the week for a given date.
  List<DateTime> getWeekDates(DateTime date) {
    int weekday = date.weekday;
    DateTime startDate = date.subtract(Duration(days: weekday - 1));
    DateTime endDate = startDate.add(Duration(days: 6));
    return [startDate, endDate];
  }
// List<String> findDayOfWeek(List<String> dateList) {
//     final daysOfWeek = [
//       'Sunday',
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday'
//     ];
//     return dateList.map((date) {
//       final dayOfWeekIndex = DateTime.parse(date).weekday;
//       return daysOfWeek[dayOfWeekIndex % 7];
//     }).toList();
//   }

  // List<double> getRate(List<String> dayOfWeek, List<String> holidays) {
  //   List<double> rates = [];
  //   for (int i = 0; i < dayOfWeek.length; i++) {
  //     String currentDayOfWeek = dayOfWeek[i];
  //     String currentHoliday = i < holidays.length ? holidays[i] : 'No Holiday';
  //     bool isHoliday = currentHoliday == 'Holiday';

  //     switch (currentDayOfWeek) {
  //       case 'Saturday':
  //       case 'Sunday':
  //         rates.add(isHoliday ? 110.0 : 55.0);
  //         break;
  //       default:
  //         rates.add(isHoliday ? 100.0 : 50.0);
  //     }
  //   }
  //   return rates;
  // }

  // List<double> calculateTotalHours(List<String> startTimeList,
  //     List<String> endTimeList, List<String> timeList) {
  //   List<double> hoursWorkedList = [];
  //   for (int i = 0; i < startTimeList.length; i++) {
  //     if (i < timeList.length) {
  //       hoursWorkedList.add(hoursFromTimeString(timeList[i]));
  //     } else {
  //       DateTime startTime = DateFormat('h:mm a').parse(startTimeList[i]);
  //       DateTime endTime = DateFormat('h:mm a').parse(endTimeList[i]);
  //       if (endTime.isBefore(startTime)) {
  //         endTime = endTime.add(const Duration(days: 1));
  //       }
  //       Duration duration = endTime.difference(startTime);
  //       hoursWorkedList.add(duration.inMinutes / 60);
  //     }
  //   }
  //   return hoursWorkedList;
  // }

  List<double> calculateTotalAmount(
      List<double> hours, List<double> rates, List<String> holidays) {
    List<double> totalAmount = [];
    for (int i = 0; i < hours.length; i++) {
      double amount = hours[i] * rates[i];
      if (i < holidays.length && holidays[i] != 'No Holiday') {
        amount *= 1.5; // Apply holiday rate
      }
      totalAmount.add(amount);
    }
    return totalAmount;
  }

  List<Map<String, dynamic>> getInvoiceComponent(
      List<String> workedDateList,
      List<String> startTimeList,
      List<String> endTimeList,
      List<String> holidays,
      List<String> timeList,
      String clientName) {
    List<Map<String, dynamic>> invoiceComponents = [];
    List<String> dayOfWeek = findDayOfWeek(workedDateList);
    List<String> timePeriods = getTimePeriods(startTimeList);

    for (int i = 0; i < workedDateList.length; i++) {
      String description =
          getComponentDescription(dayOfWeek[i], timePeriods[i], holidays[i]);
      double hoursWorked = hoursFromTimeString(timeList[i]);
      double assignedHour =
          hoursBetweenPerListItem(startTimeList[i], endTimeList[i]);

      invoiceComponents.add({
        'clientName': clientName,
        'date': workedDateList[i],
        'dayOfWeek': dayOfWeek[i],
        'startTime': startTimeList[i],
        'endTime': endTimeList[i],
        'hoursWorked': hoursWorked,
        'assignedHour': assignedHour,
        'holiday': holidays[i] == 'Holiday',
        'description': description,
      });
    }

    return invoiceComponents;
  }

  String getComponentDescription(
      String dayOfWeek, String timePeriod, String holiday) {
    bool isHoliday = holiday == 'Holiday';
    String key;

    if (isHoliday) {
      key = 'Public holiday';
    } else {
      switch (dayOfWeek) {
        case 'Saturday':
          key = 'Saturday';
          break;
        case 'Sunday':
          key = 'Sunday';
          break;
        default:
          switch (timePeriod) {
            case 'Evening':
              key = 'Weekday Evening';
              break;
            case 'Night':
              key = 'Night-Time Sleepover';
              break;
            default:
              key = 'Weekday Daytime';
          }
      }
    }

    return itemMap[key] ?? 'Unknown';
  }

  List<String> getTimePeriods(List<String> startTimeList) {
    return startTimeList.map((time) => getTimePeriod(time)).toList();
  }

  // String getTimePeriod(String timeStr) {
  //   DateTime time = DateFormat('h:mm a').parse(timeStr);
  //   int hour = time.hour;

  //   if (hour >= 6 && hour < 18) {
  //     return 'Daytime';
  //   } else if (hour >= 18 && hour < 22) {
  //     return 'Evening';
  //   } else {
  //     return 'Night';
  //   }
  // }

  double hoursFromTimeString(String timeString) {
    try {
      // Handle different time formats
      if (timeString.contains(':')) {
        List<String> parts = timeString.split(':');
        
        if (parts.length >= 2) {
          int hours = int.parse(parts[0]);
          int minutes = int.parse(parts[1].replaceAll(RegExp(r'[^0-9]'), ''));
          
          int seconds = 0;
          if (parts.length >= 3) {
            // Extract just the numeric part for seconds
            String secondsPart = parts[2].replaceAll(RegExp(r'[^0-9]'), '');
            if (secondsPart.isNotEmpty) {
              seconds = int.parse(secondsPart);
            }
          }
          
          return hours + (minutes / 60) + (seconds / 3600);
        }
      }
      
      // If it's a simple number (e.g., "7")
      if (timeString.trim().contains(RegExp(r'^\d+(\.\d+)?$'))) {
        return double.parse(timeString.trim());
      }
      
      // If we can't parse it, log and return 0
      debugPrint('Unable to parse time string: $timeString');
      return 0.0;
    } catch (e) {
      debugPrint('Error in hoursFromTimeString for "$timeString": $e');
      return 0.0;
    }
  }

  double hoursBetweenPerListItem(String start, String end) {
    // Handle null or empty strings
    if (start == null || start.isEmpty || end == null || end.isEmpty) {
      debugPrint('Warning: Empty time string provided to hoursBetweenPerListItem');
      return 0.0;
    }
    
    debugPrint('Calculating hours between "$start" and "$end"');
    
    try {
      // Try to parse using the _parseSanitizedTime method first
      DateTime startTime = _parseSanitizedTime(start);
      DateTime endTime = _parseSanitizedTime(end);
      
      debugPrint('Parsed start time: ${startTime.hour}:${startTime.minute}');
      debugPrint('Parsed end time: ${endTime.hour}:${endTime.minute}');
      
      // Handle overnight shifts (when end time is before start time)
      if (endTime.isBefore(startTime)) {
        debugPrint('Detected overnight shift');
        endTime = endTime.add(const Duration(days: 1));
      }
      
      final hours = endTime.difference(startTime).inMinutes / 60;
      debugPrint('Calculated hours: $hours');
      return hours;
    } catch (e) {
      debugPrint('Error in primary parsing method: $e');
      
      // Try multiple fallback methods
      try {
        // Fallback 1: Try with DateFormat('h:mm a')
        debugPrint('Trying fallback method 1');
        DateTime startTime = DateFormat('h:mm a').parse(start);
        DateTime endTime = DateFormat('h:mm a').parse(end);
        
        if (endTime.isBefore(startTime)) {
          endTime = endTime.add(const Duration(days: 1));
        }
        
        final hours = endTime.difference(startTime).inMinutes / 60;
        debugPrint('Fallback 1 calculated hours: $hours');
        return hours;
      } catch (e1) {
        debugPrint('Fallback method 1 failed: $e1');
        
        try {
          // Fallback 2: Try with DateFormat('H:mm')
          debugPrint('Trying fallback method 2');
          DateTime startTime = DateFormat('H:mm').parse(start);
          DateTime endTime = DateFormat('H:mm').parse(end);
          
          if (endTime.isBefore(startTime)) {
            endTime = endTime.add(const Duration(days: 1));
          }
          
          final hours = endTime.difference(startTime).inMinutes / 60;
          debugPrint('Fallback 2 calculated hours: $hours');
          return hours;
        } catch (e2) {
          debugPrint('Fallback method 2 failed: $e2');
          
          try {
            // Fallback 3: Try to extract just the hours
            debugPrint('Trying fallback method 3 (extract hours)');
            final startHour = int.parse(start.replaceAll(RegExp(r'[^0-9]'), ''));
            final endHour = int.parse(end.replaceAll(RegExp(r'[^0-9]'), ''));
            
            int hours = endHour - startHour;
            if (hours < 0) hours += 24; // Handle overnight
            
            debugPrint('Fallback 3 calculated hours: $hours');
            return hours.toDouble();
          } catch (e3) {
            debugPrint('All parsing methods failed for "$start" and "$end": $e3');
            return 0.0;
          }
        }
      }
    }
  }

  // List<DateTime> getWeekDates(DateTime date) {
  //   int weekday = date.weekday;
  //   DateTime startDate = date.subtract(Duration(days: weekday - 1));
  //   DateTime endDate = startDate.add(const Duration(days: 6));
  //   return [startDate, endDate];
  // }
}