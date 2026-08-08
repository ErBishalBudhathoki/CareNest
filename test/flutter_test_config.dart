import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences in-memory mock.
  SharedPreferences.setMockInitialValues({});

  // flutter_secure_storage has no platform implementation in unit tests;
  // stub it so reads complete immediately (empty keystore) instead of
  // hanging on an unregistered method channel in fake-async tests.
  const secureStorageChannel = MethodChannel(
    'plugins.it_nomads.com/flutter_secure_storage',
  );
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(secureStorageChannel, (call) async => null);

  await testMain();
}
