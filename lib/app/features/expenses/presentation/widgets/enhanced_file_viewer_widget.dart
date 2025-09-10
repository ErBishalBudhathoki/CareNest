import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:carenest/config/environment.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'file_types.dart';
import '../../../../shared/design_system/modern_saas_design_system.dart';

/// Enhanced file viewer widget that supports multiple file types
/// including images, PDFs, and Word documents with proper error handling
class EnhancedFileViewerWidget extends StatelessWidget {
  final List<String> filePaths;
  final String? description;

  const EnhancedFileViewerWidget({
    super.key,
    required this.filePaths,
    this.description,
  });

  /// Get file type based on extension
  ExpenseFileType _getFileType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.gif':
      case '.bmp':
      case '.webp':
        return ExpenseFileType.image;
      case '.pdf':
        return ExpenseFileType.pdf;
      case '.doc':
      case '.docx':
        return ExpenseFileType.document;
      default:
        return ExpenseFileType.unknown;
    }
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

  /// Get file color based on type
  Color _getFileColor(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.pdf':
        return Colors.red;
      case '.doc':
      case '.docx':
        return Colors.blue;
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.gif':
      case '.bmp':
      case '.webp':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Check if the path is a URL (server file) or local file path
  bool _isUrl(String path) {
    return path.startsWith('http://') ||
        path.startsWith('https://') ||
        path.startsWith('/uploads/');
  }

  /// Get the base URL from AppConfig
  String get _baseUrl => AppConfig.baseUrl;

  /// Get the full server URL for uploaded files
  String _getServerUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      debugPrint('Path is already a full URL: $path');
      return path;
    }

    // Use environment-based URL configuration
    final baseUrl = _baseUrl;

    // Handle different path formats
    String fullUrl;
    if (path.startsWith('/uploads/')) {
      // Path already includes /uploads/, just prepend base URL
      fullUrl = '$baseUrl${path.substring(1)}'; // Remove leading slash
    } else {
      // Extract just the filename from the full path
      String filename = path.split('/').last;
      // Construct the server URL with the uploads path (not uploads/receipts)
      fullUrl = '${baseUrl}uploads/$filename';
    }

    debugPrint(
        'Constructing server URL: baseUrl=$baseUrl, originalPath=$path, fullUrl=$fullUrl');
    return fullUrl;
  }

  /// Get file size in readable format
  String _getFileSize(String filePath) {
    try {
      if (_isUrl(filePath)) {
        return 'Server file';
      }

      final file = File(filePath);
      if (!file.existsSync()) return 'File not found';

      final bytes = file.lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } catch (e) {
      return 'Unknown size';
    }
  }

  /// Open file with appropriate viewer
  Future<void> _openFile(BuildContext context, String filePath) async {
    final fileType = _getFileType(filePath);
    final isServerFile = _isUrl(filePath);

    // Check if local file exists (only for local files)
    if (!isServerFile) {
      final file = File(filePath);
      if (!file.existsSync()) {
        _showErrorDialog(context, 'File not found',
            'The selected file could not be found on the device.');
        return;
      }
    }

    try {
      switch (fileType) {
        case ExpenseFileType.image:
          // Show full-screen image viewer
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _FullScreenImageViewer(
                imagePath: filePath,
                isServerFile: isServerFile,
              ),
            ),
          );
          break;
        case ExpenseFileType.pdf:
        case ExpenseFileType.document:
          if (isServerFile) {
            // For server files, download and open locally for better compatibility
            await _downloadAndOpenFile(context, filePath);
          } else {
            // For local files, try to open with open_file package
            try {
              final result = await OpenFile.open(filePath);
              if (result.type != ResultType.done) {
                debugPrint('OpenFile result: ${result.message}');
                _showErrorDialog(
                  context,
                  'Cannot open file',
                  'No app found to open this file type. Please install a PDF or document viewer app.',
                );
              }
            } catch (e) {
              debugPrint('Error opening local file: $e');
              _showErrorDialog(
                context,
                'Error opening file',
                'Failed to open the file: $e',
              );
            }
          }
          break;
        case ExpenseFileType.unknown:
          _showErrorDialog(
            context,
            'Unsupported file type',
            'This file type is not supported for viewing.',
          );
          break;
      }
    } catch (e) {
      _showErrorDialog(
        context,
        'Error opening file',
        'An error occurred while trying to open the file: $e',
      );
    }
  }

  /// Download and open server file locally
  Future<void> _downloadAndOpenFile(
      BuildContext context, String filePath) async {
    BuildContext? dialogContext;

    try {
      debugPrint('DEBUG: Starting download for file: $filePath');

      // Show loading dialog and capture its context
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Downloading file...'),
              ],
            ),
          );
        },
      );

      final serverUrl = _getServerUrl(filePath);
      debugPrint('DEBUG: Downloading from URL: $serverUrl');

      final response = await http.get(Uri.parse(serverUrl));
      debugPrint('DEBUG: HTTP response status: ${response.statusCode}');
      debugPrint(
          'DEBUG: Response content length: ${response.bodyBytes.length}');

      if (response.statusCode == 200) {
        // Get temporary directory
        final tempDir = await getTemporaryDirectory();
        final fileName = path.basename(filePath);
        final tempFile = File('${tempDir.path}/$fileName');

        debugPrint('DEBUG: Saving file to: ${tempFile.path}');

        // Write file to temporary location
        await tempFile.writeAsBytes(response.bodyBytes);

        debugPrint(
            'DEBUG: File saved successfully, size: ${await tempFile.length()} bytes');

        // Close loading dialog before opening file
        if (dialogContext != null && Navigator.of(dialogContext!).canPop()) {
          Navigator.of(dialogContext!).pop();
          dialogContext = null;
        }

        debugPrint('DEBUG: Attempting to open file with OpenFile package');

        // Try to open with open_file package
        final result = await OpenFile.open(tempFile.path);
        debugPrint('DEBUG: OpenFile result type: ${result.type}');
        debugPrint('DEBUG: OpenFile result message: ${result.message}');

        if (result.type != ResultType.done) {
          debugPrint('OpenFile result: ${result.message}');
          _showErrorDialog(
            context,
            'Cannot open file',
            'No app found to open this file type. Please install a PDF or document viewer app.\n\nResult: ${result.message}',
          );
        } else {
          debugPrint('DEBUG: File opened successfully!');
        }
      } else {
        // Close loading dialog on error
        if (dialogContext != null && Navigator.of(dialogContext!).canPop()) {
          Navigator.of(dialogContext!).pop();
          dialogContext = null;
        }

        debugPrint(
            'DEBUG: HTTP request failed with status: ${response.statusCode}');
        _showErrorDialog(
          context,
          'Download failed',
          'Failed to download file from server. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('DEBUG: Exception in _downloadAndOpenFile: $e');

      // Close loading dialog if still open
      if (dialogContext != null && Navigator.of(dialogContext!).canPop()) {
        Navigator.of(dialogContext!).pop();
      }

      debugPrint('Error downloading/opening file: $e');
      _showErrorDialog(
        context,
        'Error',
        'Failed to download or open the file: $e',
      );
    }
  }

  /// Show error dialog
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show detailed error dialog for image loading failures with retry option
  void _showImageErrorDialog(
      BuildContext context, String filePath, String url, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text('Image Load Error'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Failed to load image from server:',
              style: ModernSaasDesign.headlineSmall.copyWith(
                color: ModernSaasDesign.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                path.basename(filePath),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Error details:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: ModernSaasDesign.space1),
            Container(
              padding: EdgeInsets.all(ModernSaasDesign.space2),
              decoration: BoxDecoration(
                color: ModernSaasDesign.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
                border: Border.all(
                    color: ModernSaasDesign.error.withValues(alpha: 0.3)),
              ),
              child: Text(
                error,
                style: ModernSaasDesign.bodySmall.copyWith(
                  color: ModernSaasDesign.error,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This might be due to:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '• Network connectivity issues\n• Server file not found\n• Invalid file format\n• Server configuration problems',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Force rebuild to retry loading
              (context as Element).markNeedsBuild();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ModernSaasDesign.primary,
              foregroundColor: ModernSaasDesign.textOnPrimary,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (filePaths.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            const Icon(
              Icons.attach_file,
              color: Color(0xFF4CAF50),
              size: 20,
            ),
            const SizedBox(width: 8),
            const Text(
              'Receipt Attachments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${filePaths.length} file${filePaths.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Files grid
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: filePaths.length,
            itemBuilder: (context, index) {
              final filePath = filePaths[index];
              final fileType = _getFileType(filePath);
              final fileName = path.basename(filePath);
              final isServerFile = _isUrl(filePath);
              final fileExists = isServerFile || File(filePath).existsSync();

              return GestureDetector(
                onTap: () => _openFile(context, filePath),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: fileExists
                          ? _getFileColor(filePath).withValues(alpha: 0.3)
                          : Colors.red.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // File preview/icon
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: fileExists
                                ? _getFileColor(filePath).withValues(alpha: 0.1)
                                : Colors.red.withValues(alpha: 0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: fileExists
                              ? (fileType == ExpenseFileType.image
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: isServerFile
                                          ? CachedNetworkImage(
                                              imageUrl: _getServerUrl(filePath),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) {
                                                debugPrint(
                                                    'Loading image from URL: $url');
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                debugPrint(
                                                    'Failed to load image from URL: $url');
                                                debugPrint('Error: $error');
                                                return GestureDetector(
                                                  onTap: () {
                                                    // Show detailed error dialog and retry option
                                                    _showImageErrorDialog(
                                                        context,
                                                        filePath,
                                                        url,
                                                        error.toString());
                                                  },
                                                  child: _buildImageErrorWidget(
                                                      filePath,
                                                      url,
                                                      error.toString()),
                                                );
                                              },
                                            )
                                          : Image.file(
                                              File(filePath),
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return _buildFileIcon(
                                                    filePath, fileExists);
                                              },
                                            ),
                                    )
                                  : _buildFileIcon(filePath, fileExists))
                              : _buildFileIcon(filePath, fileExists),
                        ),
                      ),

                      // File info
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  fileName,
                                  style: ModernSaasDesign.bodySmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: fileExists
                                        ? ModernSaasDesign.textPrimary
                                        : ModernSaasDesign.error,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: ModernSaasDesign.space1),
                              Text(
                                fileExists
                                    ? _getFileSize(filePath)
                                    : 'File not found',
                                style: ModernSaasDesign.bodySmall.copyWith(
                                  fontSize: 9,
                                  color: fileExists
                                      ? ModernSaasDesign.textSecondary
                                      : ModernSaasDesign.error,
                                ),
                              ),
                              if (fileExists) ...[
                                SizedBox(height: ModernSaasDesign.space1),
                                Text(
                                  'Tap to view',
                                  style: ModernSaasDesign.bodySmall.copyWith(
                                    fontSize: 8,
                                    color: _getFileColor(filePath),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Description
        if (description != null && description!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.description,
                        size: 16, color: Colors.blue.shade600),
                    const SizedBox(width: 8),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// Build file icon widget
  Widget _buildFileIcon(String filePath, bool fileExists) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          fileExists ? _getFileIcon(filePath) : Icons.error_outline,
          size: 40,
          color: fileExists ? _getFileColor(filePath) : ModernSaasDesign.error,
        ),
        SizedBox(height: ModernSaasDesign.space2),
        Text(
          fileExists
              ? path.extension(filePath).toUpperCase().substring(1)
              : 'ERROR',
          style: ModernSaasDesign.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color:
                fileExists ? _getFileColor(filePath) : ModernSaasDesign.error,
          ),
        ),
      ],
    );
  }

  /// Build enhanced error widget for image loading failures
  Widget _buildImageErrorWidget(String filePath, String url, String error) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image,
            size: 32,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 4),
          Text(
            'Image failed to load',
            style: ModernSaasDesign.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: ModernSaasDesign.error,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'Tap to retry',
            style: ModernSaasDesign.bodySmall.copyWith(
              fontSize: 8,
              color: ModernSaasDesign.error.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: ModernSaasDesign.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
              border: Border.all(
                  color: ModernSaasDesign.error.withValues(alpha: 0.3)),
            ),
            child: Text(
              'Server file',
              style: ModernSaasDesign.bodySmall.copyWith(
                fontSize: 7,
                color: ModernSaasDesign.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen image viewer
class _FullScreenImageViewer extends StatelessWidget {
  final String imagePath;
  final bool isServerFile;

  const _FullScreenImageViewer({
    required this.imagePath,
    this.isServerFile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          path.basename(imagePath),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Share functionality coming soon'),
                  backgroundColor: ModernSaasDesign.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  /// Get the base URL from environment configuration
  String get _baseUrl {
    return kReleaseMode
        ? dotenv.env['RELEASE_URL'].toString()
        : dotenv.env['DEBUG_URL'].toString();
  }

  /// Get the full server URL for uploaded files
  String _getServerUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    // Use environment-based URL configuration
    final baseUrl = _baseUrl;
    return '$baseUrl${path.startsWith('/') ? path.substring(1) : path}';
  }

  /// Build the appropriate image widget based on file type
  Widget _buildImageWidget() {
    if (isServerFile) {
      final serverUrl = _getServerUrl(imagePath);
      debugPrint('Full-screen viewer loading image from URL: $serverUrl');
      return CachedNetworkImage(
        imageUrl: serverUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) {
          debugPrint('Full-screen placeholder for URL: $url');
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Loading image...',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          );
        },
        errorWidget: (context, url, error) {
          debugPrint('Full-screen error loading URL: $url');
          debugPrint('Full-screen error details: $error');
          return Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.broken_image,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Cannot load server image',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This might be due to network issues, an invalid URL, or the image may no longer exist on the server.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'URL: $url',
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          fontFamily: 'monospace'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Force reload by rebuilding the widget
                          Navigator.of(context).pop();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _FullScreenImageViewer(
                                  imagePath: imagePath,
                                  isServerFile: isServerFile,
                                ),
                              ),
                            );
                          });
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ModernSaasDesign.primary,
                          foregroundColor: ModernSaasDesign.textOnPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open in Browser'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ModernSaasDesign.textSecondary,
                          foregroundColor: ModernSaasDesign.textOnPrimary,
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
    } else {
      return File(imagePath).existsSync()
          ? Image.file(
              File(imagePath),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 64,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Cannot load image',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Image file not found',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            );
    }
  }
}
