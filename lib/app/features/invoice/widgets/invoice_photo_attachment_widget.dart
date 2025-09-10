import 'dart:io';
import 'dart:typed_data';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../services/system_ui_service.dart';
import 'package:flutter/foundation.dart';

/// Widget for attaching photos to invoices
/// Supports both gallery selection and camera capture with high quality
class InvoicePhotoAttachmentWidget extends ConsumerStatefulWidget {
  final Function(List<File>) onPhotosSelected;
  final List<File>? initialPhotos;
  final String? photoDescription;
  final Function(String)? onDescriptionChanged;
  final int maxPhotos;

  const InvoicePhotoAttachmentWidget({
    Key? key,
    required this.onPhotosSelected,
    this.initialPhotos,
    this.photoDescription,
    this.onDescriptionChanged,
    this.maxPhotos = 5,
  }) : super(key: key);

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
            toolbarColor: AppColors.colorPrimary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls:
                true, // Hide bottom controls to avoid navigation bar interference
            statusBarColor: AppColors.colorPrimary,
            activeControlsWidgetColor: AppColors.colorPrimary,
            cropFrameColor: AppColors.colorPrimary,
            cropGridColor: AppColors.colorPrimary.withValues(alpha: 0.5),
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
      backgroundColor:
          isError ? AppColors.colorWarning : AppColors.colorSecondary,
      context: context,
    );
  }

  void _showPhotoSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Add Invoice Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildSourceOption(
                icon: Icons.camera_alt,
                title: 'Take Photo',
                subtitle: 'Use device camera for high quality',
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromSource(ImageSource.camera);
                },
              ),
              _buildSourceOption(
                icon: Icons.photo_library,
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
          color: AppColors.colorPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: AppColors.colorPrimary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ModernInvoiceDesign.surface,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.attach_file,
                  color: AppColors.colorPrimary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Invoice Attachments',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_selectedPhotos.length}/${widget.maxPhotos}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

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
                            color: Colors.grey[300]!,
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
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

            if (_selectedPhotos.isNotEmpty) const SizedBox(height: 16),

            // Add photo button
            if (_selectedPhotos.length < widget.maxPhotos)
              GestureDetector(
                onTap: _isLoading ? null : _showPhotoSourceDialog,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  color: AppColors.colorPrimary.withValues(alpha: 0.5),
                  strokeWidth: 2,
                  dashPattern: const [8, 4],
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.colorPrimary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                color: AppColors.colorPrimary,
                                size: 32,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Add Photo',
                                style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Description field
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Photo Description (Optional)',
                hintText: 'Describe the attached photos...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 2,
              onChanged: widget.onDescriptionChanged,
            ),
          ],
        ),
      ),
    );
  }
}
