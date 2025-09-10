import 'dart:convert';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';

import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'add_update_invoice_email_view.dart';

class InvoicingEmailView extends StatefulWidget {
  final String email;
  final String genKey;
  final String? organisationName;
  const InvoicingEmailView(this.email, this.genKey, this.organisationName,
      {super.key});

  @override
  _InvoicingEmailViewState createState() => _InvoicingEmailViewState();
}

class _InvoicingEmailViewState extends State<InvoicingEmailView> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'invoice_email_form_key');
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'invoice_email_scaffold_key');
  var initialData = {};
  bool _isLoading = true;
  final _passwordController = TextEditingController();
  ApiMethod apiMethod = ApiMethod();
  final passwordVisibleNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
  }

  Future<Object> getInvoicingEmailDetails(String email) async {
    try {
      var response =
          await apiMethod.getInvoicingEmailDetails(email, widget.genKey);
      debugPrint('getInvoicingEmailDetails Response: $response');
      if (response is String) {
        initialData = jsonDecode(response as String);
      } else {
        initialData = response;
      }
      debugPrint("initialData $initialData");
      return initialData;
    } catch (e) {
      debugPrint('getInvoicingEmailDetails Error: $e');
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('InvoicingEmailView key: ${widget.genKey}');
    return Scaffold(
      backgroundColor: ModernSaasDesign.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ModernSaasDesign.surface,
        foregroundColor: ModernSaasDesign.textPrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ModernSaasDesign.primary,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Invoicing Email Details',
          style: ModernSaasDesign.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(ModernSaasDesign.spacing6),
        child: FutureBuilder(
          future: getInvoicingEmailDetails(widget.email),
          builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingState();
            }
            if (snapshot.hasError) {
              return _buildErrorState(
                'Error fetching data: ${snapshot.error}',
                widget.organisationName ?? 'Organization',
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              if (data['message'] == 'Encryption key not found') {
                debugPrint('One ${{widget.genKey}}');
                if (widget.genKey == "update" || widget.genKey == "error") {
                  debugPrint('Two');
                  return _buildErrorState(
                    'Error fetching encryption key',
                    widget.organisationName ?? 'Organization',
                  );
                } else {
                  debugPrint('Three');
                  return _buildEmailDetailsFound(data);
                }
              } else if (data['message'] ==
                  'No invoicing email details found') {
                debugPrint('4');
                return _buildNoDataState(
                  data['message'],
                  data['organisationName'] ?? 'Organization',
                );
              } else if (data['message'] == 'Invoicing email details found') {
                debugPrint('5');
                return _buildEmailDetailsFound(data);
              } else {
                debugPrint('6');
                return _buildNoDataState(
                  "No data found",
                  data['organisationName'] ?? 'Organization',
                );
              }
            }
            debugPrint('7');
            return _buildNoDataState(
              "No data found",
              widget.organisationName ?? 'Organization',
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(ModernSaasDesign.spacing8),
        decoration: BoxDecoration(
          color: ModernSaasDesign.surface,
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
          boxShadow: [
            BoxShadow(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ModernSaasDesign.primary),
              strokeWidth: 3,
            ),
            const SizedBox(height: ModernSaasDesign.spacing4),
            Text(
              'Loading email details...',
              style: ModernSaasDesign.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage, String organisationName) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(ModernSaasDesign.spacing6),
        decoration: BoxDecoration(
          color: ModernSaasDesign.surface,
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
          boxShadow: [
            BoxShadow(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(ModernSaasDesign.spacing4),
              decoration: BoxDecoration(
                color: ModernSaasDesign.errorLight,
                borderRadius:
                    BorderRadius.circular(ModernSaasDesign.radiusFull),
              ),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-flash-dynamic-color.png',
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(height: ModernSaasDesign.spacing4),
            Text(
              'Error',
              style: ModernSaasDesign.headlineSmall.copyWith(
                color: ModernSaasDesign.error,
              ),
            ),
            const SizedBox(height: ModernSaasDesign.spacing2),
            Text(
              errorMessage,
              style: ModernSaasDesign.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernSaasDesign.spacing6),
            _buildModernAddButton(organisationName),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataState(String message, String organisationName) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(ModernSaasDesign.spacing6),
        decoration: BoxDecoration(
          color: ModernSaasDesign.surface,
          borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
          boxShadow: [
            BoxShadow(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(ModernSaasDesign.spacing4),
              decoration: BoxDecoration(
                color: ModernSaasDesign.neutral100,
                borderRadius:
                    BorderRadius.circular(ModernSaasDesign.radiusFull),
              ),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(height: ModernSaasDesign.spacing4),
            Text(
              'No Email Configuration',
              style: ModernSaasDesign.headlineSmall,
            ),
            const SizedBox(height: ModernSaasDesign.spacing2),
            Text(
              message,
              style: ModernSaasDesign.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ModernSaasDesign.spacing6),
            _buildModernAddButton(organisationName),
          ],
        ),
      ),
    );
  }

  Widget _buildAddInvoicingEmailButton(String organisationName) {
    return ButtonWidget(
      buttonText: 'Add Invoicing Email Detail',
      buttonColor: AppColors.colorPrimary,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddUpdateInvoicingEmailView(
                    widget.email, widget.genKey, organisationName)));
      },
    );
  }

  Widget _buildModernAddButton(String organisationName) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUpdateInvoicingEmailView(
                widget.email,
                widget.genKey,
                organisationName,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ModernSaasDesign.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/icons/3D Icons/3dicons-pin-dynamic-color.png',
            //   width: 20,
            //   height: 20,
            // ),
            const SizedBox(width: ModernSaasDesign.spacing2),
            Text(
              'Add Invoicing Email Detail',
              style: ModernSaasDesign.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailDetailsFound(Map<String, dynamic> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.spacing6),
            decoration: BoxDecoration(
              color: ModernSaasDesign.surface,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: ModernSaasDesign.primary.withValues(alpha: 0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(ModernSaasDesign.spacing3),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.softErrorBackground.withValues(
                        alpha:
                            0.18), // Soft pink background color like admin dashboard
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusLg),
                  ),
                  child: Image.asset(
                    'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(width: ModernSaasDesign.spacing4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoicing Email Configuration',
                        style: ModernSaasDesign.headlineSmall,
                      ),
                      const SizedBox(height: ModernSaasDesign.spacing1),
                      Text(
                        'Your email settings are configured and ready',
                        style: ModernSaasDesign.bodySmall.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ModernSaasDesign.spacing3,
                    vertical: ModernSaasDesign.spacing1,
                  ),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.secondaryLight,
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   'assets/icons/3D Icons/3dicons-shield-dynamic-color.png',
                      //   width: 16,
                      //   height: 16,
                      // ),
                      const SizedBox(width: ModernSaasDesign.spacing1),
                      Text(
                        'Active',
                        style: ModernSaasDesign.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: ModernSaasDesign.spacing6),

          // Email Details Section
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.spacing6),
            decoration: BoxDecoration(
              color: ModernSaasDesign.surface,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: ModernSaasDesign.primary.withValues(alpha: 0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email Details',
                  style: ModernSaasDesign.headlineSmall,
                ),
                const SizedBox(height: ModernSaasDesign.spacing4),

                // Business Name
                _buildDetailRow(
                  iconWidget: Image.asset(
                    'assets/icons/3D Icons/3dicons-setting-dynamic-color.png',
                    width: 20,
                    height: 20,
                  ),
                  label: 'Business Name',
                  value:
                      data['data']?['invoicingBusinessName'] ?? 'No name found',
                ),
                const SizedBox(height: ModernSaasDesign.spacing4),

                // Email Address
                _buildDetailRow(
                  iconWidget: Image.asset(
                    'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                    width: 20,
                    height: 20,
                  ),
                  label: 'Email Address',
                  value: data['email'] ?? 'No email found',
                ),
                const SizedBox(height: ModernSaasDesign.spacing4),

                // Password (masked)
                _buildDetailRow(
                  iconWidget: Image.asset(
                    'assets/icons/3D Icons/3dicons-lock-dynamic-color.png',
                    width: 20,
                    height: 20,
                  ),
                  label: 'Password',
                  value: _maskPassword(
                      initialData['password'] ?? 'No password found'),
                  isPassword: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: ModernSaasDesign.spacing6),

          // Action Button
          _buildModernAddButton(
              data['data']?['invoicingBusinessName'] ?? 'Organization'),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    IconData? icon,
    Widget? iconWidget,
    required String label,
    required String value,
    bool isPassword = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(ModernSaasDesign.spacing4),
      decoration: BoxDecoration(
        color: ModernSaasDesign.neutral50,
        borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
        border: Border.all(
          color: ModernSaasDesign.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.spacing2),
            decoration: BoxDecoration(
              color: ModernSaasDesign.surface,
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusSm),
            ),
            child: iconWidget ??
                Icon(
                  icon ?? Icons.help,
                  color: ModernSaasDesign.primary,
                  size: 20,
                ),
          ),
          const SizedBox(width: ModernSaasDesign.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: ModernSaasDesign.labelMedium.copyWith(
                    color: ModernSaasDesign.textSecondary,
                  ),
                ),
                const SizedBox(height: ModernSaasDesign.spacing1),
                Text(
                  value,
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // if (isPassword)
          //   Image.asset(
          //     'assets/icons/3D Icons/3dicons-camera-dynamic-color.png',
          //     width: 20,
          //     height: 20,
          //   ),
        ],
      ),
    );
  }

  String _maskPassword(String password) {
    if (password == 'No password found' || password.isEmpty) {
      return password;
    }
    return '•' * 8; // Show 8 dots for any password
  }
}
