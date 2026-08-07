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
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        title: Text(
          'VERIFY DETAILS',
          style: GoogleFonts.bebasNeue(
            color: const Color(0xFF1D3557),
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1D3557)),
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
            _buildSectionHeader('MERCHANT'),
            _buildBauhausInput(initialValue: result.merchant),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('DATE'),
                      _buildBauhausInput(initialValue: result.date),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('AMOUNT'),
                      _buildBauhausInput(
                        initialValue: result.totalAmount.toStringAsFixed(2),
                        prefix: '\$',
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildSectionHeader('RAW TEXT PREVIEW'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFE0E0E0),
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
                  backgroundColor: const Color(0xFF1D3557), // Navy
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
                    color: Colors.white,
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: GoogleFonts.archivo(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFE63946), // Red
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildBauhausInput({required String initialValue, String? prefix}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF4A261).withOpacity(0.4), // Orange tint
            offset: const Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.archivo(fontSize: 18, fontWeight: FontWeight.w500),
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
