import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/pricing/views/ndis_item_management_view.dart';
import 'package:carenest/app/features/pricing/views/service_rate_management_view.dart';
import 'package:carenest/app/features/pricing/views/bulk_operations_view.dart';
import 'package:carenest/app/features/pricing/views/price_history_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_validation_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_analytics_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_configuration_view.dart';
import 'package:carenest/app/features/pricing/widgets/improved_design_system.dart';
import 'package:carenest/app/features/pricing/widgets/enhanced_navigation.dart';
import 'package:carenest/app/shared/design_system/modern_pricing_design_system.dart';
import 'package:carenest/app/features/pricing/widgets/modern_pricing_header.dart';
import 'package:carenest/app/features/pricing/views/modern_pricing_dashboard_view.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

/// Main pricing dashboard view that delegates to the modern implementation
class PricingDashboardView extends StatefulWidget {
  final String adminEmail;
  final String organizationId;
  final String organizationName;

  const PricingDashboardView({
    Key? key,
    required this.adminEmail,
    required this.organizationId,
    required this.organizationName,
  }) : super(key: key);

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
