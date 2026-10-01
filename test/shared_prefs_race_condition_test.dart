import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SharedPreferencesUtils Unit Tests', () {
    late ProviderContainer container;
    late SharedPreferences sharedPrefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();
      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            SharedPreferencesUtils.forTesting(),
          ),
        ],
      );
      await container.read(sharedPreferencesProvider).init();
    });

    tearDown(() {
      container.dispose();
    });

    test('Should save and retrieve user email', () async {
      final utils = container.read(sharedPreferencesProvider);
      await utils.saveUserEmailToSharedPreferences('test@example.com');
      final email = await utils.getUserEmailFromSharedPreferences();
      expect(email, 'test@example.com');
    });

    test('Multiple operations should not race', () async {
      final utils = container.read(sharedPreferencesProvider);
      await Future.wait([
        utils.setString('key1', 'value1'),
        utils.setString('key2', 'value2'),
        utils.setString('key3', 'value3'),
      ]);
      expect(sharedPrefs.getString('key1'), 'value1');
      expect(sharedPrefs.getString('key2'), 'value2');
      expect(sharedPrefs.getString('key3'), 'value3');
    });

    test(
      'SharedPreferences instance should be available after construction',
      () async {
        final utils = container.read(sharedPreferencesProvider);
        expect(utils.sharedPreferences, isNotNull);
      },
    );
  });
}
