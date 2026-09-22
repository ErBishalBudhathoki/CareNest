import 'package:flutter/foundation.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

/// Persistence + ordering rules for the admin Command Desk redesign.
///
/// - `sortByRecent` (opt-in, default off): when true, sections with recent
///   activity float to the top, most-recent use first.
/// - Recency is tracked per action tap as `categoryTitle::actionTitle`
///   entries; a section's recency is its most recent action tap.
/// - Keys follow displayed (possibly localized) titles: recents are
///   per-device convenience, not data, so locale drift is acceptable.
class CommandDeskPrefs {
  const CommandDeskPrefs._();

  static const String sortByRecentKey = 'command_desk_sort_by_recent';
  static const String recentActionsKey = 'command_desk_recent_actions';

  /// Maximum stored recency entries (bounds prefs growth).
  static const int maxEntries = 40;

  /// Live toggle value. Defaults to false until [load] completes.
  static final ValueNotifier<bool> sortByRecent = ValueNotifier<bool>(false);

  static String actionKey(String categoryTitle, String actionTitle) =>
      '$categoryTitle::$actionTitle';

  /// Loads persisted state. Safe to call multiple times.
  static Future<void> load({SharedPreferencesUtils? prefs}) async {
    final utils = prefs ?? SharedPreferencesUtils();
    await utils.init();
    sortByRecent.value = utils.getBool(sortByRecentKey) ?? false;
  }

  static Future<void> setSortByRecent(
    bool value, {
    SharedPreferencesUtils? prefs,
  }) async {
    final utils = prefs ?? SharedPreferencesUtils();
    await utils.init();
    await utils.setBool(sortByRecentKey, value);
    sortByRecent.value = value;
  }

  /// Records an action tap for recency ordering.
  static Future<void> recordActionUse(
    String categoryTitle,
    String actionTitle, {
    SharedPreferencesUtils? prefs,
    int? timestampMillis,
  }) async {
    final utils = prefs ?? SharedPreferencesUtils();
    await utils.init();
    final now = timestampMillis ?? DateTime.now().millisecondsSinceEpoch;
    final key = actionKey(categoryTitle, actionTitle);
    final entries = utils.getStringList(recentActionsKey) ?? <String>[];
    final filtered = entries.where((e) => !e.startsWith('$key::')).toList();
    filtered.insert(0, '$key::$now');
    await utils.setStringList(
      recentActionsKey,
      filtered.take(maxEntries).toList(),
    );
  }

  /// Raw recency entries (newest first). Used to derive per-section
  /// recency without re-reading storage on every build.
  static Future<List<String>> recentEntries({
    SharedPreferencesUtils? prefs,
  }) async {
    final utils = prefs ?? SharedPreferencesUtils();
    await utils.init();
    return utils.getStringList(recentActionsKey) ?? <String>[];
  }

  /// Most recent tap millis for a category, or null when never used.
  /// Malformed entries are ignored.
  static int? sectionLastUsed(String categoryTitle, List<String> entries) {
    int? latest;
    for (final entry in entries) {
      final parts = entry.split('::');
      if (parts.length != 3) continue;
      if (parts[0] != categoryTitle) continue;
      final millis = int.tryParse(parts[2]);
      if (millis == null) continue;
      if (latest == null || millis > latest) latest = millis;
    }
    return latest;
  }

  /// Section display order as indices into the dashboard's category list.
  /// Pure logic — fully unit-testable.
  ///
  /// - [sortByRecent] off (or no recency data): original order.
  /// - On: sections with recency first (most recent first), then the rest
  ///   in original order. Stable: ties keep original positions.
  static List<int> orderedSectionIndices({
    required List<String> categoryTitles,
    required Map<String, int> lastUsedByCategory,
    required bool sortByRecent,
  }) {
    final indices = List<int>.generate(categoryTitles.length, (i) => i);
    if (!sortByRecent) return indices;
    if (lastUsedByCategory.isEmpty) return indices;
    final used = <int>[];
    final unused = <int>[];
    for (final i in indices) {
      if (lastUsedByCategory.containsKey(categoryTitles[i])) {
        used.add(i);
      } else {
        unused.add(i);
      }
    }
    used.sort((a, b) {
      final cmp = lastUsedByCategory[categoryTitles[b]]!.compareTo(
        lastUsedByCategory[categoryTitles[a]]!,
      );
      if (cmp != 0) return cmp;
      return a.compareTo(b);
    });
    return [...used, ...unused];
  }
}
