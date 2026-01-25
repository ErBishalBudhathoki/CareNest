import 'package:carenest/app/features/business/viewmodels/add_business_viewmodel.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/popup_client_details.dart';
import 'package:carenest/app/shared/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

/// View for adding business details
/// Handles all UI logic and user interactions following MVVM pattern

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
  final ValueNotifier<bool> textVisibleNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessEmailController.dispose();
    _businessPhoneController.dispose();
    _businessAddressController.dispose();
    _businessCityController.dispose();
    _businessStateController.dispose();
    _businessZipController.dispose();
    textVisibleNotifier.dispose();
    super.dispose();
  }

  /// Handles status changes from ViewModel and updates UI accordingly
  void _handleStatusChange(BuildContext context, AddBusinessStatus status,
      AddBusinessViewModel viewModel) {
    // Check if widget is still mounted before handling status changes
    if (!mounted) return;

    switch (status) {
      case AddBusinessStatus.success:
        // Close any open dialog if possible
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        _handleSuccess(context, viewModel);
        break;
      case AddBusinessStatus.error:
        // Close any open dialog if possible
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop();
        }
        _handleError(context, viewModel);
        break;
      case AddBusinessStatus.idle:
        // Do nothing for idle state
        break;
      case AddBusinessStatus.processing:
        // TODO: Handle this case.
        break;
    }
  }

  /// Shows processing dialog
  void _showProcessingDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceWhite,
        content: Row(
          children: [
            CircularProgressIndicator(color: BauhausDesign.primary),
            SizedBox(width: BauhausDesign.space4),
            Text(l10n.addingBusinessMessage,
                style: BauhausDesign.getTextTheme(context).bodyMedium),
          ],
        ),
      ),
    );
  }

  /// Handles success state
  void _handleSuccess(BuildContext context, AddBusinessViewModel viewModel) {
    // Check if context is still mounted before showing dialog
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;

    // Show success dialog first, then navigate back when user clicks OK
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(l10n.success,
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      )),
          content: Text(
            l10n.businessAddedSuccess,
            style: BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                  height: 1.5,
                  fontWeight: FontWeight.w800,
                ),
          ),
          actions: [
            BauhausActionButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog
                // Check if the original context is still valid before navigating
                if (mounted && Navigator.canPop(context)) {
                  Navigator.of(context).pop(); // Go back to previous screen
                }
              },
              text: l10n.ok,
              variant: BauhausActionVariant.primary,
            )
          ],
        );
      },
    );
    viewModel.resetStatus();
  }

  /// Handles error state
  void _handleError(BuildContext context, AddBusinessViewModel viewModel) {
    final l10n = AppLocalizations.of(context)!;
    Navigator.of(context, rootNavigator: true).maybePop();
    final errorMessage = viewModel.errorMessage ?? l10n.businessAddFailed;
    popUpClientDetails(context, "error", "Business");
    viewModel.resetStatus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final viewModel = ref.watch(addBusinessViewModelProvider);
    final l10n = AppLocalizations.of(context)!;
    return ValueListenableBuilder<AddBusinessStatus>(
      valueListenable: viewModel.addBusinessStatus,
      builder: (context, status, _) {
        // Handle status changes with proper UI responses
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleStatusChange(context, status, viewModel);
        });
        return Scaffold(
          backgroundColor: BauhausDesign.backgroundLight,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: BauhausDesign.surfaceWhite,
            surfaceTintColor: Colors.transparent,
            foregroundColor: BauhausDesign.textDark,
            iconTheme: IconThemeData(
              color: BauhausDesign.textDark,
            ),
            title: Text(
              l10n.addBusinessTitle,
              style:
                  BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: BauhausDesign.textDark,
                      ),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(BauhausDesign.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  BauhausCard(
                    padding: EdgeInsets.all(BauhausDesign.space6),
                    child: Column(
                      children: [
                        Icon(
                          Icons.business_rounded,
                          size: 48,
                          color: BauhausDesign.primary,
                        ),
                        SizedBox(height: BauhausDesign.space3),
                        Text(
                          l10n.newBusinessTitle,
                          style: BauhausDesign.getTextTheme(context)
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: BauhausDesign.primary,
                              ),
                        ),
                        SizedBox(height: BauhausDesign.space2),
                        Text(
                          l10n.addBusinessDesc,
                          style: BauhausDesign.getTextTheme(context)
                              .bodyMedium
                              ?.copyWith(
                                color: BauhausDesign.textMuted,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: BauhausDesign.space8),
                  _buildSectionHeader(context, l10n.businessInformation,
                      Icons.business_rounded),
                  SizedBox(height: BauhausDesign.space4),
                  _buildBusinessInfoSection(context, theme, l10n),
                  SizedBox(height: BauhausDesign.space8),
                  _buildSectionHeader(context, l10n.contactInformation,
                      Icons.contact_mail_rounded),
                  SizedBox(height: BauhausDesign.space4),
                  _buildContactInfoSection(context, theme, l10n),
                  SizedBox(height: BauhausDesign.space8),
                  _buildSectionHeader(context, l10n.addressInformation,
                      Icons.location_on_rounded),
                  SizedBox(height: BauhausDesign.space4),
                  _buildAddressInfoSection(context, theme, l10n),
                  SizedBox(height: BauhausDesign.space10),
                  _buildSubmitButton(viewModel, theme, context, l10n),
                  SizedBox(height: BauhausDesign.space6),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(BauhausDesign.space2),
          decoration: BoxDecoration(
            color: BauhausDesign.primary,
            borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          ),
          child: Icon(
            icon,
            size: 20,
            color: BauhausDesign.surfaceWhite,
          ),
        ),
        SizedBox(width: BauhausDesign.space3),
        Text(
          title,
          style: BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }

  Widget _buildBusinessInfoSection(
      BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.businessName,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.businessNameRequired;
              }
              return null;
            },
            prefixIconData: Icons.business_outlined,
            suffixIconData: null,
            controller: _businessNameController,
            onChanged: (value) {},
            onSaved: (value) {
              _businessNameController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection(
      BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.businessEmail,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.businessEmailRequired;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return l10n.emailInvalid;
              }
              return null;
            },
            prefixIconData: Icons.email_outlined,
            suffixIconData: null,
            controller: _businessEmailController,
            onChanged: (value) {},
            onSaved: (value) {
              _businessEmailController.text = value!;
            },
          ),
          SizedBox(height: BauhausDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.businessPhone,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.businessPhoneRequired;
              }
              return null;
            },
            prefixIconData: Icons.phone_outlined,
            suffixIconData: null,
            controller: _businessPhoneController,
            onChanged: (value) {},
            onSaved: (value) {
              _businessPhoneController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInfoSection(
      BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.businessAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.businessAddressRequired;
              }
              return null;
            },
            prefixIconData: Icons.home_outlined,
            suffixIconData: null,
            controller: _businessAddressController,
            onChanged: (value) {},
            onSaved: (value) {
              _businessAddressController.text = value!;
            },
          ),
          SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFieldWidget(
                  suffixIconClickable: false,
                  obscureTextNotifier: textVisibleNotifier,
                  hintText: l10n.city,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.cityRequired;
                    }
                    return null;
                  },
                  prefixIconData: Icons.location_city_outlined,
                  suffixIconData: null,
                  controller: _businessCityController,
                  onChanged: (value) {},
                  onSaved: (value) {
                    _businessCityController.text = value!;
                  },
                ),
              ),
              SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: TextFieldWidget(
                  suffixIconClickable: false,
                  obscureTextNotifier: textVisibleNotifier,
                  hintText: l10n.state,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return l10n.stateRequired;
                    }
                    return null;
                  },
                  prefixIconData: Icons.map_outlined,
                  suffixIconData: null,
                  controller: _businessStateController,
                  onChanged: (value) {},
                  onSaved: (value) {
                    _businessStateController.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: BauhausDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.zipCodeHint,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.zipCodeRequired;
              }
              return null;
            },
            prefixIconData: Icons.code_outlined,
            suffixIconData: null,
            controller: _businessZipController,
            onChanged: (value) {},
            onSaved: (value) {
              _businessZipController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(AddBusinessViewModel viewModel, ThemeData theme,
      BuildContext context, AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      child: BauhausActionButton(
        text: l10n.addBusinessButton,
        variant: BauhausActionVariant.primary,
        onPressed: () => _handleSubmit(context, viewModel, l10n),
      ),
    );
  }

  /// Handles form submission with validation and confirmation
  void _handleSubmit(BuildContext context, AddBusinessViewModel viewModel,
      AppLocalizations l10n) {
    if (_formKey.currentState!.validate()) {
      _showConfirmationDialog(context, viewModel, l10n);
    }
  }

  /// Shows confirmation dialog before submitting
  void _showConfirmationDialog(BuildContext context,
      AddBusinessViewModel viewModel, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BauhausDesign.surfaceWhite,
          title: Text(l10n.addBusinessTitle,
              style: BauhausDesign.getTextTheme(context).headlineSmall),
          content: Text(l10n.confirmAddBusiness,
              style: BauhausDesign.getTextTheme(context).bodyMedium),
          actions: [
            BauhausActionButton(
              onPressed: () => Navigator.of(context).pop(),
              text: l10n.cancelButton,
              variant: BauhausActionVariant.ghost,
            ),
            BauhausActionButton(
              onPressed: () {
                Navigator.of(context).pop();
                _submitBusinessData(viewModel);
              },
              text: l10n.addBusinessButton,
              variant: BauhausActionVariant.primary,
            ),
          ],
        );
      },
    );
  }

  /// Submits business data to ViewModel
  void _submitBusinessData(AddBusinessViewModel viewModel) {
    final businessData = {
      'businessName': _businessNameController.text,
      'businessEmail': _businessEmailController.text,
      'businessPhone': _businessPhoneController.text,
      'businessAddress': _businessAddressController.text,
      'businessCity': _businessCityController.text,
      'businessState': _businessStateController.text,
      'businessZip': _businessZipController.text,
    };
    viewModel.addBusiness(businessData);
  }
}
