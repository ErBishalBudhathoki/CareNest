import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

class OfflineSyncDashboard extends StatefulWidget {
  final String? userId;

  const OfflineSyncDashboard({
    super.key,
    this.userId,
  });

  @override
  State<OfflineSyncDashboard> createState() => _OfflineSyncDashboardState();
}

class _OfflineSyncDashboardState extends State<OfflineSyncDashboard> {
  final bool _isLoading = false;
  final bool _isOnline = true;

  // Mock data
  final int _queuedItems = 5;
  final int _syncedToday = 23;
  final int _conflicts = 1;
  final String _lastSync = '2 hours ago';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        title: Text(
          'OFFLINE MODE',
          style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        iconTheme: const IconThemeData(color: BauhausDesign.textDark),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            color: BauhausDesign.neutral,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: BauhausDesign.space4),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space2,
                vertical: BauhausDesign.space1,
              ),
              decoration: BoxDecoration(
                color: _isOnline ? BauhausDesign.success : BauhausDesign.warning,
                border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Text(
                _isOnline ? 'ONLINE' : 'OFFLINE',
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: _isOnline
                          ? BauhausDesign.surfaceWhite
                          : BauhausDesign.textDark,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: BauhausLoadingState())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards
                  _buildStatsSection(),
                  const SizedBox(height: BauhausDesign.space6),

                  // Feature Cards
                  BauhausSectionHeader(title: 'SYNC TOOLS'),
                  const SizedBox(height: BauhausDesign.space3),

                  _buildFeatureCard(
                    title: 'Sync Now',
                    description: 'Sync all queued data to server',
                    icon: Icons.sync_outlined,
                    color: BauhausDesign.primary,
                    onTap: _syncNow,
                    enabled: _isOnline && _queuedItems > 0,
                  ),
                  const SizedBox(height: BauhausDesign.space3),

                  _buildFeatureCard(
                    title: 'View Queue',
                    description: 'See all queued offline data',
                    icon: Icons.queue_outlined,
                    color: BauhausDesign.secondary,
                    onTap: _viewQueue,
                  ),
                  const SizedBox(height: BauhausDesign.space3),

                  _buildFeatureCard(
                    title: 'Resolve Conflicts',
                    description: 'Handle sync conflicts manually',
                    icon: Icons.merge_outlined,
                    color: BauhausDesign.warning,
                    onTap: _resolveConflicts,
                    enabled: _conflicts > 0,
                  ),
                  const SizedBox(height: BauhausDesign.space3),

                  _buildFeatureCard(
                    title: 'Download Data',
                    description: 'Download data for offline use',
                    icon: Icons.download_outlined,
                    color: BauhausDesign.success,
                    onTap: _downloadData,
                    enabled: _isOnline,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(title: 'SYNC STATUS'),
        const SizedBox(height: BauhausDesign.space3),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                label: 'Queued',
                value: '$_queuedItems',
                icon: Icons.pending_outlined,
                color: BauhausDesign.warning,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: _buildStatCard(
                label: 'Synced Today',
                value: '$_syncedToday',
                icon: Icons.check_circle_outline,
                color: BauhausDesign.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: BauhausDesign.space3),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                label: 'Conflicts',
                value: '$_conflicts',
                icon: Icons.error_outline,
                color: _conflicts > 0 ? BauhausDesign.error : BauhausDesign.neutral,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: _buildStatCard(
                label: 'Last Sync',
                value: _lastSync,
                icon: Icons.schedule_outlined,
                color: BauhausDesign.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label.toUpperCase(),
                  style: BauhausDesign.getTextTheme(context).labelSmall,
                ),
                Icon(icon, color: color, size: 20),
              ],
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              value,
              style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: BauhausCard(
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space5),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        description,
                        style: BauhausDesign.getTextTheme(context).bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: enabled ? BauhausDesign.textDark : BauhausDesign.neutral,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _syncNow() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Syncing data to server...')),
    );
  }

  void _viewQueue() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading queue...')),
    );
  }

  void _resolveConflicts() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Loading conflicts...')),
    );
  }

  void _downloadData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading offline data...')),
    );
  }
}
