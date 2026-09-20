import 'package:carenest/app/core/services/device_security.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SecurityPosture.fromMap', () {
    test('parses native payload', () {
      final posture = SecurityPosture.fromMap({
        'compromised': true,
        'reasons': ['su_binary', 'test_keys'],
        'emulator': false,
        'debuggable': true,
      });
      expect(posture.compromised, isTrue);
      expect(posture.reasons, ['su_binary', 'test_keys']);
      expect(posture.emulator, isFalse);
      expect(posture.debuggable, isTrue);
      expect(posture.unknown, isFalse);
    });

    test('null or malformed payload yields unknown (fail open, warn nothing)', () {
      expect(SecurityPosture.fromMap(null).unknown, isTrue);
      expect(SecurityPosture.fromMap({}).compromised, isFalse);
      expect(SecurityPosture.fromMap({'compromised': 'yes'}).compromised,
          isFalse);
    });
  });

  group('DeviceSecurity.check', () {
    const channel = MethodChannel(DeviceSecurity.channelName);

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    test('returns posture from native shell', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, (call) async {
        expect(call.method, 'getSecurityPosture');
        return {
          'compromised': true,
          'reasons': ['sandbox_escape'],
          'emulator': false,
          'debuggable': false,
        };
      });
      final posture = await DeviceSecurity.check();
      expect(posture.compromised, isTrue);
      expect(posture.reasons, ['sandbox_escape']);
    });

    test('returns unknown when channel is missing (unit tests, web)', () async {
      final posture = await DeviceSecurity.check();
      expect(posture.unknown, isTrue);
      expect(posture.compromised, isFalse);
    });
  });
}
