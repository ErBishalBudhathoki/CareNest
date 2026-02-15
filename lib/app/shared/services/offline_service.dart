import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final offlineServiceProvider = Provider<OfflineService>((ref) {
  return OfflineService();
});

class OfflineService {
  static const String requestBoxName = 'offline_requests';
  static const String syncQueueBoxName = 'sync_queue';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(requestBoxName);
    await Hive.openBox(syncQueueBoxName);
  }

  Future<void> cacheData(String boxName, String key, dynamic data) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, data);
  }

  Future<dynamic> getCachedData(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key);
  }

  Future<void> addToSyncQueue(Map<String, dynamic> action) async {
    final box = await Hive.openBox(syncQueueBoxName);
    await box.add(action);
  }

  Future<List<dynamic>> getSyncQueue() async {
    final box = await Hive.openBox(syncQueueBoxName);
    return box.values.toList();
  }

  Future<void> clearSyncQueue() async {
    final box = await Hive.openBox(syncQueueBoxName);
    await box.clear();
  }
}
