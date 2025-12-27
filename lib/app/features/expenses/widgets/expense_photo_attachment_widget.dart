
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../services/system_ui_service.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

class ExpensePhotoAttachmentWidget extends StatefulWidget {
  final List<File>? initialPhotos;
  final Function(List<File>) onPhotosSelected;
  final String? photoDescription;
  final Function(String) onDescriptionChanged;
  final int maxPhotos;

  const ExpensePhotoAttachmentWidget({
    super.key,
    this.initialPhotos,
    required this.onPhotosSelected,
    this.photoDescription,
    required this.onDescriptionChanged,
    this.maxPhotos = 5,
  });

  @override
  State<ExpensePhotoAttachmentWidget> createState() =>
      _ExpensePhotoAttachmentWidgetState();
}

class _ExpensePhotoAttachmentWidgetState
    extends State<ExpensePhotoAttachmentWidget> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _selectedPhotos = [];
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

  Future<void> _pickImage(ImageSource source) async {
    if (_selectedPhotos.length >= widget.maxPhotos) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Maximum ${widget.maxPhotos} photos allowed')),
        );
      }
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickSingleImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      await _cropAndAddImage(File(pickedFile.path));
    }
  }

  Future<void> _pickMultipleImages() async {
    final remainingSlots = widget.maxPhotos - _selectedPhotos.length;
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (pickedFiles.isNotEmpty) {
      final filesToProcess = pickedFiles.take(remainingSlots).toList();

      for (final pickedFile in filesToProcess) {
        await _cropAndAddImage(File(pickedFile.path));
      }

      if (pickedFiles.length > remainingSlots) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Only $remainingSlots photos could be added due to limit')),
          );
        }
      }
    }
  }

  Future<void> _cropAndAddImage(File imageFile) async {
    try {
      // Hide system UI before cropping
      await SystemUIService.hideSystemUI();

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Receipt',
            toolbarColor: const Color(0xFF667EEA),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: false,
            hideBottomControls:
                true, // Hide bottom controls to avoid navigation bar interference
            statusBarColor: const Color(0xFF667EEA),
            activeControlsWidgetColor: const Color(0xFF667EEA),
            cropFrameColor: const Color(0xFF667EEA),
            cropGridColor: const Color(0xFF667EEA).withOpacity(0.1),
            dimmedLayerColor: Colors.black.withOpacity(0.1),
            showCropGrid: true,
            // Additional settings to prevent navigation bar interference
            cropFrameStrokeWidth: 3,
            cropGridStrokeWidth: 1,
            cropGridRowCount: 3,
            cropGridColumnCount: 3,
          ),
          IOSUiSettings(
            title: 'Crop Receipt',
            aspectRatioLockEnabled: false,
            hidesNavigationBar: true,
          ),
        ],
      );

      // Show system UI after cropping
      await SystemUIService.showSystemUI();

      if (croppedFile != null) {
        setState(() {
          _selectedPhotos.add(File(croppedFile.path));
        });
        widget.onPhotosSelected(_selectedPhotos);
      }
    } catch (e) {
      // Ensure system UI is restored even if cropping fails
      await SystemUIService.showSystemUI();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error cropping image: $e')),
        );
      }
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
    widget.onPhotosSelected(_selectedPhotos);
  }

  void _removeAllPhotos() {
    setState(() {
      _selectedPhotos.clear();
    });
    widget.onPhotosSelected(_selectedPhotos);
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Photo Source',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSourceOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  _buildSourceOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFF667EEA).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xFF667EEA).withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF667EEA),
            ),
            SizedBox(height: 8.0),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500).copyWith(
                color: const Color(0xFF667EEA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt,
                  color: const Color(0xFF667EEA),
                ),
                SizedBox(width: 8.0),
                Text(
                  _selectedPhotos.isEmpty
                      ? 'Receipt Photos'
                      : 'Receipt Photos (${_selectedPhotos.length}/${widget.maxPhotos})',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                    color: const Color(0xFF667EEA),
                  ),
                ),
                const Spacer(),
                if (_selectedPhotos.isNotEmpty)
                  IconButton(
                    onPressed: _removeAllPhotos,
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.red,
                    ),
                    tooltip: 'Remove all photos',
                  ),
              ],
            ),
            SizedBox(height: 12.0),
            if (_selectedPhotos.isNotEmpty) ..._buildPhotosPreview(),
            if (_selectedPhotos.length < widget.maxPhotos)
              ..._buildAddPhotoButton(),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Photo Description (Optional)',
                hintText: 'Describe what this receipt is for...',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(8.0),
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

  List<Widget> _buildPhotosPreview() {
    return [
      SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _selectedPhotos.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 12.0),
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(8.0),
                    child: Image.file(
                      _selectedPhotos[index],
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removePhoto(index),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      SizedBox(height: 12.0),
    ];
  }

  List<Widget> _buildAddPhotoButton() {
    return [
      Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xFF667EEA).withOpacity(0.1),
            style: BorderStyle.solid,
          ),
          color: const Color(0xFF667EEA).withOpacity(0.1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _showImageSourceDialog,
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: const Color(0xFF667EEA),
                ),
                SizedBox(height: 8.0),
                Text(
                  _selectedPhotos.isEmpty
                      ? 'Add Receipt Photos'
                      : 'Add More Photos',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500).copyWith(
                    color: const Color(0xFF667EEA),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  _selectedPhotos.isEmpty
                      ? 'Tap to take photo or select from gallery'
                      : 'Add up to ${widget.maxPhotos - _selectedPhotos.length} more photos',
                  style: const TextStyle(fontSize: 12).copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
