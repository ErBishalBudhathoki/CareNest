import 'package:carenest/app/features/admin/models/invoicing_email_setup_state.dart';
import 'package:flutter_test/flutter_test.dart';

/// Locks the contract that decides whether Invoice Operations is usable.
///
/// Regression this prevents: the gate used to collapse "server says no key" and
/// "we could not reach the server" into the same SETUP badge and the same
/// blocking sheet. During the firebase-admin App Check outage every admin —
/// including those fully configured — was told to redo setup and locked out of
/// invoicing.
void main() {
  group('resolve', () {
    test('hasKey true is configured', () {
      final state = InvoicingEmailSetupStateX.resolve({
        'success': true,
        'message': 'Invoicing email key found',
        'hasKey': true,
      });

      expect(state, InvoicingEmailSetupState.configured);
    });

    test('server reports no key is unconfigured', () {
      final state = InvoicingEmailSetupStateX.resolve({
        'success': true,
        'message': 'No invoicing email key found',
      });

      expect(state, InvoicingEmailSetupState.unconfigured);
    });

    test('found message without hasKey is unconfigured, not configured', () {
      final state = InvoicingEmailSetupStateX.resolve({
        'success': true,
        'message': 'Invoicing email key found',
      });

      expect(state, InvoicingEmailSetupState.unconfigured);
    });

    test('400 body is unverified', () {
      final state = InvoicingEmailSetupStateX.resolve({
        'success': false,
        'message': 'Error retrieving invoicing email key details',
      });

      expect(state, InvoicingEmailSetupState.unverified);
    });

    test('unknown error is unverified', () {
      final state = InvoicingEmailSetupStateX.resolve({
        'success': false,
        'message': 'Unknown error occurred',
      });

      expect(state, InvoicingEmailSetupState.unverified);
    });

    test('null response is unverified', () {
      expect(
        InvoicingEmailSetupStateX.resolve(null),
        InvoicingEmailSetupState.unverified,
      );
    });

    test('unrecognised message from a future server fails open', () {
      final state = InvoicingEmailSetupStateX.resolve({
        'message': 'Something New In The Future',
      });

      expect(state, InvoicingEmailSetupState.unverified);
    });
  });

  group('requiresSetup only when positively unconfigured', () {
    test('configured does not require setup', () {
      expect(InvoicingEmailSetupState.configured.requiresSetup, isFalse);
    });

    test('unverified does not require setup', () {
      // The whole point: a backend fault must not look like missing config.
      expect(InvoicingEmailSetupState.unverified.requiresSetup, isFalse);
    });

    test('unknown does not require setup', () {
      expect(InvoicingEmailSetupState.unknown.requiresSetup, isFalse);
    });

    test('unconfigured requires setup', () {
      expect(InvoicingEmailSetupState.unconfigured.requiresSetup, isTrue);
    });
  });

  group('isResolved separates a real answer from a guess', () {
    test('configured and unconfigured are resolved', () {
      expect(InvoicingEmailSetupState.configured.isResolved, isTrue);
      expect(InvoicingEmailSetupState.unconfigured.isResolved, isTrue);
    });

    test('unverified and unknown are not resolved', () {
      expect(InvoicingEmailSetupState.unverified.isResolved, isFalse);
      expect(InvoicingEmailSetupState.unknown.isResolved, isFalse);
    });
  });

  group('legacyKey bridges to the email settings screens', () {
    test('configured maps to found', () {
      expect(InvoicingEmailSetupState.configured.legacyKey, 'found');
    });

    test('unconfigured maps to add', () {
      expect(InvoicingEmailSetupState.unconfigured.legacyKey, 'add');
    });

    test('unverified maps to error', () {
      expect(InvoicingEmailSetupState.unverified.legacyKey, 'error');
    });
  });
}
