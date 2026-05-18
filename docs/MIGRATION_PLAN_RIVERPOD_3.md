# CareNest: Riverpod 3.0 Migration Plan

## 1. Overview
Riverpod 3.0 introduces massive breaking changes to state management by completely removing legacy providers (`StateNotifierProvider`, `ChangeNotifierProvider`, and `StateProvider`). It forces a shift toward the modern `Notifier` and `AsyncNotifier` architecture.

This document outlines a safe, incremental strategy to migrate the CareNest app from Riverpod `^2.6.1` to Riverpod `^3.x.x` without breaking the entire codebase at once.

---

## 2. The Core Differences (What you need to change)

### A. StateNotifier to Notifier
**Old Syntax (Riverpod 2.x):**
```dart
// The Provider
final myProvider = StateNotifierProvider<MyViewModel, MyState>((ref) {
  final api = ref.watch(apiProvider);
  return MyViewModel(api);
});

// The Class
class MyViewModel extends StateNotifier<MyState> {
  final ApiMethod _api;
  
  // Dependencies injected via constructor
  MyViewModel(this._api) : super(MyState());

  void doSomething() {
    state = state.copyWith(loading: true);
  }
}
```

**New Syntax (Riverpod 3.x):**
```dart
// The Provider uses `.new` or a closure without parameters
final myProvider = NotifierProvider<MyViewModel, MyState>(MyViewModel.new);

// The Class extends Notifier
class MyViewModel extends Notifier<MyState> {
  late final ApiMethod _api;
  
  // Dependencies are read inside build(), no constructor arguments
  @override
  MyState build() {
    _api = ref.watch(apiProvider);
    return MyState(); // Returns initial state
  }

  void doSomething() {
    state = state.copyWith(loading: true);
  }
}
```

### B. StateProvider to Notifier
`StateProvider` is removed. It must become a simple `Notifier`.

**Old Syntax:**
```dart
final searchStringProvider = StateProvider<String>((ref) => '');

// Usage
ref.read(searchStringProvider.notifier).state = 'new search';
```

**New Syntax:**
```dart
class SearchStringNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String newSearch) {
    state = newSearch;
  }
}
final searchStringProvider = NotifierProvider<SearchStringNotifier, String>(SearchStringNotifier.new);

// Usage
ref.read(searchStringProvider.notifier).update('new search');
```

---

## 3. The Migration Strategy (File by File)

Do **NOT** bump the `flutter_riverpod` version in `pubspec.yaml` yet.
Riverpod 2.x supports the new `Notifier` syntax alongside the old `StateNotifier` syntax. You will migrate the app file-by-file while still on 2.6.1. Only when the last `StateNotifier` is gone will we bump the version to 3.x.

### Phase 1: Simple StateProviders
Start with simple, un-injected state.
1. Find all instances of `StateProvider`.
2. Create lightweight `Notifier` classes for them (like the `SearchStringNotifier` example above).
3. Update the UI widgets that call `.state =` on them.

### Phase 2: ChangeNotifierProviders
`ChangeNotifierProvider` is completely deprecated.
1. Identify all view models extending `ChangeNotifier`.
2. Convert them to `Notifier<T>` where `T` is an immutable state class.
   - *Note: This requires removing `notifyListeners()` and replacing it with immutable `state = state.copyWith(...)` updates.*

### Phase 3: The Core ViewModels (StateNotifiers)
These are the heaviest files (e.g., `EarningsViewModel`, `InvoiceDetailViewModel`).
1. **Target one feature module at a time** (e.g., `/features/invoice/`).
2. Change `extends StateNotifier` to `extends Notifier` or `AutoDisposeNotifier`.
3. Move constructor parameters into the `@override build()` method using `ref.watch()`.
4. Update the `StateNotifierProvider` declaration to `NotifierProvider(ViewModel.new)`.
5. Run the app and test that specific feature module.

### Phase 4: BaseController Refactor
Currently, your `BaseController` extends `StateNotifier`.
```dart
abstract class BaseController<T extends BaseState> extends StateNotifier<T>
```
Once most ViewModels are migrated, you must update `BaseController` to extend `Notifier<T>` and refactor any subclasses that rely on its legacy constructor behavior.

### Phase 5: The Final Bump
Once a global search for `StateNotifier`, `StateProvider`, and `ChangeNotifierProvider` yields 0 results:
1. Open `pubspec.yaml`.
2. Change `flutter_riverpod: ^2.6.1` to `flutter_riverpod: ^3.3.1` (or latest).
3. Run `flutter pub get`.
4. Run `flutter analyze` to catch any lingering legacy syntax.

---

## 4. Tips for Success
- **Use `riverpod_generator`**: As you rewrite classes, consider using the `@riverpod` code generation annotation instead of manually writing the `NotifierProvider` boilerplate. It heavily simplifies Riverpod 3.0 usage.
- **Do it in PRs**: Create small Pull Requests per feature (e.g., `refactor: migrate invoice viewmodels to Notifier`). Do not let migration PRs get too large, or merge conflicts with active feature development will become impossible to resolve.
