import 'package:carenest/backend/pinned_http_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const baseUrl = 'https://api.example.com/';
  final backendUri = Uri.parse('https://api.example.com/v1/ping');
  final otherUri = Uri.parse('https://cdn.example.com/asset.png');

  group('PinnedHttpClient routing', () {
    test('returns the shared pinned client for the backend host', () {
      final first = PinnedHttpClient.clientForBackendUrl(baseUrl, backendUri);
      final second = PinnedHttpClient.clientForBackendUrl(baseUrl, backendUri);
      expect(identical(first, second), isTrue);
    });

    test('returns a different client for non-backend hosts', () {
      final backend = PinnedHttpClient.clientForBackendUrl(
        baseUrl,
        backendUri,
      );
      final other = PinnedHttpClient.clientForBackendUrl(baseUrl, otherUri);
      expect(identical(backend, other), isFalse);
    });

    test('shares the default client across non-backend hosts', () {
      final first = PinnedHttpClient.clientForBackendUrl(baseUrl, otherUri);
      final second = PinnedHttpClient.clientForBackendUrl(
        baseUrl,
        Uri.parse('https://other.example.org/y'),
      );
      expect(identical(first, second), isTrue);
    });

    test('shared:false yields a fresh instance the caller may close', () {
      final first = PinnedHttpClient.clientForBackendUrl(
        baseUrl,
        backendUri,
        shared: false,
      );
      final second = PinnedHttpClient.clientForBackendUrl(
        baseUrl,
        backendUri,
        shared: false,
      );
      expect(identical(first, second), isFalse);
      // Must be safe to close without affecting the shared instance.
      first.close();
      final shared = PinnedHttpClient.clientForBackendUrl(baseUrl, backendUri);
      expect(identical(shared, first), isFalse);
      second.close();
    });

    test('host matching is case-insensitive', () {
      final upper = PinnedHttpClient.clientForBackendUrl(
        baseUrl,
        Uri.parse('https://API.EXAMPLE.COM/v1/ping'),
      );
      final lower = PinnedHttpClient.clientForBackendUrl(baseUrl, backendUri);
      expect(identical(upper, lower), isTrue);
    });
  });
}
