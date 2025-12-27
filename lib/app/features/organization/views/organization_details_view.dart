import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Organization Details View
/// Displays organization information and provides functionality to share organization codes
class OrganizationDetailsView extends StatefulWidget {
  final String? organizationId;
  final String? organizationName;
  final String? organizationCode;
  final String userEmail;

  const OrganizationDetailsView({
    super.key,
    this.organizationId,
    this.organizationName,
    this.organizationCode,
    required this.userEmail,
  });

  @override
  State<OrganizationDetailsView> createState() =>
      _OrganizationDetailsViewState();
}

class _OrganizationDetailsViewState extends State<OrganizationDetailsView> {
  /// Generates a shareable link with the organization code
  String _generateShareableLink() {
    return DeepLinkHandler.generateSignupLink(widget.organizationCode!);
  }

  /// Copies organization code to clipboard
  Future<void> _copyToClipboard(String text, String label) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (mounted) {
      _showSuccessMessage('$label copied to clipboard!');
    }
  }

  /// Shares organization code and link
  Future<void> _shareOrganizationCode() async {
    final shareText = '''
Join our organization: ${widget.organizationName}

Organization Code: ${widget.organizationCode}

Or use this link to signup directly:
${_generateShareableLink()}
''';

    await Share.share(
      shareText,
      subject: 'Join ${widget.organizationName}',
    );
  }

  /// Shows success message using Flushbar
  void _showSuccessMessage(String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16.0),
      borderRadius: BorderRadius.circular(8.0),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  /// Shows QR code dialog with the shareable link
  void _showQRCodeDialog() {
    final shareableLink = _generateShareableLink();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'QR Code',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: ModernSaasDesign.space6),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: QrImageView(
                    data: shareableLink,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                const SizedBox(height: ModernSaasDesign.space6),
                Text(
                  'Scan this QR code to join ${widget.organizationName}',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ModernSaasDesign.space6),
                Text(
                  'Organization Code: ${widget.organizationCode}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ModernSaasDesign.space6),
                Row(
                  children: [
                    Expanded(
                      child: ModernButton(
                        text: 'Copy Link',
                        onPressed: () {
                          _copyToClipboard(shareableLink, 'Signup Link');
                          Navigator.of(context).pop();
                        },
                        variant: ButtonVariant.outline,
                        icon: Icons.copy,
                      ),
                    ),
                    const SizedBox(width: ModernSaasDesign.space4),
                    Expanded(
                      child: ModernButton(
                        text: 'Share',
                        onPressed: () {
                          Navigator.of(context).pop();
                          _shareOrganizationCode();
                        },
                        variant: ButtonVariant.primary,
                        icon: Icons.share,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds an information card widget
  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    bool showCopyButton = false,
  }) {
    return ModernCard(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              icon,
              color: ModernSaasDesign.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: ModernSaasDesign.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: ModernSaasDesign.space2),
                Text(
                  value,
                  style: ModernSaasDesign.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (showCopyButton)
            IconButton(
              onPressed: () => _copyToClipboard(value, title),
              icon: Icon(
                Icons.copy_outlined,
                color: ModernSaasDesign.primary,
                size: 20,
              ),
              tooltip: 'Copy $title',
              style: IconButton.styleFrom(
                backgroundColor:
                    ModernSaasDesign.primary.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ModernSaasDesign.radiusMd),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Organization Details',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
              .copyWith(
            color: ModernSaasDesign.textOnPrimary,
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: ModernSaasDesign.primaryGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, 8))
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color:
                          ModernSaasDesign.textOnPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999.0),
                    ),
                    child: const Icon(
                      Icons.business_rounded,
                      size: 48,
                      color: ModernSaasDesign.textOnPrimary,
                    ),
                  ),
                  const SizedBox(height: ModernSaasDesign.space6),
                  Text(
                    widget.organizationName ?? 'No Organization',
                    style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700)
                        .copyWith(
                     color: ModernSaasDesign.textOnPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: ModernSaasDesign.space6),

            // Organization Information Section
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space4),
              child: Text(
                'Organization Information',
                style: ModernSaasDesign.headlineLarge,
              ),
            ),

            const SizedBox(height: ModernSaasDesign.space4),

            // Organization Details Cards
            if (widget.organizationName != null)
              _buildInfoCard(
                title: 'Organization Name',
                value: widget.organizationName!,
                icon: Icons.business,
                showCopyButton: true,
              ),

            if (widget.organizationCode != null)
              _buildInfoCard(
                title: 'Organization Code',
                value: widget.organizationCode!,
                icon: Icons.qr_code,
                showCopyButton: true,
              ),

            if (widget.organizationId != null)
              _buildInfoCard(
                title: 'Organization ID',
                value: widget.organizationId!,
                icon: Icons.fingerprint,
                showCopyButton: true,
              ),

            const SizedBox(height: ModernSaasDesign.space6),



            // Share Section
            if (widget.organizationCode != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Invite Team Members',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space6),
              ModernCard(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF667EEA).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Icon(
                              Icons.group_add,
                              color: ModernSaasDesign.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: ModernSaasDesign.space4), 
                          Expanded(
                            child: Text(
                              'Share organization code with team members',
                              style: const TextStyle(fontSize: 16).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: ModernSaasDesign.space2),
                      Text(
                        'Team members can use the organization code to join during signup.',
                        style: const TextStyle(fontSize: 14).copyWith(
                          color: ModernSaasDesign.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space6),

                      // Action Buttons
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ModernButton(
                                  text: 'Share Code',
                                  onPressed: _shareOrganizationCode,
                                  variant: ButtonVariant.primary,
                                  icon: Icons.share,
                                ),
                              ),
                              const SizedBox(width: ModernSaasDesign.space4), 
                              Expanded(
                                child: ModernButton(
                                  text: 'Copy Link',
                                  onPressed: () => _copyToClipboard(
                                    _generateShareableLink(),
                                    'Signup Link',
                                  ),
                                  variant: ButtonVariant.outline,
                                  icon: Icons.copy,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: ModernSaasDesign.space6),
                          SizedBox(
                            width: double.infinity,
                            child: ModernButton(
                              text: 'Show QR Code',
                              onPressed: _showQRCodeDialog,
                              variant: ButtonVariant.outline,
                              icon: Icons.qr_code,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: ModernSaasDesign.space6),



            // Future Features Section
                       Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space4),
              child: Text(
                'Coming Soon',
                style: ModernSaasDesign.headlineLarge,
              ),
            ),


            const SizedBox(height: ModernSaasDesign.space6),

            ModernCard(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:  ModernSaasDesign.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.info_outline,
                          color: ModernSaasDesign.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: ModernSaasDesign.space4),
                      Text(
                        'Upcoming Features',
                       style: ModernSaasDesign.headlineLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: ModernSaasDesign.space4),
                  Text(
                    '• Organization member management\n• Role-based permissions\n• Organization settings\n• Usage analytics',
                    style: const TextStyle(fontSize: 14).copyWith(
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: ModernSaasDesign.space6),
          ],
        ),
      ),
    );
  }
}
