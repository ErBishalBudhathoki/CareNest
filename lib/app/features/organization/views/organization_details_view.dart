import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:carenest/app/shared/constants/values/dimens/app_dimens.dart';
import 'package:carenest/app/shared/widgets/button_widget.dart';
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
      backgroundColor: ModernSaasDesign.primary,
      margin: const EdgeInsets.all(ModernSaasDesign.space4),
      borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
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
            borderRadius: BorderRadius.circular(ModernSaasDesign.radiusXl),
          ),
          backgroundColor: ModernSaasDesign.surface,
          child: Padding(
            padding: const EdgeInsets.all(ModernSaasDesign.space6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'QR Code',
                      style: ModernSaasDesign.headlineLarge,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: ModernSaasDesign.space4),
                Container(
                  padding: const EdgeInsets.all(ModernSaasDesign.space4),
                  decoration: BoxDecoration(
                    color: ModernSaasDesign.surface,
                    borderRadius:
                        BorderRadius.circular(ModernSaasDesign.radiusLg),
                    border: Border.all(color: ModernSaasDesign.border),
                    boxShadow: ModernSaasDesign.shadowSm,
                  ),
                  child: QrImageView(
                    data: shareableLink,
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: ModernSaasDesign.space4),
                Text(
                  'Scan this QR code to join ${widget.organizationName}',
                  style: ModernSaasDesign.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ModernSaasDesign.space4),
                Text(
                  'Organization Code: ${widget.organizationCode}',
                  style: ModernSaasDesign.labelLarge,
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
    VoidCallback? onTap,
    bool showCopyButton = false,
  }) {
    return ModernCard(
      margin: const EdgeInsets.symmetric(
        horizontal: ModernSaasDesign.space4,
        vertical: ModernSaasDesign.space2,
      ),
      padding: const EdgeInsets.all(ModernSaasDesign.space4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ModernSaasDesign.space2),
            decoration: BoxDecoration(
              color: ModernSaasDesign.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernSaasDesign.radiusMd),
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
                  style: ModernSaasDesign.labelMedium,
                ),
                const SizedBox(height: ModernSaasDesign.space1),
                Text(
                  value,
                  style: ModernSaasDesign.bodyLarge.copyWith(
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
      backgroundColor: ModernSaasDesign.background,
      appBar: AppBar(
        title: Text(
          'Organization Details',
          style: ModernSaasDesign.headlineMedium.copyWith(
            color: ModernSaasDesign.textOnPrimary,
          ),
        ),
        backgroundColor: ModernSaasDesign.primary,
        foregroundColor: ModernSaasDesign.textOnPrimary,
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
              padding: const EdgeInsets.all(ModernSaasDesign.space6),
              decoration: BoxDecoration(
                gradient: ModernSaasDesign.primaryGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(ModernSaasDesign.radius3xl),
                  bottomRight: Radius.circular(ModernSaasDesign.radius3xl),
                ),
                boxShadow: ModernSaasDesign.shadowLg,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(ModernSaasDesign.space4),
                    decoration: BoxDecoration(
                      color:
                          ModernSaasDesign.textOnPrimary.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(ModernSaasDesign.radiusFull),
                    ),
                    child: const Icon(
                      Icons.business_rounded,
                      size: 48,
                      color: ModernSaasDesign.textOnPrimary,
                    ),
                  ),
                  const SizedBox(height: ModernSaasDesign.space4),
                  Text(
                    widget.organizationName ?? 'No Organization',
                    style: ModernSaasDesign.displaySmall.copyWith(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: ModernSaasDesign.space4),
                child: Text(
                  'Invite Team Members',
                  style: ModernSaasDesign.headlineLarge,
                ),
              ),
              const SizedBox(height: ModernSaasDesign.space4),
              ModernCard(
                margin: const EdgeInsets.symmetric(
                  horizontal: ModernSaasDesign.space4,
                  vertical: ModernSaasDesign.space2,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(ModernSaasDesign.space5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.all(ModernSaasDesign.space2),
                            decoration: BoxDecoration(
                              color: ModernSaasDesign.primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                  ModernSaasDesign.radiusMd),
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
                              style: ModernSaasDesign.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: ModernSaasDesign.space2),
                      Text(
                        'Team members can use the organization code to join during signup.',
                        style: ModernSaasDesign.bodyMedium.copyWith(
                          color: ModernSaasDesign.textSecondary,
                        ),
                      ),
                      const SizedBox(height: ModernSaasDesign.space4),

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
                          const SizedBox(height: ModernSaasDesign.space4),
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

            const SizedBox(height: ModernSaasDesign.space4),

            ModernCard(
              margin: const EdgeInsets.symmetric(
                horizontal: ModernSaasDesign.space4,
                vertical: ModernSaasDesign.space2,
              ),
              padding: const EdgeInsets.all(ModernSaasDesign.space5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(ModernSaasDesign.space2),
                        decoration: BoxDecoration(
                          color:
                              ModernSaasDesign.primary.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(ModernSaasDesign.radiusMd),
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
                    style: ModernSaasDesign.bodyMedium.copyWith(
                      color: ModernSaasDesign.textSecondary,
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
