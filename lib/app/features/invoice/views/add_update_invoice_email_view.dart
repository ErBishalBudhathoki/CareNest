import 'package:carenest/app/features/invoice/viewmodels/update_invoice_email_viewmodel.dart';
import 'package:carenest/app/features/invoice/models/invoicing_email_model.dart';
import 'package:carenest/app/shared/widgets/alert_dialog_widget.dart';
import 'package:carenest/app/shared/widgets/popup_client_details.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;

class AddUpdateInvoicingEmailView extends ConsumerStatefulWidget {
  final String email;
  final String appPassword;
  final String organizationName;
  const AddUpdateInvoicingEmailView(
      this.email, this.appPassword, this.organizationName,
      {super.key});

  @override
  ConsumerState<AddUpdateInvoicingEmailView> createState() =>
      _AddUpdateInvoicingEmailViewState();
}

class _AddUpdateInvoicingEmailViewState
    extends ConsumerState<AddUpdateInvoicingEmailView> {
  late final ApiMethod apiMethod;
  final _formKey =
      GlobalKey<FormState>(debugLabel: 'add_update_invoice_email_form_key');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UpdateInvoiceEmailViewModel _addUpdateInvoicingEmailViewController =
      UpdateInvoiceEmailViewModel();
  //final _invoicingBusinessNameController = TextEditingController();
  final _invoicingBusinessEmailController = TextEditingController();
  final _invoicingBusinessEmailPasswordController = TextEditingController();

  // Separate notifiers for email and password visibility
  final ValueNotifier<bool> _emailVisibilityNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _passwordVisibilityNotifier =
      ValueNotifier<bool>(true); // Default to hidden

  @override
  void initState() {
    super.initState();
    apiMethod = ref.read(app_providers.apiMethodProvider);
  }

  @override
  void dispose() {
    //_invoicingBusinessNameController.dispose();
    _invoicingBusinessEmailController.dispose();
    _invoicingBusinessEmailPasswordController.dispose();
    _emailVisibilityNotifier.dispose();
    _passwordVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //final theme = Theme.of(context);
    final model = InvoicingEmailModel();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        title: Text(
          'Add Invoicing Email Details',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: BauhausDesign.neutral,
            height: 1,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Organization Header Card
              BauhausCard(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary,
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusMd),
                        border:
                            Border.all(color: BauhausDesign.neutral, width: 2),
                        boxShadow: const [BauhausDesign.shadowHardSm],
                      ),
                      child: Image.asset(
                        'assets/icons/3D Icons/business.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organization',
                            style: BauhausDesign.getTextTheme(context)
                                .labelMedium
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                ),
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            widget.organizationName,
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(
                                  color: BauhausDesign.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space6),

              // Form Section Header
              Text(
                'Email Configuration',
                style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.primary,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                'Configure your email settings for invoice delivery',
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              // Email Field
              BauhausCard(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                child: BauhausTextField(
                  label: 'Email Address',
                  controller: _invoicingBusinessEmailController,
                  hintText: 'Enter your email address',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  suffixIcon: model.isValid
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/icons/3D Icons/3dicons-shield-dynamic-color.png',
                            width: 20,
                            height: 20,
                          ),
                        )
                      : null,
                  onChanged: (value) {
                    model.isValidEmail(value);
                    setState(() {}); // Rebuild to update suffix icon
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    } else {
                      if (!model.isValid) {
                        return 'Please enter valid email';
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              // Password Field
              BauhausCard(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _passwordVisibilityNotifier,
                  builder: (context, isHidden, child) {
                    return BauhausTextField(
                      label: 'App Password',
                      controller: _invoicingBusinessEmailPasswordController,
                      hintText: 'Enter your app password',
                      obscureText: isHidden,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/icons/3D Icons/3dicons-lock-dynamic-color.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility,
                          color: BauhausDesign.textMuted,
                        ),
                        onPressed: () {
                          _passwordVisibilityNotifier.value = !isHidden;
                        },
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email app password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _addUpdateInvoicingEmailViewController.email = value;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),

              // Help Text
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: BauhausDesign.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.info),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/3D Icons/3dicons-flash-dynamic-color.png',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Text(
                        'Use an app-specific password for enhanced security. You can generate one in your email provider\'s security settings.',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color: BauhausDesign.info,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space6),
              // Submit Button
              BauhausActionButton(
                text: 'Add Email Details',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showAlertDialog(context);
                    Future.delayed(const Duration(seconds: 3), () async {
                      if (!mounted) return;
                      final response =
                          await _addInvoicingEmailDetails(widget.email);
                      if (!mounted) return;

                      if (response ==
                          'Invoicing email details added successfully') {
                        if (kDebugMode) {
                          print('Add button pressed');
                        }
                        Navigator.pop(_scaffoldKey.currentContext!);
                        Navigator.of(_scaffoldKey.currentContext!,
                                rootNavigator: true)
                            .pop();
                        popUpClientDetails(_scaffoldKey.currentContext!,
                            "Success", "Invoicing email");
                      } else {
                        if (kDebugMode) {
                          print('Error at business adding');
                        }
                        Navigator.pop(_scaffoldKey.currentContext!);
                        Navigator.of(_scaffoldKey.currentContext!,
                                rootNavigator: true)
                            .pop();
                        popUpClientDetails(_scaffoldKey.currentContext!,
                            "Error", "Invoicing email");
                      }
                    });
                  }
                },
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _addInvoicingEmailDetails(String email) async {
    var ins = await apiMethod.addUpdateInvoicingEmailDetail(
        email,
        widget.organizationName,
        _invoicingBusinessEmailController.text,
        _invoicingBusinessEmailPasswordController.text);
    if (kDebugMode) {
      print("Response: $ins");
    }

    if (ins['message'] == 'Invoicing email details added successfully') {
      if (kDebugMode) {
        print("Details added Successful ");
      }
      return ins['message'];
    } else {
      if (kDebugMode) {
        print("Details added Failed");
      }
      //print("INS: " + ins);
      return ins['message'];
    }
  }
}
