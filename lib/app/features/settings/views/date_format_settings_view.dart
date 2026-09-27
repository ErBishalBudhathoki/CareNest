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
        () => ref.read(dateFormatSettingsViewModelProvider.notifier).load(),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildBauhausAppBar(context),
      body: vm.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary),
            )
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
                            color: BauhausDesign.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              BauhausDesign.radiusMd,
                            ),
                            border: Border.all(color: BauhausDesign.primary),
                          ),
                          child: Icon(
                            Icons.event_outlined,
                            color: BauhausDesign.primary,
                          ),
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.dateFormatInfoMessage,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
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
                    style: BauhausDesign.getTextTheme(context).labelSmall
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
                    onTap: () => ref
                        .read(dateFormatSettingsViewModelProvider.notifier)
                        .select('mdy'),
                  ),
                  const SizedBox(height: BauhausDesign.space4),
                  _buildOptionCard(
                    context,
                    title: AppLocalizations.of(context)!.dayMonthYear,
                    subtitle: AppLocalizations.of(context)!.dayMonthYearExample,
                    icon: Icons.public,
                    isSelected: vm.selected == 'dmy',
                    onTap: () => ref
                        .read(dateFormatSettingsViewModelProvider.notifier)
                        .select('dmy'),
                  ),
                  if (vm.errorMessage != null) ...[
                    const SizedBox(height: BauhausDesign.space4),
                    Text(
                      vm.errorMessage!,
                      style: BauhausDesign.getTextTheme(
                        context,
                      ).bodySmall?.copyWith(color: BauhausDesign.error),
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
                              await ref
                                  .read(
                                    dateFormatSettingsViewModelProvider
                                        .notifier,
                                  )
                                  .save();
                              if (vm.saveSucceeded && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                        const SizedBox(
                                          width: BauhausDesign.space3,
                                        ),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.dateFormatSaved,
                                          style:
                                              BauhausDesign.getTextTheme(
                                                context,
                                              ).bodyMedium?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: BauhausDesign.success,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        BauhausDesign.radiusMd,
                                      ),
                                      side: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                        width: 1.5,
                                      ),
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
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
            ),
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
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(
            color: isSelected
                ? BauhausDesign.primary
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
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
                    ? BauhausDesign.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? BauhausDesign.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
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
                    style: BauhausDesign.getTextTheme(context).titleSmall
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Theme.of(context).colorScheme.onSurface
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: BauhausDesign.getTextTheme(
                      context,
                    ).bodySmall?.copyWith(color: BauhausDesign.textMuted),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: BauhausDesign.primary,
                ),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
