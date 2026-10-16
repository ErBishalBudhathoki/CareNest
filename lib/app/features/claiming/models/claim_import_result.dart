/// Outcome of importing a Bulk Payment Results File (BPRF) for a claim batch.
///
/// The backend reconciles each returned claim reference against the batch's
/// claim lines and then sets the batch status:
///   * `reconciled` — every returned line was accepted
///   * `partial`    — some accepted, some rejected
///   * `failed`     — every returned line was rejected
///
/// `unmatched` counts references in the results file that do not exist in the
/// batch (a wrong file, or lines already imported). Before this existed the app
/// showed a flat "Results imported." for all three outcomes, so a rejected or
/// partially-rejected submission was indistinguishable from a clean one.
class ClaimImportResult {
  const ClaimImportResult({
    this.batchStatus = '',
    this.accepted = 0,
    this.rejected = 0,
    this.unmatched = 0,
  });

  /// Batch status after reconciliation (`reconciled`, `partial`, `failed`, …).
  final String batchStatus;
  final int accepted;
  final int rejected;
  final int unmatched;

  int get total => accepted + rejected + unmatched;

  /// True when the portal rejected anything or returned references we could not
  /// match — the cases a claim officer has to act on.
  bool get needsAttention => rejected > 0 || unmatched > 0;

  bool get isClean => total > 0 && !needsAttention;

  factory ClaimImportResult.fromJson(Map<String, dynamic> json) {
    int intOf(dynamic value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      return int.tryParse(value?.toString() ?? '') ?? 0;
    }

    return ClaimImportResult(
      batchStatus: json['batchStatus']?.toString() ??
          json['status']?.toString() ??
          '',
      accepted: intOf(json['accepted']),
      rejected: intOf(json['rejected']),
      unmatched: intOf(json['unmatched']),
    );
  }

  /// One-line human summary, e.g. `12 accepted · 3 rejected · 1 unmatched`.
  String get summaryLine {
    final parts = <String>[
      if (accepted > 0) '$accepted accepted',
      if (rejected > 0) '$rejected rejected',
      if (unmatched > 0) '$unmatched unmatched',
    ];
    if (parts.isEmpty) return 'No claim lines were returned in the results file.';
    return parts.join(' · ');
  }
}
