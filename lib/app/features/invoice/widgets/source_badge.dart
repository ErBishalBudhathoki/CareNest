import 'package:flutter/material.dart';
import 'package:carenest/app/shared/design_system/modern_pricing_design_system.dart';

class SourceBadge extends StatelessWidget {
  final String source;
  final bool isSmall;
  final String? tooltip;

  const SourceBadge({
    super.key,
    required this.source,
    this.isSmall = false,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    ModernChipVariant variant;
    String label;
    IconData? icon;

    switch (source.toLowerCase()) {
      case 'organization':
      case 'org_base_rate':
        variant = ModernChipVariant.primary;
        label = 'Organization';
        icon = Icons.business;
        break;
      case 'client_specific':
        variant = ModernChipVariant.secondary;
        label = 'Client Specific';
        icon = Icons.person;
        break;
      case 'ndis_cap':
      case 'price_cap':
        variant = ModernChipVariant.warning;
        label = 'NDIS Cap';
        icon = Icons.warning_amber_rounded;
        break;
      case 'manual':
      case 'override':
        variant = ModernChipVariant.info;
        label = 'Manual Override';
        icon = Icons.edit;
        break;
      case 'fallback':
      case 'ndis_default':
      default:
        variant = ModernChipVariant.error;
        label = 'Fallback';
        icon = Icons.flag;
        break;
    }

    Widget badge = ModernChip(
      label: label,
      variant: variant,
      icon: isSmall ? null : icon,
    );

    if (isSmall) {
      // Scale down for small variant if needed, or just rely on ModernChip
      // ModernChip doesn't support size, but we can wrap in Transform or just accept it
      badge = Transform.scale(
        scale: 0.8,
        child: badge,
      );
    }

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: badge,
      );
    }
    return badge;
  }
}
