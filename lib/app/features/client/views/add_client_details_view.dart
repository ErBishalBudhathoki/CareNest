import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/business_name_dropdown_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class AddClientDetails extends ConsumerStatefulWidget {
  const AddClientDetails({super.key});

  @override
  ConsumerState<AddClientDetails> createState() => _AddClientDetailsState();
}

class _AddClientDetailsState extends ConsumerState<AddClientDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(
    debugLabel: 'add_client_details_scaffold_key',
  );
  final _formKey = GlobalKey<FormState>(
    debugLabel: 'add_client_details_form_key',
  );

  final _clientFirstNameController = TextEditingController();
  final _clientLastNameController = TextEditingController();
  final _clientEmailController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final _clientAddressController = TextEditingController();
  final _clientCityController = TextEditingController();
  final _clientStateController = TextEditingController();
  final _clientZipController = TextEditingController();
  final _clientBusinessNameController = TextEditingController();

  bool _isSubmitting = false;

  bool _isCompactLayout(BuildContext context) {
    return MediaQuery.of(context).size.width < 390;
  }

  @override
  void dispose() {
    _clientFirstNameController.dispose();
    _clientLastNameController.dispose();
    _clientEmailController.dispose();
    _clientPhoneController.dispose();
    _clientAddressController.dispose();
    _clientCityController.dispose();
    _clientStateController.dispose();
    _clientZipController.dispose();
    _clientBusinessNameController.dispose();
    super.dispose();
  }

  Color _contentColorOn(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? BauhausDesign.surfaceWhite
        : BauhausDesign.textDark;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isCompact = _isCompactLayout(context);
    final horizontalPadding = isCompact
        ? BauhausDesign.space3
        : BauhausDesign.space4;
    final sectionSpacing = isCompact
        ? BauhausDesign.space3
        : BauhausDesign.space4;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.secondary,
        foregroundColor: BauhausDesign.surfaceWhite,
        title: Text(
          l10n.addClient.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: BauhausDesign.surfaceWhite,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: BauhausDesign.neutral),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                _buildPersonalInfoSection(context, l10n, isCompact: isCompact),
                SizedBox(height: sectionSpacing),
                _buildContactInfoSection(context, l10n, isCompact: isCompact),
                SizedBox(height: sectionSpacing),
                _buildAddressInfoSection(context, l10n, isCompact: isCompact),
                SizedBox(height: sectionSpacing),
                _buildBusinessInfoSection(context, l10n, isCompact: isCompact),
                SizedBox(
                  height: isCompact
                      ? BauhausDesign.space5
                      : BauhausDesign.space6,
                ),
                _buildActionButtons(context, l10n, isCompact: isCompact),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    const heroColor = BauhausDesign.primary;
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
                    Icons.person_add_rounded,
                    color: foreground,
                    size: isCompact ? 22 : 24,
                  ),
                ),
                SizedBox(
                  width: isCompact
                      ? BauhausDesign.space2
                      : BauhausDesign.space3,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.newClientTitle.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).titleLarge
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
                        l10n.addClientDesc,
                        style: BauhausDesign.getTextTheme(context).bodySmall
                            ?.copyWith(color: foreground.withOpacity(0.92)),
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
              horizontal: isCompact
                  ? BauhausDesign.space3
                  : BauhausDesign.space4,
              vertical: isCompact ? BauhausDesign.space2 : BauhausDesign.space3,
            ),
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                top: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Text(
              'ENTER CLIENT DETAILS',
              style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                color: BauhausDesign.primary,
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
                        borderRadius: BorderRadius.circular(
                          BauhausDesign.radiusSm,
                        ),
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
                          : BauhausDesign.space3,
                    ),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context).labelLarge
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
                  height: isCompact
                      ? BauhausDesign.space3
                      : BauhausDesign.space4,
                ),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    return _buildSectionCard(
      context,
      title: l10n.personalInfoSection,
      icon: Icons.person_outline_rounded,
      accentColor: BauhausDesign.primary,
      isCompact: isCompact,
      children: [
        BauhausTextField(
          label: l10n.firstNameHint.toUpperCase(),
          hintText: l10n.firstNameHint,
          controller: _clientFirstNameController,
          prefixIcon: const Icon(Icons.person_outline, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.firstNameRequired;
            return null;
          },
        ),
        SizedBox(
          height: isCompact ? BauhausDesign.space3 : BauhausDesign.space4,
        ),
        BauhausTextField(
          label: l10n.lastNameHint.toUpperCase(),
          hintText: l10n.lastNameHint,
          controller: _clientLastNameController,
          prefixIcon: const Icon(Icons.badge_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.lastNameRequired;
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
          label: l10n.emailAddressLabel.toUpperCase(),
          hintText: l10n.emailAddress,
          keyboardType: TextInputType.emailAddress,
          controller: _clientEmailController,
          prefixIcon: const Icon(Icons.email_outlined, size: 20),
          validator: (value) {
            final email = (value ?? '').trim();
            if (email.isEmpty) return l10n.emailRequired;
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
          label: l10n.phoneNumber.toUpperCase(),
          hintText: l10n.phoneNumber,
          keyboardType: TextInputType.phone,
          controller: _clientPhoneController,
          prefixIcon: const Icon(Icons.phone_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.phoneRequired;
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
          hintText: l10n.streetAddressHint,
          controller: _clientAddressController,
          prefixIcon: const Icon(Icons.home_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) {
              return l10n.streetAddressRequired;
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
                controller: _clientCityController,
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
                controller: _clientStateController,
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
                  controller: _clientCityController,
                  prefixIcon: const Icon(
                    Icons.location_city_outlined,
                    size: 20,
                  ),
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
                  controller: _clientStateController,
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
          controller: _clientZipController,
          prefixIcon: const Icon(Icons.pin_drop_outlined, size: 20),
          validator: (value) {
            if ((value ?? '').trim().isEmpty) return l10n.zipCodeRequired;
            return null;
          },
        ),
      ],
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
      icon: Icons.business_outlined,
      accentColor: BauhausDesign.info,
      isCompact: isCompact,
      children: [
        Text(
          l10n.businessName.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        BusinessNameDropdown(
          organizationId: ref.read(organizationIdProvider),
          onChanged: (selectedValue) {
            _clientBusinessNameController.text = selectedValue;
            debugPrint('Selected Business Name: $selectedValue');
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n, {
    required bool isCompact,
  }) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BauhausActionButton(
            text: l10n.addClientButton.toUpperCase(),
            variant: BauhausActionVariant.primary,
            icon: Icons.check_rounded,
            isLoading: _isSubmitting,
            onPressed: _isSubmitting
                ? null
                : () => _showConfirmationDialog(context),
            isFullWidth: true,
          ),
          const SizedBox(height: BauhausDesign.space3),
          BauhausActionButton(
            text: l10n.cancelButton.toUpperCase(),
            isOutlined: true,
            onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
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
            onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
            isFullWidth: true,
          ),
        ),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: BauhausActionButton(
            text: l10n.addClientButton.toUpperCase(),
            variant: BauhausActionVariant.primary,
            icon: Icons.check_rounded,
            isLoading: _isSubmitting,
            onPressed: _isSubmitting
                ? null
                : () => _showConfirmationDialog(context),
            isFullWidth: true,
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(BuildContext context) {
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
            l10n.addClient.toUpperCase(),
            style: BauhausDesign.getTextTheme(
              dialogContext,
            ).headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          content: Text(
            l10n.confirmAddClient,
            style: BauhausDesign.getTextTheme(dialogContext).bodyMedium,
          ),
          actions: [
            BauhausActionButton(
              text: l10n.cancelButton.toUpperCase(),
              semanticsLabel: 'Cancel Add Client Dialog',
              variant: BauhausActionVariant.ghost,
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            BauhausActionButton(
              text: l10n.confirmButton.toUpperCase(),
              semanticsLabel: 'Confirm Add Client Dialog',
              variant: BauhausActionVariant.primary,
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _addClient();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addClient() async {
    if (_isSubmitting) return;
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final sharedPreferencesUtils = ref.read(sharedPreferencesProvider);
      await sharedPreferencesUtils.init();

      final String? currentUserEmail = await sharedPreferencesUtils
          .getUserEmailFromSharedPreferences();
      final String? currentOrganizationId = sharedPreferencesUtils
          .getOrganizationId();

      final response = await apiMethod.addClient(
        _clientFirstNameController.text.trim(),
        _clientLastNameController.text.trim(),
        _clientEmailController.text.trim(),
        _clientPhoneController.text.trim(),
        _clientAddressController.text.trim(),
        _clientCityController.text.trim(),
        _clientStateController.text.trim(),
        _clientZipController.text.trim(),
        _clientBusinessNameController.text.trim(),
        userEmail: currentUserEmail,
        organizationId: currentOrganizationId,
      );
      debugPrint('Add client response: $response');

      final isSuccess =
          response['success'] == true ||
          response['statusCode'] == 200 ||
          response['statusCode'] == 201 ||
          (response['message']?.toString().toLowerCase().contains('success') ??
              false);

      if (!mounted) return;

      if (isSuccess) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.clientAddedSuccess),
            backgroundColor: BauhausDesign.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            ),
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['message']?.toString() ?? l10n.clientAddFailed,
            ),
            backgroundColor: BauhausDesign.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            ),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error adding client: $e');
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.errorGenericMessage),
          backgroundColor: BauhausDesign.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
