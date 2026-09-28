import 'dart:io';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import '../../../services/system_ui_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PhotoUploadScreen extends ConsumerStatefulWidget {
  final String email;
  const PhotoUploadScreen({super.key, required this.email});

  @override
  ConsumerState<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends ConsumerState<PhotoUploadScreen> {
  // State variables
  File? _imageFile;
  bool _isLoading = false;

  // Services and Utils
  late final ApiMethod _apiMethod;
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(apiMethodProvider);
  }

  void _showSnackBar({
    required String message,
    required Color backgroundColor,
  }) {
    if (!mounted) return;
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = backgroundColor == colorScheme.secondary
        ? colorScheme.onSecondary
        : colorScheme.onPrimary;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: BauhausDesign.getTextTheme(
            context,
          ).bodyMedium?.copyWith(color: foregroundColor),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
        ),
        margin: const EdgeInsets.all(BauhausDesign.space4),
      ),
    );
  }

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
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls:
                true, // Hide bottom controls to avoid navigation bar interference
            statusBarLight: false,
            activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
            cropFrameColor: Theme.of(context).colorScheme.primary,
            cropGridColor: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.5),
            dimmedLayerColor: Theme.of(
              context,
            ).colorScheme.inverseSurface.withValues(alpha: 0.8),
            showCropGrid: true,
            // Additional settings to prevent navigation bar interference
            cropFrameStrokeWidth: 3,
            cropGridStrokeWidth: 1,
            cropGridRowCount: 3,
            cropGridColumnCount: 3,
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
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
        setState(() {
          _imageFile = File(croppedFile.path);
        });
      }
    } catch (e) {
      // Ensure system UI is restored even if cropping fails
      await SystemUIService.showSystemUI();
      debugPrint('Error picking/cropping image: $e');
      _showSnackBar(
        message: "Could not select image. Please try again.",
        backgroundColor: BauhausDesign.warning,
      );
    }
  }

  Future<void> _uploadPhoto() async {
    if (_imageFile == null) {
      _showSnackBar(
        message: "Please select an image first",
        backgroundColor: BauhausDesign.warning,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiMethod.uploadPhoto(widget.email, _imageFile!);

      final isSuccess =
          response['success'] == true || response['statusCode'] == 200;

      if (isSuccess) {
        // Instant UI update with local image bytes
        final localBytes = await _imageFile!.readAsBytes();
        ref.read(photoDataProvider.notifier).updatePhotoData(localBytes);
        await SharedPreferencesUtils().setPhoto(localBytes, widget.email);

        _showSnackBar(
          message: "Photo uploaded successfully",
          backgroundColor: BauhausDesign.success,
        );

        // Non-blocking background refresh to sync with server
        // (won't overwrite local data on failure)
        ref
            .read(photoDataProvider.notifier)
            .fetchPhotoData(widget.email, forceRefresh: true);

        // Pop after delay
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) Navigator.pop(context);
        });
      } else {
        // Error
        _showSnackBar(
          message: response['message'] ?? "Upload failed",
          backgroundColor: BauhausDesign.warning,
        );
      }
    } catch (e) {
      _showSnackBar(
        message: "Error uploading photo: $e",
        backgroundColor: BauhausDesign.warning,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
        scrolledUnderElevation: 0,
        title: Text(
          'Profile Photo',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                [
                      const SizedBox(height: BauhausDesign.space5),
                      _buildHeader(),
                      const SizedBox(height: BauhausDesign.space10),
                      _buildPhotoPreview(),
                      const SizedBox(height: BauhausDesign.space8),
                      _buildActionButtons(),
                      const SizedBox(height: BauhausDesign.space10),
                      _buildTipsCard(),
                      const SizedBox(height: BauhausDesign.space10),
                    ]
                    .animate(interval: 100.ms)
                    .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                    .slideY(
                      begin: 0.2,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),
          ),
        ),
      ),
    );
  }

  // Animated background removed for cleaner Bauhaus look

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Show Your Best Side',
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        Text(
          'A great photo builds trust and makes your profile stand out.',
          textAlign: TextAlign.center,
          style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
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
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        color: BauhausDesign.primary.withValues(alpha: 0.05),
        border: Border.all(
          color: BauhausDesign.primary.withValues(alpha: 0.5),
          width: 2,
          style: BorderStyle.solid, // Replaced DottedBorder
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            color: BauhausDesign.primary,
            size: 48,
          ),
          const SizedBox(height: BauhausDesign.space2),
          Text(
            'Tap to Select',
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: BauhausDesign.primary,
            ),
          ),
        ],
      ),
    ).animate().scale(
      delay: 300.ms,
      duration: 400.ms,
      curve: Curves.elasticOut,
    );
  }

  Widget _buildImagePreview() {
    return Container(
      key: const ValueKey('image_preview'),
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        boxShadow: const [BauhausDesign.shadowHard],
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      ),
      child: ClipOval(child: Image.file(_imageFile!, fit: BoxFit.cover)),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        BauhausActionButton(
          text: _imageFile == null ? 'Choose from Gallery' : 'Change Photo',
          icon: Icons.add_photo_alternate_outlined,
          onPressed: _pickImage,
          variant: _imageFile == null
              ? BauhausActionVariant.primary
              : BauhausActionVariant.secondary,
          isFullWidth: true,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: _imageFile != null
              ? Padding(
                  padding: const EdgeInsets.only(top: BauhausDesign.space4),
                  child: BauhausActionButton(
                    text: 'Upload & Save',
                    icon: Icons.cloud_upload_outlined,
                    onPressed: _isLoading ? null : _uploadPhoto,
                    variant: BauhausActionVariant.primary,
                    isLoading: _isLoading,
                    isFullWidth: true,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildTipsCard() {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                color: BauhausDesign.warning,
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                'A Few Quick Tips',
                style: BauhausDesign.getTextTheme(context).headlineSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildTipRow(
            Icons.face_retouching_natural,
            'Use a clear, recent photo of your face.',
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildTipRow(
            Icons.wb_sunny_outlined,
            'Find a spot with good, natural lighting.',
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildTipRow(
            Icons.blur_off_outlined,
            'A simple, uncluttered background works best.',
          ),
        ],
      ),
    );
  }

  Widget _buildTipRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: BauhausDesign.primary, size: 20),
        const SizedBox(width: BauhausDesign.space4),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
