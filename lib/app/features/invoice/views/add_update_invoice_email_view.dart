import 'package:carenest/app/features/invoice/viewmodels/update_invoice_email_viewmodel.dart';
import 'package:carenest/app/features/invoice/models/invoicing_email_model.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/alertDialog_widget.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
import 'package:carenest/app/shared/widgets/textField_widget.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/features/busineess/models/addBusiness_detail_model.dart';
import 'package:carenest/app/shared/widgets/popupClientDetails.dart';
import 'package:carenest/backend/api_method.dart';

class AddUpdateInvoicingEmailView extends StatefulWidget {
  final String email;
  final String appPassword;
  final String organizationName;
  const AddUpdateInvoicingEmailView(
      this.email, this.appPassword, this.organizationName,
      {super.key});

  @override
  _AddUpdateInvoicingEmailViewState createState() =>
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
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final model = InvoicingEmailModel();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ModernSaasDesign.neutral50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ModernSaasDesign.surface,
        foregroundColor: ModernSaasDesign.primary,
        iconTheme: IconThemeData(
          color: ModernSaasDesign.primary,
        ),
        title: Text(
          'Add Invoicing Email Details',
          style: ModernSaasDesign.headlineSmall.copyWith(
            color: ModernSaasDesign.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ModernSaasDesign.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Organization Header Card
              ModernCard(
                padding: const EdgeInsets.all(ModernSaasDesign.space5),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(ModernSaasDesign.space3),
                      decoration: BoxDecoration(
                        color: ModernSaasDesign.primaryLight,
                        borderRadius:
                            BorderRadius.circular(ModernSaasDesign.radiusLg),
                      ),
                      child: Image.asset(
                        'assets/icons/3D Icons/business.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: ModernSaasDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organization',
                            style: ModernSaasDesign.bodySmall.copyWith(
                              color: ModernSaasDesign.textSecondary,
                            ),
                          ),
                          const SizedBox(height: ModernSaasDesign.space1),
                          Text(
                            widget.organizationName,
                            style: ModernSaasDesign.headlineSmall.copyWith(
                              color: ModernSaasDesign.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space8),

              // Form Section Header
              Text(
                'Email Configuration',
                style: ModernSaasDesign.headlineSmall.copyWith(
                  color: ModernSaasDesign.primary,
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space2),
              Text(
                'Configure your email settings for invoice delivery',
                style: ModernSaasDesign.bodyMedium.copyWith(
                  color: ModernSaasDesign.textSecondary,
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space6),
              // Email Field
              ModernCard(
                padding: EdgeInsets.zero,
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
                          width: 24,
                          height: 24,
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
              const SizedBox(height: ModernSaasDesign.space5),
              // Password Field
              ModernCard(
                padding: EdgeInsets.zero,
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
                        width: 24,
                        height: 24,
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
              const SizedBox(height: ModernSaasDesign.space4),

              // Help Text
              Container(
                padding: const EdgeInsets.all(ModernSaasDesign.space4),
                decoration: BoxDecoration(
                  color: ModernSaasDesign.info.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusLg),
                  border: Border.all(
                      color: ModernSaasDesign.info.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/3D Icons/3dicons-flash-dynamic-color.png',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(width: ModernSaasDesign.space3),
                    Expanded(
                      child: Text(
                        'Use an app-specific password for enhanced security. You can generate one in your email provider\'s security settings.',
                        style: ModernSaasDesign.bodySmall.copyWith(
                          color: ModernSaasDesign.info,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space8),
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ModernSaasDesign.primary,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ModernSaasDesign.radiusLg),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: ModernSaasDesign.space2),
                      Text(
                        'Add Email Details',
                        style: ModernSaasDesign.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showAlertDialog(context);
                      Future.delayed(const Duration(seconds: 3), () async {
                        final response =
                            await _addInvoicingEmailDetails(widget.email);

                        if (response ==
                            'Invoicing email details added successfully') {
                          print('Add button pressed');
                          Navigator.pop(_scaffoldKey.currentContext!);
                          Navigator.of(_scaffoldKey.currentContext!,
                                  rootNavigator: true)
                              .pop();
                          popUpClientDetails(_scaffoldKey.currentContext!,
                              "Success", "Invoicing email");
                        } else {
                          print('Error at business adding');
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
    print("Response: $ins");

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
