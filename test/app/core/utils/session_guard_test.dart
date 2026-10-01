import 'package:carenest/app/core/utils/session_guard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isSessionExpired', () {
    test('matches expired/invalid credential codes on 401', () {
      expect(
        isSessionExpired({
          'success': false,
          'statusCode': 401,
          'errorCode': 'TOKEN_EXPIRED',
        }),
        isTrue,
      );
      expect(
        isSessionExpired({
          'success': false,
          'statusCode': 401,
          'code': 'INVALID_TOKEN',
        }),
        isTrue,
      );
    });

    test('ignores other 401s (wrong password, missing token, unknown)', () {
      expect(
        isSessionExpired({
          'success': false,
          'statusCode': 401,
          'code': 'INVALID_CREDENTIALS',
        }),
        isFalse,
      );
      expect(
        isSessionExpired({
          'success': false,
          'statusCode': 401,
          'code': 'MISSING_TOKEN',
        }),
        isFalse,
      );
      expect(isSessionExpired({'success': false, 'statusCode': 401}), isFalse);
    });

    test('ignores non-401 statuses even with expired codes', () {
      expect(isSessionExpired({'success': true, 'statusCode': 200}), isFalse);
      expect(
        isSessionExpired({
          'success': false,
          'statusCode': 403,
          'errorCode': 'TOKEN_EXPIRED',
        }),
        isFalse,
      );
    });
  });

  group('isSessionExpiredResponse', () {
    test('matches raw 401 + expired body', () {
      expect(
        isSessionExpiredResponse(401, {'errorCode': 'TOKEN_EXPIRED'}),
        isTrue,
      );
      expect(
        isSessionExpiredResponse(401, {
          'code': 'INVALID_TOKEN',
          'message': 'x',
        }),
        isTrue,
      );
    });

    test('rejects null body, non-401, and other codes', () {
      expect(isSessionExpiredResponse(401, null), isFalse);
      expect(
        isSessionExpiredResponse(200, {'errorCode': 'TOKEN_EXPIRED'}),
        isFalse,
      );
      expect(
        isSessionExpiredResponse(401, {'errorCode': 'RATE_LIMIT_EXCEEDED'}),
        isFalse,
      );
    });
  });

  group('maybePromptReLogin', () {
    test('does nothing for non-expired responses', () {
      // Must not touch navigator/Firebase — returns synchronously.
      maybePromptReLogin({'success': false, 'statusCode': 500});
      maybePromptReLogin({'success': true, 'statusCode': 200});
    });
  });
}
