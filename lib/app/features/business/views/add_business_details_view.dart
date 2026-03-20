import 'package:carenest/app/features/business/viewmodels/add_business_viewmodel.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// View for adding business details
/// Handles UI interactions using the existing viewmodel flow.
class AddBusinessDetails extends ConsumerStatefulWidget {
  const AddBusinessDetails({super.key});

  @override
  ConsumerState<AddBusinessDetails> createState() => _AddBusinessDetailsState();
}

class _AddBusinessDetailsState extends ConsumerState<AddBusinessDetails> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'add_business_form_key');
  final _businessNameController = TextEditingController();
  final _businessEmailController = TextEditingController();
  final _businessPhoneController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _businessCityController = TextEditingController();
  final _businessStateController = TextEditingController();
  final _businessZipController = TextEditingController();

  bool _isProcessingDialogVisible = false;

  bool _isCompactLayout(BuildContext context) {
    return MediaQuery.of(context).size.width < 390;
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessEmailController.dispose();
    _businessPhoneController.dispose();
    _businessAddressController.dispose();
    _businessCityController.dispose();
    _businessStateController.dispose();
    _businessZipController.dispose();
    super.dispose();
  }

  Color _contentColorOn(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.textDark;
  }

  void _dismissProcessingDialogIfVisible() {
    if (!mounted || !_isProcessingDialogVisible) return;
    Navigator.of(context, rootNavigator: true).maybePop();
    _isProcessingDialogVisible = false;
  }

  /// Handles status changes from ViewModel and updates UI accordingly.
  void _handleStatusChange(
    BuildContext context,
    AddBusinessStatus status,
    AddBusinessViewModel viewModel,
  ) {
    if (!mounted) return;

    switch (status) {
      case AddBusinessStatus.processing:
        if (!_isProcessingDialogVisible) {
          _showProcessingDialog(context);
        }
        break;
      case AddBusinessStatus.success:
        _dismissProcessingDialogIfVisible();
        _handleSuccess(context, viewModel);
        break;
      case AddBusinessStatus.error:
        _dismissProcessingDialogIfVisible();
        _handleError(context, viewModel);
        break;
      case AddBusinessStatus.idle:
        break;
    }
  }

  /// Shows processing dialog.
  void _showProcessingDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _isProcessingDialogVisible = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
          side: const BorderSide(
            color: BauhausDesign.neutral,
            width: BauhausDesign.borderThick,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceWhite,
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                color: BauhausDesign.primary,
              ),
            ),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                l10n.addingBusinessMessage,
                style: BauhausDesign.getTextTheme(dialogContext).bodyMedium,
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      _isProcessingDialogVisible = false;
    });
  }

  /// Handles success state.
  void _handleSuccess(BuildContext context, AddBusinessViewModel viewModel) {
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            side: const BorderSide(
              color: BauhausDesign.neutral,
              width: BauhausDesign.borderThick,
            ),
          ),
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(
            l10n.success.toUpperCase(),
            style: BauhausDesign.getTextTheme(dialogContext)
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          content: Text(
            l10n.businessAddedSuccess,
            style:
                BauhausDesign.getTextTheme(dialogContext).bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
          ),
          actions: [
            BauhausActionButton(
              text: l10n.ok.toUpperCase(),
              variant: BauhausActionVariant.primary,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (mounted && Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
    viewModel.resetStatus();
  }

  /// Handles error state.
  void _handleError(BuildContext context, AddBusinessViewModel viewModel) {
    final l10n = AppLocalizations.of(context)!;
    final errorMessage = viewModel.errorMessage ?? l10n.businessAddFailed;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: BauhausDesign.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        ),
      ),
    );
    viewModel.resetStatus();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(addBusinessViewModelProvider);
    final l10n = AppLocalizations.of(context)!;
    final isCompact = _isCompactLayout(context);
    final horizontalPadding =
        isCompact ? BauhausDesign.space3 : BauhausDesign.space4;
    final sectionSpacing =
        isCompact ? BauhausDesign.space3 : BauhausDesign.space4;

    return ValueListenableBuilder<AddBusinessStatus>(
      valueListenable: viewModel.addBusinessStatus,
      builder: (context, status, _) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleStatusChange(context, status, viewModel);
        });

        final isSubmitting = status == AddBusinessStatus.processing;
        return Scaffold(
          backgroundColor: BauhausDesign.backgroundLight,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: BauhausDesign.secondary,
            foregroundColor: BauhausDesign.surfaceWhite,
            title: Text(
              l10n.addBusinessTitle.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: BauhausDesign.surfaceWhite,
                    letterSpacing: 1.0,
                  ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: BauhausDesign.neutral,
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  horizontalPadding,
                  horizontalPadding,
                  isCompact ? BauhausDesign.space6 : BauhausDesign.space8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeroCard(context, l10n, isCompact: isCompact),
                    SizedBox(height: sectionSpacing),
                    _buildBusinessInfoSection(context, l10n,
                        isCompact: isCompact),
                    SizedBox(height: sectionSpacing),
                    _buildContactInfoSection(context, l10n,
                        isCompact: isCompact),
                    SizedBox(height: sectionSpacing),
                    _buildAddressInfoSection(context, l10n,
                        isCompact: isCompact),
                    SizedBox(
                        height: isCompact
                            ? BauhausDesign.space5
                            : BauhausDesign.space6),
                    _buildActionButtons(
                      context,
                      l10n,
                      viewModel,
                      isSubmitting,
                      isCompact: isCompact,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    const heroColor = BauhausDesign.secondary;
    final foreground = _contentColorOn(heroColor);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: heroColor,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(
              isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
            ),
            child: Row(
              children: [
                Container(
                  width: isCompact ? 40 : 44,
                  height: isCompact ? 40 : 44,
                  decoration: BoxDecoration(
                    color: foreground.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                    border: Border.all(color: BauhausDesign.neutral),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.business_rounded,
                    color: foreground,
                    size: isCompact ? 22 : 24,
                  ),
                ),
                SizedBox(
                    width: isCompact
                        ? BauhausDesign.space2
                        : BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.newBusinessTitle.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .titleLarge
                            ?.copyWith(
                              color: foreground,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        l10n.addBusinessDesc,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: foreground.withOpacity(0.92),
                            ),
                        maxLines: isCompact ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal:
                  isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
              vertical: isCompact ? BauhausDesign.space2 : BauhausDesign.space3,
            ),
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                top: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Text(
              'ENTER BUSINESS DETAILS',
              style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                    color: BauhausDesign.secondary,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color accentColor,
    required List<Widget> children,
    required bool isCompact,
  }) {
    final iconForeground = _contentColorOn(accentColor);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(BauhausDesign.radiusLg - 2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: isCompact ? 32 : 36,
                      height: isCompact ? 32 : 36,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusSm),
                        border: Border.all(color: BauhausDesign.neutral),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        size: isCompact ? 16 : 18,
                        color: iconForeground,
                      ),
                    ),
                    SizedBox(
                        width: isCompact
                            ? BauhausDesign.space2
                            : BauhausDesign.space3),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:
                      isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
                ),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInfoSection(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    return _buildSectionCard(
      context,
      title: l10n.businessInformation,
      icon: Icons.business_center_outlined,
      accentColor: BauhausDesign.primary,
      isCompact: isCompact,
      children: [
        BauhausTextField(
          label: l10n.businessName.toUpperCase(),
          hintText: l10n.businessName,
          controller: _businessNameController,
          prefixIcon: const Icon(Icons.business_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.businessNameRequired;
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    return _buildSectionCard(
      context,
      title: l10n.contactInformation,
      icon: Icons.contact_mail_outlined,
      accentColor: BauhausDesign.secondary,
      isCompact: isCompact,
      children: [
        BauhausTextField(
          label: l10n.businessEmail.toUpperCase(),
          hintText: l10n.businessEmail,
          keyboardType: TextInputType.emailAddress,
          controller: _businessEmailController,
          prefixIcon: const Icon(Icons.email_outlined, size: 20),
          validator: (value) {
            final email = (value ?? '').trim();
            if (email.isEmpty) return l10n.businessEmailRequired;
            if (!RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
              return l10n.emailInvalid;
            }
            return null;
          },
        ),
        SizedBox(
          height: isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
        ),
        BauhausTextField(
          label: l10n.businessPhone.toUpperCase(),
          hintText: l10n.businessPhone,
          keyboardType: TextInputType.phone,
          controller: _businessPhoneController,
          prefixIcon: const Icon(Icons.phone_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.businessPhoneRequired;
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAddressInfoSection(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    return _buildSectionCard(
      context,
      title: l10n.addressInformation,
      icon: Icons.location_on_outlined,
      accentColor: BauhausDesign.accent,
      isCompact: isCompact,
      children: [
        BauhausTextField(
          label: l10n.addressLine1.toUpperCase(),
          hintText: l10n.businessAddress,
          controller: _businessAddressController,
          prefixIcon: const Icon(Icons.home_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return l10n.businessAddressRequired;
            }
            return null;
          },
        ),
        SizedBox(
          height: isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
        ),
        if (isCompact)
          Column(
            children: [
              BauhausTextField(
                label: l10n.city.toUpperCase(),
                hintText: l10n.city,
                controller: _businessCityController,
                prefixIcon: const Icon(Icons.location_city_outlined, size: 20),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) return l10n.cityRequired;
                  return null;
                },
              ),
              const SizedBox(height: BauhausDesign.space3),
              BauhausTextField(
                label: l10n.state.toUpperCase(),
                hintText: l10n.state,
                controller: _businessStateController,
                prefixIcon: const Icon(Icons.map_outlined, size: 20),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) return l10n.stateRequired;
                  return null;
                },
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                flex: 7,
                child: BauhausTextField(
                  label: l10n.city.toUpperCase(),
                  hintText: l10n.city,
                  controller: _businessCityController,
                  prefixIcon:
                      const Icon(Icons.location_city_outlined, size: 20),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) return l10n.cityRequired;
                    return null;
                  },
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                flex: 8,
                child: BauhausTextField(
                  label: l10n.state.toUpperCase(),
                  hintText: l10n.state,
                  controller: _businessStateController,
                  prefixIcon: const Icon(Icons.map_outlined, size: 20),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) return l10n.stateRequired;
                    return null;
                  },
                ),
              ),
            ],
          ),
        SizedBox(
          height: isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
        ),
        BauhausTextField(
          label: l10n.postcodeLabel.toUpperCase(),
          hintText: l10n.zipCodeHint,
          keyboardType: TextInputType.number,
          controller: _businessZipController,
          prefixIcon: const Icon(Icons.code_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.zipCodeRequired;
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n,
    AddBusinessViewModel viewModel,
    bool isSubmitting, {
    required bool isCompact,
  }) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BauhausActionButton(
            text: l10n.addBusinessButton.toUpperCase(),
            variant: BauhausActionVariant.primary,
            icon: Icons.check_rounded,
            isLoading: isSubmitting,
            onPressed: isSubmitting
                ? null
                : () => _handleSubmit(context, viewModel, l10n),
            isFullWidth: true,
          ),
          const SizedBox(height: BauhausDesign.space3),
          BauhausActionButton(
            text: l10n.cancelButton.toUpperCase(),
            isOutlined: true,
            onPressed: isSubmitting ? null : () => Navigator.of(context).pop(),
            isFullWidth: true,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: BauhausActionButton(
            text: l10n.cancelButton.toUpperCase(),
            isOutlined: true,
            onPressed: isSubmitting ? null : () => Navigator.of(context).pop(),
            isFullWidth: true,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: BauhausActionButton(
            text: l10n.addBusinessButton.toUpperCase(),
            variant: BauhausActionVariant.primary,
            icon: Icons.check_rounded,
            isLoading: isSubmitting,
            onPressed: isSubmitting
                ? null
                : () => _handleSubmit(context, viewModel, l10n),
            isFullWidth: true,
          ),
        ),
      ],
    );
  }

  /// Handles form submission with validation and confirmation.
  void _handleSubmit(
    BuildContext context,
    AddBusinessViewModel viewModel,
    AppLocalizations l10n,
  ) {
    if (_formKey.currentState!.validate()) {
      _showConfirmationDialog(context, viewModel, l10n);
    }
  }

  /// Shows confirmation dialog before submitting.
  void _showConfirmationDialog(
    BuildContext context,
    AddBusinessViewModel viewModel,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
            side: const BorderSide(
              color: BauhausDesign.neutral,
              width: BauhausDesign.borderThick,
            ),
          ),
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(
            l10n.addBusinessTitle.toUpperCase(),
            style: BauhausDesign.getTextTheme(dialogContext)
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          content: Text(
            l10n.confirmAddBusiness,
            style: BauhausDesign.getTextTheme(dialogContext).bodyMedium,
          ),
          actions: [
            BauhausActionButton(
              text: l10n.cancelButton.toUpperCase(),
              variant: BauhausActionVariant.ghost,
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            BauhausActionButton(
              text: l10n.addBusinessButton.toUpperCase(),
              variant: BauhausActionVariant.primary,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _submitBusinessData(viewModel);
              },
            ),
          ],
        );
      },
    );
  }

  /// Submits business data to ViewModel.
  void _submitBusinessData(AddBusinessViewModel viewModel) {
    final businessData = {
      'businessName': _businessNameController.text.trim(),
      'businessEmail': _businessEmailController.text.trim(),
      'businessPhone': _businessPhoneController.text.trim(),
      'businessAddress': _businessAddressController.text.trim(),
      'businessCity': _businessCityController.text.trim(),
      'businessState': _businessStateController.text.trim(),
      'businessZip': _businessZipController.text.trim(),
    };
    viewModel.addBusiness(businessData);
  }
}
