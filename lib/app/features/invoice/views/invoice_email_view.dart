import 'dart:convert';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';

import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';

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
  final bool _isLoading = true;
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
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xFF007AFF),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Invoicing Email Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.0),
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
        padding: EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.0), // iOS standard
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF007AFF).withOpacity(0.1),
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
                  AlwaysStoppedAnimation<Color>(const Color(0xFF007AFF)),
              strokeWidth: 3,
            ),
            SizedBox(height: 16.0),
            Text(
              'Loading email details...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage, String organisationName) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius:
                    BorderRadius.circular(999.0),
              ),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-flash-dynamic-color.png',
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Error',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            _buildModernAddButton(organisationName),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataState(String message, String organisationName) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius:
                    BorderRadius.circular(999.0),
              ),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'No Email Configuration',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
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
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
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
            const SizedBox(width: 8.0),
            Text(
              'Add Invoicing Email Detail',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500).copyWith(
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
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2).withValues(
                        alpha:
                            0.18), // Soft pink surface color like admin dashboard
                    borderRadius:
                        BorderRadius.circular(12.0),
                  ),
                  child: Image.asset(
                    'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invoicing Email Configuration',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Your email settings are configured and ready',
                        style: const TextStyle(fontSize: 12).copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF764BA2),
                    borderRadius:
                        BorderRadius.circular(999.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   'assets/icons/3D Icons/3dicons-shield-dynamic-color.png',
                      //   width: 16,
                      //   height: 16,
                      // ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Active',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500).copyWith(
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
          const SizedBox(height: 24.0),

          // Email Details Section
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667EEA).withOpacity(0.1),
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),

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
                const SizedBox(height: 16.0),

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
                const SizedBox(height: 16.0),

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
          const SizedBox(height: 24.0),

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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: iconWidget ??
                Icon(
                  icon ?? Icons.help,
                  color: const Color(0xFF667EEA),
                  size: 20,
                ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500).copyWith(
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14).copyWith(
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
