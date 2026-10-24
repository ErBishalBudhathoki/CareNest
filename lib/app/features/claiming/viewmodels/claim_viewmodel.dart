import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/claiming/models/claim_import_result.dart';
import 'package:carenest/app/features/claiming/models/claim_models.dart';
import 'package:carenest/app/features/claiming/repositories/claim_repository.dart';

class ClaimState {
  final bool isLoading;
  final String? error;
  final List<ClaimBatch> batches;
  final ClaimBatch? activeBatch;
  final List<ClaimLine> activeLines;
  final String? lastCsv;
  final ClaimValidation? validation;

  /// Reconciliation outcome of the most recent (or opened) results import.
  final ClaimImportResult? lastImport;

  ClaimState({
    this.isLoading = false,
    this.error,
    this.batches = const [],
    this.activeBatch,
    this.activeLines = const [],
    this.lastCsv,
    this.validation,
    this.lastImport,
  });

  ClaimState copyWith({
    bool? isLoading,
    String? error,
    List<ClaimBatch>? batches,
    ClaimBatch? activeBatch,
    List<ClaimLine>? activeLines,
    String? lastCsv,
    ClaimValidation? validation,
    ClaimImportResult? lastImport,
    bool clearLastImport = false,
  }) {
    return ClaimState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      batches: batches ?? this.batches,
      activeBatch: activeBatch ?? this.activeBatch,
      activeLines: activeLines ?? this.activeLines,
      lastCsv: lastCsv ?? this.lastCsv,
      validation: validation ?? this.validation,
      lastImport: clearLastImport ? null : (lastImport ?? this.lastImport),
    );
  }
}

class ClaimViewModel extends Notifier<ClaimState> {
  ClaimRepository get _repository => ref.read(claimRepositoryProvider);

  @override
  ClaimState build() {
    ref.watch(claimRepositoryProvider);
    return ClaimState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final batches = await _repository.getBatches();
      state = state.copyWith(isLoading: false, batches: batches);
    } catch (e) {
      debugPrint('Error loading claim batches: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> openBatch(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getBatch(id);
      state = state.copyWith(
        isLoading: false,
        activeBatch: result.batch,
        activeLines: result.lines,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Returns the generated CSV on success; surfaces validation errors on failure.
  Future<String?> generate({
    required String from,
    required String to,
    bool allowInvalid = false,
  }) async {
    state = state.copyWith(isLoading: true, error: null, validation: null);
    try {
      final result = await _repository.generate(
        from: from,
        to: to,
        allowInvalid: allowInvalid,
      );
      await load();
      state = state.copyWith(
        isLoading: false,
        activeBatch: result.batch,
        lastCsv: result.csv,
        validation: result.validation,
      );
      return result.csv;
    } on ClaimGenerationException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
        validation: e.validation,
      );
      return null;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  Future<bool> submitBatch(
    String batchId, {
    String portalReference = '',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.submit(batchId, portalReference: portalReference);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> recordRemittance(
    String batchId, {
    required double paidAmount,
    String? paidAt,
    String reference = '',
    String notes = '',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.recordRemittance(
        batchId,
        paidAmount: paidAmount,
        paidAt: paidAt,
        reference: reference,
        notes: notes,
      );
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> resubmitRejected(String batchId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.resubmit(batchId);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Imports a results file and returns the reconciliation summary, or null
  /// when the import itself failed (network/validation error). A non-null
  /// result may still describe a `partial` or `failed` reconciliation — that is
  /// a successful import with a business outcome the officer must see.
  Future<ClaimImportResult?> importResults(
    String batchId,
    String fileContent,
  ) async {
    state = state.copyWith(isLoading: true, error: null, clearLastImport: true);
    try {
      final result = await _repository.importResults(batchId, fileContent);
      await load();
      state = state.copyWith(isLoading: false, lastImport: result);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }
}

final claimViewModelProvider = NotifierProvider<ClaimViewModel, ClaimState>(
  ClaimViewModel.new,
);
