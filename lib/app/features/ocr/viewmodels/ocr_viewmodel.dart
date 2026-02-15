import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/ocr_service.dart';
import '../models/ocr_result.dart';
import '../repositories/ocr_repository.dart';

class OcrState {
  final File? scannedImage;
  final OcrResult? result;
  final bool isLoading;
  final String? errorMessage;

  const OcrState({
    this.scannedImage,
    this.result,
    this.isLoading = false,
    this.errorMessage,
  });

  OcrState copyWith({
    File? scannedImage,
    OcrResult? result,
    bool? isLoading,
    String? errorMessage,
  }) {
    return OcrState(
      scannedImage: scannedImage ?? this.scannedImage,
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage, // Reset if not provided? No, specific update needed.
    );
  }

  // Helper to clear error/result/image easily
  OcrState clear() => const OcrState();
}

final ocrViewModelProvider =
    StateNotifierProvider.autoDispose<OcrViewModel, OcrState>((ref) {
  final repository = ref.watch(ocrRepositoryProvider);
  return OcrViewModel(OcrService(), repository);
});

class OcrViewModel extends StateNotifier<OcrState> {
  final OcrService _ocrService;
  final OcrRepository _repository;

  OcrViewModel(this._ocrService, this._repository) : super(const OcrState());

  Future<void> pickAndScanImage(
      ImageSource source, BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null, result: null);

    try {
      // 1. Pick
      final pickedFile = await _ocrService.pickImage(source);
      if (pickedFile == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      // 2. Crop
      final croppedFile = await _ocrService.cropImage(pickedFile);
      if (croppedFile == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      state = state.copyWith(scannedImage: croppedFile);

      // 3. Extract Text (On-device)
      final rawText = await _ocrService.extractText(state.scannedImage!);

      // 4. Parse (Backend)
      final ocrSource = Platform.isIOS ? 'apple_vision' : 'google_mlkit';
      final parsedData =
          await _repository.parseReceipt(rawText, source: ocrSource);

      state = state.copyWith(
        isLoading: false,
        result: parsedData,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clear() {
    state = state.clear();
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }
}
