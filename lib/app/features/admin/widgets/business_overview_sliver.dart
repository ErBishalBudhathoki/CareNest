import 'package:carenest/app/features/admin/widgets/business_overview_section.dart';
import 'package:flutter/material.dart';

class BusinessOverviewSliver extends StatelessWidget {
  final Animation<double> animation;
  final Map<String, dynamic> businessStats;
  final VoidCallback? onActiveBusinessesTap;
  final VoidCallback? onTotalClientsTap;
  final VoidCallback? onInvoicesGeneratedTap;

  const BusinessOverviewSliver({
    super.key,
    required this.animation,
    required this.businessStats,
    this.onActiveBusinessesTap,
    this.onTotalClientsTap,
    this.onInvoicesGeneratedTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BusinessOverviewSection(
        animation: animation,
        businessStats: businessStats,
        onActiveBusinessesTap: onActiveBusinessesTap,
        onTotalClientsTap: onTotalClientsTap,
        onInvoicesGeneratedTap: onInvoicesGeneratedTap,
      ),
    );
  }
}
