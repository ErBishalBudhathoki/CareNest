/// Whether this organization can invoice, as far as we can tell.
///
/// The distinction that matters is between "we know it is not configured" and
/// "we could not find out". Collapsing the two into one SETUP badge blocks
/// every admin whenever the backend is briefly unreachable, and tells them to
/// redo setup they already completed.
enum InvoicingEmailSetupState {
  /// Not checked yet, or a check is in flight.
  unknown,

  /// The server confirmed a business key exists.
  configured,

  /// The server confirmed no key exists. This is the only state that should
  /// block invoicing.
  unconfigured,

  /// The check could not complete: offline, timeout, 5xx, malformed response.
  /// We do not know either way, so we must not claim setup is missing.
  unverified,
}

extension InvoicingEmailSetupStateX on InvoicingEmailSetupState {
  /// True only when the server positively reported no key.
  ///
  /// Gate every invoicing workflow on this, never on "not configured".
  bool get requiresSetup => this == InvoicingEmailSetupState.unconfigured;

  /// True when we have an answer from the server rather than a guess.
  bool get isResolved =>
      this == InvoicingEmailSetupState.configured ||
      this == InvoicingEmailSetupState.unconfigured;

  /// Maps the response of `checkInvoicingEmailKey` to a state.
  ///
  /// Deliberately fails open: anything we cannot positively read as
  /// "unconfigured" leaves the workflows usable, so a transient backend fault
  /// cannot lock admins out of invoicing.
  static InvoicingEmailSetupState resolve(Map<String, dynamic>? response) {
    if (response == null) return InvoicingEmailSetupState.unverified;

    switch (response['message']) {
      case 'Invoicing email key found':
        // `hasKey` is the only presence signal the server sends; the raw
        // encryption key is deliberately withheld.
        return response['hasKey'] == true
            ? InvoicingEmailSetupState.configured
            : InvoicingEmailSetupState.unconfigured;
      case 'No invoicing email key found':
        return InvoicingEmailSetupState.unconfigured;
      default:
        // 'Error retrieving invoicing email key details', 'Unknown error
        // occurred', and anything unrecognised from a future server.
        return InvoicingEmailSetupState.unverified;
    }
  }

  /// Legacy string the email-settings screens still expect.
  ///
  /// `AddUpdateInvoicingEmailView` / `InvoicingEmailView` compare against
  /// 'update' and 'error'; keep feeding them the vocabulary they understand
  /// until they are migrated too.
  String get legacyKey => switch (this) {
    InvoicingEmailSetupState.configured => 'found',
    InvoicingEmailSetupState.unconfigured => 'add',
    InvoicingEmailSetupState.unverified => 'error',
    InvoicingEmailSetupState.unknown => 'error',
  };
}
