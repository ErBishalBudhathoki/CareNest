import 'package:carenest/config/environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig URL resolution', () {
    test('normalizes base URL with trailing slash', () {
      expect(
        AppConfig.normalizeBaseUrl('https://api.example.com'),
        'https://api.example.com/',
      );
      expect(
        AppConfig.normalizeBaseUrl('https://api.example.com/'),
        'https://api.example.com/',
      );
      expect(
        AppConfig.normalizeBaseUrl('https://api.example.com///'),
        'https://api.example.com/',
      );
    });

    test('resolves /uploads path against base URL', () {
      final resolved = AppConfig.resolveResourceUrl(
        '/uploads/receipt.png',
        baseUrlOverride: 'https://api.example.com/',
      );
      expect(resolved, 'https://api.example.com/uploads/receipt.png');
    });

    test('rewrites local absolute URL host to base URL host', () {
      final resolved = AppConfig.resolveResourceUrl(
        'http://192.168.1.10:8080/uploads/receipt.png',
        baseUrlOverride: 'https://api.example.com/',
      );
      expect(resolved, 'https://api.example.com/uploads/receipt.png');
    });

    test('rewrites absolute IPv4 host to base URL host', () {
      final resolved = AppConfig.resolveResourceUrl(
        'http://192.170.30.7:8080/uploads/receipt.png',
        baseUrlOverride: 'https://api.example.com/',
      );
      expect(resolved, 'https://api.example.com/uploads/receipt.png');
    });

    test('does not rewrite non-local absolute URL', () {
      final input = 'https://cdn.example.com/uploads/receipt.png';
      final resolved = AppConfig.resolveResourceUrl(
        input,
        baseUrlOverride: 'https://api.example.com/',
      );
      expect(resolved, input);
    });

    test('cleans backticks before resolving', () {
      final resolved = AppConfig.resolveResourceUrl(
        '`/uploads/receipt.png`',
        baseUrlOverride: 'https://api.example.com/',
      );
      expect(resolved, 'https://api.example.com/uploads/receipt.png');
    });

    test('keeps file:// URLs unchanged', () {
      final input = 'file:///tmp/receipt.png';
      final resolved = AppConfig.resolveResourceUrl(
        input,
        baseUrlOverride: 'https://api.example.com/',
      );
      expect(resolved, input);
    });
  });

  group('AppConfig transport security', () {
    test('accepts https in release mode', () {
      expect(
        () => AppConfig.checkTransportSecurity(
          Uri.parse('https://api.example.com/'),
          sourceLabel: 'Test',
          isRelease: true,
        ),
        returnsNormally,
      );
    });

    test('rejects public http in release mode', () {
      expect(
        () => AppConfig.checkTransportSecurity(
          Uri.parse('http://api.example.com/'),
          sourceLabel: 'Test',
          isRelease: true,
        ),
        throwsStateError,
      );
    });

    test('allows local http in release mode', () {
      for (final url in [
        'http://localhost:8080/',
        'http://127.0.0.1:8080/',
        'http://192.168.1.10:8080/',
        'http://10.0.2.2:8080/',
        'http://172.20.5.4:8080/',
      ]) {
        expect(
          () => AppConfig.checkTransportSecurity(
            Uri.parse(url),
            sourceLabel: 'Test',
            isRelease: true,
          ),
          returnsNormally,
          reason: url,
        );
      }
    });

    test('warns but allows public http in debug mode', () {
      expect(
        () => AppConfig.checkTransportSecurity(
          Uri.parse('http://api.example.com/'),
          sourceLabel: 'Test',
          isRelease: false,
        ),
        returnsNormally,
      );
    });

    test('isLocalHost classifies hosts', () {
      expect(AppConfig.isLocalHost('localhost'), isTrue);
      expect(AppConfig.isLocalHost('127.0.0.1'), isTrue);
      expect(AppConfig.isLocalHost('10.1.2.3'), isTrue);
      expect(AppConfig.isLocalHost('172.16.0.1'), isTrue);
      expect(AppConfig.isLocalHost('172.31.255.255'), isTrue);
      expect(AppConfig.isLocalHost('172.15.0.1'), isFalse);
      expect(AppConfig.isLocalHost('172.32.0.1'), isFalse);
      expect(AppConfig.isLocalHost('192.168.0.5'), isTrue);
      expect(AppConfig.isLocalHost('myprinter.local'), isTrue);
      expect(AppConfig.isLocalHost('api.example.com'), isFalse);
      expect(AppConfig.isLocalHost('8.8.8.8'), isFalse);
    });
  });
}
