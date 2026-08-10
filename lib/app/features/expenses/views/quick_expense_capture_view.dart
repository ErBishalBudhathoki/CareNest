import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
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
  ConsumerState<QuickExpenseCaptureView> createState() =>
      _QuickExpenseCaptureViewState();
}

class _QuickExpenseCaptureViewState
    extends ConsumerState<QuickExpenseCaptureView> {
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
        title: Text(
          AppLocalizations.of(context)!.quickCaptureTitle,
          style: BauhausTheme.headerStyle.copyWith(color: BauhausTheme.white),
        ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        'Open Camera',
                        style: BauhausTheme.subHeaderStyle.copyWith(
                          color: BauhausTheme.white,
                        ),
                      ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        'Open Gallery',
                        style: BauhausTheme.subHeaderStyle.copyWith(
                          color: BauhausTheme.white,
                        ),
                      ),
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
              child: Image.file(File(_capturedImage!.path), fit: BoxFit.cover),
            ),
          ] else ...[
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(
                child: Text(AppLocalizations.of(context)!.capturedReceipt),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.receiptScanned,
            style: BauhausTheme.headerStyle,
          ),
          const SizedBox(height: 12),
          if (_ocrResult != null) ...[
            Text(
              _ocrResult!.merchant.isNotEmpty
                  ? _ocrResult!.merchant
                  : 'Unknown Merchant',
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
              onPressed: _navigateToAddExpenseFromState,
              style: ElevatedButton.styleFrom(
                backgroundColor: BauhausTheme.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.confirmAndEdit,
                style: BauhausTheme.subHeaderStyle.copyWith(
                  color: BauhausTheme.white,
                ),
              ),
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
            child: Text(
              AppLocalizations.of(context)!.retake,
              style: BauhausTheme.bodyStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scanWithNativeCamera() async {
    setState(() {
      _isProcessing = true;
    });
    File? imageFile;
    String rawText = '';
    try {
      final hasPermission = await _ensureCameraPermission();
      if (!hasPermission) {
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
        return;
      }
      final File? picked = await _ocrService.pickImage(ImageSource.camera);
      if (picked == null) {
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
        return;
      }
      final File? cropped = await _ocrService.cropImage(picked);
      imageFile = cropped ?? picked;
      rawText = await _ocrService.extractText(imageFile);
      _logOcrPreview(rawText, 'camera');
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
      final parsedTotal = _ocrResult?.totalAmount;
      final correctedTotal = _deriveBestTotal(rawText, parsedTotal);
      final resolvedTotal = _resolveTotal(parsedTotal, correctedTotal);
      if (resolvedTotal != null && resolvedTotal > 0) {
        _ocrResult = _withUpdatedTotal(_ocrResult, resolvedTotal, rawText);
        debugPrint(
          'QuickExpenseCaptureView: totals parsed=$parsedTotal derived=$correctedTotal resolved=$resolvedTotal',
        );
      }
      _capturedImage = XFile(imageFile.path);
      await _navigateToAddExpense(imageFile: imageFile, ocrResult: _ocrResult);
      return;
    } catch (e) {
      debugPrint('QuickExpenseCaptureView: camera scan failed: $e');
      if (imageFile != null) {
        _ocrResult ??= OcrResult(
          merchant: '',
          date: '',
          totalAmount: 0.0,
          currency: 'USD',
          items: const [],
          rawText: rawText,
        );
        _capturedImage = XFile(imageFile.path);
        await _navigateToAddExpense(
          imageFile: imageFile,
          ocrResult: _ocrResult,
        );
        return;
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
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
          message:
              '${AppLocalizations.of(context)!.permissionCamera}\n\nEnable it in Settings to scan receipts.',
        );
      }
      return false;
    }
    if (status.isRestricted) {
      if (mounted) {
        await _showPermissionSheet(
          title: AppLocalizations.of(context)!.permissionRequired,
          message:
              '${AppLocalizations.of(context)!.permissionCamera}\n\nCamera access is restricted on this device.',
        );
      }
      return false;
    }
    if (status.isPermanentlyDenied) {
      if (mounted) {
        await _showPermissionSheet(
          title: AppLocalizations.of(context)!.permissionRequired,
          message:
              '${AppLocalizations.of(context)!.permissionCamera}\n\nCamera access is disabled. Open Settings to enable it.',
        );
      }
      return false;
    }
    return false;
  }

  Future<bool> _showCameraRationaleDialog() async {
    final localizations = AppLocalizations.of(context)!;
    final message =
        '${localizations.permissionCamera}\n\nWe only use the camera when you tap Scan Receipt.';
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
                Text(
                  localizations.permissionRequired,
                  style: BauhausTheme.headerStyle.copyWith(
                    color: BauhausTheme.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: BauhausTheme.bodyStyle.copyWith(
                    color: BauhausTheme.white,
                  ),
                ),
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            localizations.cancelButtonCaps,
                            style: BauhausTheme.subHeaderStyle.copyWith(
                              color: BauhausTheme.white,
                            ),
                          ),
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            localizations.grantPermission,
                            style: BauhausTheme.subHeaderStyle.copyWith(
                              color: BauhausTheme.white,
                            ),
                          ),
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

  Future<void> _showPermissionSheet({
    required String title,
    required String message,
  }) async {
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
                Text(
                  title,
                  style: BauhausTheme.headerStyle.copyWith(
                    color: BauhausTheme.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: BauhausTheme.bodyStyle.copyWith(
                    color: BauhausTheme.white,
                  ),
                ),
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'Open Settings',
                            style: BauhausTheme.subHeaderStyle.copyWith(
                              color: BauhausTheme.white,
                            ),
                          ),
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'Retry',
                            style: BauhausTheme.subHeaderStyle.copyWith(
                              color: BauhausTheme.white,
                            ),
                          ),
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
    File? imageFile;
    String rawText = '';
    try {
      final File? picked = await _ocrService.pickImage(ImageSource.gallery);
      if (picked == null) {
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
        return;
      }
      final File? cropped = await _ocrService.cropImage(picked);
      imageFile = cropped ?? picked;
      rawText = await _ocrService.extractText(imageFile);
      _logOcrPreview(rawText, 'gallery');
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
      final parsedTotal = _ocrResult?.totalAmount;
      final correctedTotal = _deriveBestTotal(rawText, parsedTotal);
      final resolvedTotal = _resolveTotal(parsedTotal, correctedTotal);
      if (resolvedTotal != null && resolvedTotal > 0) {
        _ocrResult = _withUpdatedTotal(_ocrResult, resolvedTotal, rawText);
        debugPrint(
          'QuickExpenseCaptureView: totals parsed=$parsedTotal derived=$correctedTotal resolved=$resolvedTotal',
        );
      }
      _capturedImage = XFile(imageFile.path);
      await _navigateToAddExpense(imageFile: imageFile, ocrResult: _ocrResult);
      return;
    } catch (e) {
      debugPrint('QuickExpenseCaptureView: gallery scan failed: $e');
      if (imageFile != null) {
        _ocrResult ??= OcrResult(
          merchant: '',
          date: '',
          totalAmount: 0.0,
          currency: 'USD',
          items: const [],
          rawText: rawText,
        );
        _capturedImage = XFile(imageFile.path);
        await _navigateToAddExpense(
          imageFile: imageFile,
          ocrResult: _ocrResult,
        );
        return;
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _navigateToAddExpenseFromState() async {
    final image = _capturedImage;
    if (image == null) {
      return;
    }
    await _navigateToAddExpense(
      imageFile: File(image.path),
      ocrResult: _ocrResult,
    );
  }

  Future<void> _navigateToAddExpense({
    required File imageFile,
    required OcrResult? ocrResult,
  }) async {
    if (!mounted) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpenseView(
          adminEmail: widget.adminEmail,
          organizationId: widget.organizationId,
          initialCategory: 'Office',
          initialReceiptFilePaths: [imageFile.path],
          initialTitle: ocrResult?.merchant,
          initialAmount: ocrResult?.totalAmount,
          initialDate: _parseOcrDate(ocrResult?.date),
          initialDescription: ocrResult?.rawText,
        ),
      ),
    );
    if (!mounted) return;
    Navigator.pop(context, result);
  }

  void _logOcrPreview(String rawText, String source) {
    final preview = rawText.trim();
    const maxLen = 200;
    final snippet = preview.length > maxLen
        ? preview.substring(0, maxLen)
        : preview;
    debugPrint(
      'QuickExpenseCaptureView: OCR preview ($source, len=${preview.length}): $snippet',
    );
  }

  OcrResult _withUpdatedTotal(OcrResult? base, double total, String rawText) {
    return OcrResult(
      merchant: base?.merchant ?? '',
      date: base?.date ?? '',
      totalAmount: total,
      currency: base?.currency ?? 'USD',
      items: base?.items ?? const [],
      rawText: base?.rawText.isNotEmpty == true ? base!.rawText : rawText,
    );
  }

  double? _deriveBestTotal(String rawText, double? parsedTotal) {
    final lines = rawText.split('\n');
    final candidates = <_AmountCandidate>[];
    for (var i = 0; i < lines.length; i++) {
      final lower = lines[i].toLowerCase();
      final score = _scoreLineForTotal(lower);
      if (score == null) continue;
      final bestNear = _selectAmountNearLine(lines, i, score, parsedTotal);
      if (bestNear != null) {
        candidates.add(bestNear);
      }
    }

    if (candidates.isNotEmpty) {
      candidates.sort((a, b) => b.score.compareTo(a.score));
      return candidates.first.value;
    }

    final allAmounts = <double>[];
    for (var i = 0; i < lines.length; i++) {
      final lower = lines[i].toLowerCase();
      if (_shouldIgnoreLineForTotal(lower)) continue;
      for (final hit in _extractAmounts(lines[i], i)) {
        if (hit.value > 0) allAmounts.add(hit.value);
      }
    }

    if (allAmounts.isEmpty) {
      return parsedTotal;
    }
    allAmounts.sort();
    return allAmounts.last;
  }

  _AmountCandidate? _selectAmountNearLine(
    List<String> lines,
    int index,
    int baseScore,
    double? parsedTotal,
  ) {
    final windowEnd = (index + 20).clamp(0, lines.length);
    final candidates = <double>[];
    for (var i = index; i < windowEnd; i++) {
      final lower = lines[i].toLowerCase();
      if (_shouldIgnoreLineForTotal(lower)) continue;
      for (final hit in _extractAmounts(lines[i], i)) {
        if (hit.value > 0) {
          candidates.add(hit.value);
        }
      }
    }
    if (candidates.isEmpty) {
      return null;
    }
    candidates.sort();
    if (parsedTotal != null && parsedTotal > 0) {
      final cap = parsedTotal * 3.0;
      final capped = candidates.where((value) => value <= cap).toList();
      if (capped.isNotEmpty) {
        capped.sort();
        return _AmountCandidate(capped.last, baseScore);
      }
    }
    return _AmountCandidate(candidates.last, baseScore);
  }

  List<_AmountHit> _extractAmounts(String line, int index) {
    final regex = RegExp(
      r'(?<!\d)(?:[$€£]|AUD|USD|NZD|GBP|EUR)?\s*-?\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})',
      caseSensitive: false,
    );
    final matches = regex.allMatches(line);
    final hits = <_AmountHit>[];
    for (final match in matches) {
      final token = match.group(0);
      if (token == null) continue;
      final value = _parseAmount(token);
      if (value == null) continue;
      hits.add(_AmountHit(value, index, line));
    }
    return hits;
  }

  double? _parseAmount(String token) {
    var cleaned = token.replaceAll(RegExp(r'[^\d,.\-()]'), '');
    if (cleaned.isEmpty) return null;
    final isNegative =
        cleaned.contains('-') ||
        (cleaned.startsWith('(') && cleaned.endsWith(')'));
    cleaned = cleaned.replaceAll('-', '');
    cleaned = cleaned.replaceAll('(', '');
    cleaned = cleaned.replaceAll(')', '');

    final hasDot = cleaned.contains('.');
    final hasComma = cleaned.contains(',');
    if (hasDot && hasComma) {
      final lastDot = cleaned.lastIndexOf('.');
      final lastComma = cleaned.lastIndexOf(',');
      final decimalSep = lastDot > lastComma ? '.' : ',';
      final thousandSep = decimalSep == '.' ? ',' : '.';
      cleaned = cleaned.replaceAll(thousandSep, '');
      cleaned = cleaned.replaceAll(decimalSep, '.');
      final value = double.tryParse(cleaned);
      if (value == null) return null;
      return isNegative ? -value : value;
    }

    if (hasComma) {
      final lastComma = cleaned.lastIndexOf(',');
      final decimals = cleaned.length - lastComma - 1;
      if (decimals == 2) {
        cleaned = cleaned.replaceAll('.', '');
        cleaned = cleaned.replaceAll(',', '.');
      } else {
        cleaned = cleaned.replaceAll(',', '');
      }
      final value = double.tryParse(cleaned);
      if (value == null) return null;
      return isNegative ? -value : value;
    }

    final value = double.tryParse(cleaned);
    if (value == null) return null;
    return isNegative ? -value : value;
  }

  int? _scoreLineForTotal(String lower) {
    if (lower.contains('invoice total')) return 100;
    if (lower.contains('grand total')) return 95;
    if (lower.contains('amount due') || lower.contains('amount payable')) {
      return 90;
    }
    if (lower.contains('balance due') || lower.contains('total due')) return 85;
    if (lower.contains('total') && !lower.contains('subtotal')) return 80;
    if (lower.contains('subtotal') || lower.contains('sub total')) return 30;
    return null;
  }

  bool _shouldIgnoreLineForTotal(String lower) {
    return lower.contains('change') ||
        lower.contains('cash') ||
        lower.contains('tender') ||
        lower.contains('paid') ||
        lower.contains('round') ||
        lower.contains('gst') ||
        lower.contains('vat') ||
        lower.contains('tax') ||
        lower.contains('discount');
  }

  double? _resolveTotal(double? parsed, double? derived) {
    if (parsed == null || parsed <= 0) return derived;
    if (derived == null || derived <= 0) return parsed;
    if (derived > parsed * 3.0) return parsed;
    return derived;
  }

  DateTime? _parseOcrDate(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;

    final direct = DateTime.tryParse(trimmed);
    if (direct != null) return direct;

    final match = RegExp(
      r'(\d{1,2})[./-](\d{1,2})[./-](\d{2,4})',
    ).firstMatch(trimmed);
    if (match != null) {
      final part1 = int.tryParse(match.group(1) ?? '');
      final part2 = int.tryParse(match.group(2) ?? '');
      var year = int.tryParse(match.group(3) ?? '');
      if (part1 == null || part2 == null || year == null) return null;
      if (year < 100) year += 2000;

      final dayFirst = part1 > 12 || part2 <= 12;
      final day = dayFirst ? part1 : part2;
      final month = dayFirst ? part2 : part1;
      if (month < 1 || month > 12 || day < 1 || day > 31) return null;
      return DateTime(year, month, day);
    }

    return null;
  }
}

class _AmountHit {
  final double value;
  final int lineIndex;
  final String line;

  _AmountHit(this.value, this.lineIndex, this.line);
}

class _AmountCandidate {
  final double value;
  final int score;

  _AmountCandidate(this.value, this.score);
}
