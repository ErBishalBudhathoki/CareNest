import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/features/invoice/services/download_service.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:open_file/open_file.dart';

class PdfViewPage extends StatefulWidget {
  final String pdfPath;
  final List<String> receiptUrls;

  const PdfViewPage({
    super.key,
    required this.pdfPath,
    this.receiptUrls = const [],
  });

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  late PdfControllerPinch _pdfController;
  bool _isSharing = false;
  bool _isDownloading = false;
  bool _isOpeningReceipt = false;
  bool _isOpeningExternally = false;

  @override
  void initState() {
    super.initState();
    debugPrint('📄 PdfViewPage: Initializing with path: ${widget.pdfPath}');
    debugPrint(
        '📄 PdfViewPage: Receipt URLs count: ${widget.receiptUrls.length}');
    debugPrint('📄 PdfViewPage: Receipt URLs: ${widget.receiptUrls}');

    _pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.pdfPath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (_isOpeningReceipt) return;

    setState(() => _isOpeningReceipt = true);
    debugPrint('🔗 PdfViewPage: Attempting to launch URL: $url');
    final uri = Uri.parse(url);
    try {
      // Check if we can launch, but don't stop if we can't (as it might be a false negative)
      final canLaunch = await canLaunchUrl(uri);
      debugPrint('🔗 PdfViewPage: canLaunchUrl returned $canLaunch');

      if (!canLaunch) {
        debugPrint(
            '⚠️ PdfViewPage: canLaunchUrl is false, but attempting launch anyway...');
      }

      // Try external application mode first (opens in browser/external app)
      debugPrint('🔗 PdfViewPage: Trying LaunchMode.externalApplication...');
      try {
        if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          debugPrint('✅ PdfViewPage: launchUrl(externalApplication) success');
          return;
        }
      } catch (e) {
        debugPrint('❌ PdfViewPage: launchUrl(externalApplication) failed: $e');
      }

      // Fallback to platform default (might use Custom Tabs / In-App Browser)
      debugPrint(
          '⚠️ PdfViewPage: Falling back to LaunchMode.platformDefault...');
      if (await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        debugPrint('✅ PdfViewPage: launchUrl(platformDefault) success');
        return;
      }

      // If we got here, everything failed
      debugPrint('❌ PdfViewPage: All launch attempts failed');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Could not open receipt. Please check your internet connection or browser settings.'),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ PdfViewPage: Exception launching URL: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching URL: $e'),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isOpeningReceipt = false);
      }
    }
  }

  void _showReceiptsDialog(BuildContext context) {
    debugPrint('Show receipts dialog called');
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attached Receipts',
              style: ModernInvoiceDesign.headlineMedium,
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.receiptUrls.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return Semantics(
                    button: true,
                    label: 'Open Receipt ${index + 1}',
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: const Icon(Icons.description_outlined,
                          size: 24, color: ModernInvoiceDesign.primary),
                      title: Text(
                        'Receipt ${index + 1}',
                        style: ModernInvoiceDesign.bodyLarge,
                      ),
                      trailing: const Icon(Icons.open_in_new, size: 20),
                      onTap: () {
                        Navigator.pop(context);
                        _launchUrl(widget.receiptUrls[index]);
                      },
                      tileColor: ModernInvoiceDesign.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleShare() async {
    if (_isSharing) return;

    setState(() => _isSharing = true);
    try {
      final box = context.findRenderObject() as RenderBox?;
      await Share.shareXFiles(
        [XFile(widget.pdfPath)],
        subject: 'Invoice PDF',
        sharePositionOrigin:
            box != null ? box.localToGlobal(Offset.zero) & box.size : null,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing PDF: ${e.toString()}'),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  Future<void> _handleDownload() async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);
    try {
      final downloadService = DownloadService();
      final zipPath = await downloadService.downloadFiles([widget.pdfPath]);
      if (zipPath.isNotEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF saved successfully'),
            backgroundColor: ModernInvoiceDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving PDF: ${e.toString()}'),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  Future<void> _handleOpenExternally() async {
    if (_isOpeningExternally) return;

    setState(() => _isOpeningExternally = true);
    try {
      final result = await OpenFile.open(widget.pdfPath);
      if (result.type != ResultType.done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening PDF: ${e.toString()}'),
            backgroundColor: ModernInvoiceDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isOpeningExternally = false);
      }
    }
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
            child: _isOpeningExternally
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ModernInvoiceDesign.primary,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.open_in_new,
                      color: ModernInvoiceDesign.textPrimary,
                    ),
                    tooltip: 'Open PDF externally',
                    onPressed: _handleOpenExternally,
                  ),
          ),
          if (widget.receiptUrls.isNotEmpty)
            Container(
              margin: EdgeInsets.only(right: ModernInvoiceDesign.space2),
              decoration: BoxDecoration(
                color: ModernInvoiceDesign.surfaceVariant,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusMd),
                border: Border.all(
                  color: ModernInvoiceDesign.border,
                  width: 1,
                ),
              ),
              child: _isOpeningReceipt
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ModernInvoiceDesign.primary,
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.receipt_long,
                        color: ModernInvoiceDesign.textPrimary,
                      ),
                      tooltip: 'Download Receipts',
                      onPressed: () {
                        if (widget.receiptUrls.length == 1) {
                          _launchUrl(widget.receiptUrls.first);
                        } else {
                          _showReceiptsDialog(context);
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
            child: _isSharing
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ModernInvoiceDesign.primary,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.share,
                      color: ModernInvoiceDesign.textPrimary,
                    ),
                    tooltip: 'Share PDF',
                    onPressed: _handleShare,
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
            child: _isDownloading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ModernInvoiceDesign.primary,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.download,
                      color: ModernInvoiceDesign.textPrimary,
                    ),
                    tooltip: 'Download PDF',
                    onPressed: _handleDownload,
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
      body: PdfViewPinch(
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
