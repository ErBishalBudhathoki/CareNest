import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:flutter/foundation.dart';
// CORRECTED: The import path for flutter_riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import '../../../services/system_ui_service.dart';

// --- New Imports for Modern UI (Ensure you've run 'flutter pub get') ---
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:blur/blur.dart'; // For the glassmorphism effect

class PhotoUploadScreen extends ConsumerStatefulWidget {
  final String email;
  const PhotoUploadScreen({super.key, required this.email});

  @override
  ConsumerState<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends ConsumerState<PhotoUploadScreen> {
  // State variables
  File? _imageFile;
  Uint8List? _updatedPhotoBytes;
  bool _isLoading = false;

  // Services and Utils
  final ApiMethod _apiMethod = ApiMethod();
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();
  final FlushBarWidget _flushBarWidget = FlushBarWidget();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // Slightly higher quality for better cropping
      );

      if (pickedFile == null) return;

      // Hide system UI before cropping
      await SystemUIService.hideSystemUI();

      final croppedFile = await _imageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Photo',
            toolbarColor: ModernInvoiceDesign.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls:
                true, // Hide bottom controls to avoid navigation bar interference
            statusBarColor: ModernInvoiceDesign.primary,
            activeControlsWidgetColor: ModernInvoiceDesign.primary,
            cropFrameColor: ModernInvoiceDesign.primary,
            cropGridColor: ModernInvoiceDesign.primary.withValues(alpha: 0.5),
            dimmedLayerColor: Colors.black.withValues(alpha: 0.8),
            showCropGrid: true,
            // Additional settings to prevent navigation bar interference
            cropFrameStrokeWidth: 3,
            cropGridStrokeWidth: 1,
            cropGridRowCount: 3,
            cropGridColumnCount: 3,
            backgroundColor: Colors.black,
          ),
          IOSUiSettings(
            title: 'Crop Photo',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
            hidesNavigationBar: true,
          ),
        ],
      );

      // Show system UI after cropping
      await SystemUIService.showSystemUI();

      if (croppedFile != null) {
        final bytes = await croppedFile.readAsBytes();
        setState(() {
          _imageFile = File(croppedFile.path);
          _updatedPhotoBytes = bytes;
        });
      }
    } catch (e) {
      // Ensure system UI is restored even if cropping fails
      await SystemUIService.showSystemUI();

      debugPrint("Error picking or cropping image: $e");
      _flushBarWidget.flushBar(
        title: 'Error',
        message: 'Could not select image. Please try again.',
        backgroundColor: ModernInvoiceDesign.warning,
        context: context,
      );
    }
  }

  Future<void> _uploadPhoto() async {
    if (_imageFile == null || _updatedPhotoBytes == null) return;

    setState(() => _isLoading = true);

    try {
      final response =
          await _apiMethod.uploadPhoto(context, widget.email, _imageFile!);

      bool isSuccess = false;
      if (response.containsKey('message')) {
        String message = response['message'];
        if (message.contains('Photo uploaded successfully')) {
          await ref
              .read(photoDataProvider.notifier)
              .updatePhotoData(_updatedPhotoBytes!);
          await SharedPreferencesUtils()
              .setPhoto(_updatedPhotoBytes!, widget.email);
          isSuccess = true;
        }
      }

      if (mounted) {
        if (isSuccess) {
          _flushBarWidget.flushBar(
            title: 'Success!',
            message: 'Your new photo is live.',
            backgroundColor: ModernInvoiceDesign.secondary,
            context: _scaffoldKey.currentContext!,
          );
          // Optionally pop after a short delay
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) Navigator.of(context).pop();
          });
        } else {
          throw Exception("API did not confirm success.");
        }
      }
    } catch (e) {
      debugPrint("Error uploading photo: $e");
      if (mounted) {
        _flushBarWidget.flushBar(
          title: 'Upload Failed',
          message: 'Could not upload photo. Please try again.',
          backgroundColor: ModernInvoiceDesign.warning,
          context: _scaffoldKey.currentContext!,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          ModernInvoiceDesign.background, // A soft, off-white background
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: ModernInvoiceDesign.surface, // Make AppBar transparent
        foregroundColor: ModernInvoiceDesign.textPrimary,
        title: const Text('Profile Photo'),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading:
            true, // Ensure leading widget is always shown
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          // Animated decorative background shapes
          _buildAnimatedBackground(),
          // Main scrollable content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: ModernInvoiceDesign.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: ModernInvoiceDesign.space5),
                  _buildHeader(),
                  const SizedBox(height: ModernInvoiceDesign.space10),
                  _buildPhotoPreview(),
                  const SizedBox(height: ModernInvoiceDesign.space8),
                  _buildActionButtons(),
                  const SizedBox(height: ModernInvoiceDesign.space10),
                  _buildTipsCard(),
                  const SizedBox(height: ModernInvoiceDesign.space10),
                ]
                    .animate(interval: 100.ms)
                    .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                    .slideY(
                        begin: 0.2, duration: 400.ms, curve: Curves.easeOut),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                  ModernInvoiceDesign.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(duration: 6000.ms, angle: 45, colors: [
          ModernInvoiceDesign.primary.withValues(alpha: 0.1),
          ModernInvoiceDesign.secondary.withValues(alpha: 0.1),
          ModernInvoiceDesign.primary.withValues(alpha: 0.1),
        ]),
        Positioned(
          bottom: -150,
          right: -150,
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  ModernInvoiceDesign.secondary.withValues(alpha: 0.1),
                  ModernInvoiceDesign.secondary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Show Your Best Side',
          textAlign: TextAlign.center,
          style: ModernInvoiceDesign.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: ModernInvoiceDesign.neutral900,
          ),
        ),
        const SizedBox(height: ModernInvoiceDesign.space3),
        Text(
          'A great photo builds trust and makes your profile stand out.',
          textAlign: TextAlign.center,
          style: ModernInvoiceDesign.bodyLarge.copyWith(
            color: ModernInvoiceDesign.neutral600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoPreview() {
    return GestureDetector(
      onTap: _pickImage,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: _imageFile == null ? _buildPlaceholder() : _buildImagePreview(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return DottedBorder(
      borderType: BorderType.Circle,
      color: ModernInvoiceDesign.primary.withValues(alpha: 0.5),
      strokeWidth: 2,
      dashPattern: const [12, 8],
      child: Container(
        height: 220,
        width: 220,
        decoration: BoxDecoration(
          color: ModernInvoiceDesign.primary.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              color: ModernInvoiceDesign.primary,
              size: 48,
            ),
            const SizedBox(height: ModernInvoiceDesign.space2),
            Text(
              'Tap to Select',
              style: ModernInvoiceDesign.bodyLarge.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .scale(delay: 300.ms, duration: 400.ms, curve: Curves.elasticOut);
  }

  Widget _buildImagePreview() {
    return Container(
      key: const ValueKey('image_preview'),
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ModernInvoiceDesign.primary.withValues(alpha: 0.3),
            blurRadius: 25,
            spreadRadius: -5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.file(
          _imageFile!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildButton(
          text: _imageFile == null ? 'Choose from Gallery' : 'Change Photo',
          icon: Icons.add_photo_alternate_outlined,
          onTap: _pickImage,
          isPrimary: true,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: _imageFile != null
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: ModernInvoiceDesign.space4),
                  child: _buildButton(
                    text: 'Upload & Save',
                    icon: Icons.cloud_upload_outlined,
                    onTap: _uploadPhoto,
                    isPrimary: false,
                    isLoading: _isLoading,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = true,
    bool isLoading = false,
  }) {
    final primaryColor =
        isPrimary ? ModernInvoiceDesign.primary : ModernInvoiceDesign.secondary;
    final onPrimaryColor = Colors.white;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [Colors.grey.shade400, Colors.grey.shade500]
                : [primaryColor, primaryColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isLoading)
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: onPrimaryColor, size: 20),
                    const SizedBox(width: ModernInvoiceDesign.space3),
                    Text(
                      text,
                      style: ModernInvoiceDesign.labelLarge.copyWith(
                        color: onPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    )
        .animate(target: isLoading ? 0 : 1)
        .scaleXY(end: 1.0, curve: Curves.elasticOut);
  }

  Widget _buildTipsCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          // The glassmorphism effect
          Positioned.fill(
            child: Container(
              color: Colors.white.withValues(alpha: 0.5),
            ).frosted(
              blur: 15,
              frostColor: ModernInvoiceDesign.background,
              frostOpacity: 0.4,
            ),
          ),
          // The content
          Container(
            padding: const EdgeInsets.all(ModernInvoiceDesign.space6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: ModernInvoiceDesign.primaryDark,
                    ),
                    const SizedBox(width: ModernInvoiceDesign.space3),
                    Text(
                      'A Few Quick Tips',
                      style: ModernInvoiceDesign.headlineMedium.copyWith(
                        color: ModernInvoiceDesign.neutral900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: ModernInvoiceDesign.space4),
                _buildTipRow(Icons.face_retouching_natural,
                    'Use a clear, recent photo of your face.'),
                const SizedBox(height: ModernInvoiceDesign.space3),
                _buildTipRow(Icons.wb_sunny_outlined,
                    'Find a spot with good, natural lighting.'),
                const SizedBox(height: ModernInvoiceDesign.space3),
                _buildTipRow(Icons.blur_off_outlined,
                    'A simple, uncluttered background works best.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ModernInvoiceDesign.primary, size: 20),
        const SizedBox(width: ModernInvoiceDesign.space4),
        Expanded(
          child: Text(
            text,
            style: ModernInvoiceDesign.bodyLarge.copyWith(
              color: ModernInvoiceDesign.neutral800,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
