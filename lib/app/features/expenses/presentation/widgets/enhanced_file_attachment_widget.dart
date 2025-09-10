import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as picker;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'file_types.dart';
import '../../../../shared/design_system/modern_saas_design_system.dart';

/// Enhanced file attachment widget that supports multiple file types
/// including images, PDFs, and Word documents with file size limits
class EnhancedFileAttachmentWidget extends StatefulWidget {
  final List<File>? initialFiles;
  final Function(List<File>) onFilesSelected;
  final int maxFiles;
  final int maxFileSizeMB; // Maximum file size in MB
  final String? description;
  final Function(String)? onDescriptionChanged;

  const EnhancedFileAttachmentWidget({
    super.key,
    this.initialFiles,
    required this.onFilesSelected,
    this.maxFiles = 5,
    this.maxFileSizeMB = 10, // Default 10MB limit
    this.description,
    this.onDescriptionChanged,
  });

  @override
  State<EnhancedFileAttachmentWidget> createState() =>
      _EnhancedFileAttachmentWidgetState();
}

class _EnhancedFileAttachmentWidgetState
    extends State<EnhancedFileAttachmentWidget> {
  List<File> _selectedFiles = [];
  final ImagePicker _imagePicker = ImagePicker();
  late TextEditingController _descriptionController;

  // Supported file extensions
  static const List<String> _supportedImageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.bmp',
    '.webp'
  ];
  static const List<String> _supportedDocumentExtensions = [
    '.pdf',
    '.doc',
    '.docx'
  ];
  static const List<String> _allSupportedExtensions = [
    ..._supportedImageExtensions,
    ..._supportedDocumentExtensions,
  ];

  @override
  void initState() {
    super.initState();
    _selectedFiles = widget.initialFiles ?? [];
    _descriptionController =
        TextEditingController(text: widget.description ?? '');
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  /// Check if file size is within limits
  bool _isFileSizeValid(File file) {
    final fileSizeInBytes = file.lengthSync();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    return fileSizeInMB <= widget.maxFileSizeMB;
  }

  /// Get file type based on extension
  ExpenseFileType _getFileType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    if (_supportedImageExtensions.contains(extension)) {
      return ExpenseFileType.image;
    } else if (_supportedDocumentExtensions.contains(extension)) {
      return ExpenseFileType.document;
    }
    return ExpenseFileType.unknown;
  }

  /// Get appropriate icon for file type
  IconData _getFileIcon(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.pdf':
        return Icons.picture_as_pdf;
      case '.doc':
      case '.docx':
        return Icons.description;
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.gif':
      case '.bmp':
      case '.webp':
        return Icons.image;
      default:
        return Icons.attach_file;
    }
  }

  /// Show file source selection dialog
  void _showFileSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ModernSaasDesign.radiusXl)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(ModernSaasDesign.space5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select File Source',
              style: ModernSaasDesign.headlineMedium,
            ),
            SizedBox(height: ModernSaasDesign.space5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromCamera();
                  },
                ),
                _buildSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
                _buildSourceOption(
                  icon: Icons.folder,
                  label: 'Files',
                  onTap: () {
                    Navigator.pop(context);
                    _pickFiles();
                  },
                ),
              ],
            ),
            SizedBox(height: ModernSaasDesign.space5),
          ],
        ),
      ),
    );
  }

  /// Build source option widget
  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(ModernSaasDesign.space4),
            decoration: BoxDecoration(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              border: Border.all(color: ModernSaasDesign.primary),
            ),
            child: Icon(
              icon,
              size: 32,
              color: ModernSaasDesign.primary,
            ),
          ),
          SizedBox(height: ModernSaasDesign.space2),
          Text(
            label,
            style: ModernSaasDesign.labelLarge,
          ),
        ],
      ),
    );
  }

  /// Pick image from camera
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        await _processImageFile(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Error taking photo: $e');
    }
  }

  /// Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 85,
      );

      for (final image in images) {
        if (_selectedFiles.length >= widget.maxFiles) {
          _showErrorSnackBar('Maximum ${widget.maxFiles} files allowed');
          break;
        }
        await _processImageFile(File(image.path));
      }
    } catch (e) {
      _showErrorSnackBar('Error selecting images: $e');
    }
  }

  /// Pick files using file picker
  Future<void> _pickFiles() async {
    try {
      picker.FilePickerResult? result =
          await picker.FilePicker.platform.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions:
            _allSupportedExtensions.map((e) => e.substring(1)).toList(),
        allowMultiple: true,
      );

      if (result != null) {
        for (final platformFile in result.files) {
          if (_selectedFiles.length >= widget.maxFiles) {
            _showErrorSnackBar('Maximum ${widget.maxFiles} files allowed');
            break;
          }

          if (platformFile.path != null) {
            final file = File(platformFile.path!);
            await _processFile(file);
          }
        }
      }
    } catch (e) {
      _showErrorSnackBar('Error selecting files: $e');
    }
  }

  /// Process image file with optional cropping
  Future<void> _processImageFile(File imageFile) async {
    if (!_isFileSizeValid(imageFile)) {
      _showErrorSnackBar('File size exceeds ${widget.maxFileSizeMB}MB limit');
      return;
    }

    try {
      // Offer cropping for images
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Receipt',
            toolbarColor: ModernSaasDesign.primary,
            toolbarWidgetColor: ModernSaasDesign.textOnPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Receipt',
          ),
        ],
      );

      final fileToAdd =
          croppedFile != null ? File(croppedFile.path) : imageFile;
      await _addFileToList(fileToAdd);
    } catch (e) {
      // If cropping fails, add original image
      await _addFileToList(imageFile);
    }
  }

  /// Process non-image file
  Future<void> _processFile(File file) async {
    if (!_isFileSizeValid(file)) {
      _showErrorSnackBar('File size exceeds ${widget.maxFileSizeMB}MB limit');
      return;
    }

    await _addFileToList(file);
  }

  /// Add file to the selected files list
  Future<void> _addFileToList(File file) async {
    try {
      // Copy file to app's document directory for persistent access
      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
      final newPath = path.join(appDir.path, 'receipts', fileName);

      // Create receipts directory if it doesn't exist
      final receiptsDir = Directory(path.dirname(newPath));
      if (!await receiptsDir.exists()) {
        await receiptsDir.create(recursive: true);
      }

      final copiedFile = await file.copy(newPath);

      setState(() {
        _selectedFiles.add(copiedFile);
      });

      widget.onFilesSelected(_selectedFiles);
    } catch (e) {
      _showErrorSnackBar('Error saving file: $e');
    }
  }

  /// Remove file from selection
  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
    widget.onFilesSelected(_selectedFiles);
  }

  /// Show error snackbar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ModernSaasDesign.error,
      ),
    );
  }

  /// Get file size in readable format
  String _getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(
              Icons.attach_file,
              color: ModernSaasDesign.primary,
              size: 20,
            ),
            SizedBox(width: ModernSaasDesign.space2),
            Text(
              'Receipt Attachments',
              style: ModernSaasDesign.headlineSmall.copyWith(
                color: ModernSaasDesign.primary,
              ),
            ),
            const Spacer(),
            Text(
              '${_selectedFiles.length}/${widget.maxFiles}',
              style: ModernSaasDesign.bodySmall.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: ModernSaasDesign.space3),

        // File size limit info
        Container(
          padding: EdgeInsets.all(ModernSaasDesign.space2),
          decoration: BoxDecoration(
            color: ModernSaasDesign.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
            border:
                Border.all(color: ModernSaasDesign.info.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: ModernSaasDesign.info),
              SizedBox(width: ModernSaasDesign.space2),
              Expanded(
                child: Text(
                  'Supported: Images, PDF, Word docs. Max ${widget.maxFileSizeMB}MB per file.',
                  style: ModernSaasDesign.bodySmall.copyWith(
                    color: ModernSaasDesign.info,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ModernSaasDesign.space3),

        // Selected files grid
        if (_selectedFiles.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(ModernSaasDesign.space3),
            decoration: BoxDecoration(
              color: ModernSaasDesign.neutral50,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              border: Border.all(color: ModernSaasDesign.neutral300),
            ),
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _selectedFiles.length,
                  itemBuilder: (context, index) {
                    final file = _selectedFiles[index];
                    final fileType = _getFileType(file.path);

                    return Container(
                      decoration: BoxDecoration(
                        color: ModernSaasDesign.surface,
                        borderRadius:
                            BorderRadius.circular(ModernSaasDesign.radiusMd),
                        border: Border.all(color: ModernSaasDesign.neutral300),
                      ),
                      child: Stack(
                        children: [
                          // File content
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  ModernSaasDesign.radiusMd),
                              child: fileType == ExpenseFileType.image
                                  ? Image.file(
                                      file,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildFileIcon(file);
                                      },
                                    )
                                  : _buildFileIcon(file),
                            ),
                          ),

                          // Remove button
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _removeFile(index),
                              child: Container(
                                padding:
                                    EdgeInsets.all(ModernSaasDesign.space1),
                                decoration: BoxDecoration(
                                  color: ModernSaasDesign.error,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: ModernSaasDesign.textOnPrimary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),

                          // File info
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(ModernSaasDesign.space1),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      ModernSaasDesign.radiusMd),
                                  bottomRight: Radius.circular(
                                      ModernSaasDesign.radiusMd),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    path.basename(file.path),
                                    style: ModernSaasDesign.bodySmall.copyWith(
                                      color: ModernSaasDesign.textOnPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _getFileSize(file),
                                    style: ModernSaasDesign.bodySmall.copyWith(
                                      color: ModernSaasDesign.textOnPrimary
                                          .withValues(alpha: 0.7),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: ModernSaasDesign.space3),
        ],

        // Add file button
        if (_selectedFiles.length < widget.maxFiles)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showFileSourceDialog,
              icon: const Icon(Icons.add),
              label: Text(_selectedFiles.isEmpty
                  ? 'Add Receipt Files'
                  : 'Add More Files'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ModernSaasDesign.primary,
                side: BorderSide(color: ModernSaasDesign.primary),
                padding:
                    EdgeInsets.symmetric(vertical: ModernSaasDesign.space3),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
              ),
            ),
          ),

        // Description field
        if (widget.onDescriptionChanged != null) ...[
          SizedBox(height: ModernSaasDesign.space4),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'File Description (Optional)',
              hintText: 'Add a description for your attachments...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              ),
              prefixIcon: const Icon(Icons.description),
            ),
            maxLines: 2,
            onChanged: widget.onDescriptionChanged,
          ),
        ],
      ],
    );
  }

  /// Build file icon widget for non-image files
  Widget _buildFileIcon(File file) {
    return Container(
      color: ModernSaasDesign.neutral100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getFileIcon(file.path),
            size: 32,
            color: ModernSaasDesign.primary,
          ),
          SizedBox(height: ModernSaasDesign.space1),
          Text(
            path.extension(file.path).toUpperCase(),
            style: ModernSaasDesign.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: ModernSaasDesign.primary,
            ),
          ),
        ],
      ),
    );
  }
}
