import 'package:carenest/app/features/invoice/viewmodels/update_invoice_email_viewmodel.dart';
import 'package:carenest/app/shared/widgets/alert_dialog_widget.dart';
import 'package:carenest/app/shared/widgets/popup_client_details.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;

class AddUpdateInvoicingEmailView extends ConsumerStatefulWidget {
  final String email;
  final String appPassword;
  final String organizationName;
  const AddUpdateInvoicingEmailView(
    this.email,
    this.appPassword,
    this.organizationName, {
    super.key,
  });

  @override
  ConsumerState<AddUpdateInvoicingEmailView> createState() =>
      _AddUpdateInvoicingEmailViewState();
}

class _AddUpdateInvoicingEmailViewState
    extends ConsumerState<AddUpdateInvoicingEmailView> {
  late final ApiMethod apiMethod;
  final _formKey = GlobalKey<FormState>(
    debugLabel: 'add_update_invoice_email_form_key',
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UpdateInvoiceEmailViewModel _addUpdateInvoicingEmailViewController =
      UpdateInvoiceEmailViewModel();
  //final _invoicingBusinessNameController = TextEditingController();
  final _invoicingBusinessEmailController = TextEditingController();
  final _invoicingBusinessEmailPasswordController = TextEditingController();

  // Separate notifier for password visibility
  final ValueNotifier<bool> _passwordVisibilityNotifier = ValueNotifier<bool>(
    true,
  ); // Default to hidden

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
    _passwordVisibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BauhausDesign.backgroundLight,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.surfaceWhite,
        foregroundColor: BauhausDesign.textDark,
        title: Text(
          'Add Invoicing Email Details',
          style: BauhausDesign.getTextTheme(context).headlineLarge?.copyWith(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
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
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: _panelDecoration(),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary,
                        borderRadius: BorderRadius.zero,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
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
                                ?.copyWith(color: BauhausDesign.textMuted),
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            widget.organizationName,
                            style: BauhausDesign.getTextTheme(context)
                                .headlineMedium
                                ?.copyWith(color: BauhausDesign.primary),
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
                style: BauhausDesign.getTextTheme(
                  context,
                ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
              ),
              const SizedBox(height: BauhausDesign.space4),
              // Email Field
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: _panelDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel('Email Address'),
                    const SizedBox(height: BauhausDesign.space1),
                    TextFormField(
                      controller: _invoicingBusinessEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: BauhausDesign.getTextTheme(context).bodyMedium,
                      decoration: _squareInputDecoration(
                        hintText: 'Enter your email address',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        suffixIcon:
                            _isValidEmail(
                              _invoicingBusinessEmailController.text,
                            )
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/icons/3D Icons/3dicons-shield-dynamic-color.png',
                                  width: 20,
                                  height: 20,
                                ),
                              )
                            : null,
                      ),
                      onChanged: (_) => setState(() {}),
                      validator: (value) {
                        final email = (value ?? '').trim();
                        if (email.isEmpty) {
                          return 'Please enter email';
                        }
                        if (!_isValidEmail(email)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              // Password Field
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: _panelDecoration(),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _passwordVisibilityNotifier,
                  builder: (context, isHidden, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFieldLabel('App Password'),
                        const SizedBox(height: BauhausDesign.space1),
                        TextFormField(
                          controller: _invoicingBusinessEmailPasswordController,
                          obscureText: isHidden,
                          style: BauhausDesign.getTextTheme(context).bodyMedium,
                          decoration: _squareInputDecoration(
                            hintText: 'Enter your app password',
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
                                isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: BauhausDesign.textMuted,
                              ),
                              onPressed: () {
                                _passwordVisibilityNotifier.value = !isHidden;
                              },
                            ),
                          ),
                          validator: (value) {
                            if ((value ?? '').isEmpty) {
                              return 'Please enter email app password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _addUpdateInvoicingEmailViewController.email =
                                value;
                          },
                        ),
                      ],
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
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: BauhausDesign.info, width: 2),
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
                        style: BauhausDesign.getTextTheme(context).bodySmall
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
              SizedBox(
                width: double.infinity,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _submitForm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space6,
                        vertical: BauhausDesign.space3,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary,
                        borderRadius: BorderRadius.zero,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 2,
                        ),
                        boxShadow: const [BauhausDesign.shadowHardSm],
                      ),
                      child: Text(
                        'Add Email Details',
                        textAlign: TextAlign.center,
                        style: BauhausDesign.getTextTheme(context).labelLarge
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _squareInputDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: BauhausDesign.neutral, width: 2),
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: BauhausDesign.getTextTheme(
        context,
      ).bodyMedium?.copyWith(color: BauhausDesign.textMuted),
      filled: true,
      fillColor: BauhausDesign.surfaceWhite,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space3,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: border,
      enabledBorder: border,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: BauhausDesign.primary, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: BauhausDesign.error, width: 2),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: BauhausDesign.error, width: 2),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Text(
      text,
      style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
        color: BauhausDesign.textDark,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  BoxDecoration _panelDecoration() {
    return const BoxDecoration(
      color: BauhausDesign.surfaceWhite,
      borderRadius: BorderRadius.zero,
      border: Border.fromBorderSide(
        BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      boxShadow: [BauhausDesign.shadowHardSm],
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    showAlertDialog(context);
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final result = await _addInvoicingEmailDetails(widget.email);
    if (!mounted) return;

    final isSuccess = result['success'] == true;
    final detailsMessage = (result['message'] ?? '').toString().trim();

    Navigator.pop(_scaffoldKey.currentContext!);
    Navigator.of(_scaffoldKey.currentContext!, rootNavigator: true).pop();

    popUpClientDetails(
      _scaffoldKey.currentContext!,
      isSuccess ? "Success" : "Error",
      "Invoicing email",
      detailMessage: detailsMessage.isNotEmpty
          ? detailsMessage
          : (isSuccess
                ? 'Invoicing email details added successfully'
                : 'Failed to add invoicing email details'),
    );
  }

  bool _isValidEmail(String input) {
    final email = input.trim();
    if (email.isEmpty) return false;
    return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
  }

  Future<Map<String, dynamic>> _addInvoicingEmailDetails(String email) async {
    var ins = await apiMethod.addUpdateInvoicingEmailDetail(
      email,
      widget.organizationName,
      _invoicingBusinessEmailController.text,
      _invoicingBusinessEmailPasswordController.text,
    );
    if (kDebugMode) {
      debugPrint("Response: $ins");
    }

    final backendMessage = (ins['message'] ?? '').toString().trim();
    final lowerMessage = backendMessage.toLowerCase();
    final alreadyExists = lowerMessage.contains('already');
    final unauthorized =
        lowerMessage.contains('unauthorized') || lowerMessage.contains('401');

    if (ins['success'] == true) {
      if (kDebugMode) {
        debugPrint("Details added Successful ");
      }
      return {
        'success': true,
        'message': backendMessage.isNotEmpty
            ? backendMessage
            : 'Invoicing email details added successfully',
      };
    }

    if (alreadyExists) {
      return {
        'success': false,
        'message': 'Data already added for invoicing email',
      };
    }

    if (unauthorized) {
      return {
        'success': false,
        'message': 'Session expired or unauthorized. Please login again.',
      };
    }

    if (kDebugMode) {
      debugPrint("Details added Failed");
    }
    return {
      'success': false,
      'message': backendMessage.isNotEmpty
          ? backendMessage
          : 'Failed to add invoicing email details',
    };
  }
}
