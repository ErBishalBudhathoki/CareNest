import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BusinessOverviewSection extends StatelessWidget {
  final Animation<double>? animation;
  final Map<String, dynamic> businessStats;
  final VoidCallback? onActiveBusinessesTap;
  final VoidCallback? onTotalClientsTap;
  final VoidCallback? onInvoicesGeneratedTap;

  const BusinessOverviewSection({
    super.key,
    required this.businessStats,
    this.animation,
    this.onActiveBusinessesTap,
    this.onTotalClientsTap,
    this.onInvoicesGeneratedTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Business Overview',
              style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.neutral,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              'Track your business performance at a glance',
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space6),
            SizedBox(
              height: 150,
              child: ListView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildEnhancedStatsCard(
                    context: context,
                    icon: Icons.business_center_rounded,
                    value: businessStats['activeBusinesses']?.toString() ?? '0',
                    title: 'Active Businesses',
                    color: BauhausDesign.primary,
                    index: 0,
                    onTap: onActiveBusinessesTap,
                  ),
                  _buildEnhancedStatsCard(
                    context: context,
                    icon: Icons.people_rounded,
                    value: businessStats['totalClients']?.toString() ?? '0',
                    title: 'Total Clients',
                    color: BauhausDesign.success,
                    index: 1,
                    onTap: onTotalClientsTap,
                  ),
                  _buildEnhancedStatsCard(
                    context: context,
                    icon: Icons.receipt_long_rounded,
                    value: businessStats['totalInvoices']?.toString() ?? '0',
                    title: 'Invoices Generated',
                    color: BauhausDesign.secondary,
                    index: 2,
                    onTap: onInvoicesGeneratedTap,
                  ),
                  _buildEnhancedStatsCard(
                    context: context,
                    icon: Icons.trending_up_rounded,
                    value: businessStats['totalRevenue']?.toString() ?? '\$0.00',
                    title: 'Total Revenue',
                    color: BauhausDesign.warning,
                    index: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final a = animation;
    if (a == null) {
      return child;
    }

    return AnimatedBuilder(
      animation: a,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - a.value)),
          child: Opacity(
            opacity: a.value,
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: child,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedStatsCard({
    required BuildContext context,
    required IconData icon,
    required String value,
    required String title,
    required Color color,
    required int index,
    VoidCallback? onTap,
  }) {
    final card = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        child: Container(
          width: 140,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: const [
              BauhausDesign.shadowHard,
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                    border: Border.all(color: BauhausDesign.neutral, width: 1.5),
                    boxShadow: const [
                      BauhausDesign.shadowHardSm,
                    ],
                  ),
                  child: Icon(icon, color: BauhausDesign.surfaceLight, size: 18),
                ),
                const SizedBox(height: BauhausDesign.space2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          style: BauhausDesign.getTextTheme(context)
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.neutral,
                                letterSpacing: -0.5,
                              ),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.neutral,
                              height: 1.1,
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final disableAnimations = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (disableAnimations) {
      return card;
    }

    return card
        .animate(delay: (index * 150).ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutQuart)
        .fadeIn(duration: 600.ms, curve: Curves.easeOutQuart);
  }
}
