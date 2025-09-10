import 'dart:async';

import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/widgets/alertDialog_widget.dart';
import 'package:carenest/app/shared/widgets/businessNameDropDown_widget.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/shared/widgets/textField_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/features/client/models/addClient_detail_model.dart';
import 'package:carenest/app/shared/widgets/popupClientDetails.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';

class AddClientDetails extends ConsumerStatefulWidget {
  const AddClientDetails({super.key});

  @override
  ConsumerState<AddClientDetails> createState() => _AddClientDetailsState();
}

class _AddClientDetailsState extends ConsumerState<AddClientDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'add_client_details_scaffold_key');
  final _formKey =
      GlobalKey<FormState>(debugLabel: 'add_client_details_form_key');
  final _clientFirstNameController = TextEditingController();
  final _clientLastNameController = TextEditingController();
  final _clientEmailController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final _clientAddressController = TextEditingController();
  final _clientCityController = TextEditingController();
  final _clientStateController = TextEditingController();
  final _clientZipController = TextEditingController();
  final _clientBusinessNameController = TextEditingController();
  late String selectedBusinessName;
  List businessNameList = [];

  @override
  void initState() {
    super.initState();
    // apiMethod.getBusinessNameList();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textVisibleNotifier = ValueNotifier<bool>(false);
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ModernSaasDesign.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ModernSaasDesign.surface,
        foregroundColor: ModernSaasDesign.textPrimary,
        iconTheme: IconThemeData(
          color: ModernSaasDesign.textPrimary,
        ),
        title: Text(
          'Add Client',
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
                      Icons.person_add_rounded,
                      size: 48,
                      color: ModernSaasDesign.primary,
                    ),
                    SizedBox(height: ModernSaasDesign.space3),
                    Text(
                      'New Client',
                      style: ModernSaasDesign.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ModernSaasDesign.textPrimary,
                      ),
                    ),
                    SizedBox(height: ModernSaasDesign.space2),
                    Text(
                      'Add client information to get started',
                      style: ModernSaasDesign.bodyMedium.copyWith(
                        color: ModernSaasDesign.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: ModernSaasDesign.space8),

              // Personal Information Section
              _buildSectionHeader(
                  'Personal Information', Icons.person_rounded, theme),
              SizedBox(height: ModernSaasDesign.space4),
              _buildPersonalInfoSection(textVisibleNotifier, size),
              SizedBox(height: ModernSaasDesign.space8),

              // Contact Information Section
              _buildSectionHeader(
                  'Contact Information', Icons.contact_mail_rounded, theme),
              SizedBox(height: ModernSaasDesign.space4),
              _buildContactInfoSection(textVisibleNotifier, size),
              SizedBox(height: ModernSaasDesign.space8),

              // Address Information Section
              _buildSectionHeader(
                  'Address Information', Icons.location_on_rounded, theme),
              SizedBox(height: ModernSaasDesign.space4),
              _buildAddressInfoSection(textVisibleNotifier, size),
              SizedBox(height: ModernSaasDesign.space8),

              // Business Information Section
              _buildSectionHeader(
                  'Business Information', Icons.business_rounded, theme),
              SizedBox(height: ModernSaasDesign.space4),
              _buildBusinessInfoSection(),
              SizedBox(height: ModernSaasDesign.space10),

              // Submit Button
              _buildSubmitButton(theme),
              SizedBox(height: ModernSaasDesign.space6),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a section header with icon and title
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
          style: ModernSaasDesign.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: ModernSaasDesign.textPrimary,
          ),
        ),
      ],
    );
  }

  /// Builds the personal information section
  Widget _buildPersonalInfoSection(
      ValueNotifier<bool> textVisibleNotifier, Size size) {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surfaceVariant,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.border,
        ),
      ),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'First Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter first name';
              }
              return null;
            },
            prefixIconData: Icons.person_outline,
            suffixIconData: null,
            controller: _clientFirstNameController,
            onChanged: (value) {},
            onSaved: (value) {
              _clientFirstNameController.text = value!;
            },
          ),
          SizedBox(height: ModernSaasDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Last Name',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter last name';
              }
              return null;
            },
            prefixIconData: Icons.person_outline,
            suffixIconData: null,
            controller: _clientLastNameController,
            onChanged: (value) {},
            onSaved: (value) {
              _clientLastNameController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  /// Builds the contact information section
  Widget _buildContactInfoSection(
      ValueNotifier<bool> textVisibleNotifier, Size size) {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surfaceVariant,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.border,
        ),
      ),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Email Address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            prefixIconData: Icons.email_outlined,
            suffixIconData: null,
            controller: _clientEmailController,
            onChanged: (value) {},
            onSaved: (value) {
              _clientEmailController.text = value!;
            },
          ),
          SizedBox(height: ModernSaasDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Phone Number',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
            prefixIconData: Icons.phone_outlined,
            suffixIconData: null,
            controller: _clientPhoneController,
            onChanged: (value) {},
            onSaved: (value) {
              _clientPhoneController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  /// Builds the address information section
  Widget _buildAddressInfoSection(
      ValueNotifier<bool> textVisibleNotifier, Size size) {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surfaceVariant,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.border,
        ),
      ),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'Street Address',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter street address';
              }
              return null;
            },
            prefixIconData: Icons.home_outlined,
            suffixIconData: null,
            controller: _clientAddressController,
            onChanged: (value) {},
            onSaved: (value) {
              _clientAddressController.text = value!;
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
                  controller: _clientCityController,
                  onChanged: (value) {},
                  onSaved: (value) {
                    _clientCityController.text = value!;
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
                  controller: _clientStateController,
                  onChanged: (value) {},
                  onSaved: (value) {
                    _clientStateController.text = value!;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: ModernSaasDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: 'ZIP Code',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter ZIP code';
              }
              return null;
            },
            prefixIconData: Icons.pin_drop_outlined,
            suffixIconData: null,
            controller: _clientZipController,
            onChanged: (value) {},
            onSaved: (value) {
              _clientZipController.text = value!;
            },
          ),
        ],
      ),
    );
  }

  /// Builds the business information section
  Widget _buildBusinessInfoSection() {
    return Container(
      padding: EdgeInsets.all(ModernSaasDesign.space5),
      decoration: BoxDecoration(
        color: ModernSaasDesign.surfaceVariant,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
        border: Border.all(
          color: ModernSaasDesign.border,
        ),
      ),
      child: BusinessNameDropdown(
        onChanged: (selectedValue) {
          _clientBusinessNameController.text = selectedValue;
          debugPrint('Selected Business Name: $selectedValue');
        },
      ),
    );
  }

  /// Builds the submit button with modern styling
  Widget _buildSubmitButton(ThemeData theme) {
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
        buttonText: 'Add Client',
        buttonColor: ModernSaasDesign.primary,
        textColor: ModernSaasDesign.surface,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add Client'),
                  content:
                      const Text('Are you sure you want to add this client?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await _addClient();
                      },
                      child: const Text('Add Client'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _addClient() async {
    try {
      final apiMethod = ref.read(apiMethodProvider);
      final sharedPreferencesUtils = ref.read(sharedPreferencesProvider);

      // Initialize SharedPreferences if not already done
      await sharedPreferencesUtils.init();

      // Get current user's email
      String? currentUserEmail =
          await sharedPreferencesUtils.getUserEmailFromSharedPreferences();

      var ins = await apiMethod.addClient(
        _clientFirstNameController.text,
        _clientLastNameController.text,
        _clientEmailController.text,
        _clientPhoneController.text,
        _clientAddressController.text,
        _clientCityController.text,
        _clientStateController.text,
        _clientZipController.text,
        _clientBusinessNameController.text,
        userEmail: currentUserEmail,
      );
      debugPrint("Response: $ins");

      if (ins['message'] == 'Client added successfully') {
        if (kDebugMode) {
          debugPrint("Client added successfully");
        }
        // Navigate back or show success message
        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Client added successfully!'),
              backgroundColor: ModernSaasDesign.success,
            ),
          );
        }
      } else {
        if (kDebugMode) {
          debugPrint("Client addition failed");
        }
        debugPrint("Response: $ins");
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add client. Please try again.'),
              backgroundColor: ModernSaasDesign.error,
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error adding client: $e");
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: ModernSaasDesign.error,
          ),
        );
      }
    }
  }
}
