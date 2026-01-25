import 'package:flutter/material.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    BauhausChipVariant variant;
    String label;
    IconData? icon;

    switch (source.toLowerCase()) {
      case 'organization':
      case 'org_base_rate':
        variant = BauhausChipVariant.primary;
        label = l10n.sourceOrganization;
        icon = Icons.business;
        break;
      case 'client_specific':
        variant = BauhausChipVariant.secondary;
        label = l10n.sourceClientSpecific;
        icon = Icons.person;
        break;
      case 'ndis_cap':
      case 'price_cap':
        variant = BauhausChipVariant.warning;
        label = l10n.sourceNdisCap;
        icon = Icons.warning_amber_rounded;
        break;
      case 'manual':
      case 'override':
        variant = BauhausChipVariant.info;
        label = l10n.sourceManualOverride;
        icon = Icons.edit;
        break;
      case 'fallback':
      case 'ndis_default':
      default:
        variant = BauhausChipVariant.error;
        label = l10n.sourceFallback;
        icon = Icons.flag;
        break;
    }

    Widget badge = BauhausChip(
      label: label,
      variant: variant,
      icon: isSmall ? null : icon,
    );

    if (isSmall) {
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
