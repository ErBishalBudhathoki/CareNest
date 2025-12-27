import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:carenest/config/environment.dart';

/// Service for uploading files to the server
class FileUploadService {
  // Use AppConfig for base URL
  String get _baseUrl => AppConfig.baseUrl;

  /// Upload a receipt file to the server
  /// Returns the server URL of the uploaded file
  Future<String> uploadReceiptFile(File file) async {
    try {
      final uploadUrl = '${_baseUrl}api/upload/receipt';

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

      // Add the file
      request.files.add(
        await http.MultipartFile.fromPath(
          'receipt',
          file.path,
        ),
      );

      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true &&
            responseData['fileUrl'] != null) {
          // Return the full server URL
          final fileUrl = responseData['fileUrl'] as String;
          // Check if fileUrl already starts with http/https (full URL) or is a relative path
          if (fileUrl.startsWith('http://') || fileUrl.startsWith('https://')) {
            return fileUrl;
          } else {
            // Construct full URL for relative paths
            return '$_baseUrl${fileUrl.startsWith('/') ? fileUrl.substring(1) : fileUrl}';
          }
        } else {
          throw Exception(responseData['message'] ?? 'Upload failed');
        }
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ??
            'Upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
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
