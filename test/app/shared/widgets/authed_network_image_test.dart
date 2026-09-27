import 'package:carenest/app/shared/widgets/authed_network_image.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const backend = 'backend-dev-123.australia-southeast1.run.app';

  group('AuthedNetworkImage host matching', () {
    test('matches backend uploads URLs', () {
      expect(
        AuthedNetworkImage.matchesBackendHost(
          'https://$backend/uploads/receipt-1.jpg',
          backend,
        ),
        isTrue,
      );
    });

    test('matching is case-insensitive', () {
      expect(
        AuthedNetworkImage.matchesBackendHost(
          'https://BACKEND-DEV-123.AUSTRALIA-SOUTHEAST1.RUN.APP/uploads/x.png',
          backend,
        ),
        isTrue,
      );
    });

    test('rejects third-party hosts (tokens must never leak cross-origin)', () {
      expect(
        AuthedNetworkImage.matchesBackendHost(
          'https://lh3.googleusercontent.com/photo.jpg',
          backend,
        ),
        isFalse,
      );
      expect(
        AuthedNetworkImage.matchesBackendHost(
          'https://evil-$backend/uploads/x.jpg',
          backend,
        ),
        isFalse,
      );
      expect(
        AuthedNetworkImage.matchesBackendHost(
          'https://$backend.evil.com/uploads/x.jpg',
          backend,
        ),
        isFalse,
      );
    });

    test('rejects non-http schemes and malformed URLs', () {
      expect(
        AuthedNetworkImage.matchesBackendHost('file:///a/b.jpg', backend),
        isFalse,
      );
      expect(
        AuthedNetworkImage.matchesBackendHost('ftp://$backend/x', backend),
        isFalse,
      );
      expect(
        AuthedNetworkImage.matchesBackendHost('not a url', backend),
        isFalse,
      );
      expect(AuthedNetworkImage.matchesBackendHost('', backend), isFalse);
    });
  });

  group('AuthedNetworkImage.needsAuth', () {
    test('fails closed when no base URL is configured', () {
      // No --dart-define in unit tests, so AppConfig.baseUrl is empty and
      // needsAuth must refuse to attach credentials anywhere.
      expect(
        AuthedNetworkImage.needsAuth('https://$backend/uploads/x.jpg'),
        isFalse,
      );
    });
  });

  group('AuthedCacheManager', () {
    test('exposes a shared singleton instance', () {
      expect(
        identical(AuthedCacheManager.instance, AuthedCacheManager.instance),
        isTrue,
      );
    });
  });
}
