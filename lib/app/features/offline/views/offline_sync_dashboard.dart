import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/core/services/sync/sync_manager.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';

class OfflineSyncDashboard extends StatefulWidget {
  final String? userId;

  const OfflineSyncDashboard({super.key, this.userId});

  @override
  State<OfflineSyncDashboard> createState() =>
      _OfflineSyncDashboardState();
}

class _OfflineSyncDashboardState extends State<OfflineSyncDashboard> {
  final SyncManager _sync = SyncManager.instance;

  bool _isOnline = true;
  bool _isSyncing = false;
  bool _isLoading = true;
  List<SyncQueueItem> _queue = [];
  String _lastSync = '';
  StreamSubscription<List<ConnectivityResult>>? _connectSub;
  StreamSubscription<bool>? _syncSub;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _connectSub =
        Connectivity().onConnectivityChanged.listen((results) {
      if (!mounted) return;
      setState(() {
        _isOnline =
            results.any((r) => r != ConnectivityResult.none);
      });
    });
    _syncSub = _sync.isSyncingStream.listen((syncing) {
      if (!mounted) return;
      setState(() => _isSyncing = syncing);
      if (!syncing) _loadData();
    });
    _loadData();
  }

  @override
  void dispose() {
    _connectSub?.cancel();
    _syncSub?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    if (!mounted) return;
    setState(() {
      _isOnline =
          results.any((r) => r != ConnectivityResult.none);
    });
  }

  Future<void> _loadData() async {
    final queue = await _sync.getQueue();
    if (!mounted) return;
    setState(() {
      _queue = queue;
      _isLoading = false;
      _lastSync = _formatLastSync();
    });
  }

  String _formatLastSync() {
    if (_queue.isEmpty && _lastSync.isEmpty) return 'Never';
    if (_lastSync.isNotEmpty) return _lastSync;
    return 'Just now';
  }

  Future<void> _syncNow() async {
    if (!_isOnline || _queue.isEmpty) return;
    await _sync.processQueue();
    setState(() => _lastSync = 'Just now');
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BauhausDesign.getTextTheme(context);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: BauhausDesign.surfaceWhite,
              padding: const EdgeInsets.fromLTRB(
                  BauhausDesign.space4,
                  BauhausDesign.space3,
                  BauhausDesign.space2,
                  BauhausDesign.space3),
              child: Row(
                children: [
                  const SizedBox(
                      width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      _isOnline
                          ? 'SYNC STATUS'
                          : 'OFFLINE MODE',
                      style: theme.headlineLarge?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: BauhausDesign.space1,
                    ),
                    decoration: BoxDecoration(
                      color: _isOnline
                          ? BauhausDesign.success
                          : BauhausDesign.warning,
                    ),
                    child: Text(
                      _isOnline ? 'ONLINE' : 'OFFLINE',
                      style: theme.labelSmall?.copyWith(
                        color: _isOnline
                            ? BauhausDesign.surfaceWhite
                            : BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 2, color: BauhausDesign.neoInk),
            Expanded(
              child: _isLoading
          ? const Center(child: BauhausLoadingState())
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusBar(
                    isOnline: _isOnline,
                    queueCount: _queue.length,
                    lastSync: _lastSync,
                  ),
                  const SizedBox(height: BauhausDesign.space6),
                  BauhausSectionHeader(
                      title: 'PENDING CHANGES'),
                  const SizedBox(
                      height: BauhausDesign.space3),
                  if (_queue.isEmpty)
                    _EmptyState(isOnline: _isOnline)
                  else
                    ..._queue.map(_buildQueueItem),
                  const SizedBox(
                      height: BauhausDesign.space6),
                  if (_queue.isNotEmpty)
                    ButtonWidget(
                      buttonText:
                          _isSyncing ? 'SYNCING...' : 'SYNC NOW',
                      isLoading: _isSyncing,
                      onPressed:
                          (_isOnline && !_isSyncing)
                              ? _syncNow
                              : null,
                    ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueItem(SyncQueueItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BauhausCard(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: BauhausDesign.warning.withOpacity(0.1),
                border: Border.all(
                    color: BauhausDesign.warning, width: 2),
              ),
              child: const Icon(Icons.pending_outlined,
                  size: 20, color: BauhausDesign.warning),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.endpoint,
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                          fontWeight: FontWeight.w700,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                      height: BauhausDesign.space0_5),
                  Text(
                    '${item.method.toUpperCase()} · '
                    '${_timeAgo(item.timestamp)}',
                    style: BauhausDesign.getTextTheme(context)
                        .bodySmall
                        ?.copyWith(
                            color: BauhausDesign.textMuted),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: BauhausDesign.warning.withOpacity(0.1),
                border: Border.all(
                    color: BauhausDesign.warning, width: 1.5),
              ),
              child: Text(
                'PENDING',
                style: BauhausDesign.neoMonoStyle(
                  context,
                  color: BauhausDesign.warning,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class _StatusBar extends StatelessWidget {
  final bool isOnline;
  final int queueCount;
  final String lastSync;

  const _StatusBar({
    required this.isOnline,
    required this.queueCount,
    required this.lastSync,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: isOnline
            ? BauhausDesign.success.withOpacity(0.06)
            : BauhausDesign.warning.withOpacity(0.08),
        border: Border.all(
          color: isOnline
              ? BauhausDesign.success
              : BauhausDesign.warning,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isOnline ? Icons.wifi : Icons.wifi_off,
            size: 28,
            color: isOnline
                ? BauhausDesign.success
                : BauhausDesign.warning,
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOnline ? 'Connected' : 'No Connection',
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(
                        color: BauhausDesign.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  queueCount == 0
                      ? 'All changes synced · Last sync $lastSync'
                      : '$queueCount pending change${queueCount == 1 ? '' : 's'} · '
                          'Last sync $lastSync',
                  style: BauhausDesign.getTextTheme(context)
                      .bodySmall
                      ?.copyWith(color: BauhausDesign.textMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isOnline;
  const _EmptyState({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: BauhausDesign.space8),
      child: Center(
        child: Column(
          children: [
            Icon(
              isOnline
                  ? Icons.check_circle_outline
                  : Icons.cloud_off,
              size: 48,
              color: BauhausDesign.textMuted,
            ),
            const SizedBox(height: BauhausDesign.space3),
            Text(
              isOnline
                  ? 'Nothing pending'
                  : 'No offline data yet',
              style: BauhausDesign.getTextTheme(context)
                  .bodyLarge
                  ?.copyWith(color: BauhausDesign.textMuted),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              isOnline
                  ? 'All your changes have been synced.'
                  : 'Work done offline will appear here '
                      'to sync when back online.',
              textAlign: TextAlign.center,
              style: BauhausDesign.getTextTheme(context)
                  .bodySmall
                  ?.copyWith(color: BauhausDesign.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
