import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';

class TimesheetPdfService {
  Future<String> generateTimesheetPdf({
    required List<TimesheetEntry> entries,
    required DateTime startDate,
    required DateTime endDate,
    required String userEmail,
    String? totalHours,
  }) async {
    final pdf = pw.Document();
    
    // Sort entries by date
    entries.sort((a, b) {
      final dateA = a.workDate ?? (a.shiftDate != null ? DateTime.tryParse(a.shiftDate!) : null) ?? DateTime(0);
      final dateB = b.workDate ?? (b.shiftDate != null ? DateTime.tryParse(b.shiftDate!) : null) ?? DateTime(0);
      return dateA.compareTo(dateB);
    });

    // Formatting helpers
    final dateFormat = DateFormat('EEE, MMM dd, yyyy');
    final periodFormat = DateFormat('MMM dd, yyyy');
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
             _buildHeader(startDate, endDate, periodFormat),
             pw.SizedBox(height: 20),
             _buildUserInfo(userEmail),
             pw.SizedBox(height: 10),
             pw.Divider(),
             pw.SizedBox(height: 10),
             _buildTimesheetTable(entries, dateFormat),
             pw.SizedBox(height: 20),
             _buildTotalSection(totalHours ?? _calculateTotal(entries)),
             pw.SizedBox(height: 40),
             _buildSignatureSection(),
          ];
        },
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final fileName = 'Timesheet_${periodFormat.format(startDate).replaceAll(',', '').replaceAll(' ', '_')}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }
  
  String _calculateTotal(List<TimesheetEntry> entries) {
      // Basic calculation fallback if not passed
      int totalSeconds = 0;
      for (var entry in entries) {
         if (entry.timeWorked != null) {
            final parts = entry.timeWorked!.split(':');
            if (parts.length == 3) {
                totalSeconds += int.parse(parts[0]) * 3600 + int.parse(parts[1]) * 60 + int.parse(parts[2]);
            }
         } else if (entry.totalHours != null) {
             try {
                final hours = double.parse(entry.totalHours.toString());
                totalSeconds += (hours * 3600).toInt();
             } catch (_) {}
         }
      }
      final hours = totalSeconds ~/ 3600;
      final minutes = (totalSeconds % 3600) ~/ 60;
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  pw.Widget _buildHeader(DateTime start, DateTime end, DateFormat format) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('TIMESHEET', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.Text('Weekly Report', style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text('Period', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('${format.format(start)} - ${format.format(end)}'),
          ],
        )
      ],
    );
  }

  pw.Widget _buildUserInfo(String email) {
    return pw.Row(
        children: [
            pw.Text('Employee: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text(email),
        ]
    );
  }

  pw.Widget _buildTimesheetTable(List<TimesheetEntry> entries, DateFormat dateFormat) {
    final headers = ['Date', 'Shift Time', 'Break', 'Total Hours', 'Notes'];
    
    final data = entries.map((e) {
        final date = e.workDate ?? (e.shiftDate != null ? DateTime.tryParse(e.shiftDate!) : null);
        final dateStr = date != null ? dateFormat.format(date) : (e.shiftDate ?? 'N/A');
        
        final start = e.shiftStartTime ?? '';
        final end = e.shiftEndTime ?? '';
        final shiftTime = (start.isNotEmpty && end.isNotEmpty) ? '$start - $end' : 'N/A';
        
        final hours = e.timeWorked ?? e.totalHours ?? '00:00';
        
        return [
            dateStr,
            shiftTime,
            'No', // Placeholder for break if not in model
            hours,
            '' // Notes placeholder
        ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.black),
      rowDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5))),
      cellAlignment: pw.Alignment.centerLeft,
      cellAlignments: {
         3: pw.Alignment.centerRight,
      },
    );
  }

  pw.Widget _buildTotalSection(String total) {
      return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
              pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  color: PdfColors.grey200,
                  child: pw.Row(
                      children: [
                          pw.Text('Total Weekly Hours: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Text(total, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
                      ]
                  )
              )
          ]
      );
  }
  
  pw.Widget _buildSignatureSection() {
      return pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                      pw.Container(width: 200, height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 5),
                      pw.Text('Employee Signature'),
                  ]
              ),
               pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                      pw.Container(width: 200, height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 5),
                      pw.Text('Supervisor Signature'),
                  ]
              ),
          ]
      );
  }
}
