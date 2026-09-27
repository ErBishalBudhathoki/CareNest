import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/ocr_result.dart';
import '../viewmodels/ocr_viewmodel.dart';

class OcrResultView extends ConsumerWidget {
  final OcrResult result;

  const OcrResultView({super.key, required this.result});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'VERIFY DETAILS',
          style: GoogleFonts.bebasNeue(
            color: colorScheme.secondary,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => ref.read(ocrViewModelProvider).clear(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'MERCHANT'),
            _buildBauhausInput(context, initialValue: result.merchant),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(context, 'DATE'),
                      _buildBauhausInput(context, initialValue: result.date),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(context, 'AMOUNT'),
                      _buildBauhausInput(
                        context,
                        initialValue: result.totalAmount.toStringAsFixed(2),
                        prefix: '\$',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSectionHeader(context, 'RAW TEXT PREVIEW'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: colorScheme.surfaceContainer,
              child: Text(
                result.rawText,
                style: GoogleFonts.robotoMono(fontSize: 12),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.secondary,
                  foregroundColor: colorScheme.onSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  ref.read(ocrViewModelProvider).clear();
                  Navigator.of(context).pop(result);
                },
                child: Text(
                  'CONFIRM & SAVE',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 24,
                    color: colorScheme.onSecondary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.archivo(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.tertiary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildBauhausInput(
    BuildContext context, {
    required String initialValue,
    String? prefix,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline, width: 2),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.4),
            offset: const Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.archivo(
          color: colorScheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixText: prefix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
