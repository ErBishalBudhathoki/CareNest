import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/app/features/expenses/views/add_expense_view.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/features/ocr/services/ocr_service.dart';
import 'package:carenest/app/features/ocr/models/ocr_result.dart';
import 'package:carenest/backend/api_method.dart';

class QuickExpenseCaptureView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;

  const QuickExpenseCaptureView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
  });

  @override
  ConsumerState<QuickExpenseCaptureView> createState() => _QuickExpenseCaptureViewState();
}

class _QuickExpenseCaptureViewState extends ConsumerState<QuickExpenseCaptureView> {
  bool _isCapturing = true;
  bool _isProcessing = false;
  XFile? _capturedImage;
  OcrResult? _ocrResult;
  final OcrService _ocrService = OcrService();
  late final ApiMethod _api;

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausTheme.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.quickCaptureTitle, style: BauhausTheme.headerStyle.copyWith(color: BauhausTheme.white)),
        backgroundColor: BauhausTheme.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.white),
      ),
      body: _isCapturing ? _buildCaptureLauncher() : _buildConfirmation(),
    );
  }

  Widget _buildCaptureLauncher() {
    if (_isProcessing) {
      return const Center(
        child: CircularProgressIndicator(color: BauhausTheme.white),
      );
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 72, color: BauhausTheme.white),
            const SizedBox(height: 24),
            Text(
              'Scan a receipt with the native camera or pick from gallery.',
              style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _scanWithNativeCamera,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BauhausTheme.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      child: Text('Open Camera', style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _scanFromGallery,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BauhausTheme.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      ),
                      child: Text('Open Gallery', style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmation() {
    return Container(
      color: BauhausTheme.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_capturedImage != null) ...[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.file(
                File(_capturedImage!.path),
                fit: BoxFit.cover,
              ),
            ),
          ] else ...[
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(child: Text(AppLocalizations.of(context)!.capturedReceipt)),
            ),
          ],
          const SizedBox(height: 24),
          Text(AppLocalizations.of(context)!.receiptScanned, style: BauhausTheme.headerStyle),
          const SizedBox(height: 12),
          if (_ocrResult != null) ...[
            Text(
              _ocrResult!.merchant.isNotEmpty ? _ocrResult!.merchant : 'Unknown Merchant',
              style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: \$${_ocrResult!.totalAmount.toStringAsFixed(2)} • Date: ${_ocrResult!.date}',
              style: BauhausTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
          
          const SizedBox(height: 48),
          
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Add Expense with pre-filled data
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpenseView(
                      adminEmail: widget.adminEmail,
                      organizationId: widget.organizationId,
                      initialCategory: 'Office',
                      initialReceiptFilePaths: _capturedImage != null ? [ _capturedImage!.path ] : null,
                      initialTitle: _ocrResult?.merchant,
                      initialAmount: _ocrResult?.totalAmount,
                      initialDate: (_ocrResult?.date.isNotEmpty ?? false)
                          ? DateTime.tryParse(_ocrResult!.date)
                          : null,
                      initialDescription: _ocrResult?.rawText,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: BauhausTheme.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              child: Text(AppLocalizations.of(context)!.confirmAndEdit, style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                _isCapturing = true;
                _ocrResult = null;
              });
            },
            child: Text(AppLocalizations.of(context)!.retake, style: BauhausTheme.bodyStyle.copyWith(decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }

  Future<void> _scanWithNativeCamera() async {
    setState(() {
      _isProcessing = true;
    });
    try {
      final hasPermission = await _ensureCameraPermission();
      if (!hasPermission) {
        setState(() {
          _isProcessing = false;
        });
        return;
      }
      final File? picked = await _ocrService.pickImage(ImageSource.camera);
      if (picked == null) {
        setState(() {
          _isProcessing = false;
        });
        return;
      }
      final File? cropped = await _ocrService.cropImage(picked);
      final File imageFile = cropped ?? picked;
      final rawText = await _ocrService.extractText(imageFile);
      final source = Platform.isIOS ? 'apple_vision' : 'google_mlkit';
      final parsed = await _api.parseReceiptText(rawText, source: source);
      if (parsed['success'] == true) {
        final dynamic data = parsed['data'] ?? parsed;
        if (data is Map<String, dynamic>) {
          _ocrResult = OcrResult.fromJson(data);
        } else {
          _ocrResult = OcrResult(
            merchant: '',
            date: '',
            totalAmount: 0.0,
            currency: 'USD',
            items: const [],
            rawText: rawText,
          );
        }
      } else {
        _ocrResult = OcrResult(
          merchant: '',
          date: '',
          totalAmount: 0.0,
          currency: 'USD',
          items: const [],
          rawText: rawText,
        );
      }
      _capturedImage = XFile(imageFile.path);
      setState(() {
        _isCapturing = false;
      });
    } catch (_) {
      setState(() {});
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<bool> _ensureCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      final proceed = await _showCameraRationaleDialog();
      if (!proceed) {
        return false;
      }
      final req = await Permission.camera.request();
      if (req.isGranted) return true;
      // Show guidance sheet if still denied
      if (mounted) {
        await _showPermissionSheet(
          title: AppLocalizations.of(context)!.permissionRequired,
          message: '${AppLocalizations.of(context)!.permissionCamera}\n\nEnable it in Settings to scan receipts.',
        );
      }
      return false;
    }
    if (status.isRestricted) {
      if (mounted) {
        await _showPermissionSheet(
          title: AppLocalizations.of(context)!.permissionRequired,
          message: '${AppLocalizations.of(context)!.permissionCamera}\n\nCamera access is restricted on this device.',
        );
      }
      return false;
    }
    if (status.isPermanentlyDenied) {
      if (mounted) {
        await _showPermissionSheet(
          title: AppLocalizations.of(context)!.permissionRequired,
          message: '${AppLocalizations.of(context)!.permissionCamera}\n\nCamera access is disabled. Open Settings to enable it.',
        );
      }
      return false;
    }
    return false;
  }

  Future<bool> _showCameraRationaleDialog() async {
    final localizations = AppLocalizations.of(context)!;
    final message = '${localizations.permissionCamera}\n\nWe only use the camera when you tap Scan Receipt.';
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausTheme.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(localizations.permissionRequired, style: BauhausTheme.headerStyle.copyWith(color: BauhausTheme.white)),
                const SizedBox(height: 8),
                Text(message, style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.white)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BauhausTheme.black,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text(localizations.cancelButtonCaps, style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BauhausTheme.black,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text(localizations.grantPermission, style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return result ?? false;
  }

  Future<void> _showPermissionSheet({required String title, required String message}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: BauhausTheme.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: BauhausTheme.headerStyle.copyWith(color: BauhausTheme.white)),
                const SizedBox(height: 8),
                Text(message, style: BauhausTheme.bodyStyle.copyWith(color: BauhausTheme.white)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            await openAppSettings();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BauhausTheme.black,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text('Open Settings', style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(ctx);
                            // Try again
                            await _scanWithNativeCamera();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BauhausTheme.black,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                          ),
                          child: Text('Retry', style: BauhausTheme.subHeaderStyle.copyWith(color: BauhausTheme.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _scanFromGallery() async {
    setState(() {
      _isProcessing = true;
    });
    try {
      final File? picked = await _ocrService.pickImage(ImageSource.gallery);
      if (picked == null) {
        setState(() {
          _isProcessing = false;
        });
        return;
      }
      final File? cropped = await _ocrService.cropImage(picked);
      final File imageFile = cropped ?? picked;
      final rawText = await _ocrService.extractText(imageFile);
      final source = Platform.isIOS ? 'apple_vision' : 'google_mlkit';
      final parsed = await _api.parseReceiptText(rawText, source: source);
      if (parsed['success'] == true) {
        final dynamic data = parsed['data'] ?? parsed;
        if (data is Map<String, dynamic>) {
          _ocrResult = OcrResult.fromJson(data);
        } else {
          _ocrResult = OcrResult(
            merchant: '',
            date: '',
            totalAmount: 0.0,
            currency: 'USD',
            items: const [],
            rawText: rawText,
          );
        }
      } else {
        _ocrResult = OcrResult(
          merchant: '',
          date: '',
          totalAmount: 0.0,
          currency: 'USD',
          items: const [],
          rawText: rawText,
        );
      }
      _capturedImage = XFile(imageFile.path);
      setState(() {
        _isCapturing = false;
      });
    } catch (_) {
      setState(() {});
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }
}
