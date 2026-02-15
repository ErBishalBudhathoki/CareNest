import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/backend/api_method.dart';

/// OAuth callback handler for integrations
/// This view handles the OAuth redirect after user authorizes an integration
class IntegrationOAuthCallbackView extends StatefulWidget {
  final String? code;
  final String? state;
  final String? error;

  const IntegrationOAuthCallbackView({
    super.key,
    this.code,
    this.state,
    this.error,
  });

  @override
  State<IntegrationOAuthCallbackView> createState() => _IntegrationOAuthCallbackViewState();
}

class _IntegrationOAuthCallbackViewState extends State<IntegrationOAuthCallbackView> {
  final ApiMethod _apiMethod = ApiMethod();
  bool _isProcessing = true;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _handleCallback();
  }

  Future<void> _handleCallback() async {
    // Check for errors from OAuth provider
    if (widget.error != null) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Authorization failed: ${widget.error}';
      });
      return;
    }

    // Validate required parameters
    if (widget.code == null || widget.state == null) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Invalid callback parameters';
      });
      return;
    }

    try {
      // Parse state to get organizationId and integrationType
      // State format: "organizationId:integrationType"
      final stateParts = widget.state!.split(':');
      if (stateParts.length != 2) {
        throw Exception('Invalid state parameter');
      }

      final organizationId = stateParts[0];
      final integrationType = stateParts[1];

      // Exchange authorization code for tokens
      final result = await _apiMethod.handleIntegrationCallback(
        organizationId: organizationId,
        integrationType: integrationType,
        code: widget.code!,
      );

      if (result['success'] == true) {
        setState(() {
          _isProcessing = false;
          _successMessage = 'Successfully connected ${_getIntegrationName(integrationType)}!';
        });

        // Auto-close after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        });
      } else {
        throw Exception(result['message'] ?? 'Failed to connect integration');
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Failed to complete authorization: ${e.toString()}';
      });
    }
  }

  String _getIntegrationName(String integrationType) {
    switch (integrationType) {
      case 'xero':
        return 'Xero';
      case 'myob':
        return 'MYOB';
      case 'quickbooks':
        return 'QuickBooks';
      case 'googleCalendar':
        return 'Google Calendar';
      case 'outlookCalendar':
        return 'Outlook Calendar';
      case 'slack':
        return 'Slack';
      case 'teams':
        return 'Microsoft Teams';
      case 'stripe':
        return 'Stripe';
      default:
        return integrationType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.surfaceOffWhite,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 2),
            boxShadow: [BauhausDesign.shadowHard],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: _errorMessage != null
                      ? BauhausDesign.error
                      : _successMessage != null
                          ? BauhausDesign.success
                          : BauhausDesign.primary,
                  border: Border(
                    bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      color: BauhausDesign.surfaceWhite,
                      child: Icon(
                        _errorMessage != null
                            ? Icons.error_outline
                            : _successMessage != null
                                ? Icons.check_circle_outline
                                : Icons.link,
                        color: _errorMessage != null
                            ? BauhausDesign.error
                            : _successMessage != null
                                ? BauhausDesign.success
                                : BauhausDesign.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Text(
                        'INTEGRATION AUTHORIZATION',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.textDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(BauhausDesign.space6),
                child: Column(
                  children: [
                    if (_isProcessing) ...[
                      const CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Text(
                        'Processing authorization...',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontMd,
                          fontWeight: FontWeight.w500,
                          color: BauhausDesign.textDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ] else if (_errorMessage != null) ...[
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: BauhausDesign.error,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Text(
                        'Authorization Failed',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.textDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      Text(
                        _errorMessage!,
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          fontWeight: FontWeight.w400,
                          color: BauhausDesign.textDark.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: BauhausDesign.space6),
                      _BauhausButton(
                        label: 'CLOSE',
                        onPressed: () => Navigator.of(context).pop(false),
                        color: BauhausDesign.error,
                      ),
                    ] else if (_successMessage != null) ...[
                      Icon(
                        Icons.check_circle_outline,
                        size: 64,
                        color: BauhausDesign.success,
                      ),
                      const SizedBox(height: BauhausDesign.space4),
                      Text(
                        'Success!',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w700,
                          color: BauhausDesign.textDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      Text(
                        _successMessage!,
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          fontWeight: FontWeight.w400,
                          color: BauhausDesign.textDark.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: BauhausDesign.space3),
                      Text(
                        'Closing automatically...',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontXs,
                          fontWeight: FontWeight.w400,
                          color: BauhausDesign.textDark.withOpacity(0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BauhausButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const _BauhausButton({
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space3,
        ),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: [BauhausDesign.shadowHardSm],
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontSm,
            fontWeight: FontWeight.w700,
            color: BauhausDesign.textDark,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
