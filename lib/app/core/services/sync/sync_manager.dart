import 'dart:convert';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

class SyncQueueItem {
  final String id;
  final String endpoint;
  final String method;
  final Map<String, dynamic>? body;
  final DateTime timestamp;
  final int retryCount;

  SyncQueueItem({
    required this.id,
    required this.endpoint,
    required this.method,
    this.body,
    required this.timestamp,
    this.retryCount = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'endpoint': endpoint,
      'method': method,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'retryCount': retryCount,
    };
  }

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) {
    return SyncQueueItem(
      id: json['id'],
      endpoint: json['endpoint'],
      method: json['method'],
      body: json['body'] != null
          ? Map<String, dynamic>.from(json['body'])
          : null,
      timestamp: DateTime.parse(json['timestamp']),
      retryCount: json['retryCount'] ?? 0,
    );
  }
}

class SyncManager {
  static final SyncManager _instance = SyncManager._internal();

  // Singleton instance getter
  static SyncManager get instance => _instance;

  // Allow dependency injection for testing
  factory SyncManager({Connectivity? connectivity}) {
    if (connectivity != null) {
      _instance._connectivity = connectivity;
    }
    return _instance;
  }

  SyncManager._internal() : _connectivity = Connectivity();

  Box<String>? _queueBox;
  late Connectivity _connectivity;
  final StreamController<bool> _isSyncingController =
      StreamController<bool>.broadcast();
  bool _isSyncing = false;

  // Callback for executing requests - allows testing and dependency injection
  Future<bool> Function(SyncQueueItem)? requestPerformer;

  Stream<bool> get isSyncingStream => _isSyncingController.stream;
  bool get isSyncing => _isSyncing;

  @visibleForTesting
  void setQueueBox(Box<String> box) {
    _queueBox = box;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    _queueBox = await Hive.openBox<String>('sync_queue');

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen((results) {
      // connectivity_plus 6.0 returns List<ConnectivityResult>
      if (results.any((result) => result != ConnectivityResult.none)) {
        processQueue();
      }
    });
  }

  Future<bool> isOnline() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  Future<void> queueRequest(
    String endpoint,
    String method, {
    Map<String, dynamic>? body,
  }) async {
    final item = SyncQueueItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      endpoint: endpoint,
      method: method,
      body: body,
      timestamp: DateTime.now(),
    );

    await _queueBox?.put(item.id, jsonEncode(item.toJson()));
    debugPrint('🔌 Offline: Request queued - $method $endpoint');
  }

  Future<List<SyncQueueItem>> getQueue() async {
    if (_queueBox == null) return [];
    return _queueBox!.values
        .map((e) => SyncQueueItem.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<void> processQueue() async {
    if (_isSyncing || _queueBox == null || _queueBox!.isEmpty) return;

    _isSyncing = true;
    _isSyncingController.add(true);
    debugPrint('🔄 SyncManager: Starting sync process...');

    final items = await getQueue();
    // Sort by timestamp to ensure order
    items.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    for (final item in items) {
      bool success = await _replayRequest(item);
      if (success) {
        await _queueBox!.delete(item.id);
        debugPrint('✅ SyncManager: Request ${item.id} synced successfully');
      } else {
        debugPrint('❌ SyncManager: Request ${item.id} failed to sync');
        // Increment retry count or handle failure strategy
      }
    }

    _isSyncing = false;
    _isSyncingController.add(false);
    debugPrint('🏁 SyncManager: Sync process finished');
  }

  // Circular dependency: ApiMethod uses SyncManager, SyncManager uses ApiMethod?
  // Solution: Pass the actual http call function or duplicate simple logic here.
  // Ideally, SyncManager should rely on a lower-level HTTP client, not the high-level ApiMethod
  // to avoid recursion if ApiMethod intercepts again.
  // For now, we'll inject a "performer" or just import ApiMethod but bypass the interceptor.
  // However, ApiMethod is the one that has the Base URL and Headers logic.

  // Strategy: We will modify ApiMethod to expose a 'performRequest' that takes a 'bypassInterceptor' flag.
  // But since we can't easily change the architecture right now, let's assume we need to
  // manually reconstruct the request here using the stored token.

  Future<bool> _replayRequest(SyncQueueItem item) async {
    if (requestPerformer != null) {
      return await requestPerformer!(item);
    }

    // Default implementation (stub for now, until ApiMethod is integrated)
    // In a real scenario, this would call ApiMethod.performRequest(..., bypassInterceptor: true)
    debugPrint('⚠️ SyncManager: No request performer set for ${item.endpoint}');
    return false;
  }
}
