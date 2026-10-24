import 'package:carenest/app/core/providers/organization_provider.dart';
import 'package:carenest/app/features/organization/repositories/organization_repository.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeOrganizationRepository extends OrganizationRepository {
  _FakeOrganizationRepository() : super(ApiMethod());

  int calls = 0;

  @override
  Future<List<dynamic>> getUserOrganizations() async {
    calls += 1;
    return [
      {'_id': 'org-1', 'name': 'Pratiksha Care Services'},
    ];
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('first read initialises without touching state inside build()', () async {
    final repository = _FakeOrganizationRepository();
    final container = ProviderContainer(
      overrides: [
        organizationRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    // Regression: `loadUserOrganizations` used to run synchronously from
    // build() and assign `state` before the notifier was mounted, which threw
    // "Tried to read the state of an uninitialized provider" the first time a
    // workforce screen read this provider.
    final initial = container.read(organizationProvider);
    expect(initial.isLoading, isFalse);
    expect(initial.userOrganizations, isEmpty);

    // The deferred load lands on the next microtask.
    await Future<void>.delayed(Duration.zero);

    final loaded = container.read(organizationProvider);
    expect(repository.calls, 1);
    expect(loaded.userOrganizations, hasLength(1));
    expect(loaded.isLoading, isFalse);
    expect(loaded.error, isNull);
  });
}
