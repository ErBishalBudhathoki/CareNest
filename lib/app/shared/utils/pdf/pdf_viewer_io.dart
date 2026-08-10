import 'dart:io';

import 'package:carenest/config/environment.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/features/invoice/services/download_service.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

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
      '📄 PdfViewPage: Receipt URLs count: ${widget.receiptUrls.length}',
    );
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
    final cleanUrl = url.trim().replaceAll('`', '');
    debugPrint('🔗 PdfViewPage: Attempting to launch URL: $cleanUrl');
    final uri = Uri.parse(cleanUrl);
    try {
      final isPrivateR2ApiHost = AppConfig.isPrivateR2StorageHost(uri.host);
      final isFilesDownloadProxy = uri.path.contains('/files/download');
      debugPrint(
        '🔗 PdfViewPage: URL classification host=${uri.host}, isPrivateR2ApiHost=$isPrivateR2ApiHost, isFilesDownloadProxy=$isFilesDownloadProxy',
      );

      if (isPrivateR2ApiHost || isFilesDownloadProxy) {
        final proxyUrl = isFilesDownloadProxy
            ? uri.toString()
            : AppConfig.buildFilesProxyUrl(uri.toString());
        await _downloadAndOpenAuthenticated(proxyUrl);
        return;
      }

      // Check if we can launch, but don't stop if we can't (as it might be a false negative)
      final canLaunch = await canLaunchUrl(uri);
      debugPrint('🔗 PdfViewPage: canLaunchUrl returned $canLaunch');

      if (!canLaunch) {
        debugPrint(
          '⚠️ PdfViewPage: canLaunchUrl is false, but attempting launch anyway...',
        );
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
        '⚠️ PdfViewPage: Falling back to LaunchMode.platformDefault...',
      );
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
              'Could not open receipt. Please check your internet connection or browser settings.',
            ),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ PdfViewPage: Exception launching URL: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching URL: $e'),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isOpeningReceipt = false);
      }
    }
  }

  Future<void> _downloadAndOpenAuthenticated(String url) async {
    final uri = Uri.parse(url);
    final headers = <String, String>{};

    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdToken();
    if (idToken != null && idToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $idToken';
    }

    try {
      final appCheckToken = await FirebaseAppCheck.instance.getToken();
      if (appCheckToken != null && appCheckToken.isNotEmpty) {
        headers['X-Firebase-AppCheck'] = appCheckToken;
      }
    } catch (_) {
      // App Check token is optional for this operation.
    }

    final response = await http.get(uri, headers: headers);
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to download receipt (HTTP ${response.statusCode})',
      );
    }

    final fileName = _extractFileName(response, uri);
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    final result = await OpenFile.open(filePath);
    if (result.type != ResultType.done) {
      throw Exception(result.message);
    }
  }

  String _extractFileName(http.Response response, Uri fallbackUri) {
    final disposition = response.headers['content-disposition'] ?? '';
    final quotedMatch = RegExp(
      r'filename=\"([^\"]+)\"',
    ).firstMatch(disposition);
    if (quotedMatch != null && quotedMatch.groupCount >= 1) {
      final value = quotedMatch.group(1);
      if (value != null && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    final sourceUrl = fallbackUri.queryParameters['url'];
    if (sourceUrl != null && sourceUrl.isNotEmpty) {
      final source = Uri.tryParse(sourceUrl);
      final sourceName = source?.pathSegments.isNotEmpty == true
          ? source!.pathSegments.last
          : '';
      if (sourceName.isNotEmpty) return sourceName;
    }

    final fallbackName = fallbackUri.pathSegments.isNotEmpty
        ? fallbackUri.pathSegments.last
        : '';
    if (fallbackName.isNotEmpty) return fallbackName;
    return 'receipt_${DateTime.now().millisecondsSinceEpoch}';
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
              style: BauhausDesign.getTextTheme(context).headlineSmall,
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
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.description_outlined,
                        size: 24,
                        color: BauhausDesign.primary,
                      ),
                      title: Text(
                        'Receipt ${index + 1}',
                        style: BauhausDesign.getTextTheme(context).bodyLarge,
                      ),
                      trailing: const Icon(Icons.open_in_new, size: 20),
                      onTap: () {
                        Navigator.pop(context);
                        _launchUrl(widget.receiptUrls[index]);
                      },
                      tileColor: BauhausDesign.surfaceWhite,
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
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(widget.pdfPath)],
          subject: 'Invoice PDF',
          sharePositionOrigin: box != null
              ? box.localToGlobal(Offset.zero) & box.size
              : null,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing PDF: ${e.toString()}'),
            backgroundColor: BauhausDesign.error,
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
      if (Platform.isIOS) {
        final box = context.findRenderObject() as RenderBox?;
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(widget.pdfPath)],
            subject: 'Invoice PDF',
            sharePositionOrigin: box != null
                ? box.localToGlobal(Offset.zero) & box.size
                : null,
          ),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'PDF ready. Choose Save to Files to keep a local copy.',
              ),
              backgroundColor: BauhausDesign.success,
            ),
          );
        }
        return;
      }

      final downloadService = DownloadService();
      final zipPath = await downloadService.downloadFiles([widget.pdfPath]);
      if (zipPath.isNotEmpty && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF saved successfully'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving PDF: ${e.toString()}'),
            backgroundColor: BauhausDesign.error,
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
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening PDF: ${e.toString()}'),
            backgroundColor: BauhausDesign.error,
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
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BauhausDesign.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Invoice PDF',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _isOpeningExternally
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: BauhausDesign.primary,
                        ),
                      ),
                    ),
                  )
                : BauhausIconButton(
                    icon: Icons.open_in_new,
                    onPressed: _handleOpenExternally,
                    variant: BauhausActionVariant.neutral,
                    tooltip: 'Open PDF externally',
                  ),
          ),
          if (widget.receiptUrls.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _isOpeningReceipt
                  ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: BauhausDesign.primary,
                          ),
                        ),
                      ),
                    )
                  : BauhausIconButton(
                      icon: Icons.receipt_long,
                      onPressed: () {
                        if (widget.receiptUrls.length == 1) {
                          _launchUrl(widget.receiptUrls.first);
                        } else {
                          _showReceiptsDialog(context);
                        }
                      },
                      variant: BauhausActionVariant.neutral,
                      tooltip: 'Download Receipts',
                    ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _isSharing
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: BauhausDesign.primary,
                        ),
                      ),
                    ),
                  )
                : BauhausIconButton(
                    icon: Icons.share,
                    onPressed: _handleShare,
                    variant: BauhausActionVariant.neutral,
                    tooltip: 'Share PDF',
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _isDownloading
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: BauhausDesign.primary,
                        ),
                      ),
                    ),
                  )
                : BauhausIconButton(
                    icon: Icons.download,
                    onPressed: _handleDownload,
                    variant: BauhausActionVariant.neutral,
                    tooltip: 'Download PDF',
                  ),
          ),
          PdfPageNumber(
            controller: _pdfController,
            builder: (_, loadingState, page, pagesCount) => Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: 8, // Adjust vertical padding for app bar alignment
              ),
              padding: EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space1,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                border: Border.all(
                  color: BauhausDesign.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '$page/${pagesCount ?? 0}',
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                  color: BauhausDesign.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: PdfViewPinch(
        controller: _pdfController,
        onDocumentError: (error) {
          debugPrint('PDF Viewer Error: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error loading PDF: $error'),
              backgroundColor: BauhausDesign.error,
              duration: const Duration(seconds: 5),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: '-',
            backgroundColor: BauhausDesign.surfaceWhite,
            foregroundColor: BauhausDesign.primary,
            elevation: 2,
            child: const Icon(Icons.keyboard_arrow_left, size: 28),
            onPressed: () {
              _pdfController.previousPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
          SizedBox(width: BauhausDesign.space4),
          FloatingActionButton(
            heroTag: '+',
            backgroundColor: BauhausDesign.surfaceWhite,
            foregroundColor: BauhausDesign.primary,
            elevation: 2,
            child: const Icon(Icons.keyboard_arrow_right, size: 28),
            onPressed: () {
              _pdfController.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
        ],
      ),
    );
  }
}
