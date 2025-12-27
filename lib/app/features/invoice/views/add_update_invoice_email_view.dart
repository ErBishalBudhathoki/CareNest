import 'package:carenest/app/features/invoice/viewmodels/update_invoice_email_viewmodel.dart';
import 'package:carenest/app/features/invoice/models/invoicing_email_model.dart';
import 'package:carenest/app/shared/widgets/alert_dialog_widget.dart';
import 'package:carenest/app/shared/widgets/popup_client_details.dart';
import 'package:carenest/app/shared/widgets/text_field_widget.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';

class AddUpdateInvoicingEmailView extends StatefulWidget {
  final String email;
  final String appPassword;
  final String organizationName;
  const AddUpdateInvoicingEmailView(
      this.email, this.appPassword, this.organizationName,
      {super.key});

  @override
  State<AddUpdateInvoicingEmailView> createState() =>
      _AddUpdateInvoicingEmailViewState();
}

class _AddUpdateInvoicingEmailViewState
    extends State<AddUpdateInvoicingEmailView> {
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
      backgroundColor: ModernInvoiceDesign.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ModernInvoiceDesign.background,
        foregroundColor: ModernInvoiceDesign.primary,
        iconTheme: IconThemeData(
          color: ModernInvoiceDesign.primary,
        ),
        title: Text(
          'Add Invoicing Email Details',
          style: ModernInvoiceDesign.headlineMedium.copyWith(
            color: ModernInvoiceDesign.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Organization Header Card
              ModernInvoiceCard(
                padding: const EdgeInsets.all(20.0),
                backgroundColor: ModernInvoiceDesign.surface,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                boxShadow: ModernInvoiceDesign.shadowSm,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: ModernInvoiceDesign.primary,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: ModernInvoiceDesign.shadowPrimaryGlow,
                      ),
                      child: Image.asset(
                        'assets/icons/3D Icons/business.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: ModernInvoiceDesign.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organization',
                            style: ModernInvoiceDesign.labelMedium.copyWith(
                              color: ModernInvoiceDesign.textSecondary,
                            ),
                          ),
                          const SizedBox(height: ModernInvoiceDesign.space4),
                          Text(
                            widget.organizationName,
                            style: ModernInvoiceDesign.headlineMedium.copyWith(
                              color: ModernInvoiceDesign.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ModernInvoiceDesign.space8),

              // Form Section Header
              Text(
                'Email Configuration',
                style: ModernInvoiceDesign.headlineMedium.copyWith(
                  color: ModernInvoiceDesign.primary,
                ),
              ),
              const SizedBox(height: ModernInvoiceDesign.space8),
              Text(
                'Configure your email settings for invoice delivery',
                style: ModernInvoiceDesign.bodyMedium,
              ),
              const SizedBox(height: ModernInvoiceDesign.space6),
              // Email Field
              ModernInvoiceCard(
                padding: EdgeInsets.zero,
                backgroundColor: ModernInvoiceDesign.surface,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                boxShadow: ModernInvoiceDesign.shadowSm,
                child: TextFieldWidget(
                  suffixIconClickable: false,
                  obscureTextNotifier: _emailVisibilityNotifier,
                  hintText: 'Enter your email address',
                  prefixIcon: Image.asset(
                    'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                    width: 24,
                    height: 24,
                  ),
                  suffixIcon: model.isValid
                      ? Image.asset(
                          'assets/icons/3D Icons/3dicons-shield-dynamic-color.png',
                          width: ModernInvoiceDesign.iconSize,
                          height: ModernInvoiceDesign.iconSize,
                        )
                      : null,
                  controller: _invoicingBusinessEmailController,
                  onChanged: (value) {
                    model.isValidEmail(value);
                  },
                  onSaved: (value) {
                    _invoicingBusinessEmailController.text = value!;
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
              const SizedBox(height: ModernInvoiceDesign.space20),
              // Password Field
              ModernInvoiceCard(
                padding: EdgeInsets.zero,
                backgroundColor: ModernInvoiceDesign.surface,
                borderRadius:
                    BorderRadius.circular(ModernInvoiceDesign.radiusLg),
                boxShadow: ModernInvoiceDesign.shadowSm,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _passwordVisibilityNotifier,
                  builder: (context, isPasswordVisible, child) {
                    return TextFieldWidget(
                      suffixIconClickable: true,
                      obscureTextNotifier: _passwordVisibilityNotifier,
                      hintText: 'Enter your app password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email app password';
                        }
                        return null;
                      },
                      prefixIcon: Image.asset(
                        'assets/icons/3D Icons/3dicons-lock-dynamic-color.png',
                        width: ModernInvoiceDesign.space6,
                        height: ModernInvoiceDesign.space6,
                      ),
                      getSuffixIcon: (isObscured) {
                        return isObscured
                            ? Icons.visibility_off
                            : Icons.visibility;
                      },
                      controller: _invoicingBusinessEmailPasswordController,
                      onChanged: (value) {},
                      onSaved: (value) {
                        _addUpdateInvoicingEmailViewController.email = value!;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),

              // Help Text
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: ModernInvoiceDesign.info.withValues(alpha: 0.1)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/3D Icons/3dicons-flash-dynamic-color.png',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        'Use an app-specific password for enhanced security. You can generate one in your email provider\'s security settings.',
                        style: ModernInvoiceDesign.bodySmall.copyWith(
                          color: ModernInvoiceDesign.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              // Submit Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: ModernInvoiceDesign.primaryGradient,
                  boxShadow: ModernInvoiceDesign.shadowPrimaryGlow,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8.0),
                      Text(
                        'Add Email Details',
                        style: ModernInvoiceDesign.labelLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ApiMethod apiMethod = ApiMethod();
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
