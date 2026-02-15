import 'dart:io';
import 'dart:typed_data';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final apiMethod = ref.read(apiMethodProvider);
  return PhotoRepository(apiMethod);
});

class PhotoRepository {
  final ApiMethod _apiMethod;

  PhotoRepository(this._apiMethod);

  /// Get user photo by email
  /// Returns the photo data as Uint8List
  Future<Uint8List?> getUserPhoto(String email) async {
    try {
      // Use the existing getUserPhoto method from ApiMethod
      final photoData = await _apiMethod.getUserPhoto(email);
      return photoData;
    } catch (e) {
      throw Exception('Failed to get user photo: $e');
    }
  }

  /// Upload user photo
  /// [context] - BuildContext for showing feedback (required by ApiMethod)
  /// [email] - User email
  /// [imageFile] - Image file to upload
  /// Returns the uploaded photo URL
  Future<String> uploadUserPhoto(
      BuildContext context, String email, File imageFile) async {
    try {
      final response = await _apiMethod.uploadPhoto(
        context,
        email,
        imageFile,
      );

      if (response['success'] == true) {
        return response['photoUrl'] ?? '';
      } else {
        throw Exception(response['message'] ?? 'Failed to upload photo');
      }
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }

  /// Get user initialization data
  /// Returns user data including photo information
  Future<Map<String, dynamic>> getUserInitData(String email) async {
    try {
      final response = await _apiMethod.get('user/init-data/$email');

      if (response['success'] == true && response['data'] != null) {
        return response['data'] as Map<String, dynamic>;
      }

      throw Exception(response['message'] ?? 'Failed to get user data');
    } catch (e) {
      throw Exception('Failed to get user init data: $e');
    }
  }
}
