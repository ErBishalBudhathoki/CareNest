import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carenest/app/features/invoice/services/download_service.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';

class PdfViewPage extends StatefulWidget {
  final String pdfPath;

  const PdfViewPage({super.key, required this.pdfPath});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.pdfPath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernInvoiceDesign.background,
      appBar: AppBar(
        backgroundColor: ModernInvoiceDesign.surface,
        foregroundColor: ModernInvoiceDesign.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ModernInvoiceDesign.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Invoice PDF',
          style: ModernInvoiceDesign.headlineMedium.copyWith(
            color: ModernInvoiceDesign.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: ModernInvoiceDesign.space2),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surfaceVariant,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
              border: Border.all(
                color: ModernInvoiceDesign.border,
                width: 1,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.share,
                color: ModernInvoiceDesign.textPrimary,
              ),
              onPressed: () async {
                try {
                  await Share.shareXFiles(
                    [XFile(widget.pdfPath)],
                    subject: 'Invoice PDF',
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error sharing PDF: ${e.toString()}')),
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: ModernInvoiceDesign.space2),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.surfaceVariant,
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.radiusMd),
              border: Border.all(
                color: ModernInvoiceDesign.border,
                width: 1,
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.download,
                color: ModernInvoiceDesign.textPrimary,
              ),
              onPressed: () async {
                try {
                  final downloadService = DownloadService();
                  final zipPath =
                      await downloadService.downloadFiles([widget.pdfPath]);
                  if (zipPath.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('PDF saved successfully')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error saving PDF: ${e.toString()}')),
                  );
                }
              },
            ),
          ),
          PdfPageNumber(
            controller: _pdfController,
            builder: (_, loadingState, page, pagesCount) => Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: ModernInvoiceDesign.space3),
              padding: EdgeInsets.symmetric(
                horizontal: ModernInvoiceDesign.space3,
                vertical: ModernInvoiceDesign.space2,
              ),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                border: Border.all(
                  color: ModernInvoiceDesign.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '$page/${pagesCount ?? 0}',
                style: ModernInvoiceDesign.labelLarge.copyWith(
                  color: ModernInvoiceDesign.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
      body: PdfView(
        controller: _pdfController,
        onDocumentError: (error) {
          debugPrint('PDF Viewer Error: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error loading PDF: $error'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: ModernInvoiceDesign.primaryGradient,
              borderRadius:
                  BorderRadius.circular(ModernInvoiceDesign.radiusFull),
              boxShadow: ModernInvoiceDesign.shadowMd,
            ),
            child: FloatingActionButton(
              heroTag: '-',
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
              child: const Icon(Icons.keyboard_arrow_left, size: 28),
              onPressed: () {
                _pdfController.previousPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
          ),
          SizedBox(width: ModernInvoiceDesign.space4),
          Container(
            decoration: BoxDecoration(
              gradient: ModernInvoiceDesign.primaryGradient,
              borderRadius:
                  BorderRadius.circular(ModernInvoiceDesign.radiusFull),
              boxShadow: ModernInvoiceDesign.shadowMd,
            ),
            child: FloatingActionButton(
              heroTag: '+',
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
              child: const Icon(Icons.keyboard_arrow_right, size: 28),
              onPressed: () {
                _pdfController.nextPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
