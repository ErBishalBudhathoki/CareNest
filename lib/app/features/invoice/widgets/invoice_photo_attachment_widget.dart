

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../services/system_ui_service.dart';

/// Widget for attaching photos to invoices
/// Supports both gallery selection and camera capture with high quality
class InvoicePhotoAttachmentWidget extends ConsumerStatefulWidget {
  final Function(List<File>) onPhotosSelected;
  final List<File>? initialPhotos;
  final String? photoDescription;
  final Function(String)? onDescriptionChanged;
  final int maxPhotos;

  const InvoicePhotoAttachmentWidget({
    super.key,
    required this.onPhotosSelected,
    this.initialPhotos,
    this.photoDescription,
    this.onDescriptionChanged,
    this.maxPhotos = 5,
  });

  @override
  ConsumerState<InvoicePhotoAttachmentWidget> createState() =>
      _InvoicePhotoAttachmentWidgetState();
}

class _InvoicePhotoAttachmentWidgetState
    extends ConsumerState<InvoicePhotoAttachmentWidget> {
  List<File> _selectedPhotos = [];
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _imageCropper = ImageCropper();
  final FlushBarWidget _flushBarWidget = FlushBarWidget();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedPhotos = widget.initialPhotos ?? [];
    _descriptionController.text = widget.photoDescription ?? '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    if (_selectedPhotos.length >= widget.maxPhotos) {
      _showMessage('Maximum ${widget.maxPhotos} photos allowed', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (source == ImageSource.gallery) {
        // For gallery, allow multiple selection
        await _pickMultipleImages();
      } else {
        // For camera, single image only
        await _pickSingleImage(source);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error picking image: $e");
      _showMessage('Could not select photo. Please try again.', isError: true);
    }
  }

  Future<void> _pickSingleImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 90, // High quality for invoices
      maxWidth: 2048,
      maxHeight: 2048,
    );

    if (pickedFile == null) {
      setState(() => _isLoading = false);
      return;
    }

    await _processSingleImage(pickedFile.path);
  }

  Future<void> _pickMultipleImages() async {
    final remainingSlots = widget.maxPhotos - _selectedPhotos.length;

    final pickedFiles = await _picker.pickMultiImage(
      imageQuality: 90,
      maxWidth: 2048,
      maxHeight: 2048,
    );

    if (pickedFiles.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    // Limit to remaining slots
    final filesToProcess = pickedFiles.take(remainingSlots).toList();

    if (filesToProcess.length < pickedFiles.length) {
      _showMessage('Only ${filesToProcess.length} photos added due to limit',
          isError: true);
    }

    // Process each selected image
    for (final pickedFile in filesToProcess) {
      await _processSingleImage(pickedFile.path);
    }
  }

  Future<void> _processSingleImage(String imagePath) async {
    try {
      // Hide system UI before cropping
      await SystemUIService.hideSystemUI();

      // Optional cropping for better presentation
      final croppedFile = await _imageCropper.cropImage(
        sourcePath: imagePath,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Invoice Photo',
            toolbarColor: BauhausDesign.primary,
            toolbarWidgetColor: BauhausDesign.surfaceWhite,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls:
                true, // Hide bottom controls to avoid navigation bar interference
            statusBarColor: BauhausDesign.primary,
            activeControlsWidgetColor: BauhausDesign.primary,
            cropFrameColor: BauhausDesign.primary,
            cropGridColor: BauhausDesign.primary.withOpacity(0.1),
            dimmedLayerColor: Colors.black.withOpacity(0.1),
            showCropGrid: true,
            // Additional settings to prevent navigation bar interference
            cropFrameStrokeWidth: 3,
            cropGridStrokeWidth: 1,
            cropGridRowCount: 3,
            cropGridColumnCount: 3,
          ),
          IOSUiSettings(
            title: 'Crop Invoice Photo',
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
            hidesNavigationBar: true,
          ),
        ],
      );

      // Show system UI after cropping
      await SystemUIService.showSystemUI();

      final File finalFile =
          croppedFile != null ? File(croppedFile.path) : File(imagePath);

      setState(() {
        _selectedPhotos.add(finalFile);
        _isLoading = false;
      });

      widget.onPhotosSelected(_selectedPhotos);
      _showMessage('Photo added successfully!');
    } catch (e) {
      // Ensure system UI is restored even if cropping fails
      await SystemUIService.showSystemUI();

      setState(() {
        _isLoading = false;
      });

      _showMessage('Error processing image: $e', isError: true);
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
    widget.onPhotosSelected(_selectedPhotos);
    _showMessage('Photo removed');
  }

  void _showMessage(String message, {bool isError = false}) {
    _flushBarWidget.flushBar(
      title: isError ? 'Error' : 'Success',
      message: message,
      context: context,
      backgroundColor: isError ? BauhausDesign.error : BauhausDesign.success,
    );
  }

  void _showPhotoSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: BauhausDesign.neutral,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Add Invoice Photo',
                style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildSourceOption(
                icon: Icons.camera_alt_outlined,
                title: 'Take Photo',
                subtitle: 'Use device camera for high quality',
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromSource(ImageSource.camera);
                },
              ),
              _buildSourceOption(
                icon: Icons.photo_library_outlined,
                title: 'Choose from Gallery',
                subtitle: 'Select from existing photos',
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromSource(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: BauhausDesign.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: BauhausDesign.primary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
          color: BauhausDesign.textMuted,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BauhausCard(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.attach_file,
                color: BauhausDesign.primary,
                size: 20,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                'Invoice Attachments',
                style: BauhausDesign.getTextTheme(context).titleMedium,
              ),
              const Spacer(),
              Text(
                '${_selectedPhotos.length}/${widget.maxPhotos}',
                style: BauhausDesign.getTextTheme(context).bodySmall,
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Photo grid
          if (_selectedPhotos.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: _selectedPhotos.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _selectedPhotos[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => _removePhoto(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: BauhausDesign.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: BauhausDesign.surfaceWhite,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

          if (_selectedPhotos.isNotEmpty) const SizedBox(height: BauhausDesign.space4),

          // Add photo button
          if (_selectedPhotos.length < widget.maxPhotos)
            GestureDetector(
              onTap: _isLoading ? null : _showPhotoSourceDialog,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                color: BauhausDesign.primary.withOpacity(0.3),
                strokeWidth: 2,
                dashPattern: const [8, 4],
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: BauhausDesign.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: BauhausDesign.primary,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: BauhausDesign.primary,
                              size: 32,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Add Photo',
                              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                                color: BauhausDesign.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

          const SizedBox(height: BauhausDesign.space4),

          // Description field
          BauhausTextField(
            controller: _descriptionController,
            label: 'Photo Description (Optional)',
            hintText: 'Describe the attached photos...',
            prefixIcon: const Icon(Icons.description_outlined, color: BauhausDesign.textMuted),
            maxLines: 2,
            onChanged: widget.onDescriptionChanged,
          ),
        ],
      ),
    );
  }
}
