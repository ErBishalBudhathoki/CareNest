import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/services/notificationservice/fcm_token_manager.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';

class MockApiMethod extends Mock implements ApiMethod {}

class MockSharedPreferencesUtils extends Mock
    implements SharedPreferencesUtils {
  @override
  String? getAuthToken() => 'test_token';
}

class MockFcmTokenManager extends Mock implements FcmTokenManager {}

void main() {
  late ProviderContainer container;
  late MockApiMethod mockApiMethod;
  late MockSharedPreferencesUtils mockSharedPrefs;
  late MockFcmTokenManager mockFcmTokenManager;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseCoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() {
    mockApiMethod = MockApiMethod();
    mockSharedPrefs = MockSharedPreferencesUtils();
    mockFcmTokenManager = MockFcmTokenManager();

    container = ProviderContainer(
      overrides: [
        app_providers.apiMethodProvider.overrideWith((ref) => mockApiMethod),
        app_providers.sharedPreferencesProvider.overrideWith(
          (ref) => mockSharedPrefs,
        ),
        app_providers.fcmTokenManagerProvider.overrideWith(
          (ref) => mockFcmTokenManager,
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('LoginViewModel Unit Tests', () {
    test('Initial state should be correct', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      expect(viewModel.isLoading, false);
      expect(viewModel.model.isVisible, false);
      expect(viewModel.model.isValid, false);
    });

    test('Validation should fail for empty email', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      viewModel.model.validateEmail('');
      expect(viewModel.model.hasValidEmail, false);
      expect(viewModel.model.emailError, isNotNull);
    });

    test('Validation should fail for invalid email format', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      viewModel.model.validateEmail('invalid-email');
      expect(viewModel.model.hasValidEmail, false);
      expect(viewModel.model.emailError, isNotNull);
    });

    test('Validation should fail for empty password', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      viewModel.model.validatePassword('');
      expect(viewModel.model.hasSecurePassword, false);
      expect(viewModel.model.passwordError, isNotNull);
    });

    test('Validation should pass for short password (login only)', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      viewModel.model.validateEmail('test@example.com');
      viewModel.model.validatePassword('123');
      expect(viewModel.model.hasValidEmail, true);
      expect(viewModel.model.hasSecurePassword, true);
      expect(viewModel.model.emailError, isNull);
      expect(viewModel.model.passwordError, isNull);
    });

    test('Validation should pass for valid credentials', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      viewModel.model.validateEmail('test@example.com');
      viewModel.model.validatePassword('password123');
      expect(viewModel.model.hasValidEmail, true);
      expect(viewModel.model.hasSecurePassword, true);
      expect(viewModel.model.emailError, isNull);
      expect(viewModel.model.passwordError, isNull);
    });

    test('Toggle password visibility', () {
      final viewModel = container.read(loginViewModelProvider.notifier);
      expect(viewModel.model.isVisible, false);
      viewModel.togglePasswordVisibility();
      expect(viewModel.model.isVisible, true);
      viewModel.togglePasswordVisibility();
      expect(viewModel.model.isVisible, false);
    });
  });
}
