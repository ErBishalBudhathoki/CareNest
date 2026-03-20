import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/business/models/business_model.dart';
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

  Future<Map<String, String>?> _getRequiredUserContext() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.init();

    final userEmail = await prefs.getUserEmailFromSharedPreferences();
    final organizationId = prefs.getOrganizationId();

    if (userEmail == null ||
        userEmail.isEmpty ||
        organizationId == null ||
        organizationId.isEmpty) {
      if (!mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session data missing. Please log in again.'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return null;
    }

    return {
      'userEmail': userEmail,
      'organizationId': organizationId,
    };
  }

  double _dialogWidth(
    BuildContext context, {
    double maxWidth = 760,
    double horizontalMargin = 24,
  }) {
    final available =
        MediaQuery.of(context).size.width - (horizontalMargin * 2);
    return available > maxWidth ? maxWidth : available;
  }

  Future<bool> _showBauhausConfirmDialog({
    required String title,
    required String message,
    required IconData icon,
    required String confirmText,
    Color headerColor = BauhausDesign.primary,
    BauhausActionVariant confirmVariant = BauhausActionVariant.primary,
  }) async {
    final headerForeground =
        ThemeData.estimateBrightnessForColor(headerColor) == Brightness.dark
            ? BauhausDesign.surfaceWhite
            : BauhausDesign.textDark;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Container(
            width: _dialogWidth(dialogContext, maxWidth: 520),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 3),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space4,
                    vertical: BauhausDesign.space3,
                  ),
                  decoration: BoxDecoration(
                    color: headerColor,
                    border: const Border(
                      bottom:
                          BorderSide(color: BauhausDesign.neutral, width: 3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: headerForeground,
                        size: 22,
                      ),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                          style: BauhausDesign.getTextTheme(dialogContext)
                              .titleMedium
                              ?.copyWith(
                                color: headerForeground,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(BauhausDesign.space4),
                  child: Text(
                    message,
                    style: BauhausDesign.getTextTheme(dialogContext)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BauhausDesign.space4,
                    0,
                    BauhausDesign.space4,
                    BauhausDesign.space4,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BauhausActionButton(
                          text: 'Cancel',
                          variant: BauhausActionVariant.secondary,
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(false),
                        ),
                      ),
                      const SizedBox(width: BauhausDesign.space3),
                      Expanded(
                        child: BauhausActionButton(
                          text: confirmText,
                          variant: confirmVariant,
                          onPressed: () =>
                              Navigator.of(dialogContext).pop(true),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result == true;
  }

  Future<void> _showEditBusinessDialog(
    BusinessModel business,
    BusinessListViewModel viewModel,
  ) async {
    if (business.id == null || business.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot edit this business because ID is missing.'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    final nameController = TextEditingController(text: business.businessName);
    final emailController = TextEditingController(text: business.businessEmail);
    final phoneController = TextEditingController(text: business.businessPhone);
    final addressController =
        TextEditingController(text: business.businessAddress);
    final cityController = TextEditingController(text: business.businessCity);
    final stateController = TextEditingController(text: business.businessState);
    final zipController = TextEditingController(text: business.businessZip);
    final formKey = GlobalKey<FormState>();
    bool isSaving = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Container(
                width: _dialogWidth(dialogContext, maxWidth: 760),
                decoration: BoxDecoration(
                  color: BauhausDesign.surfaceWhite,
                  border: Border.all(color: BauhausDesign.neutral, width: 3),
                  boxShadow: const [BauhausDesign.shadowHard],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space3,
                      ),
                      decoration: const BoxDecoration(
                        color: BauhausDesign.secondary,
                        border: Border(
                          bottom: BorderSide(
                              color: BauhausDesign.neutral, width: 3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.edit_note_rounded,
                            color: BauhausDesign.surfaceWhite,
                            size: 22,
                          ),
                          const SizedBox(width: BauhausDesign.space2),
                          Expanded(
                            child: Text(
                              'EDIT BUSINESS',
                              style: BauhausDesign.getTextTheme(dialogContext)
                                  .titleMedium
                                  ?.copyWith(
                                    color: BauhausDesign.surfaceWhite,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(dialogContext).size.height * 0.62,
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(BauhausDesign.space4),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BauhausTextField(
                                controller: nameController,
                                label: 'Business name',
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Required'
                                        : null,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: emailController,
                                label: 'Business email',
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  final value = (v ?? '').trim();
                                  if (value.isEmpty) return 'Required';
                                  if (!value.contains('@')) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: phoneController,
                                label: 'Business phone',
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: addressController,
                                label: 'Business address',
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: BauhausTextField(
                                      controller: cityController,
                                      label: 'City',
                                    ),
                                  ),
                                  const SizedBox(width: BauhausDesign.space3),
                                  Expanded(
                                    child: BauhausTextField(
                                      controller: stateController,
                                      label: 'State',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: BauhausDesign.space3),
                              BauhausTextField(
                                controller: zipController,
                                label: 'Postcode',
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        BauhausDesign.space4,
                        0,
                        BauhausDesign.space4,
                        BauhausDesign.space4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Cancel',
                              variant: BauhausActionVariant.secondary,
                              onPressed: isSaving
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                            ),
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: BauhausActionButton(
                              text: 'Save',
                              variant: BauhausActionVariant.primary,
                              isLoading: isSaving,
                              onPressed: isSaving
                                  ? null
                                  : () async {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }

                                      final userContext =
                                          await _getRequiredUserContext();
                                      if (userContext == null) return;
                                      if (!dialogContext.mounted) return;

                                      setDialogState(() => isSaving = true);
                                      try {
                                        final response =
                                            await viewModel.updateBusiness(
                                          businessId: business.id!,
                                          businessName:
                                              nameController.text.trim(),
                                          businessEmail:
                                              emailController.text.trim(),
                                          businessPhone:
                                              phoneController.text.trim(),
                                          businessAddress:
                                              addressController.text.trim(),
                                          businessCity:
                                              cityController.text.trim(),
                                          businessState:
                                              stateController.text.trim(),
                                          businessZip:
                                              zipController.text.trim(),
                                          userEmail: userContext['userEmail']!,
                                          organizationId:
                                              userContext['organizationId']!,
                                        );

                                        if (!mounted) return;
                                        if (dialogContext.mounted) {
                                          Navigator.of(dialogContext).pop();
                                        }
                                        final message =
                                            response['message']?.toString() ??
                                                'Business updated successfully';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(message),
                                            backgroundColor:
                                                BauhausDesign.success,
                                          ),
                                        );
                                      } catch (e) {
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Failed to update business: $e'),
                                            backgroundColor:
                                                BauhausDesign.error,
                                          ),
                                        );
                                      } finally {
                                        if (mounted && dialogContext.mounted) {
                                          setDialogState(
                                              () => isSaving = false);
                                        }
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
  }

  Future<void> _confirmDeleteBusiness(
    BusinessModel business,
    BusinessListViewModel viewModel,
  ) async {
    if (business.id == null || business.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot delete this business because ID is missing.'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    final confirmed = await _showBauhausConfirmDialog(
      title: 'Delete Business?',
      message:
          'This will remove ${business.businessName} from active businesses.',
      icon: Icons.delete_forever_outlined,
      headerColor: BauhausDesign.error,
      confirmText: 'Delete',
      confirmVariant: BauhausActionVariant.error,
    );

    if (!confirmed) return;

    final userContext = await _getRequiredUserContext();
    if (userContext == null) return;

    try {
      final response = await viewModel.deleteBusiness(
        businessId: business.id!,
        userEmail: userContext['userEmail']!,
        organizationId: userContext['organizationId']!,
      );
      if (!mounted) return;
      final message =
          response['message']?.toString() ?? 'Business deleted successfully';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: BauhausDesign.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete business: $e'),
          backgroundColor: BauhausDesign.error,
        ),
      );
    }
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
          ...viewModel.businesses.map(
            (business) => Padding(
              padding: EdgeInsets.only(bottom: BauhausDesign.space4),
              child: _buildBusinessCard(context, business, viewModel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(
    BuildContext context,
    BusinessModel business,
    BusinessListViewModel viewModel,
  ) {
    return BauhausCard(
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
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
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
                text: business.isActive ? 'Active' : 'Inactive',
                variant: business.isActive
                    ? BauhausChipVariant.success
                    : BauhausChipVariant.neutral,
                size: BauhausChipSize.small,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: BauhausDesign.space4),
            child: Divider(
              color: BauhausDesign.neutral.withOpacity(0.2),
              height: 1,
            ),
          ),
          if (business.businessPhone.isNotEmpty)
            _buildInfoRow(
                context, Icons.phone_outlined, business.businessPhone),
          if (business.businessPhone.isNotEmpty)
            SizedBox(height: BauhausDesign.space2),
          if (business.businessAddress.isNotEmpty)
            _buildInfoRow(
              context,
              Icons.location_on_outlined,
              '${business.businessAddress}, ${business.businessCity}',
            ),
          SizedBox(height: BauhausDesign.space4),
          Divider(color: BauhausDesign.neutral.withOpacity(0.2), height: 1),
          SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                child: BauhausActionButton(
                  text: 'Edit',
                  icon: Icons.edit_outlined,
                  variant: BauhausActionVariant.secondary,
                  isSmall: true,
                  onPressed: () => _showEditBusinessDialog(business, viewModel),
                ),
              ),
              SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: BauhausActionButton(
                  text: 'Delete',
                  icon: Icons.delete_outline,
                  variant: BauhausActionVariant.error,
                  isSmall: true,
                  onPressed: () => _confirmDeleteBusiness(business, viewModel),
                ),
              ),
            ],
          ),
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
