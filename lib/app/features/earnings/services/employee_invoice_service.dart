import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/invoice/services/invoice_pdf_generator_service.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/holiday/services/holiday_service.dart';
import 'package:open_file/open_file.dart';
import 'package:carenest/app/features/pricing/constants/schads_rate_constants.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import '../../mileage/repositories/mileage_repository.dart';
import '../../mileage/models/trip_model.dart';

final employeeInvoiceServiceProvider = Provider(
  (ref) => EmployeeInvoiceService(ref),
);

class EmployeeInvoiceService {
  final Ref _ref;

  EmployeeInvoiceService(this._ref);

  Future<void> generateAndOpenInvoice(
    BuildContext context,
    String userEmail,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final l10n = AppLocalizations.of(context)!;
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
      final holidayIsoSet = holidays
          .map((h) => h.date.toIso8601String().split('T')[0])
          .toSet();

      // 1c. Fetch Mileage/Trips for the period
      final mileageRepo = _ref.read(mileageRepositoryProvider);
      // Convert dates to YYYY-MM-DD for API
      final startStr = startDate.toIso8601String().split('T')[0];
      final endStr = endDate.toIso8601String().split('T')[0];

      // Fetch trips
      final user = _ref.read(currentUserProvider).value;
      final userId = user?.id;

      List<Trip> trips = [];
      if (userId != null) {
        trips = await mileageRepo.getTrips(
          userId,
          startDate: startStr,
          endDate: endStr,
        );
      }

      // 2. Prepare Invoice Data Structure
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

      final activeAllowances = user?.activeAllowances ?? [];

      // Track weekly caps
      double laundryTotal = 0;
      double uniformTotal = 0;

      for (final item in summary.history) {
        final date = DateTime.parse(item.date);
        // Check if this date is a holiday (Check both DD-MM-YYYY and YYYY-MM-DD)
        final dateStrDDMMYYYY =
            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
        final dateStrISO = item.date.split('T')[0];

        final isHoliday =
            holidaySet.contains(dateStrDDMMYYYY) ||
            holidayIsoSet.contains(dateStrISO);

        final applicableRate = getRateForDate(item.date, isHoliday);
        final rates = user?.detailedRates;

        // --- ALLOWANCES (Per Shift) ---
        // 1. Laundry
        if (activeAllowances.contains('Laundry')) {
          final rate = SchadsRateConstants.allowances['Laundry']!;
          if (laundryTotal < 1.49) {
            // Weekly cap approx $1.49
            items.add({
              'date': item.date,
              'startTime': '',
              'endTime': '',
              'hours': 1,
              'rate': rate,
              'amount': rate,
              'itemCode': 'ALW-LND',
              'itemName': l10n.allowanceLaundry,
              'clientState': '',
            });
            laundryTotal += rate;
          }
        }

        // 2. Uniform
        if (activeAllowances.contains('Uniform')) {
          final rate = SchadsRateConstants.allowances['Uniform']!;
          if (uniformTotal < 6.24) {
            // Weekly cap
            items.add({
              'date': item.date,
              'startTime': '',
              'endTime': '',
              'hours': 1,
              'rate': rate,
              'amount': rate,
              'itemCode': 'ALW-UNF',
              'itemName': l10n.allowanceUniform,
              'clientState': '',
            });
            uniformTotal += rate;
          }
        }

        // 3. First Aid - Casual (Per Hour)
        if (activeAllowances.contains('First aid - Casual')) {
          final rate =
              SchadsRateConstants.allowances['First aid - Casual'] ?? 0.54;
          final amount = rate * item.hours;
          items.add({
            'date': item.date,
            'startTime': '',
            'endTime': '',
            'hours': item.hours,
            'rate': rate,
            'amount': amount,
            'itemCode': 'ALW-FA-CAS',
            'itemName': l10n.allowanceFirstAidCasual,
            'clientState': '',
          });
        }

        // --- OVERTIME LOGIC ---
        // Assumption: Standard day is 8 hours. Anything above is overtime.
        // OR if specific day rate is applied (Sat/Sun/PH), typically the whole shift is that rate,
        // unless award says otherwise. Simplification: Weekend/PH rates apply to ALL hours.
        // Weekday base hours > 8 get OT.

        final isStandardDay =
            !isHoliday &&
            date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday;

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
            'itemName': l10n.standardHours,
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
              'itemName': l10n.overtimeFirst2h,
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
              'itemName': l10n.overtimeOver2h,
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
              'itemName': l10n.overtime,
              'clientState': '',
            });
          }
        } else {
          // No split needed (Weekend, Holiday, or under 8h)
          String itemName = l10n.standardHours;
          if (isHoliday) {
            itemName = l10n.publicHoliday;
          } else if (date.weekday == DateTime.sunday) {
            itemName = l10n.sundayRate;
          } else if (date.weekday == DateTime.saturday) {
            itemName = l10n.saturdayRate;
          }

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

      // --- VEHICLE ALLOWANCE LOGIC ---
      // 4. Process Trips for Reimbursement
      final vehicleRate = SchadsRateConstants.allowances['Vehicle'] ?? 0.99;

      for (final trip in trips) {
        // Filter for reimbursable trips within the date range (double check date)
        // Ensure status is APPROVED
        if (trip.isReimbursable &&
            trip.status == 'APPROVED' &&
            trip.date.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
            trip.date.isBefore(endDate.add(const Duration(seconds: 1)))) {
          final amount = trip.distance * vehicleRate;

          items.add({
            'date': trip.date.toIso8601String().split('T')[0],
            'startTime': '', // Not applicable
            'endTime': '', // Not applicable
            'hours': trip.distance, // Using 'hours' field for Quantity (km)
            'rate': vehicleRate,
            'amount': amount,
            'itemCode': 'ALW-VEH',
            'itemName':
                'Vehicle Allowance (${trip.startLocation} - ${trip.endLocation})',
            'clientState': '',
          });
        }
      }

      // --- WEEKLY ALLOWANCES (Fixed) ---
      // First Aid (Full-time: $20.46/week, Casual: $0.54/hr)
      if (activeAllowances.contains('First aid - Full-time')) {
        final rate = SchadsRateConstants.allowances['First aid - Full-time']!;
        // Add once per week. For simplicity, add to the last day or separate item.
        // Check if we haven't exceeded date range (assuming generating for 1 pay period).
        items.add({
          'date': endDate.toIso8601String().split('T')[0],
          'startTime': '',
          'endTime': '',
          'hours': 1,
          'rate': rate,
          'amount': rate,
          'itemCode': 'ALW-FA-FT',
          'itemName': l10n.allowanceFirstAidWeekly,
          'clientState': '',
        });
      }

      // Recalculate total because rates might differ from the simple summary total
      final finalTotal = items.fold<double>(
        0,
        (sum, item) => sum + (item['amount'] as double),
      );

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
        'billTo': {
          'name': user?.name ?? l10n.employeeFallback,
          'email': user?.email ?? userEmail,
          'address': 'Employee Address', // TODO: Add to user model
          'phone': user?.phone ?? '',
          'businessName': '',
          'abn': '',
        },
        'adminProfile': {
          'businessName': 'CareNest Provider', // Fallback
        },
        'invoiceType': 'employee',
        'jobTitle': user?.jobRole ?? l10n.jobRoleFallback,
      };

      // 3. Generate PDF
      final generator = InvoicePdfGenerator(
        api: _ref.read(app_providers.apiMethodProvider),
      );
      final paths = await generator.generatePdfs(
        {
          'clients': [invoiceData],
        }, // Wrap in 'clients' list as expected by generator
        showTax: false,
        taxRate: 0.0,
      );

      // 4. Open PDF
      if (!context.mounted) return;
      if (paths.isNotEmpty) {
        await OpenFile.open(paths.first);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.pdfGenerationFailed)));
      }
    } catch (e) {
      if (!context.mounted) return;
      debugPrint('Error generating employee invoice: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
