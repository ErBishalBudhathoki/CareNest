import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/analytics/theme/bauhaus_theme.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:carenest/app/core/services/sync/sync_manager.dart';
import 'package:carenest/app/core/providers/core_providers.dart';

class OfflineSyncDashboardView extends ConsumerStatefulWidget {
  const OfflineSyncDashboardView({super.key});

  @override
  ConsumerState<OfflineSyncDashboardView> createState() =>
      _OfflineSyncDashboardViewState();
}

class _OfflineSyncDashboardViewState
    extends ConsumerState<OfflineSyncDashboardView> {
  late SyncManager _syncManager;
  bool _isOnline = false;
  List<SyncQueueItem> _queue = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _syncManager = ref.read(syncManagerProvider);
    _loadData();
    _listenToSync();
  }

  void _loadData() async {
    final online = await _syncManager.isOnline();
    final queue = await _syncManager.getQueue();
    if (mounted) {
      setState(() {
        _isOnline = online;
        _queue = queue;
        _isLoading = false;
      });
    }
  }

  void _listenToSync() {
    _syncManager.isSyncingStream.listen((isSyncing) {
      if (mounted) {
        // Refresh queue when sync starts/stops
        _loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: BauhausTheme.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.offlineSyncTitle,
          style: BauhausTheme.headerStyle,
        ),
        backgroundColor: BauhausTheme.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: BauhausTheme.black),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BauhausTheme.blockDecoration.copyWith(
                color: _isOnline ? BauhausTheme.blue : BauhausTheme.red,
              ),
              child: Row(
                children: [
                  Icon(
                    _isOnline ? Icons.wifi : Icons.wifi_off,
                    size: 48,
                    color: BauhausTheme.white,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isOnline
                              ? 'Online'
                              : AppLocalizations.of(context)!.offlineStatus,
                          style: BauhausTheme.headerStyle.copyWith(
                            color: BauhausTheme.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          _queue.isEmpty
                              ? 'All data is synced'
                              : '${_queue.length} requests pending',
                          style: BauhausTheme.bodyStyle.copyWith(
                            color: BauhausTheme.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text(
              AppLocalizations.of(context)!.pendingUploads,
              style: BauhausTheme.subHeaderStyle,
            ),
            const SizedBox(height: 16),

            Expanded(
              child: _queue.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No pending changes',
                            style: BauhausTheme.bodyStyle.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _queue.length,
                      itemBuilder: (context, index) {
                        final item = _queue[index];
                        return _buildQueueItem(item);
                      },
                    ),
            ),

            const SizedBox(height: 16),

            // Sync Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: StreamBuilder<bool>(
                stream: _syncManager.isSyncingStream,
                initialData: _syncManager.isSyncing,
                builder: (context, snapshot) {
                  final isSyncing = snapshot.data ?? false;
                  return ElevatedButton.icon(
                    onPressed: (_isOnline && !isSyncing && _queue.isNotEmpty)
                        ? () async {
                            await _syncManager.processQueue();
                            _loadData();
                          }
                        : null,
                    icon: isSyncing
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.sync, color: BauhausTheme.white),
                    label: Text(
                      isSyncing
                          ? 'Syncing...'
                          : AppLocalizations.of(context)!.syncNow,
                      style: BauhausTheme.subHeaderStyle.copyWith(
                        color: BauhausTheme.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BauhausTheme.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      disabledBackgroundColor: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueItem(SyncQueueItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BauhausTheme.blockDecoration.copyWith(
        border: Border.all(color: BauhausTheme.black, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: BauhausTheme.yellow,
                  shape: BoxShape.circle,
                  border: Border.all(color: BauhausTheme.black),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.endpoint,
                    style: BauhausTheme.subHeaderStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    item.method,
                    style: BauhausTheme.bodyStyle.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Pending',
            style: BauhausTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: BauhausTheme.black,
            ),
          ),
        ],
      ),
    );
  }
}
