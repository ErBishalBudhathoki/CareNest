import 'package:carenest/app/features/claiming/models/claim_import_result.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 6: the import summary must distinguish a clean reconciliation from a
/// partial or failed one, which the batch status alone does not convey at a
/// glance.
void main() {
  test('parses an accepted summary as clean', () {
    final result = ClaimImportResult.fromJson({
      'batchStatus': 'reconciled',
      'accepted': 12,
      'rejected': 0,
      'unmatched': 0,
    });

    expect(result.batchStatus, 'reconciled');
    expect(result.total, 12);
    expect(result.isClean, isTrue);
    expect(result.needsAttention, isFalse);
    expect(result.summaryLine, '12 accepted');
  });

  test('parses a partial summary as needing attention', () {
    final result = ClaimImportResult.fromJson({
      'batchStatus': 'partial',
      'accepted': 9,
      'rejected': 3,
      'unmatched': 1,
    });

    expect(result.isClean, isFalse);
    expect(result.needsAttention, isTrue);
    expect(result.summaryLine, '9 accepted · 3 rejected · 1 unmatched');
  });

  test('parses a failed summary', () {
    final result = ClaimImportResult.fromJson({
      'batchStatus': 'failed',
      'accepted': 0,
      'rejected': 4,
      'unmatched': 0,
    });

    expect(result.needsAttention, isTrue);
    expect(result.summaryLine, '4 rejected');
  });

  test('tolerates a missing summary and numeric strings', () {
    const empty = ClaimImportResult();
    expect(empty.total, 0);
    expect(empty.isClean, isFalse);
    expect(
      empty.summaryLine,
      'No claim lines were returned in the results file.',
    );

    final coerced = ClaimImportResult.fromJson({
      'batchStatus': 'reconciled',
      'accepted': '5',
      'rejected': 0,
      'unmatched': null,
    });
    expect(coerced.accepted, 5);
    expect(coerced.unmatched, 0);
  });
}
