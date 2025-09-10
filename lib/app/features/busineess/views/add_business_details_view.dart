import 'package:carenest/app/features/busineess/models/addBusiness_detail_model.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/shared/widgets/textField_widget.dart';
import 'package:carenest/app/shared/widgets/popupClientDetails.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/busineess/viewmodels/add_business_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            SizedBox(width: ModernSaasDesign.space4),
            const Text('Adding business...'),
          ],
        ),
      ),
    );
  }

  /// Handles success state
  void _handleSuccess(BuildContext context, AddBusinessViewModel viewModel) {
    // Check if context is still mounted before showing dialog
    if (!mounted) return;

    // Show success dialog first, then navigate back when user clicks OK
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Success",
              style: ModernSaasDesign.headlineSmall.copyWith(
                fontWeight: FontWeight.w800,
              )),
          content: Text(
            'Business details added successfully',
            style: ModernSaasDesign.bodyLarge.copyWith(
              height: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ModernSaasDesign.primary,
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close dialog
                  // Check if the original context is still valid before navigating
                  if (mounted && Navigator.canPop(context)) {
                    Navigator.of(context).pop(); // Go back to previous screen
                  }
                },
                child: Text('OK',
                    style: ModernSaasDesign.bodyMedium.copyWith(
                      color: ModernSaasDesign.textOnPrimary,
                    )))
          ],
        );
      },
    );
    viewModel.resetStatus();
  }

  /// Handles error state
  void _handleError(BuildContext context, AddBusinessViewModel viewModel) {
    Navigator.of(context, rootNavigator: true).maybePop();
    final errorMessage =
        viewModel.errorMessage ?? 'Failed to add business. Please try again.';
    popUpClientDetails(context, "error", "Business");
    viewModel.resetStatus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final viewModel = ref.watch(addBusinessViewModelProvider);
    return ValueListenableBuilder<AddBusinessStatus>(
      valueListenable: viewModel.addBusinessStatus,
      builder: (context, status, _) {
        // Handle status changes with proper UI responses
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleStatusChange(context, status, viewModel);
        });
        return Scaffold(
          backgroundColor: ModernSaasDesign.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ModernSaasDesign.surface,
            surfaceTintColor: ModernSaasDesign.surfaceTintColor,
            foregroundColor: ModernSaasDesign.textPrimary,
            iconTheme: IconThemeData(
              color: ModernSaasDesign.textPrimary,
            ),
            title: Text(
              'Add Business',
              style: ModernSaasDesign.headlineSmall.copyWith(
                fontWeight: FontWeight.w600,
                color: ModernSaasDesign.textPrimary,
              ),
            ),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ModernSaasDesign.space6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ModernSaasDesign.space6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ModernSaasDesign.primary.withValues(alpha: 0.1),
                          ModernSaasDesign.primary.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(ModernSaasDesign.radius2xl),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.business_rounded,
                          size: 48,
                          color: ModernSaasDesign.primary,
                        ),
                        SizedBox(height: ModernSaasDesign.space3),
                        Text(
                          'New Business',
                          style: ModernSaasDesign.headlineSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ModernSaasDesign.textPrimary,
                          ),
                        ),
                        SizedBox(height: ModernSaasDesign.space2),
                        Text(
                          'Add business information to get started',
                          style: ModernSaasDesign.bodyMedium.copyWith(
                            color: ModernSaasDesign.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ModernSaasDesign.space8),
                  _buildSectionHeader(
                      'Business Information', Icons.business_rounded, theme),
                  SizedBox(height: ModernSaasDesign.space4),
                  _buildBusinessInfoSection(theme),
                  SizedBox(height: ModernSaasDesign.space8),
                  _buildSectionHeader(
                      'Contact Information', Icons.contact_mail_rounded, theme),
                  SizedBox(height: ModernSaasDesign.space4),
                  _buildContactInfoSection(theme),
                  SizedBox(height: ModernSaasDesign.space8),
                  _buildSectionHeader(
                      'Address Information', Icons.location_on_rounded, theme),
                  SizedBox(height: ModernSaasDesign.space4),
                  _buildAddressInfoSection(theme),
                  SizedBox(height: ModernSaasDesign.space10),
                  _buildSubmitButton(viewModel, theme, context),
                  SizedBox(height: ModernSaasDesign.space6),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, ThemeData theme) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(ModernSaasDesign.space2),
          decoration: BoxDecoration(
            color: ModernSaasDesign.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
          ),
          child: Icon(
            icon,
            size: 20,
            color: ModernSaasDesign.primary,
          ),
        ),
        SizedBox(width: ModernSaasDesign.space3),
        Text(
          title,
          style: ModernSaasDesign.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
            color: ModernSaasDesign.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessInfoSection(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.neutral200,
        ),
      ),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Business Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter business name';
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

  Widget _buildContactInfoSection(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.neutral200,
        ),
      ),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Business Email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter business email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
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
          SizedBox(height: ModernSaasDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Business Phone',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter business phone';
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

  Widget _buildAddressInfoSection(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surface,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.neutral200,
        ),
      ),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Business Address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter business address';
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
          SizedBox(height: ModernSaasDesign.space4),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFieldWidget(
                  suffixIconClickable: false,
                  obscureTextNotifier: textVisibleNotifier,
                  hintText: 'City',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter city';
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
              SizedBox(width: ModernSaasDesign.space3),
              Expanded(
                child: TextFieldWidget(
                  suffixIconClickable: false,
                  obscureTextNotifier: textVisibleNotifier,
                  hintText: 'State',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter state';
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
          SizedBox(height: ModernSaasDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Zip Code',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter zip code';
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

  Widget _buildSubmitButton(
      AddBusinessViewModel viewModel, ThemeData theme, BuildContext context) {
    return Container(
      width: double.infinity,
      height: ModernSaasDesign.space12 + ModernSaasDesign.space2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        gradient: LinearGradient(
          colors: [
            ModernSaasDesign.primary,
            ModernSaasDesign.primary.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: ModernSaasDesign.primary.withValues(alpha: 0.3),
            blurRadius: ModernSaasDesign.space2,
            offset: const Offset(0, ModernSaasDesign.space1),
          ),
        ],
      ),
      child: ButtonWidget(
        buttonText: 'Add Business',
        buttonColor: ModernSaasDesign.primary,
        textColor: ModernSaasDesign.surface,
        onPressed: () => _handleSubmit(context, viewModel),
      ),
    );
  }

  /// Handles form submission with validation and confirmation
  void _handleSubmit(BuildContext context, AddBusinessViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      _showConfirmationDialog(context, viewModel);
    }
  }

  /// Shows confirmation dialog before submitting
  void _showConfirmationDialog(
      BuildContext context, AddBusinessViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Business'),
          content: const Text('Are you sure you want to add this business?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _submitBusinessData(viewModel);
              },
              child: const Text('Add Business'),
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
