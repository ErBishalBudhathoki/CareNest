import 'package:carenest/app/features/invoice/utils/employee_rate_calculator.dart';

void main() {
  print('Testing calculateEmployeeRateDecision...');

  final baseRate = 30.0;
  final saturdayRate = 45.0;
  final sundayRate = 60.0;
  final publicHolidayRate = 75.0;
  final eveningShiftRate = 33.0; // 10% penalty approx
  final nightShiftRate = 34.5; // 15% penalty approx

  // Test 1: Weekday Day (Base Rate)
  var result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 23), // Monday
    isHoliday: false,
    startTime: '09:00',
    endTime: '17:00',
  );
  print(
    'Test 1 (Weekday Day): ${result['rate'] == baseRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );

  // Test 2: Saturday
  result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 28), // Saturday
    isHoliday: false,
    startTime: '09:00',
    endTime: '17:00',
  );
  print(
    'Test 2 (Saturday): ${result['rate'] == saturdayRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );

  // Test 3: Sunday
  result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 29), // Sunday
    isHoliday: false,
    startTime: '09:00',
    endTime: '17:00',
  );
  print(
    'Test 3 (Sunday): ${result['rate'] == sundayRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );

  // Test 4: Public Holiday
  result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 23), // Monday
    isHoliday: true,
    startTime: '09:00',
    endTime: '17:00',
  );
  print(
    'Test 4 (Public Holiday): ${result['rate'] == publicHolidayRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );

  // Test 5: Weekday Evening (Ends after 8pm)
  result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 23), // Monday
    isHoliday: false,
    startTime: '16:00',
    endTime: '21:00', // Ends at 9pm
  );
  print(
    'Test 5 (Weekday Evening): ${result['rate'] == eveningShiftRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );

  // Test 6: Weekday Night (Starts before 6am)
  result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 23), // Monday
    isHoliday: false,
    startTime: '05:00',
    endTime: '13:00',
  );
  print(
    'Test 6 (Weekday Night - Early Start): ${result['rate'] == nightShiftRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );

  // Test 7: Weekday Night (Ends after 12am / Overnight)
  result = calculateEmployeeRateDecision(
    baseRate: baseRate,
    saturdayRate: saturdayRate,
    sundayRate: sundayRate,
    publicHolidayRate: publicHolidayRate,
    eveningShiftRate: eveningShiftRate,
    nightShiftRate: nightShiftRate,
    date: DateTime(2023, 10, 23), // Monday
    isHoliday: false,
    startTime: '22:00',
    endTime: '06:00', // Overnight
  );
  print(
    'Test 7 (Weekday Night - Overnight): ${result['rate'] == nightShiftRate ? 'PASS' : 'FAIL'} (${result['rate']} - ${result['source']})',
  );
}
