import 'dart:convert';
import 'package:carenest/app/shared/widgets/button_widget.dart';

import 'package:flutter/material.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'add_update_invoice_email_view.dart';

class InvoicingEmailView extends ConsumerStatefulWidget {
  final String email;
  final String genKey;
  final String? organisationName;
  const InvoicingEmailView(this.email, this.genKey, this.organisationName,
      {super.key});

  @override
  ConsumerState<InvoicingEmailView> createState() => _InvoicingEmailViewState();
}

class _InvoicingEmailViewState extends ConsumerState<InvoicingEmailView> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'invoice_email_form_key');
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'invoice_email_scaffold_key');
  var initialData = {};
  final bool _isLoading = true;
  final _passwordController = TextEditingController();
  late final ApiMethod apiMethod;
  final passwordVisibleNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    apiMethod = ref.read(app_providers.apiMethodProvider);
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
        backgroundColor: BauhausDesign.backgroundLight,
        elevation: 0,
        foregroundColor: BauhausDesign.textDark,
        leading: Center(
          child: Container(
            margin: const EdgeInsets.only(left: BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              border: Border.all(color: BauhausDesign.neutral, width: 1.5),
              borderRadius: BorderRadius.zero,
              boxShadow: const [BauhausDesign.shadowHardXs],
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: BauhausDesign.textDark,
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          'INVOICING EMAIL',
          style: BauhausDesign.getTextTheme(context).headlineLarge!.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.w700,
              ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: BauhausDesign.neutral,
            height: 2.0, // Bold border at bottom of AppBar
          ),
        ),
      ),
      backgroundColor: BauhausDesign.backgroundLight,
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
        padding: const EdgeInsets.all(BauhausDesign.space8),
        decoration: _panelDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
              strokeWidth: 4,
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'LOADING DETAILS...',
              style: BauhausDesign.getTextTheme(context).labelLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage, String organisationName) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: _panelDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.error,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
              ),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-flash-dynamic-color.png',
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'ERROR',
              style:
                  BauhausDesign.getTextTheme(context).headlineLarge!.copyWith(
                        color: BauhausDesign.error,
                      ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              errorMessage.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space6),
            _buildModernAddButton(organisationName),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataState(String message, String organisationName) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space6),
        decoration: _panelDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                color: BauhausDesign.backgroundLight,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: BauhausDesign.neutral, width: 2),
              ),
              child: Image.asset(
                'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                width: 48,
                height: 48,
              ),
            ),
            const SizedBox(height: BauhausDesign.space4),
            Text(
              'NO CONFIGURATION',
              style: BauhausDesign.getTextTheme(context).headlineLarge,
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              message,
              style: BauhausDesign.getTextTheme(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BauhausDesign.space6),
            _buildModernAddButton(organisationName),
          ],
        ),
      ),
    );
  }

  Widget _buildAddInvoicingEmailButton(String organisationName) {
    return ButtonWidget(
      buttonText: 'Add Invoicing Email Detail',
      buttonColor: BauhausDesign.secondary,
      textColor: BauhausDesign.surfaceLight,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
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
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.primary,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
              boxShadow: const [BauhausDesign.shadowHardSm],
            ),
            child: Text(
              'ADD EMAIL DETAILS',
              textAlign: TextAlign.center,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.surfaceWhite,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailDetailsFound(Map<String, dynamic> data) {
    final details = (data['data'] is Map<String, dynamic>)
        ? data['data'] as Map<String, dynamic>
        : <String, dynamic>{};
    final businessName =
        (details['invoicingBusinessName'] ?? '').toString().trim();
    final email = (details['email'] ?? data['email'] ?? '').toString().trim();
    final password =
        (details['password'] ?? initialData['password'] ?? '').toString();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space6),
            decoration: _panelDecoration(),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.zero,
                    border:
                        Border.all(color: BauhausDesign.neutral, width: 1.5),
                  ),
                  child: Image.asset(
                    'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CONFIGURATION',
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge!
                            .copyWith(
                              color: BauhausDesign.neutral,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        'Email settings ready',
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium!
                            .copyWith(
                              color: BauhausDesign.textDark,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3,
                    vertical: BauhausDesign.space1,
                  ),
                  decoration: BoxDecoration(
                    color:
                        BauhausDesign.success, // Use success green for Active
                    borderRadius: BorderRadius.zero,
                    border:
                        Border.all(color: BauhausDesign.neutral, width: 1.5),
                    boxShadow: const [BauhausDesign.shadowHardXs],
                  ),
                  child: Text(
                    'ACTIVE',
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge!
                        .copyWith(
                          color: BauhausDesign.surfaceLight,
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),

          // Email Details Section
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space6),
            decoration: _panelDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DETAILS',
                  style: BauhausDesign.getTextTheme(context)
                      .headlineLarge!
                      .copyWith(
                        color: BauhausDesign.textDark,
                      ),
                ),
                const SizedBox(height: BauhausDesign.space4),

                // Business Name
                _buildDetailRow(
                  iconWidget: Image.asset(
                    'assets/icons/3D Icons/3dicons-setting-dynamic-color.png',
                    width: 24,
                    height: 24,
                  ),
                  label: 'BUSINESS NAME',
                  value:
                      businessName.isNotEmpty ? businessName : 'No name found',
                ),
                const SizedBox(height: BauhausDesign.space4),

                // Email Address
                _buildDetailRow(
                  iconWidget: Image.asset(
                    'assets/icons/3D Icons/3dicons-mail-dynamic-color.png',
                    width: 24,
                    height: 24,
                  ),
                  label: 'EMAIL ADDRESS',
                  value: email.isNotEmpty ? email : 'No email found',
                ),
                const SizedBox(height: BauhausDesign.space4),

                // Password (masked)
                _buildDetailRow(
                  iconWidget: Image.asset(
                    'assets/icons/3D Icons/3dicons-lock-dynamic-color.png',
                    width: 24,
                    height: 24,
                  ),
                  label: 'PASSWORD',
                  value: _maskPassword(password),
                  isPassword: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: BauhausDesign.space6),

          // Action Button
          _buildModernAddButton(
              businessName.isNotEmpty ? businessName : 'Organization'),
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
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.backgroundLight,
        borderRadius: BorderRadius.zero,
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 1.5, // Thicker border
        ),
        boxShadow: const [BauhausDesign.shadowHardXs], // Subtle depth
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: BauhausDesign.textDark, width: 1.5),
            ),
            child: iconWidget ??
                Icon(
                  icon ?? Icons.help,
                  color: BauhausDesign.secondary,
                  size: 20,
                ),
          ),
          const SizedBox(width: BauhausDesign.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style:
                      BauhausDesign.getTextTheme(context).labelLarge!.copyWith(
                            color: BauhausDesign.textDark, // Darker text
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                ),
                const SizedBox(height: BauhausDesign.space1),
                Text(
                  value,
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge!.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _maskPassword(String password) {
    if (password.trim().isEmpty) {
      return 'Not available';
    }
    return '•' * 8;
  }

  BoxDecoration _panelDecoration() {
    return BoxDecoration(
      color: BauhausDesign.surfaceWhite,
      borderRadius: BorderRadius.zero,
      border: Border.all(color: BauhausDesign.neutral, width: 2),
      boxShadow: const [BauhausDesign.shadowHardSm],
    );
  }
}
