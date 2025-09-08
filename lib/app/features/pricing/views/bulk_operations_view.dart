import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:file_picker/file_picker.dart';

class BulkOperationsView extends ConsumerStatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const BulkOperationsView({
    Key? key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  }) : super(key: key);

  @override
  ConsumerState<BulkOperationsView> createState() => _BulkOperationsViewState();
}

class _BulkOperationsViewState extends ConsumerState<BulkOperationsView> {
  int _selectedIndex = 0;
  bool _isProcessing = false;
  double _uploadProgress = 0.0;
  String _selectedOperation = 'import';

  // Mock data for operation history
  final List<Map<String, dynamic>> _operationHistory = [
    {
      'id': 'OP001',
      'type': 'Import',
      'description': 'NDIS Items Bulk Import',
      'status': 'Completed',
      'recordsProcessed': 150,
      'recordsSuccessful': 148,
      'recordsFailed': 2,
      'startTime': '2024-01-15 10:30:00',
      'endTime': '2024-01-15 10:32:15',
      'fileName': 'ndis_items_2024.csv',
      'initiatedBy': 'admin@example.com',
    },
    {
      'id': 'OP002',
      'type': 'Export',
      'description': 'Service Rates Export',
      'status': 'Completed',
      'recordsProcessed': 75,
      'recordsSuccessful': 75,
      'recordsFailed': 0,
      'startTime': '2024-01-14 15:45:00',
      'endTime': '2024-01-14 15:45:30',
      'fileName': 'service_rates_export.xlsx',
      'initiatedBy': 'admin@example.com',
    },
    {
      'id': 'OP003',
      'type': 'Update',
      'description': 'Bulk Price Update - Q1 2024',
      'status': 'Failed',
      'recordsProcessed': 200,
      'recordsSuccessful': 180,
      'recordsFailed': 20,
      'startTime': '2024-01-13 09:15:00',
      'endTime': '2024-01-13 09:18:45',
      'fileName': 'price_updates_q1.csv',
      'initiatedBy': 'admin@example.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            //_buildHeader(),
            _buildModernHeader(),
            _buildStatsOverview(),
            _buildNavigationTabs(),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;
            return Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                          ),
                          color: const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bulk Operations',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 24 : 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isSmallScreen) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Manage and optimize your service pricing across different regions and categories',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ]
                          ],
                        ),
                      ),
                      if (!isSmallScreen)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'System Active',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (isSmallScreen) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Import and export data in batch operations',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'System Active',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bulk Operations',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Import and export data in batch operations',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'System Active',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(
          icon: Icons.refresh,
          onPressed: _refreshData,
          tooltip: 'Refresh',
        ),
        const SizedBox(width: 8),
        _buildActionButton(
          icon: Icons.help_outline,
          onPressed: _showHelp,
          tooltip: 'Help',
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: _showBulkOperationDialog,
          icon: const Icon(Icons.add, size: 16),
          label: const Text(
            'New',
            style: TextStyle(fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6366F1),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 16, color: const Color(0xFF64748B)),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    final completedOps =
        _operationHistory.where((op) => op['status'] == 'Completed').length;
    final failedOps =
        _operationHistory.where((op) => op['status'] == 'Failed').length;
    final totalRecords = _operationHistory.fold<int>(
        0, (sum, op) => sum + (op['recordsProcessed'] as int));
    final successfulRecords = _operationHistory.fold<int>(
        0, (sum, op) => sum + (op['recordsSuccessful'] as int));
    final successRate = totalRecords > 0
        ? ((successfulRecords / totalRecords) * 100).toStringAsFixed(1)
        : '0';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Total Operations',
                value: '${_operationHistory.length}',
                icon: Icons.analytics_outlined,
                color: const Color(0xFF6366F1),
                backgroundColor: const Color(0xFFF0F0FF),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Completed',
                value: '$completedOps',
                icon: Icons.check_circle_outline,
                color: const Color(0xFF10B981),
                backgroundColor: const Color(0xFFF0FDF4),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Failed',
                value: '$failedOps',
                icon: Icons.error_outline,
                color: const Color(0xFFEF4444),
                backgroundColor: const Color(0xFFFEF2F2),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 160,
              child: _buildStatCard(
                title: 'Success Rate',
                value: '$successRate%',
                icon: Icons.trending_up,
                color: const Color(0xFFF59E0B),
                backgroundColor: const Color(0xFFFFFBEB),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTabs() {
    final tabs = [
      {
        'title': 'Import',
        'subtitle': 'Data',
        'icon': Icons.upload_file_outlined
      },
      {'title': 'Export', 'subtitle': 'Data', 'icon': Icons.download_outlined},
      {'title': 'Bulk', 'subtitle': 'Updates', 'icon': Icons.edit_outlined},
      {'title': 'History', 'subtitle': '', 'icon': Icons.history_outlined},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 600;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: tabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tab = entry.value;
                final isSelected = _selectedIndex == index;

                return Expanded(
                  child: _AnimatedTabItem(
                    isSelected: isSelected,
                    isCompact: isCompact,
                    tab: tab,
                    onTap: () {
                      setState(() => _selectedIndex = index);
                    },
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _AnimatedTabItem({
    required bool isSelected,
    required bool isCompact,
    required Map<String, dynamic> tab,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: isSelected ? 300 : 200),
      curve: isSelected ? Curves.elasticOut : Curves.easeOutCubic,
      tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
      builder: (context, animationValue, child) {
        return GestureDetector(
          onTap: onTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: EdgeInsets.symmetric(
                vertical: isCompact ? 10 : 14,
                horizontal: 8,
              ),
              transform: Matrix4.identity()
                ..scale(1.0 + (animationValue * 0.02))
                ..translate(0.0, -animationValue * 1.0),
              decoration: BoxDecoration(
                color: Color.lerp(
                  Colors.transparent,
                  Colors.white,
                  animationValue,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withValues(alpha: 0.08 * animationValue),
                    blurRadius: 8 + (4 * animationValue),
                    offset: Offset(0, 2 + (2 * animationValue)),
                  ),
                  BoxShadow(
                    color: const Color(0xFF6366F1)
                        .withValues(alpha: 0.1 * animationValue),
                    blurRadius: 12 + (8 * animationValue),
                    offset: Offset(0, 4 + (4 * animationValue)),
                  ),
                ],
                border: animationValue > 0
                    ? Border.all(
                        color: Color.lerp(
                          Colors.transparent,
                          const Color(0xFF6366F1).withValues(alpha: 0.2),
                          animationValue,
                        )!,
                        width: animationValue,
                      )
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: isSelected ? 400 : 250),
                    curve: isSelected ? Curves.elasticOut : Curves.easeOutCubic,
                    tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
                    builder: (context, iconAnimationValue, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.all(6),
                        transform: Matrix4.identity()
                          ..scale(1.0 + (iconAnimationValue * 0.1))
                          ..rotateZ(iconAnimationValue * 0.05),
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            Colors.transparent,
                            const Color(0xFF6366F1).withValues(alpha: 0.1),
                            iconAnimationValue,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            tab['icon'] as IconData,
                            key: ValueKey(isSelected),
                            size: isCompact ? 16 : 18,
                            color: Color.lerp(
                              const Color(0xFF64748B),
                              const Color(0xFF6366F1),
                              iconAnimationValue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 6,
                    child: const SizedBox(),
                  ),
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: isSelected ? 350 : 200),
                    curve: Curves.easeOutCubic,
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, textAnimationValue, child) {
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: textAnimationValue,
                        child: Transform.translate(
                          offset: Offset(0, (1 - textAnimationValue) * 5),
                          child: Column(
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutCubic,
                                style: TextStyle(
                                  fontSize: isCompact ? 11 : 12,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: Color.lerp(
                                    const Color(0xFF1E293B),
                                    const Color(0xFF6366F1),
                                    animationValue,
                                  ),
                                  height: 1.2,
                                ),
                                child: Text(
                                  tab['title'] as String,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if ((tab['subtitle'] as String).isNotEmpty)
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOutCubic,
                                  transform: Matrix4.identity()
                                    ..scale(1.0 + (animationValue * 0.05)),
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeOutCubic,
                                    style: TextStyle(
                                      fontSize: isCompact ? 10 : 11,
                                      fontWeight: FontWeight.w500,
                                      color: Color.lerp(
                                        const Color(0xFF64748B),
                                        const Color(0xFF6366F1)
                                            .withValues(alpha: 0.8),
                                        animationValue,
                                      ),
                                      height: 1.1,
                                    ),
                                    child: Text(
                                      tab['subtitle'] as String,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildImportTab();
      case 1:
        return _buildExportTab();
      case 2:
        return _buildBulkUpdatesTab();
      case 3:
        return _buildHistoryTab();
      default:
        return _buildImportTab();
    }
  }

  Widget _buildImportTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final isSmallScreen = constraints.maxWidth < 600;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Import Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Upload CSV or Excel files to import pricing data in bulk',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _buildModernImportCard(
                  title: 'NDIS Items',
                  subtitle: 'item codes',
                  value: '1,247',
                  unit: 'items',
                  icon: Icons.list_alt,
                  color: const Color(0xFF6366F1),
                  onTap: () => _handleImport('ndis_items'),
                ),
                _buildModernImportCard(
                  title: 'Service Rates',
                  subtitle: 'rate structures',
                  value: '89',
                  unit: 'rates',
                  icon: Icons.rate_review,
                  color: const Color(0xFF10B981),
                  onTap: () => _handleImport('service_rates'),
                ),
                _buildModernImportCard(
                  title: 'Price Updates',
                  subtitle: 'bulk adjustments',
                  value: '342',
                  unit: 'updates',
                  icon: Icons.trending_up,
                  color: const Color(0xFFF59E0B),
                  onTap: () => _handleImport('price_updates'),
                ),
                _buildModernImportCard(
                  title: 'Regional Rates',
                  subtitle: 'pricing variations',
                  value: '15',
                  unit: 'regions',
                  icon: Icons.location_on,
                  color: const Color(0xFF8B5CF6),
                  onTap: () => _handleImport('regional_rates'),
                ),
              ],
            ),
            if (_isProcessing) ...[
              const SizedBox(height: 24),
              _buildProgressIndicator(),
            ],
            const SizedBox(height: 24),
            _buildTemplateDownloads(),
          ],
        ),
      );
    });
  }

  Widget _buildModernImportCard({
    required String title,
    required String subtitle,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 26,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 18,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: const Color(0xFF64748B),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: color,
                      height: 1.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF64748B),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.upload,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Processing import...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(_uploadProgress * 100).toInt()}% complete',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _uploadProgress,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateDownloads() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.file_download_outlined,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Download Templates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Get properly formatted CSV templates for seamless data import',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 16) / 2;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: cardWidth,
                    height: 120,
                    child: _buildModernTemplateCard(
                      'NDIS Items',
                      'Complete NDIS service items with codes and descriptions',
                      Icons.medical_services_outlined,
                      'ndis_template',
                      const Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: 120,
                    child: _buildModernTemplateCard(
                      'Service Rates',
                      'Pricing rates for all service categories',
                      Icons.attach_money_outlined,
                      'rates_template',
                      const Color(0xFF6366F1),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: 120,
                    child: _buildModernTemplateCard(
                      'Price Updates',
                      'Bulk price adjustments and modifications',
                      Icons.trending_up_outlined,
                      'updates_template',
                      const Color(0xFFF59E0B),
                    ),
                  ),
                  SizedBox(
                    width: cardWidth,
                    height: 120,
                    child: _buildModernTemplateCard(
                      'Regional Rates',
                      'Location-based pricing variations',
                      Icons.location_on_outlined,
                      'regional_template',
                      const Color(0xFFEF4444),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModernTemplateCard(
    String title,
    String description,
    IconData icon,
    String template,
    Color accentColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _downloadTemplate(template),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        icon,
                        color: accentColor,
                        size: 16,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.download,
                        color: const Color(0xFF64748B),
                        size: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF64748B),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateButton(String title, String template) {
    return OutlinedButton.icon(
      onPressed: () => _downloadTemplate(template),
      icon: const Icon(Icons.download, size: 16),
      label: Text(title),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF6366F1),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildExportTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final isSmallScreen = constraints.maxWidth < 600;
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Export Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Export your pricing data to various formats',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _buildModernImportCard(
                  title: 'All Pricing Data',
                  subtitle: 'complete database',
                  value: '1,247',
                  unit: 'records',
                  icon: Icons.storage,
                  color: const Color(0xFF6366F1),
                  onTap: () => _handleExport('all_data'),
                ),
                _buildModernImportCard(
                  title: 'NDIS Items Only',
                  subtitle: 'items and rates',
                  value: '89',
                  unit: 'items',
                  icon: Icons.list_alt,
                  color: const Color(0xFF10B981),
                  onTap: () => _handleExport('ndis_only'),
                ),
                _buildModernImportCard(
                  title: 'Service Rates',
                  subtitle: 'rate structures',
                  value: '342',
                  unit: 'rates',
                  icon: Icons.rate_review,
                  color: const Color(0xFFF59E0B),
                  onTap: () => _handleExport('service_rates'),
                ),
                _buildModernImportCard(
                  title: 'Regional Data',
                  subtitle: 'pricing variations',
                  value: '15',
                  unit: 'regions',
                  icon: Icons.location_on,
                  color: const Color(0xFF8B5CF6),
                  onTap: () => _handleExport('regional_data'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBulkUpdatesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bulk Updates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Perform mass updates on your pricing data',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
              final childAspectRatio = 1.2;

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: childAspectRatio,
                children: [
                  _buildModernImportCard(
                    title: 'Price Adjustment',
                    subtitle: 'Apply percentage increases/decreases',
                    value: 'Bulk',
                    unit: 'Updates',
                    icon: Icons.trending_up,
                    color: const Color(0xFF3B82F6),
                    onTap: () => _handleBulkUpdate('price_adjustment'),
                  ),
                  _buildModernImportCard(
                    title: 'Regional Updates',
                    subtitle: 'Update rates for specific regions',
                    value: 'Region',
                    unit: 'Based',
                    icon: Icons.location_on,
                    color: const Color(0xFF10B981),
                    onTap: () => _handleBulkUpdate('regional_updates'),
                  ),
                  _buildModernImportCard(
                    title: 'Category Updates',
                    subtitle: 'Update entire service categories',
                    value: 'Category',
                    unit: 'Wide',
                    icon: Icons.category,
                    color: const Color(0xFF8B5CF6),
                    onTap: () => _handleBulkUpdate('category_updates'),
                  ),
                  _buildModernImportCard(
                    title: 'Status Changes',
                    subtitle: 'Activate/deactivate multiple items',
                    value: 'Status',
                    unit: 'Toggle',
                    icon: Icons.toggle_on,
                    color: const Color(0xFFF59E0B),
                    onTap: () => _handleBulkUpdate('status_changes'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operation History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'View history of all bulk operations',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _refreshData,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 16,
                            color: const Color(0xFF6366F1),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Refresh',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _operationHistory.length,
            itemBuilder: (context, index) {
              final operation = _operationHistory[index];
              return _buildHistoryCard(operation);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> operation) {
    final isCompleted = operation['status'] == 'Completed';
    final isFailed = operation['status'] == 'Failed';
    final statusColor = isCompleted
        ? const Color(0xFF10B981)
        : isFailed
            ? const Color(0xFFEF4444)
            : const Color(0xFFF59E0B);
    final statusBgColor = isCompleted
        ? const Color(0xFFF0FDF4)
        : isFailed
            ? const Color(0xFFFEF2F2)
            : const Color(0xFFFFFBEB);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operation['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${operation['type']} • ${operation['fileName']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  operation['status'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildOperationStat(
                  'Processed',
                  '${operation['recordsProcessed']}',
                  const Color(0xFF6366F1),
                ),
              ),
              Expanded(
                child: _buildOperationStat(
                  'Successful',
                  '${operation['recordsSuccessful']}',
                  const Color(0xFF10B981),
                ),
              ),
              Expanded(
                child: _buildOperationStat(
                  'Failed',
                  '${operation['recordsFailed']}',
                  const Color(0xFFEF4444),
                ),
              ),
              Expanded(
                child: _buildOperationStat(
                  'Duration',
                  _calculateDuration(
                      operation['startTime'], operation['endTime']),
                  const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Started: ${operation['startTime']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
              Text(
                'By: ${operation['initiatedBy']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOperationStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  String _calculateDuration(String startTime, String endTime) {
    try {
      final start = DateTime.parse(startTime.replaceAll(' ', 'T'));
      final end = DateTime.parse(endTime.replaceAll(' ', 'T'));
      final duration = end.difference(start);

      if (duration.inMinutes > 0) {
        return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
      } else {
        return '${duration.inSeconds}s';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  void _handleImport(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xlsx', 'xls'],
      );

      if (result != null) {
        setState(() {
          _isProcessing = true;
          _uploadProgress = 0.0;
        });

        // Simulate upload progress
        for (int i = 0; i <= 100; i += 10) {
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {
            _uploadProgress = i / 100;
          });
        }

        setState(() {
          _isProcessing = false;
        });

        _showSnackBar('Import completed successfully for $type');
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showSnackBar('Import failed: ${e.toString()}');
    }
  }

  void _handleExport(String type) {
    _showSnackBar('Exporting $type...');
  }

  void _handleBulkUpdate(String type) {
    _showSnackBar('Initiating $type...');
  }

  void _downloadTemplate(String template) {
    _showSnackBar('Downloading $template...');
  }

  void _refreshData() {
    _showSnackBar('Data refreshed successfully');
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bulk Operations Help'),
        content: const SizedBox(
          width: 400,
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Import Data:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• Upload CSV or Excel files to import pricing data'),
                Text('• Download templates for proper formatting'),
                SizedBox(height: 16),
                Text(
                  'Export Data:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• Export current pricing data to various formats'),
                SizedBox(height: 16),
                Text(
                  'Bulk Updates:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• Perform mass updates on pricing data'),
                SizedBox(height: 16),
                Text(
                  'Operation History:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('• View history of all bulk operations'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBulkOperationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quick Actions'),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:
                    const Icon(Icons.upload_file, color: Color(0xFF6366F1)),
                title: const Text('Import Data'),
                subtitle: const Text('Upload CSV or Excel files'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectedIndex = 0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.download, color: Color(0xFF10B981)),
                title: const Text('Export Data'),
                subtitle: const Text('Download current data'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectedIndex = 1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Color(0xFFF59E0B)),
                title: const Text('Bulk Updates'),
                subtitle: const Text('Mass update pricing data'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectedIndex = 2);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
