import 'package:flutter/material.dart';
import 'package:carenest/app/features/pricing/views/bauhaus_pricing_dashboard_view.dart';

/// Main pricing dashboard view that delegates to the modern implementation
class PricingDashboardView extends StatelessWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PricingDashboardView({
    super.key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  Widget build(BuildContext context) => BauhausPricingDashboardView(
        adminEmail: adminEmail,
        organizationId: organizationId,
        organizationName: organizationName,
      );
}
