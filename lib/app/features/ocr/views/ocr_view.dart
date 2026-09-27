import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../viewmodels/ocr_viewmodel.dart';
import 'ocr_result_view.dart';

class OcrView extends ConsumerWidget {
  const OcrView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ocrViewModelProvider);
    final notifier = ref.read(ocrViewModelProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    // Navigation to Result View
    if (state.result != null) {
      // Use microtask to avoid build phase navigation or assume this replaces the view
      // But typically we should navigate.
      // For now, return the result view directly
      return OcrResultView(result: state.result!);
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'EXPENSE CAPTURE',
          style: GoogleFonts.bebasNeue(
            color: colorScheme.secondary,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.secondary),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBauhausCard(
                  context: context,
                  title: 'CAMERA',
                  icon: Icons.camera_alt_outlined,
                  color: colorScheme.error,
                  onTap: () =>
                      notifier.pickAndScanImage(ImageSource.camera, context),
                ),
                const SizedBox(height: 24),
                _buildBauhausCard(
                  context: context,
                  title: 'GALLERY',
                  icon: Icons.photo_library_outlined,
                  color: colorScheme.secondary,
                  onTap: () =>
                      notifier.pickAndScanImage(ImageSource.gallery, context),
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      border: Border.all(color: colorScheme.error, width: 2),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: GoogleFonts.archivo(
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (state.isLoading) _buildBauhausLoader(context, size),
        ],
      ),
    );
  }

  Widget _buildBauhausCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = color == colorScheme.error
        ? colorScheme.onError
        : color == colorScheme.secondary
        ? colorScheme.onSecondary
        : colorScheme.onTertiary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(0), // Sharp corners for Bauhaus
          boxShadow: [
            BoxShadow(
              color: colorScheme.outline.withValues(alpha: 0.2),
              offset: const Offset(8, 8), // Hard shadow
              blurRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Geometric Decor
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: foregroundColor.withValues(alpha: 0.2),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 48, color: foregroundColor),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: foregroundColor,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBauhausLoader(BuildContext context, Size size) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.inverseSurface.withValues(alpha: 0.9),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Simple geometric loader
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                backgroundColor: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'PROCESSING...',
              style: GoogleFonts.bebasNeue(
                fontSize: 28,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
