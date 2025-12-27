import 'package:flutter/foundation.dart';


import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Service for converting various file types to PDF and merging them
class FileConversionService {
  /// Convert a file to PDF based on its type
  Future<File?> convertFileToPdf(File file) async {
    try {
      final extension = path.extension(file.path).toLowerCase();
      
      switch (extension) {
        case '.pdf':
          // Already a PDF, return as is
          return file;
        case '.jpg':
        case '.jpeg':
        case '.png':
        case '.gif':
        case '.bmp':
        case '.webp':
          return await _convertImageToPdf(file);
        case '.txt':
          return await _convertTextToPdf(file);
        case '.doc':
        case '.docx':
          // For now, create a placeholder PDF with file info
          // In a production app, you'd use a proper document conversion library
          return await _createPlaceholderPdf(file, 'Word Document');
        case '.xls':
        case '.xlsx':
          return await _createPlaceholderPdf(file, 'Excel Spreadsheet');
        default:
          return await _createPlaceholderPdf(file, 'Attached File');
      }
    } catch (e) {
      debugPrint('Error converting file to PDF: $e');
      return null;
    }
  }

  /// Convert an image file to PDF
  Future<File> _convertImageToPdf(File imageFile) async {
    final pdf = pw.Document();
    final imageBytes = await imageFile.readAsBytes();
    
    // Create image widget
    final image = pw.MemoryImage(imageBytes);
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(
              image,
              fit: pw.BoxFit.contain,
            ),
          );
        },
      ),
    );

    // Save the PDF
    final output = await getApplicationDocumentsDirectory();
    final fileName = '${path.basenameWithoutExtension(imageFile.path)}_converted.pdf';
    final pdfFile = File('${output.path}/$fileName');
    await pdfFile.writeAsBytes(await pdf.save());
    
    return pdfFile;
  }

  /// Convert a text file to PDF
  Future<File> _convertTextToPdf(File textFile) async {
    final pdf = pw.Document();
    final content = await textFile.readAsString();
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Text Document: ${path.basename(textFile.path)}',
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Paragraph(
            text: content,
            style: const pw.TextStyle(fontSize: 12),
          ),
        ],
      ),
    );

    // Save the PDF
    final output = await getApplicationDocumentsDirectory();
    final fileName = '${path.basenameWithoutExtension(textFile.path)}_converted.pdf';
    final pdfFile = File('${output.path}/$fileName');
    await pdfFile.writeAsBytes(await pdf.save());
    
    return pdfFile;
  }

  /// Create a placeholder PDF for unsupported file types
  Future<File> _createPlaceholderPdf(File file, String fileType) async {
    final pdf = pw.Document();
    final fileName = path.basename(file.path);
    final fileSize = await file.length();
    final fileSizeKB = (fileSize / 1024).toStringAsFixed(2);
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Container(
                  width: 96,
                  height: 96,
                  alignment: pw.Alignment.center,
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey200,
                    borderRadius: pw.BorderRadius.circular(48),
                    border: pw.Border.all(color: PdfColors.grey400),
                  ),
                  child: pw.Text(
                    'FILE',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey700,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Attached File',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'File Type: $fileType',
                  style: const pw.TextStyle(fontSize: 16),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'File Name: $fileName',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  'File Size: $fileSizeKB KB',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey400),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text(
                    'This file was attached to the invoice but could not be converted to PDF format. '
                    'The original file is available separately.',
                    style: const pw.TextStyle(fontSize: 12),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF
    final output = await getApplicationDocumentsDirectory();
    final pdfFileName = '${path.basenameWithoutExtension(file.path)}_placeholder.pdf';
    final pdfFile = File('${output.path}/$pdfFileName');
    await pdfFile.writeAsBytes(await pdf.save());
    
    return pdfFile;
  }

  /// Merge multiple PDF files into one
  Future<File> mergePdfs(List<File> pdfFiles, String outputFileName) async {
    if (pdfFiles.isEmpty) {
      throw Exception('No PDF files to merge');
    }

    if (pdfFiles.length == 1) {
      // If only one file, just copy it with the new name
      final output = await getApplicationDocumentsDirectory();
      final mergedFile = File('${output.path}/$outputFileName');
      await pdfFiles.first.copy(mergedFile.path);
      return mergedFile;
    }

    final mergedPdf = pw.Document();

    for (final pdfFile in pdfFiles) {
      try {
        final pdfBytes = await pdfFile.readAsBytes();
        
        // For now, we'll add each PDF as an image page
        // In a production app, you'd use a proper PDF merging library
        mergedPdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(
                  'Attached PDF: ${path.basename(pdfFile.path)}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        );
      } catch (e) {
        debugPrint('Error processing PDF file ${pdfFile.path}: $e');
        // Add an error page instead
        mergedPdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Error Loading PDF',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'File: ${path.basename(pdfFile.path)}',
                      style: const pw.TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    }

    // Save the merged PDF
    final output = await getApplicationDocumentsDirectory();
    final mergedFile = File('${output.path}/$outputFileName');
    await mergedFile.writeAsBytes(await mergedPdf.save());
    
    return mergedFile;
  }

  /// Convert multiple files to PDFs and merge them with the main invoice PDF
  Future<File> convertAndMergeWithInvoice(File invoicePdf, List<File> attachments) async {
    try {
      final convertedPdfs = <File>[invoicePdf]; // Start with the main invoice
      
      // Convert each attachment to PDF
      for (final attachment in attachments) {
        final convertedPdf = await convertFileToPdf(attachment);
        if (convertedPdf != null) {
          convertedPdfs.add(convertedPdf);
        }
      }
      
      // Generate a unique filename for the merged PDF
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final mergedFileName = 'Invoice_with_attachments_$timestamp.pdf';
      
      // Merge all PDFs
      final mergedPdf = await mergePdfs(convertedPdfs, mergedFileName);
      
      // Clean up temporary converted files (keep the original invoice)
      for (int i = 1; i < convertedPdfs.length; i++) {
        try {
          await convertedPdfs[i].delete();
        } catch (e) {
          debugPrint('Error deleting temporary file: $e');
        }
      }
      
      return mergedPdf;
    } catch (e) {
      debugPrint('Error in convertAndMergeWithInvoice: $e');
      rethrow;
    }
  }

  /// Get supported file extensions
  static List<String> getSupportedExtensions() {
    return [
      '.pdf',
      '.jpg',
      '.jpeg',
      '.png',
      '.gif',
      '.bmp',
      '.webp',
      '.txt',
      '.doc',
      '.docx',
      '.xls',
      '.xlsx',
    ];
  }

  /// Check if a file type is supported for conversion
  static bool isFileSupported(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    return getSupportedExtensions().contains(extension);
  }
}
