import 'dart:convert';

import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';

/// Locks the `checkInvoicingEmailKey` response contract that the admin
/// dashboard's Invoice Operations gate depends on.
///
/// Regression: the backend stopped returning the raw encryption key and now
/// returns only `{ hasKey: true }`, but the parser still filtered on
/// `data['key']`. That turned every configured org into "Encryption key empty",
/// so `_checkEmailKey` returned 'error', the invoicing actions showed SETUP
/// permanently, and taps opened the "SETUP REQUIRED" sheet — even though the
/// key was sitting in the database.
///
/// If the server contract changes again, these fail loudly rather than
/// silently re-gating every org.
void main() {
  Map<String, dynamic> parse(
    Map<String, dynamic> payload, {
    int status = 200,
  }) => ApiMethod.parseCheckInvoicingEmailKeyResponse(
    statusCode: status,
    body: json.encode(payload),
  );

  group('configured org (hasKey: true)', () {
    const payload = {
      'success': true,
      'message': 'Invoicing email key found',
      'hasKey': true,
    };

    test('reports the key as found', () {
      expect(parse(payload)['message'], 'Invoicing email key found');
    });

    test('preserves hasKey so the caller can see it', () {
      // This is the assertion the shipped bug violated: hasKey was discarded
      // mid-flight, leaving _checkEmailKey no way to return 'found'.
      expect(parse(payload)['hasKey'], isTrue);
    });

    test('never invents a key the server withheld', () {
      expect(parse(payload).containsKey('key'), isFalse);
    });
  });

  group('unconfigured org', () {
    test('maps the server message to not-found', () {
      final result = parse({
        'success': true,
        'message': 'No invoicing email key found',
      });

      expect(result['message'], 'No invoicing email key found');
      expect(result.containsKey('hasKey'), isFalse);
    });

    test('a found message without hasKey is not treated as configured', () {
      // Guards against a future "hasKey defaults to true" regression: the
      // caller reads hasKey itself, so dropping it must not imply readiness.
      final result = parse({
        'success': true,
        'message': 'Invoicing email key found',
      });

      expect(result['message'], 'Invoicing email key found');
      expect(result['hasKey'], isNot(true));
    });
  });

  group('error responses are not mistaken for readiness', () {
    test('400 reports a retrieval error', () {
      final result = parse({
        'success': false,
        'message': 'email query param is required',
      }, status: 400);

      expect(result['message'], 'Error retrieving invoicing email key details');
      expect(result.containsKey('hasKey'), isFalse);
    });

    test('500 reports an unknown error', () {
      final result = parse({'success': false, 'message': 'boom'}, status: 500);

      expect(result['message'], 'Unknown error occurred');
      expect(result.containsKey('hasKey'), isFalse);
    });
  });
}
