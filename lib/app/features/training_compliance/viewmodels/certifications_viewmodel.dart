import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carenest/app/features/training_compliance/models/certification.dart';
import 'package:carenest/app/features/training_compliance/repositories/training_compliance_repository.dart';

part 'certifications_viewmodel.freezed.dart';

@freezed
abstract class CertificationsState with _$CertificationsState {
  const factory CertificationsState({
    @Default(false) bool isLoading,
    @Default([]) List<Certification> certifications,
    String? errorMessage,
  }) = _CertificationsState;
}

class CertificationsViewModel extends StateNotifier<CertificationsState> {
  final TrainingComplianceRepository _repository;

  CertificationsViewModel(this._repository) : super(const CertificationsState());

  Future<void> loadCertifications({String? status, String? userId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final certs = await _repository.getCertifications(status: status, userId: userId);
      state = state.copyWith(isLoading: false, certifications: certs);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> uploadCertification(
    File file,
    String name,
    String issuer,
    DateTime expiryDate,
    String? notes, {
    String? certificationNumber,
    String? requirementId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.uploadCertification(
        file: file,
        name: name,
        issuer: issuer,
        expiryDate: expiryDate,
        notes: notes,
        certificationNumber: certificationNumber,
        requirementId: requirementId,
      );
      // Reload list
      await loadCertifications();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateCertification({
    required String id,
    String? name,
    String? issuer,
    DateTime? expiryDate,
    String? notes,
    String? certificationNumber,
    String? requirementId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.updateCertification(
        id: id,
        name: name,
        issuer: issuer,
        expiryDate: expiryDate,
        notes: notes,
        certificationNumber: certificationNumber,
        requirementId: requirementId,
      );
      await loadCertifications();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteCertification(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repository.deleteCertification(id);
      await loadCertifications();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
