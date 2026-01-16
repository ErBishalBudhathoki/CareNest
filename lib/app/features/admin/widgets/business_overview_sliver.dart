import 'package:carenest/app/features/admin/widgets/business_overview_section.dart';
import 'package:flutter/material.dart';

class BusinessOverviewSliver extends StatelessWidget {
  final Animation<double> animation;
  final Map<String, dynamic> businessStats;

  const BusinessOverviewSliver({
    super.key,
    required this.animation,
    required this.businessStats,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BusinessOverviewSection(
        animation: animation,
        businessStats: businessStats,
      ),
    );
  }
}

