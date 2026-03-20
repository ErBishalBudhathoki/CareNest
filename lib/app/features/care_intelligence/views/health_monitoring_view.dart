import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/features/care_intelligence/viewmodels/intelligence_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

class HealthMonitoringView extends ConsumerStatefulWidget {
  const HealthMonitoringView({super.key});

  @override
  ConsumerState<HealthMonitoringView> createState() =>
      _HealthMonitoringViewState();
}

class _HealthMonitoringViewState extends ConsumerState<HealthMonitoringView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final orgId = ref.read(organizationIdProvider);
    const clientId = 'placeholder_client_id';

    if (orgId != null) {
      ref.read(intelligenceViewModelProvider.notifier).analyzeCarePatterns(
            clientId: clientId,
            organizationId: orgId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(intelligenceViewModelProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          'HEALTH MONITORING',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: BauhausLoadingState())
          : state.error != null
              ? Center(
                  child: BauhausEmptyState(
                    title: 'Error',
                    message: state.error!,
                    icon: Icons.error_outline,
                    onAction: _loadData,
                    actionLabel: 'RETRY',
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BauhausSectionHeader(title: 'VITAL SIGNS & TRENDS'),
                      const SizedBox(height: 16),
                      _buildHealthSummaryCard(state),
                      const SizedBox(height: 32),
                      BauhausSectionHeader(title: 'MONITORED INDICATORS'),
                      const SizedBox(height: 16),
                      _buildIndicatorCard(
                        title: 'HEART RATE',
                        value: '72 BPM',
                        status: 'Stable',
                        color: BauhausDesign.success,
                        icon: Icons.favorite_outline,
                      ),
                      const SizedBox(height: 16),
                      _buildIndicatorCard(
                        title: 'BLOOD PRESSURE',
                        value: '120/80',
                        status: 'Normal',
                        color: BauhausDesign.success,
                        icon: Icons.speed,
                      ),
                      const SizedBox(height: 16),
                      _buildIndicatorCard(
                        title: 'SLEEP PATTERN',
                        value: '6.5 Hours',
                        status: 'Decreased',
                        color: BauhausDesign.warning,
                        icon: Icons.nightlight_outlined,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHealthSummaryCard(IntelligenceState state) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.monitor_heart_outlined,
                    color: BauhausDesign.primary, size: 28),
                const SizedBox(width: 12),
                Text(
                  'HEALTH STATUS: OPTIMAL',
                  style:
                      BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                            color: BauhausDesign.primary,
                            fontWeight: FontWeight.w900,
                          ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'No significant health deviations detected in the last 7 days. Vital signs remain within average range.',
              style: TextStyle(color: BauhausDesign.textDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorCard({
    required String title,
    required String value,
    required String status,
    required Color color,
    required IconData icon,
  }) {
    return BauhausCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1),
                  ),
                  Text(
                    value,
                    style: BauhausDesign.getTextTheme(context)
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
