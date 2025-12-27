import 'package:flutter/material.dart';
import 'package:carenest/app/features/pricing/views/modern_pricing_dashboard_view.dart';


/// Main pricing dashboard view that delegates to the modern implementation
class PricingDashboardView extends StatefulWidget {
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
  _PricingDashboardViewState createState() => _PricingDashboardViewState();
}

class _PricingDashboardViewState extends State<PricingDashboardView> {
  @override
  Widget build(BuildContext context) {
    // Use the new modern dashboard implementation
    return const ModernPricingDashboardView();
  }
}
