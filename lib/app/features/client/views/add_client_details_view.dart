import 'dart:async';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/app/shared/widgets/business_name_dropdown_widget.dart';

import 'package:carenest/app/shared/widgets/text_field_widget.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.primary,
        foregroundColor: BauhausDesign.surfaceWhite,
        iconTheme: IconThemeData(
          color: BauhausDesign.surfaceWhite,
        ),
        title: Text(
          l10n.addClient,
          style: BauhausDesign.getTextTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.surfaceWhite,
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
                      Icons.person_add_rounded,
                      size: 48,
                      color: BauhausDesign.primary,
                    ),
                    SizedBox(height: BauhausDesign.space3),
                    Text(
                      l10n.newClientTitle,
                      style: BauhausDesign.getTextTheme(context)
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.primary,
                          ),
                    ),
                    SizedBox(height: BauhausDesign.space2),
                    Text(
                      l10n.addClientDesc,
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

              // Personal Information Section
              _buildSectionHeader(
                  context, l10n.personalInfoSection, Icons.person_rounded),
              SizedBox(height: BauhausDesign.space4),
              _buildPersonalInfoSection(
                  context, textVisibleNotifier, size, l10n),
              SizedBox(height: BauhausDesign.space8),

              // Contact Information Section
              _buildSectionHeader(
                  context, l10n.contactInformation, Icons.contact_mail_rounded),
              SizedBox(height: BauhausDesign.space4),
              _buildContactInfoSection(
                  context, textVisibleNotifier, size, l10n),
              SizedBox(height: BauhausDesign.space8),

              // Address Information Section
              _buildSectionHeader(
                  context, l10n.addressInformation, Icons.location_on_rounded),
              SizedBox(height: BauhausDesign.space4),
              _buildAddressInfoSection(
                  context, textVisibleNotifier, size, l10n),
              SizedBox(height: BauhausDesign.space8),

              // Business Information Section
              _buildSectionHeader(
                  context, l10n.businessInformation, Icons.business_rounded),
              SizedBox(height: BauhausDesign.space4),
              _buildBusinessInfoSection(context),
              SizedBox(height: BauhausDesign.space10),

              // Submit Button
              _buildSubmitButton(context, theme, l10n),
              SizedBox(height: BauhausDesign.space6),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a section header with icon and title
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
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: BauhausDesign.textDark,
              ),
        ),
      ],
    );
  }

  /// Builds the personal information section
  Widget _buildPersonalInfoSection(
      BuildContext context,
      ValueNotifier<bool> textVisibleNotifier,
      Size size,
      AppLocalizations l10n) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.firstNameHint,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.firstNameRequired;
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
          SizedBox(height: BauhausDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.lastNameHint,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.lastNameRequired;
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
      BuildContext context,
      ValueNotifier<bool> textVisibleNotifier,
      Size size,
      AppLocalizations l10n) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.emailRequired;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return l10n.emailInvalid;
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
          SizedBox(height: BauhausDesign.space4),
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.phoneNumber,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.phoneRequired;
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
      BuildContext context,
      ValueNotifier<bool> textVisibleNotifier,
      Size size,
      AppLocalizations l10n) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: Column(
        children: [
          TextFieldWidget(
            suffixIconClickable: false,
            obscureTextNotifier: textVisibleNotifier,
            hintText: l10n.streetAddressHint,
            validator: (value) {
              if (value!.isEmpty) {
                return l10n.streetAddressRequired;
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
                  controller: _clientCityController,
                  onChanged: (value) {},
                  onSaved: (value) {
                    _clientCityController.text = value!;
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
                  controller: _clientStateController,
                  onChanged: (value) {},
                  onSaved: (value) {
                    _clientStateController.text = value!;
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
  Widget _buildBusinessInfoSection(BuildContext context) {
    return BauhausCard(
      padding: EdgeInsets.all(BauhausDesign.space5),
      child: BusinessNameDropdown(
        onChanged: (selectedValue) {
          _clientBusinessNameController.text = selectedValue;
          debugPrint('Selected Business Name: $selectedValue');
        },
      ),
    );
  }

  /// Builds the submit button with modern styling
  Widget _buildSubmitButton(
      BuildContext context, ThemeData theme, AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      child: BauhausActionButton(
        text: l10n.addClientButton,
        variant: BauhausActionVariant.primary,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: BauhausDesign.surfaceWhite,
                  title: Text(l10n.addClient,
                      style:
                          BauhausDesign.getTextTheme(context).headlineMedium),
                  content: Text(l10n.confirmAddClient,
                      style: BauhausDesign.getTextTheme(context).bodyMedium),
                  actions: [
                    BauhausActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: l10n.cancelButton,
                      variant: BauhausActionVariant.ghost,
                    ),
                    BauhausActionButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await _addClient();
                      },
                      text: l10n.addClientButton,
                      variant: BauhausActionVariant.primary,
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
    final l10n = AppLocalizations.of(context)!;
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
            SnackBar(
              content: Text(l10n.clientAddedSuccess),
              backgroundColor: BauhausDesign.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              ),
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
            SnackBar(
              content: Text(l10n.clientAddFailed),
              backgroundColor: BauhausDesign.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              ),
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
          SnackBar(
            content: Text(l10n.errorGenericMessage),
            backgroundColor: BauhausDesign.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
            ),
          ),
        );
      }
    }
  }
}
