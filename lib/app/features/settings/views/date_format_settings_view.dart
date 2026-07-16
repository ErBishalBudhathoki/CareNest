import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/settings/providers/settings_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// Screen to configure the user's preferred date format for parsing ambiguous numeric dates.
///
/// Provides two options:
/// - Month/Day/Year (US)
/// - Day/Month/Year
class DateFormatSettingsView extends ConsumerWidget {
  const DateFormatSettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(dateFormatSettingsViewModelProvider);
    // Trigger a one-time load when first built, while keeping the view stateless.
    if (!vm.isLoaded && !vm.isLoading) {
      // Schedule asynchronously to avoid side-effects during build.
      Future.microtask(
          () => ref.read(dateFormatSettingsViewModelProvider.notifier).load());
    }

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: _buildBauhausAppBar(context),
      body: vm.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : Padding(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Card
                  BauhausCard(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(BauhausDesign.space3),
                          decoration: BoxDecoration(
                            color: BauhausDesign.primary.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusMd),
                            border: Border.all(color: BauhausDesign.primary),
                          ),
                          child: const Icon(Icons.event_outlined,
                              color: BauhausDesign.primary),
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.dateFormatInfoMessage,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: BauhausDesign.textDark,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space6),
                  Text(
                    AppLocalizations.of(context)!.formatOptions,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildOptionCard(
                    context,
                    title: AppLocalizations.of(context)!.monthDayYearUs,
                    subtitle: AppLocalizations.of(context)!.monthDayYearExample,
                    icon: Icons.flag_outlined,
                    isSelected: vm.selected == 'mdy',
                    onTap: () => ref.read(dateFormatSettingsViewModelProvider.notifier).select('mdy'),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildOptionCard(
                    context,
                    title: AppLocalizations.of(context)!.dayMonthYear,
                    subtitle: AppLocalizations.of(context)!.dayMonthYearExample,
                    icon: Icons.public,
                    isSelected: vm.selected == 'dmy',
                    onTap: () => ref.read(dateFormatSettingsViewModelProvider.notifier).select('dmy'),
                  ),
                  if (vm.errorMessage != null) ...[
                    const SizedBox(height: BauhausDesign.space4),
                    Text(
                      vm.errorMessage!,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: BauhausDesign.error),
                    ),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: BauhausActionButton(
                      text: AppLocalizations.of(context)!.saveButton,
                      onPressed: vm.isLoading
                          ? null
                          : () async {
                              await ref.read(dateFormatSettingsViewModelProvider.notifier).save();
                              if (vm.saveSucceeded && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle,
                                            color: BauhausDesign.surfaceWhite),
                                        const SizedBox(
                                            width: BauhausDesign.space3),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .dateFormatSaved,
                                          style: BauhausDesign.getTextTheme(
                                                  context)
                                              .bodyMedium
                                              ?.copyWith(
                                                color:
                                                    BauhausDesign.surfaceWhite,
                                              ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: BauhausDesign.success,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          BauhausDesign.radiusMd),
                                      side: const BorderSide(
                                          color: BauhausDesign.neutral,
                                          width: 1.5),
                                    ),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            },
                      isLoading: vm.isLoading,
                      variant: BauhausActionVariant.primary,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget _buildBauhausAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: BauhausDesign.surfaceLight,
          border: Border(
            bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
            child: Row(
              children: [
                BauhausIconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icons.arrow_back,
                  variant: BauhausActionVariant.ghost,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Text(
                  AppLocalizations.of(context)!.dateFormatAppBarTitle,
                  style: BauhausDesign.getTextTheme(context).displaySmall,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(BauhausDesign.space4),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceLight,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(
            color: isSelected
                ? BauhausDesign.primary
                : BauhausDesign.neutral.withOpacity(0.3),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected ? const [BauhausDesign.shadowHardSm] : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: isSelected
                    ? BauhausDesign.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: Icon(
                icon,
                color:
                    isSelected ? BauhausDesign.primary : BauhausDesign.neutral,
                size: 24,
              ),
            ),
            const SizedBox(width: BauhausDesign.space4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: BauhausDesign.getTextTheme(context)
                        .titleSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? BauhausDesign.textDark
                              : BauhausDesign.neutral,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style:
                        BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                              color: BauhausDesign.textMuted,
                            ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BauhausDesign.primary,
                ),
                child: const Icon(Icons.check,
                    size: 16, color: BauhausDesign.surfaceWhite),
              ),
          ],
        ),
      ),
    );
  }
}
