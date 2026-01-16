import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/holiday/services/holiday_service.dart';
import 'package:open_file/open_file.dart';
import 'package:carenest/app/features/pricing/constants/schads_rate_constants.dart';

final employeeInvoiceServiceProvider = Provider((ref) => EmployeeInvoiceService(ref));

class EmployeeInvoiceService {
  final Ref _ref;

  EmployeeInvoiceService(this._ref);

  Future<void> generateAndOpenInvoice(BuildContext context, String userEmail, DateTime startDate, DateTime endDate) async {
    try {
      // 1. Fetch Earnings Data
      final earningsRepo = _ref.read(earningsRepositoryProvider);
      final summary = await earningsRepo.getEarningsSummary(
        userEmail,
        startDate: startDate.toIso8601String().split('T')[0],
        endDate: endDate.toIso8601String().split('T')[0],
      );
      
      // 1b. Fetch Holidays for the period
      final holidayService = _ref.read(holidayServiceProvider);
      final holidays = await holidayService.getAllHolidays();
      // Create a set of date strings for quick lookup "DD-MM-YYYY"
      final holidaySet = holidays.map((h) => h.date).map((d) {
          // Format DateTime to "DD-MM-YYYY" string if not already
          // The holiday model 'date' is DateTime, so we format it
          return "${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}";
      }).toSet();
      
      // Also check standard ISO format matches just in case "YYYY-MM-DD"
      final holidayIsoSet = holidays.map((h) => h.date.toIso8601String().split('T')[0]).toSet();

      // 2. Prepare Invoice Data Structure
      final user = _ref.read(currentUserProvider).value;
      
      // Determine applicable rate for each day
      double getRateForDate(String dateStr, bool isHoliday) {
          final date = DateTime.parse(dateStr);
          final rates = user?.detailedRates;
          final base = user?.payRate ?? 0.0;
          
          if (rates == null) return base;
          
          if (isHoliday) {
              return rates.publicHolidayRate > 0 ? rates.publicHolidayRate : base;
          }
          if (date.weekday == DateTime.sunday) {
              return rates.sundayRate > 0 ? rates.sundayRate : base;
          }
          if (date.weekday == DateTime.saturday) {
              return rates.saturdayRate > 0 ? rates.saturdayRate : base;
          }
          
          return base;
      }
      
      // Construct line items from daily history
      final items = <Map<String, dynamic>>[];
      
      // Group shifts by date for Broken Shift Logic
      final shiftsByDate = <String, List<dynamic>>{};
      // Assuming summary.history gives aggregated items. 
      // If we need broken shift logic, we need RAW shifts.
      // summary.history seems to be aggregated by date in backend service.
      // We might need to fetch raw shifts or rely on the backend to provide shift count/details.
      // Let's check `earningsService.js` output. It aggregates by date.
      // If we want broken shift allowance, we need the raw shifts or the backend to flag it.
      // For now, let's assume if there are multiple raw records for a date, it's a broken shift?
      // But `summary.history` is ALREADY aggregated. 
      // CRITICAL: We need raw records or a "shiftCount" per day from backend.
      // Currently `getEarningsSummary` returns `history: [{date, hours, earnings}]`.
      // We can't detect broken shifts from this summary accurately.
      // However, for Vehicle Allowance, we need KM.
      // For Sleepover, we need Shift Type.
      
      // TEMPORARY SOLUTION:
      // We will calculate fixed allowances (First Aid, Laundry, etc.) based on activeAllowances.
      // Dynamic allowances (Vehicle, Broken Shift) require backend data update.
      // I'll add logic to ADD these allowances if the USER has them enabled, assuming triggers are met?
      // No, user said "Include allowances in the pay period covering when the trigger occurred".
      // This implies we need data from the Shift.
      
      // Let's implement the Fixed/Weekly allowances first (First Aid, Laundry - usually per shift).
      // Since we have `history` items (daily), we can apply per-shift allowances like Laundry/Uniform here.
      
      final activeAllowances = user?.activeAllowances ?? [];
      
      // Track weekly caps
      double laundryTotal = 0;
      double uniformTotal = 0;

      for (final item in summary.history) {
        final date = DateTime.parse(item.date);
        // Check if this date is a holiday (Check both DD-MM-YYYY and YYYY-MM-DD)
        final dateStrDDMMYYYY = "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
        final dateStrISO = item.date.split('T')[0];
        
        final isHoliday = holidaySet.contains(dateStrDDMMYYYY) || holidayIsoSet.contains(dateStrISO);
        
        final applicableRate = getRateForDate(item.date, isHoliday);
        final rates = user?.detailedRates;
        // final baseRate = user?.payRate ?? 0.0; // Unused variable
        
        // --- ALLOWANCES (Per Shift) ---
        // 1. Laundry
        if (activeAllowances.contains('Laundry')) {
            final rate = SchadsRateConstants.allowances['Laundry']!;
            if (laundryTotal < 1.49) { // Weekly cap approx $1.49
                items.add({
                    'date': item.date,
                    'startTime': '', 'endTime': '',
                    'hours': 1,
                    'rate': rate,
                    'amount': rate,
                    'itemCode': 'ALW-LND',
                    'itemName': 'Laundry Allowance',
                    'clientState': '',
                });
                laundryTotal += rate;
            }
        }
        
        // 2. Uniform
        if (activeAllowances.contains('Uniform')) {
            final rate = SchadsRateConstants.allowances['Uniform']!;
            if (uniformTotal < 6.24) { // Weekly cap
                items.add({
                    'date': item.date,
                    'startTime': '', 'endTime': '',
                    'hours': 1,
                    'rate': rate,
                    'amount': rate,
                    'itemCode': 'ALW-UNF',
                    'itemName': 'Uniform Allowance',
                    'clientState': '',
                });
                uniformTotal += rate;
            }
        }

        // 3. First Aid - Casual (Per Hour)
        if (activeAllowances.contains('First aid - Casual')) {
            final rate = SchadsRateConstants.allowances['First aid - Casual'] ?? 0.54;
            final amount = rate * item.hours;
            items.add({
                'date': item.date,
                'startTime': '', 'endTime': '',
                'hours': item.hours,
                'rate': rate,
                'amount': amount,
                'itemCode': 'ALW-FA-CAS',
                'itemName': 'First Aid Allowance (Casual)',
                'clientState': '',
            });
        }
        
        // 3. Vehicle (Mock implementation - requires KM data)
        // If we had item.kilometers, we would add it here.
        // items.add({ ... 'itemName': 'Vehicle Allowance', 'hours': item.km, 'rate': 0.99 ... });

        // --- OVERTIME LOGIC ---
        // Assumption: Standard day is 8 hours. Anything above is overtime.
        // OR if specific day rate is applied (Sat/Sun/PH), typically the whole shift is that rate, 
        // unless award says otherwise. Simplification: Weekend/PH rates apply to ALL hours. 
        // Weekday base hours > 8 get OT.
        
        final isStandardDay = !isHoliday && date.weekday != DateTime.saturday && date.weekday != DateTime.sunday;
        
        if (isStandardDay && item.hours > 8 && (rates?.overtimeRate ?? 0) > 0) {
            // Split into Base (8h) and OT (Excess)
            final baseHours = 8.0;
            final otHours = item.hours - 8.0;
            
            // Item 1: Standard Hours
            items.add({
              'date': item.date,
              'startTime': '00:00',
              'endTime': '00:00',
              'hours': baseHours,
              'rate': applicableRate,
              'amount': baseHours * applicableRate,
              'itemCode': 'PAY',
              'itemName': 'Standard Hours',
              'clientState': '',
            });
            
            // Item 2: Overtime
            // Check if we have "After 2 hours" rate (i.e. > 10 hours total)
            if (otHours > 2 && (rates?.overtimeRate2 ?? 0) > 0) {
                 final ot1Hours = 2.0;
                 final ot2Hours = otHours - 2.0;
                 
                 items.add({
                  'date': item.date,
                  'startTime': '00:00',
                  'endTime': '00:00',
                  'hours': ot1Hours,
                  'rate': rates!.overtimeRate,
                  'amount': ot1Hours * rates.overtimeRate,
                  'itemCode': 'OT1',
                  'itemName': 'Overtime (First 2h)',
                  'clientState': '',
                });
                
                items.add({
                  'date': item.date,
                  'startTime': '00:00',
                  'endTime': '00:00',
                  'hours': ot2Hours,
                  'rate': rates.overtimeRate2,
                  'amount': ot2Hours * rates.overtimeRate2,
                  'itemCode': 'OT2',
                  'itemName': 'Overtime (>2h)',
                  'clientState': '',
                });
            } else {
                // All OT at first rate
                items.add({
                  'date': item.date,
                  'startTime': '00:00',
                  'endTime': '00:00',
                  'hours': otHours,
                  'rate': rates!.overtimeRate,
                  'amount': otHours * rates.overtimeRate,
                  'itemCode': 'OT',
                  'itemName': 'Overtime',
                  'clientState': '',
                });
            }
            
        } else {
            // No split needed (Weekend, Holiday, or under 8h)
            String itemName = 'Standard Hours';
            if (isHoliday) itemName = 'Public Holiday';
            else if (date.weekday == DateTime.sunday) itemName = 'Sunday Rate';
            else if (date.weekday == DateTime.saturday) itemName = 'Saturday Rate';
            
            items.add({
              'date': item.date,
              'startTime': '00:00',
              'endTime': '00:00',
              'hours': item.hours,
              'rate': applicableRate,
              'amount': item.hours * applicableRate,
              'itemCode': 'PAY',
              'itemName': itemName,
              'clientState': '',
            });
        }
      }
      
      // Recalculate total because rates might differ from the simple summary total
      final totalEarnings = items.fold<double>(0, (sum, item) => sum + (item['amount'] as double));

      // --- WEEKLY ALLOWANCES (Fixed) ---
      // First Aid (Full-time: $20.46/week, Casual: $0.54/hr)
      if (activeAllowances.contains('First aid - Full-time')) {
           final rate = SchadsRateConstants.allowances['First aid - Full-time']!;
           // Add once per week. For simplicity, add to the last day or separate item.
           // Check if we haven't exceeded date range (assuming generating for 1 pay period).
           items.add({
              'date': endDate.toIso8601String().split('T')[0],
              'startTime': '', 'endTime': '',
              'hours': 1,
              'rate': rate,
              'amount': rate,
              'itemCode': 'ALW-FA-FT',
              'itemName': 'First Aid Allowance (Weekly)',
              'clientState': '',
           });
      }
      
      // Update total again
      final finalTotal = items.fold<double>(0, (sum, item) => sum + (item['amount'] as double));

      final invoiceData = {
        'invoiceNumber': 'PAY-${DateTime.now().millisecondsSinceEpoch}',
        'startDate': startDate.toIso8601String().split('T')[0],
        'endDate': endDate.toIso8601String().split('T')[0],
        'total': finalTotal,
        'subtotal': finalTotal,
        'taxAmount': 0.0, // Simplification: Gross Pay
        'taxRate': 0.0,
        'items': items,
        'itemsSubtotal': finalTotal,
        'expensesTotal': 0.0, // TODO: Fetch expenses
        'expenses': [],
        
        // Employee is the "Bill To" in this context (Self-Bill / Payslip)
        // OR Business is Bill To? 
        // User said: "employee is just simply replacing invoice business header payload with client"
        // And "generate invoice for employee"
        
        // Let's assume standard "Payslip" style:
        // Issuer: Business
        // Bill To: Employee
        
        'billTo': {
          'name': user?.name ?? 'Employee',
          'email': user?.email ?? userEmail,
          'address': 'Employee Address', // TODO: Add to user model
          'phone': user?.phone ?? '',
          'businessName': '',
          'abn': '',
        },
        
        // Issuer details are fetched inside PDF generator from Admin Profile (Business)
        'adminProfile': {
            'businessName': 'CareNest Provider', // Fallback
             // Real details are fetched in PDF generator via API if missing here
        },
        
        'invoiceType': 'employee', 
        'jobTitle': user?.jobRole ?? 'Employee',
      };

      // 3. Generate PDF
      final generator = InvoicePdfGenerator();
      final paths = await generator.generatePdfs(
        {'clients': [invoiceData]}, // Wrap in 'clients' list as expected by generator
        showTax: false,
        taxRate: 0.0,
      );

      // 4. Open PDF
      if (paths.isNotEmpty) {
        await OpenFile.open(paths.first);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to generate invoice PDF')),
        );
      }

    } catch (e) {
      debugPrint('Error generating employee invoice: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
