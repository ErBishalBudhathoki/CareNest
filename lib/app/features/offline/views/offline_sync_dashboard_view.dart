import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = BauhausDesign.getTextTheme(context);
    final statusColor = _isOnline ? colorScheme.secondary : colorScheme.error;
    final statusForeground = _isOnline
        ? colorScheme.onSecondary
        : colorScheme.onError;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: CircularProgressIndicator(color: colorScheme.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.offlineSyncTitle,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: colorScheme.inverseSurface,
        foregroundColor: colorScheme.onInverseSurface,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onInverseSurface),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: statusColor,
                border: Border.all(color: colorScheme.outline, width: 2),
              ),
              child: Row(
                children: [
                  Icon(
                    _isOnline ? Icons.wifi : Icons.wifi_off,
                    size: 48,
                    color: statusForeground,
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
                          style: textTheme.headlineSmall?.copyWith(
                            color: statusForeground,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          _queue.isEmpty
                              ? 'All data is synced'
                              : '${_queue.length} requests pending',
                          style: textTheme.bodyMedium?.copyWith(
                            color: statusForeground,
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
              style: textTheme.titleMedium,
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
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No pending changes',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _queue.length,
                      itemBuilder: (context, index) {
                        return _buildQueueItem(context, _queue[index]);
                      },
                    ),
            ),
            const SizedBox(height: 16),
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
                              color: colorScheme.onInverseSurface,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(Icons.sync, color: colorScheme.onInverseSurface),
                    label: Text(
                      isSyncing
                          ? 'Syncing...'
                          : AppLocalizations.of(context)!.syncNow,
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.onInverseSurface,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.inverseSurface,
                      foregroundColor: colorScheme.onInverseSurface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      disabledBackgroundColor: colorScheme.surfaceContainerHigh,
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

  Widget _buildQueueItem(BuildContext context, SyncQueueItem item) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = BauhausDesign.getTextTheme(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: Border.all(color: colorScheme.outline, width: 2),
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
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.outline),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.endpoint,
                    style: textTheme.titleSmall?.copyWith(fontSize: 14),
                  ),
                  Text(
                    item.method,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'Pending',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
