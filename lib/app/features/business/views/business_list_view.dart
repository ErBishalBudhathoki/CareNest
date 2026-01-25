import 'package:carenest/app/features/business/viewmodels/business_list_viewmodel.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessListView extends ConsumerStatefulWidget {
  const BusinessListView({super.key});

  @override
  ConsumerState<BusinessListView> createState() => _BusinessListViewState();
}

class _BusinessListViewState extends ConsumerState<BusinessListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(businessListViewModelProvider).loadBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(businessListViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.businessesTitle,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: BauhausDesign.space4),
            child: BauhausActionButton(
              text: l10n.addButton,
              icon: Icons.add,
              isSmall: true,
              onPressed: () async {
                await Navigator.pushNamed(context, Routes.addBusinessDetails);
                viewModel.refresh();
              },
            ),
          ),
        ],
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(BusinessListViewModel viewModel) {
    final l10n = AppLocalizations.of(context)!;

    if (viewModel.status == BusinessListStatus.loading) {
      return BauhausLoadingState(
        message: l10n.loadingBusinesses,
      );
    }

    if (viewModel.status == BusinessListStatus.error) {
      return Center(
        child: BauhausErrorState(
          title: l10n.oopsTitle,
          message: viewModel.errorMessage ?? l10n.somethingWentWrong,
          onRetry: viewModel.refresh,
        ),
      );
    }

    if (viewModel.status == BusinessListStatus.empty) {
      return Center(
        child: BauhausEmptyState(
          title: l10n.noBusinessesFoundTitle,
          subtitle: l10n.noBusinessesFoundSubtitle,
          icon: Icons.business_outlined,
          actionLabel: l10n.addBusinessButton,
          onAction: () async {
            await Navigator.pushNamed(context, Routes.addBusinessDetails);
            viewModel.refresh();
          },
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        children: [
          ...viewModel.businesses.map((business) => Padding(
                padding: EdgeInsets.only(bottom: BauhausDesign.space4),
                child: BauhausCard(
                  padding: EdgeInsets.all(BauhausDesign.space4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(BauhausDesign.space3),
                            decoration: BoxDecoration(
                              color: BauhausDesign.primary.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(BauhausDesign.radiusMd),
                            ),
                            child: Icon(
                              Icons.business,
                              color: BauhausDesign.primary,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: BauhausDesign.space4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  business.businessName,
                                  style: BauhausDesign.getTextTheme(context)
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: BauhausDesign.textDark,
                                      ),
                                ),
                                SizedBox(height: BauhausDesign.space1),
                                Text(
                                  business.businessEmail,
                                  style: BauhausDesign.getTextTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                        color: BauhausDesign.textMuted,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          BauhausChip(
                            text:
                                business.isActive ? l10n.active : l10n.inactive,
                            variant: business.isActive
                                ? BauhausChipVariant.success
                                : BauhausChipVariant.neutral,
                            size: BauhausChipSize.small,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: BauhausDesign.space4),
                        child: Divider(
                          color: BauhausDesign.neutral.withOpacity(0.2),
                          height: 1,
                        ),
                      ),
                      _buildInfoRow(context, Icons.phone_outlined,
                          business.businessPhone),
                      SizedBox(height: BauhausDesign.space2),
                      _buildInfoRow(context, Icons.location_on_outlined,
                          '${business.businessAddress}, ${business.businessCity}'),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: BauhausDesign.textMuted,
        ),
        SizedBox(width: BauhausDesign.space2),
        Expanded(
          child: Text(
            text,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
