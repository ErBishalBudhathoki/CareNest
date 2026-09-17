import 'package:carenest/app/core/providers/connectivity_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Slim offline banner. Renders nothing while online (or while the
/// connectivity status is still loading) so screens stay unchanged
/// in the normal case.
class BauhausOfflineBanner extends ConsumerWidget {
  const BauhausOfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final online = ref.watch(isOnlineProvider).value ?? true;
    if (online) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space2,
      ),
      decoration: const BoxDecoration(
        color: BauhausDesign.warning,
        border: Border(
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off, size: 16, color: BauhausDesign.textDark),
          const SizedBox(width: BauhausDesign.space2),
          Expanded(
            child: Text(
              l10n.offlineBannerMessage,
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
