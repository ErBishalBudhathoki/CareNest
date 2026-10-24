import 'dart:convert';

import 'package:carenest/backend/api_method.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Durable queue for end-of-shift worked-time saves.
///
/// The timer is stopped locally before the API call. If the device is offline
/// (SIL homes are often in low-coverage areas), the save is persisted here and
/// replayed when connectivity returns. Replay uses the same public
/// `setWorkedTime` call, so the server-side SIL fallback still resolves the
/// synthetic `sil-shift-*` shift.
class WorkedTimeQueueService {
  WorkedTimeQueueService._();
  static final WorkedTimeQueueService instance = WorkedTimeQueueService._();

  static const String _boxName = 'worked_time_queue';

  Box<String>? _box;

  Future<Box<String>> _ensureBox() async {
    final existing = _box;
    if (existing != null && existing.isOpen) return existing;
    try {
      await Hive.initFlutter();
    } catch (_) {}
    _box = await Hive.openBox<String>(_boxName);
    return _box!;
  }

  Future<void> enqueue({
    required String userEmail,
    required String clientEmail,
    required String workedTime,
    required int shiftIndex,
    String? shiftDate,
    String? shiftStartTime,
    String? shiftEndTime,
    dynamic shiftBreak,
  }) async {
    try {
      final box = await _ensureBox();
      final id =
          '${DateTime.now().millisecondsSinceEpoch}-${clientEmail.hashCode}';
      await box.put(
        id,
        jsonEncode({
          'id': id,
          'userEmail': userEmail,
          'clientEmail': clientEmail,
          'workedTime': workedTime,
          'shiftIndex': shiftIndex,
          'shiftDate': shiftDate,
          'shiftStartTime': shiftStartTime,
          'shiftEndTime': shiftEndTime,
          'shiftBreak': shiftBreak,
        }),
      );
      debugPrint('WorkedTimeQueue: queued save for $clientEmail ($id)');
    } catch (e) {
      debugPrint('WorkedTimeQueue: failed to persist save: $e');
    }
  }

  Future<int> pendingCount() async {
    try {
      final box = await _ensureBox();
      return box.length;
    } catch (_) {
      return 0;
    }
  }

  /// Replay pending saves in the order they were captured.
  /// Returns the number successfully synced.
  Future<int> flush(ApiMethod api) async {
    Box<String> box;
    try {
      box = await _ensureBox();
    } catch (_) {
      return 0;
    }
    if (box.isEmpty) return 0;

    final entries = box.values.toList()
      ..sort((a, b) {
        final da = (jsonDecode(a)['id'] ?? '').toString();
        final db = (jsonDecode(b)['id'] ?? '').toString();
        return da.compareTo(db);
      });

    var synced = 0;
    for (final raw in entries) {
      Map<String, dynamic> entry;
      try {
        entry = Map<String, dynamic>.from(jsonDecode(raw));
      } catch (_) {
        await box.delete(box.keyAt(0));
        continue;
      }
      final id = entry['id']?.toString() ?? '';
      try {
        await api.setWorkedTime(
          entry['userEmail']?.toString() ?? '',
          entry['clientEmail']?.toString() ?? '',
          entry['workedTime']?.toString() ?? '00:00:00',
          (entry['shiftIndex'] as num?)?.toInt() ?? 0,
          shiftDate: entry['shiftDate']?.toString(),
          shiftStartTime: entry['shiftStartTime']?.toString(),
          shiftEndTime: entry['shiftEndTime']?.toString(),
          shiftBreak: entry['shiftBreak'],
        );
        if (id.isNotEmpty) await box.delete(id);
        synced += 1;
        debugPrint('WorkedTimeQueue: synced $id');
      } catch (e) {
        final message = e.toString().toLowerCase();
        final permanentFailure =
            message.contains('bad request') ||
            message.contains('endpoint not found') ||
            message.contains('invalid') ||
            message.contains('selected shift details');
        if (permanentFailure) {
          // Never retry a payload the server will always reject.
          if (id.isNotEmpty) await box.delete(id);
          debugPrint('WorkedTimeQueue: dropped invalid entry $id: $e');
          continue;
        }
        // Network/auth failure: keep the entry and stop; connectivity or the
        // next app start will retry.
        debugPrint('WorkedTimeQueue: sync paused on $id: $e');
        break;
      }
    }
    return synced;
  }
}
