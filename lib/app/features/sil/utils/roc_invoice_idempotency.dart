/// Deterministic idempotency keys for SIL roster-of-care invoicing
/// (Milestone 7.1).
///
/// The backend replays an existing SIL invoice when the client resubmits the
/// same billing period for the same roster of care, so the key must be stable
/// across retries: it must never contain timestamps or random data. The key is
/// derived purely from the roster id and the normalized ISO date parts of the
/// billed period.
library;

/// Prefix for every roster-of-care invoice idempotency key.
const String rocInvoiceIdempotencyPrefix = 'roc';

/// Normalized `YYYY-MM-DD` calendar date (no timestamp, no timezone drift).
String silIsoDate(DateTime date) {
  final y = date.year.toString().padLeft(4, '0');
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

/// Builds a stable idempotency key for billing one roster-of-care period:
/// `roc_<rocId>_YYYY-MM-DD_YYYY-MM-DD`.
String buildRocInvoiceIdempotencyKey({
  required String rocId,
  required DateTime from,
  required DateTime to,
}) {
  return '${rocInvoiceIdempotencyPrefix}_'
      '${rocId}_'
      '${silIsoDate(from)}_'
      '${silIsoDate(to)}';
}
