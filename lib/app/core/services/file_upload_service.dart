import 'package:flutter/foundation.dart';

import 'dart:io';
import 'package:carenest/backend/api_method.dart';

/// Service for uploading files to the server
class FileUploadService {
  final ApiMethod _api;

  FileUploadService({ApiMethod? api}) : _api = api ?? ApiMethod();

  /// Upload a receipt file to the server
  /// Returns the server URL of the uploaded file
  Future<String> uploadReceiptFile(File file) async {
    return _api.uploadReceiptFile(file);
  }

  /// Upload an organization logo file
  /// Returns the server URL of the uploaded file
  Future<String> uploadLogoFile(File file) async {
    return _api.uploadLogoFile(file);
  }

  /// Upload multiple receipt files
  /// Returns a list of server URLs
  Future<List<String>> uploadMultipleReceiptFiles(List<File> files) async {
    final List<String> uploadedUrls = [];

    for (final file in files) {
      try {
        final url = await uploadReceiptFile(file);
        uploadedUrls.add(url);
      } catch (e) {
        // If one file fails, we still want to try the others
        debugPrint('Failed to upload file ${file.path}: $e');
        rethrow; // Re-throw to let the caller handle the error
      }
    }

    return uploadedUrls;
  }
}
