import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/auth/services/session_timeout_service.dart';
import 'package:carenest/app/features/organization/views/organization_edit_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carenest/app/features/auth/utils/deep_link_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class OrganizationDetailsView extends ConsumerStatefulWidget {
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
  ConsumerState<OrganizationDetailsView> createState() =>
      _OrganizationDetailsViewState();
}

class _OrganizationDetailsViewState
    extends ConsumerState<OrganizationDetailsView> {
  late final ApiMethod _api;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  Map<String, dynamic>? _organization;
  String _selectedTab = 'General';
  latlong2.LatLng? _organizationLocation;

  // Keys for scrolling to sections
  final _generalKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _bankingKey = GlobalKey();
  final _ndisKey = GlobalKey();

  // Map controllers
  final MapController _mapController = MapController();
  google_maps.GoogleMapController? _googleMapController;
  apple_maps.AppleMapController? _appleMapController;

  @override
  void dispose() {
    // Dispose resources
    _scrollController.dispose();
    _mapController.dispose();
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _api = ref.read(app_providers.apiMethodProvider);
    if ((widget.organizationId ?? '').isNotEmpty) {
      _loadOrganization();
    }
  }

  Map<String, dynamic> _toStringDynamicMap(dynamic value) {
    if (value is Map<String, dynamic>) return Map<String, dynamic>.from(value);
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  Map<String, dynamic> _mergeOrganizationData(
    Map<String, dynamic>? base,
    Map<String, dynamic> updates,
  ) {
    final merged = Map<String, dynamic>.from(base ?? const <String, dynamic>{});
    updates.forEach((key, value) {
      if (value is Map) {
        final existing = _toStringDynamicMap(merged[key]);
        merged[key] = {
          ...existing,
          ..._toStringDynamicMap(value),
        };
      } else {
        merged[key] = value;
      }
    });
    return merged;
  }

  bool _isUnauthorizedResponse(Map<String, dynamic> response) {
    final statusCode = response['statusCode'];
    if (statusCode == 401 || statusCode == 403) {
      return true;
    }

    final lowerMessage = (response['message'] ?? '').toString().toLowerCase();
    return lowerMessage.contains('unauthorized') ||
        lowerMessage.contains('authentication failed') ||
        lowerMessage.contains('token expired') ||
        lowerMessage.contains('session expired');
  }

  Future<void> _loadOrganization({bool forceRefresh = false}) async {
    if (widget.organizationId == null) return;
    setState(() => _loading = true);
    try {
      final resp = await _api.getOrganizationDetails(
        widget.organizationId!,
        forceRefresh: forceRefresh,
      );

      if (_isUnauthorizedResponse(resp)) {
        await SessionTimeoutService().logoutAndClearSession(
          reason: 'organization_details_unauthorized',
        );
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Session expired. Please sign in again.',
              style: BauhausDesign.getTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: BauhausDesign.surfaceWhite),
            ),
            backgroundColor: BauhausDesign.warning,
          ),
        );

        Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
          Routes.login,
          (route) => false,
        );
        return;
      }

      final org = _toStringDynamicMap(resp['organization'] ?? resp['data']);
      if (org.isNotEmpty) {
        setState(() {
          _organization = org;
        });
        _loadLocation();
      }
    } catch (e) {
      debugPrint('Error loading organization: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrganizationEditView(
          organizationId: widget.organizationId,
          organizationName: widget.organizationName,
          organizationCode: widget.organizationCode,
          userEmail: widget.userEmail,
        ),
      ),
    );

    if (!mounted) return;

    bool didUpdate = result == true;

    if (result is Map) {
      final resultMap = _toStringDynamicMap(result);
      didUpdate = resultMap['updated'] == true || didUpdate;
      final optimisticOrg = _toStringDynamicMap(resultMap['organization']);
      if (optimisticOrg.isNotEmpty) {
        setState(() {
          _organization = _mergeOrganizationData(_organization, optimisticOrg);
        });
        _loadLocation();
      }
    }

    if (didUpdate && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.organizationSaved,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.surfaceWhite,
                ),
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      await _loadOrganization(forceRefresh: true);
    }
  }

  String _generateShareableLink() {
    final code = (_organization?['code'] ?? widget.organizationCode ?? '')
        .toString()
        .trim();
    return DeepLinkHandler.generateSignupLink(code);
  }

  String _generateAppSchemeLink() {
    final code = (_organization?['code'] ?? widget.organizationCode ?? '')
        .toString()
        .trim();
    return DeepLinkHandler.generateCustomSchemeSignupLink(
      code,
    );
  }

  Future<void> _shareOrganizationCode() async {
    final l10n = AppLocalizations.of(context)!;
    final webLink = _generateShareableLink();
    final appLink = _generateAppSchemeLink();
    final code = (_organization?['code'] ?? widget.organizationCode ?? '')
        .toString()
        .trim();
    final shareText = '''
${l10n.joinOrganizationMessage(widget.organizationName ?? l10n.organization)}

${l10n.organizationCodeParam(code)}

${l10n.orSignupLink}
$webLink

APP LINK (opens app directly):
$appLink
''';

    // iOS/iPad requires a non-zero share origin rectangle.
    final overlayRenderBox =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    final currentRenderBox = context.findRenderObject() as RenderBox?;
    final shareOrigin = (overlayRenderBox != null && overlayRenderBox.hasSize)
        ? (Offset.zero & overlayRenderBox.size)
        : (currentRenderBox != null && currentRenderBox.hasSize)
            ? (currentRenderBox.localToGlobal(Offset.zero) &
                currentRenderBox.size)
            : const Rect.fromLTWH(0, 0, 1, 1);

    try {
      await Share.share(
        shareText,
        subject: '${l10n.joinOrganization} ${widget.organizationName}',
        sharePositionOrigin: shareOrigin,
      );
    } catch (e) {
      debugPrint('Error sharing organization invite: $e');
      await Clipboard.setData(ClipboardData(text: shareText));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Share failed. Invite text copied to clipboard.',
            style: BauhausDesign.getTextTheme(context)
                .bodyMedium
                ?.copyWith(color: BauhausDesign.surfaceWhite),
          ),
          backgroundColor: BauhausDesign.warning,
        ),
      );
    }
  }

  Future<void> _copyOrganizationCode() async {
    final code = (_organization?['code'] ?? widget.organizationCode ?? '')
        .toString()
        .trim();
    if (code.isEmpty) return;
    await _copyValueToClipboard(code,
        successMessage: 'Organization code copied');
  }

  Future<void> _copyValueToClipboard(
    String value, {
    String successMessage = 'Copied to clipboard',
  }) async {
    final normalizedValue = value.trim();
    if (normalizedValue.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: normalizedValue));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          successMessage,
          style: BauhausDesign.getTextTheme(context)
              .bodyMedium
              ?.copyWith(color: BauhausDesign.surfaceWhite),
        ),
        backgroundColor: BauhausDesign.success,
      ),
    );
  }

  Future<void> _launchExternalUri(
    Uri uri, {
    String? fallbackCopyValue,
  }) async {
    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched && fallbackCopyValue != null) {
        await _copyValueToClipboard(fallbackCopyValue);
      }
    } catch (e) {
      debugPrint('Error launching uri $uri: $e');
      if (fallbackCopyValue != null) {
        await _copyValueToClipboard(fallbackCopyValue);
      }
    }
  }

  Future<void> _openEmail(String email) async {
    final normalized = email.trim();
    if (!_hasDisplayValue(normalized)) return;
    await _launchExternalUri(
      Uri(
        scheme: 'mailto',
        path: normalized,
      ),
      fallbackCopyValue: normalized,
    );
  }

  Future<void> _openPhone(String phone) async {
    final normalized = phone.trim();
    if (!_hasDisplayValue(normalized)) return;
    await _launchExternalUri(
      Uri(
        scheme: 'tel',
        path: normalized,
      ),
      fallbackCopyValue: normalized,
    );
  }

  Future<void> _openWebsite(String website) async {
    final raw = website.trim();
    if (!_hasDisplayValue(raw)) return;
    final normalized = raw.startsWith('http://') || raw.startsWith('https://')
        ? raw
        : 'https://$raw';
    await _launchExternalUri(
      Uri.parse(normalized),
      fallbackCopyValue: raw,
    );
  }

  String _composeFullAddress(Map<String, dynamic> address) {
    final street = (address['street'] ?? '').toString().trim();
    final city = (address['city'] ?? '').toString().trim();
    final state = (address['state'] ?? '').toString().trim();
    final postcode = (address['postcode'] ?? '').toString().trim();
    final rawCountry = (address['country'] ?? '').toString().trim();
    final hasAddressCore =
        [street, city, state, postcode].any((part) => part.isNotEmpty);
    final country = rawCountry.isNotEmpty
        ? rawCountry
        : (hasAddressCore ? 'Australia' : '');

    return [street, city, state, postcode, country]
        .where((part) => part.isNotEmpty)
        .join(', ');
  }

  Future<void> _loadLocation() async {
    if (_organization == null) return;
    final address = _organization?['address'] as Map<String, dynamic>? ?? {};
    final fullAddress = _composeFullAddress(address);

    if (fullAddress.isEmpty) return;

    try {
      final locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        if (mounted) {
          setState(() {
            _organizationLocation = latlong2.LatLng(
                locations.first.latitude, locations.first.longitude);
          });
        }
      }
    } catch (e) {
      debugPrint('Error geocoding address: $e');
    }
  }

  Future<void> _openMap() async {
    if (_organizationLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.locationUnavailable,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.surfaceWhite,
                ),
          ),
          backgroundColor: BauhausDesign.error,
        ),
      );
      return;
    }

    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        backgroundColor: BauhausDesign.surfaceWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(BauhausDesign.radiusLg)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: BauhausDesign.neutral,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    Text(
                      AppLocalizations.of(context)!.openWith,
                      style: BauhausDesign.getTextTheme(context).titleLarge,
                    ),
                    const SizedBox(height: BauhausDesign.space4),
                    ...availableMaps.map((map) => ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            map.showMarker(
                              coords: Coords(
                                _organizationLocation!.latitude,
                                _organizationLocation!.longitude,
                              ),
                              title: _organization?['name'] ??
                                  AppLocalizations.of(context)!.organization,
                            );
                          },
                          leading: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(BauhausDesign.radiusSm),
                            child: SvgPicture.asset(
                              map.icon,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          title: Text(
                            map.mapName,
                            style:
                                BauhausDesign.getTextTheme(context).bodyLarge,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('Error opening map: $e');
    }
  }

  void _showQRCodeDialog() {
    final link = _generateShareableLink();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: BauhausCard(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.joinOrganization,
                style: BauhausDesign.getTextTheme(context).headlineSmall,
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                AppLocalizations.of(context)!.scanToJoin(
                    widget.organizationName ??
                        AppLocalizations.of(context)!.organization),
                textAlign: TextAlign.center,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textMuted,
                    ),
              ),
              const SizedBox(height: BauhausDesign.space6),
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
                  border: Border.all(color: BauhausDesign.neutral),
                ),
                child: QrImageView(
                  data: link,
                  version: QrVersions.auto,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: BauhausDesign.space6),
              BauhausActionButton(
                onPressed: () => Navigator.pop(context),
                text: AppLocalizations.of(context)!.closeButton,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToSection(String tabName) {
    setState(() => _selectedTab = tabName);
    GlobalKey? key;
    switch (tabName) {
      case 'General':
        key = _generalKey;
        break;
      case 'Contact':
        key = _contactKey;
        break;
      case 'Banking':
        key = _bankingKey;
        break;
      case 'NDIS':
        key = _ndisKey;
        break;
    }

    // Run after frame so section contexts are attached before scrolling.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || key?.currentContext == null) return;
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.08,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Data extraction
    final name =
        _organization?['name'] ?? widget.organizationName ?? l10n.organization;
    final tradingName =
        (_organization?['tradingName']?.toString().isNotEmpty == true)
            ? _organization!['tradingName']
            : _organization?['name'] ?? l10n.notSet;
    final code = _organization?['code'] ?? widget.organizationCode ?? '...';
    final abn = _organization?['abn'] ?? l10n.notSet;
    final address = _organization?['address'] as Map<String, dynamic>? ?? {};
    final contact =
        _organization?['contactDetails'] as Map<String, dynamic>? ?? {};
    final bank = _organization?['bankDetails'] as Map<String, dynamic>? ?? {};
    final ndis =
        _organization?['ndisRegistration'] as Map<String, dynamic>? ?? {};

    final fullAddress = _composeFullAddress(address);

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.secondary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: BauhausDesign.surfaceWhite,
        ),
        title: Text(
          l10n.organizationDetails.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                letterSpacing: 1.0,
                color: BauhausDesign.surfaceWhite,
                fontWeight: FontWeight.w900,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _navigateToEdit,
            icon: const Icon(Icons.edit_outlined),
            color: BauhausDesign.surfaceWhite,
            tooltip: l10n.editOrganization,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: BauhausDesign.neutral,
            height: 1,
          ),
        ),
      ),
      body: _loading
          ? Center(child: BauhausLoadingState())
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Profile Header & Org Code
                SliverToBoxAdapter(
                  child: _buildHeroSection(
                    name: name,
                    code: code,
                    subtitle:
                        '${l10n.enterprisePlan} • ID: ${_organization?['id']?.toString().substring(0, 4) ?? '...'}',
                  ),
                ),

                // Sticky Tab Header
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SectionHeaderDelegate(
                    height: 72,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space4,
                        vertical: BauhausDesign.space2,
                      ),
                      child: Row(
                        children: [
                          _buildTab(AppLocalizations.of(context)!.generalTab,
                              'General', _selectedTab == 'General'),
                          const SizedBox(width: BauhausDesign.space3),
                          _buildTab(AppLocalizations.of(context)!.contactTab,
                              'Contact', _selectedTab == 'Contact'),
                          const SizedBox(width: BauhausDesign.space3),
                          _buildTab(AppLocalizations.of(context)!.banking,
                              'Banking', _selectedTab == 'Banking'),
                          const SizedBox(width: BauhausDesign.space3),
                          _buildTab(AppLocalizations.of(context)!.ndisTab,
                              'NDIS', _selectedTab == 'NDIS'),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content Sections
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: BauhausDesign.space4),

                      // General Information
                      _buildSectionCard(
                        context,
                        key: _generalKey,
                        title: AppLocalizations.of(context)!.generalInformation,
                        icon: Icons.info_outline,
                        iconColor: BauhausDesign.primary,
                        iconBackgroundColor:
                            BauhausDesign.primary.withOpacity(0.1),
                        children: [
                          _buildDetailRow(
                              context,
                              AppLocalizations.of(context)!.tradingNameLabel,
                              tradingName),
                          _buildDetailRow(
                              context,
                              AppLocalizations.of(context)!.companyNameLabel,
                              name), // Fallback if same
                          _buildDetailRow(context,
                              AppLocalizations.of(context)!.abnLabel, abn),
                          // Map Section
                          const SizedBox(height: BauhausDesign.space4),
                          _buildMetaLabel(
                              AppLocalizations.of(context)!.location),
                          const SizedBox(height: BauhausDesign.space2),
                          _buildLocationPanel(
                            fullAddress:
                                fullAddress.isEmpty ? l10n.notSet : fullAddress,
                          ),
                        ],
                      ),

                      const SizedBox(height: BauhausDesign.space4),

                      // Contact Details
                      _buildSectionCard(
                        context,
                        key: _contactKey,
                        title: AppLocalizations.of(context)!.contactDetails,
                        icon: Icons.contact_phone_outlined,
                        iconColor: BauhausDesign.secondary, // Or purple/accent
                        iconBackgroundColor:
                            BauhausDesign.secondary.withOpacity(0.1),
                        children: [
                          _buildDetailRow(
                            context,
                            AppLocalizations.of(context)!
                                .emailLabel
                                .toUpperCase(),
                            contact['email'] ?? l10n.notSet,
                            isEmail: true,
                            showCopy: true,
                          ),
                          _buildDetailRow(
                            context,
                            AppLocalizations.of(context)!
                                .phoneNumber
                                .toUpperCase(),
                            contact['phone'] ?? l10n.notSet,
                            isPhone: true,
                            showCopy: true,
                          ),
                          _buildDetailRow(
                            context,
                            AppLocalizations.of(context)!.websiteLabel,
                            contact['website'] ?? l10n.notSet,
                            isWebsite: true,
                            showCopy: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: BauhausDesign.space4),

                      // Banking Details
                      _buildSectionCard(
                        context,
                        key: _bankingKey,
                        title: AppLocalizations.of(context)!.bankDetailsTitle,
                        icon: Icons.account_balance_outlined,
                        iconColor: BauhausDesign.warning,
                        iconBackgroundColor:
                            BauhausDesign.warning.withOpacity(0.1),
                        trailing: Builder(builder: (context) {
                          final isVerified = bank['isVerified'] == true;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isVerified
                                  ? BauhausDesign.success.withOpacity(0.1)
                                  : BauhausDesign.error.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(BauhausDesign.radiusSm),
                              border: Border.all(
                                  color: isVerified
                                      ? BauhausDesign.success.withOpacity(0.5)
                                      : BauhausDesign.error.withOpacity(0.5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isVerified) ...[
                                  const Icon(Icons.check_circle,
                                      size: 12, color: BauhausDesign.success),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  isVerified
                                      ? AppLocalizations.of(context)!
                                          .verified
                                          .toUpperCase()
                                      : AppLocalizations.of(context)!
                                          .unverified
                                          .toUpperCase(),
                                  style: BauhausDesign.getTextTheme(context)
                                      .labelSmall
                                      ?.copyWith(
                                        color: isVerified
                                            ? BauhausDesign.success
                                            : BauhausDesign.error,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }),
                        children: [
                          _buildInstitutionRow(
                              context, bank['bankName'] ?? l10n.notSet),
                          Row(
                            children: [
                              Expanded(
                                  child: _buildDetailRow(
                                      context,
                                      AppLocalizations.of(context)!.bsbLabel,
                                      bank['bsb'] ?? l10n.notSet)),
                              const SizedBox(width: BauhausDesign.space3),
                              Expanded(
                                  child: _buildDetailRow(
                                      context,
                                      AppLocalizations.of(context)!
                                          .accountNoLabel,
                                      bank['accountNumber'] ?? l10n.notSet)),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: BauhausDesign.space4),

                      // NDIS Registration
                      _buildSectionCard(
                        context,
                        key: _ndisKey,
                        title: AppLocalizations.of(context)!.ndisRegistration,
                        icon: Icons.medical_services_outlined,
                        iconColor: BauhausDesign.secondary,
                        iconBackgroundColor:
                            BauhausDesign.secondary.withOpacity(0.12),
                        children: [
                          if (ndis['isRegistered'] == true) ...[
                            Builder(builder: (context) {
                              final status = _getNdisStatus(ndis);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: BauhausDesign.space4,
                                    horizontal: BauhausDesign.space4),
                                decoration: BoxDecoration(
                                  color: BauhausDesign.surfaceWhite,
                                  borderRadius: BorderRadius.circular(
                                      BauhausDesign.radiusMd),
                                  border:
                                      Border.all(color: BauhausDesign.neutral),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .status,
                                              style: BauhausDesign.getTextTheme(
                                                      context)
                                                  .labelSmall
                                                  ?.copyWith(
                                                      color: BauhausDesign
                                                          .textMuted),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    color: status['color']
                                                        as Color,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  status['text'] as String,
                                                  style: BauhausDesign
                                                          .getTextTheme(context)
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: status['color']
                                                            as Color,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: BauhausDesign.neutral,
                                        thickness: 1,
                                        width: 24,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .expires,
                                              style: BauhausDesign.getTextTheme(
                                                      context)
                                                  .labelSmall
                                                  ?.copyWith(
                                                      color: BauhausDesign
                                                          .textMuted),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _formatDate(ndis['renewalDate'] ??
                                                  ndis['expiryDate']),
                                              style: BauhausDesign.getTextTheme(
                                                      context)
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: BauhausDesign.space4),
                            _buildDetailRow(
                                context,
                                AppLocalizations.of(context)!
                                    .registrationNumberLabel,
                                ndis['registrationNumber'] ?? l10n.notSet,
                                showCopy: true),
                          ] else ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: BauhausDesign.space3,
                                vertical: BauhausDesign.space3,
                              ),
                              decoration: BoxDecoration(
                                color: BauhausDesign.surfaceOffWhite,
                                borderRadius: BorderRadius.circular(
                                    BauhausDesign.radiusMd),
                                border:
                                    Border.all(color: BauhausDesign.neutral),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: BauhausDesign.neutral,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: BauhausDesign.space2),
                                  Text(
                                    AppLocalizations.of(context)!.notRegistered,
                                    style: BauhausDesign.getTextTheme(context)
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: BauhausDesign.space6),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeroSection({
    required String name,
    required String code,
    required String subtitle,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final isVerified = _organization?['isVerified'] == true;
    final logoUrl = _organization?['logoUrl']?.toString();

    return Container(
      margin: const EdgeInsets.fromLTRB(
        BauhausDesign.space4,
        BauhausDesign.space6,
        BauhausDesign.space4,
        BauhausDesign.space6,
      ),
      decoration: BoxDecoration(
        color: BauhausDesign.secondary,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BauhausDesign.surfaceWhite,
                        image: (logoUrl != null && logoUrl.isNotEmpty)
                            ? DecorationImage(
                                image: NetworkImage(logoUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                        border: Border.all(color: BauhausDesign.neutral),
                      ),
                      child: (logoUrl == null || logoUrl.isEmpty)
                          ? const Icon(
                              Icons.business_rounded,
                              color: BauhausDesign.primary,
                              size: 30,
                            )
                          : null,
                    ),
                    if (isVerified)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: BauhausDesign.success,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: BauhausDesign.getTextTheme(context)
                            .headlineMedium
                            ?.copyWith(
                              color: BauhausDesign.surfaceWhite,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.2,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        subtitle,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              color:
                                  BauhausDesign.surfaceWhite.withOpacity(0.85),
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BauhausDesign.space2,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isVerified
                              ? BauhausDesign.success
                              : BauhausDesign.accent,
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(color: BauhausDesign.neutral),
                        ),
                        child: Text(
                          isVerified
                              ? l10n.verified.toUpperCase()
                              : l10n.unverified.toUpperCase(),
                          style: BauhausDesign.getTextTheme(context)
                              .labelSmall
                              ?.copyWith(
                                color: BauhausDesign.neutral,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                top: BorderSide(color: BauhausDesign.neutral, width: 2),
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.organizationCode.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              color: BauhausDesign.primary,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        code,
                        style: BauhausDesign.getTextTheme(context)
                            .headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space1),
                      Text(
                        l10n.shareCodeInvite,
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(color: BauhausDesign.textMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                _buildActionIcon(
                  icon: Icons.copy_rounded,
                  label: 'COPY',
                  onTap: _copyOrganizationCode,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Row(
              children: [
                Expanded(
                  child: _buildInviteActionTile(
                    icon: Icons.qr_code_2_outlined,
                    title: 'SHOW QR',
                    color: BauhausDesign.accent,
                    onTap: _showQRCodeDialog,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: _buildInviteActionTile(
                    icon: Icons.ios_share_outlined,
                    title: 'SHARE LINK',
                    color: BauhausDesign.primary,
                    onTap: _shareOrganizationCode,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInviteActionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space3,
          vertical: BauhausDesign.space3,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: const [BauhausDesign.shadowHardSm],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: BauhausDesign.neutral, size: 18),
            const SizedBox(width: BauhausDesign.space2),
            Text(
              title,
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
            color: BauhausDesign.secondary,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
          ),
    );
  }

  Widget _buildMapCtaChip({
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space2,
          vertical: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: BauhausDesign.accent,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          border: Border.all(color: BauhausDesign.neutral, width: 1.5),
          boxShadow: const [BauhausDesign.shadowHardXs],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.open_in_new_rounded,
              size: 14,
              color: BauhausDesign.neutral,
            ),
            const SizedBox(width: BauhausDesign.space1),
            Text(
              AppLocalizations.of(context)!.openMap.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPanel({required String fullAddress}) {
    final hasLocation = _organizationLocation != null;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: 2,
        ),
        color: BauhausDesign.surfaceOffWhite,
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                Positioned.fill(child: _buildEmbeddedMap()),
                Positioned(
                  top: BauhausDesign.space2,
                  left: BauhausDesign.space2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BauhausDesign.space2,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(BauhausDesign.radiusSm),
                      border: Border.all(color: BauhausDesign.neutral),
                    ),
                    child: Text(
                      hasLocation
                          ? l10n.location.toUpperCase()
                          : l10n.locationNotSet.toUpperCase(),
                      style: BauhausDesign.getTextTheme(context)
                          .labelSmall
                          ?.copyWith(
                            color: BauhausDesign.neutral,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: BauhausDesign.space2,
                  right: BauhausDesign.space2,
                  child: _buildMapCtaChip(onTap: _openMap),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space3,
              vertical: BauhausDesign.space3,
            ),
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                top: BorderSide(
                  color: BauhausDesign.neutral,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.place_outlined,
                  size: 16,
                  color: BauhausDesign.secondary,
                ),
                const SizedBox(width: BauhausDesign.space2),
                Expanded(
                  child: Text(
                    fullAddress,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmbeddedMap() {
    if (_organizationLocation == null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _MapGridPainter()),
          Center(
            child: Text(
              AppLocalizations.of(context)!.locationNotSet,
              style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                    color: BauhausDesign.textMuted,
                  ),
            ),
          ),
        ],
      );
    }

    if (Platform.isIOS) {
      return apple_maps.AppleMap(
        onMapCreated: (apple_maps.AppleMapController controller) {
          _appleMapController = controller;
        },
        initialCameraPosition: apple_maps.CameraPosition(
          target: apple_maps.LatLng(
            _organizationLocation!.latitude,
            _organizationLocation!.longitude,
          ),
          zoom: 15,
        ),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        pitchGesturesEnabled: false,
      );
    } else if (Platform.isAndroid) {
      return google_maps.GoogleMap(
        onMapCreated: (google_maps.GoogleMapController controller) {
          _googleMapController = controller;
        },
        initialCameraPosition: google_maps.CameraPosition(
          target: google_maps.LatLng(
            _organizationLocation!.latitude,
            _organizationLocation!.longitude,
          ),
          zoom: 15,
        ),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        liteModeEnabled: false,
      );
    }

    // Fallback for Web/Desktop/Other
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _organizationLocation!,
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.bishal.invoice',
        ),
      ],
    );
  }

  Color _tabColorFor(String key) {
    switch (key) {
      case 'General':
        return BauhausDesign.primary;
      case 'Contact':
        return BauhausDesign.secondary;
      case 'Banking':
        return BauhausDesign.accent;
      case 'NDIS':
        return BauhausDesign.info;
      default:
        return BauhausDesign.primary;
    }
  }

  Color _tabTextColorFor(
    String key, {
    required bool isSelected,
  }) {
    if (!isSelected) return BauhausDesign.textMuted;
    final color = _tabColorFor(key);
    if (color == BauhausDesign.accent || color.computeLuminance() > 0.6) {
      return BauhausDesign.neutral;
    }
    return BauhausDesign.surfaceWhite;
  }

  Widget _buildTab(String label, String key, bool isSelected) {
    final tabColor = _tabColorFor(key);
    return GestureDetector(
      onTap: () => _scrollToSection(key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: BauhausDesign.space4,
          vertical: BauhausDesign.space2,
        ),
        decoration: BoxDecoration(
          color: isSelected ? tabColor : BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusPill),
          border: Border.all(color: BauhausDesign.neutral, width: 2),
          boxShadow: isSelected
              ? const [BauhausDesign.shadowHardSm]
              : const [BauhausDesign.shadowHardXs],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _tabTextColorFor(key, isSelected: true),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: BauhausDesign.space2),
            ],
            Text(
              label.toUpperCase(),
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: _tabTextColorFor(key, isSelected: isSelected),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
    Color? iconBackgroundColor,
    Color? iconColor,
    Widget? trailing,
    Key? key,
  }) {
    final accentColor = iconColor ?? BauhausDesign.primary;
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: const [BauhausDesign.shadowHardSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 9,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(BauhausDesign.radiusLg - 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: iconBackgroundColor ??
                            accentColor.withOpacity(0.15),
                        borderRadius:
                            BorderRadius.circular(BauhausDesign.radiusSm),
                        border: Border.all(color: BauhausDesign.neutral),
                      ),
                      child: Icon(icon, color: accentColor, size: 20),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: Text(
                        title.toUpperCase(),
                        style: BauhausDesign.getTextTheme(context)
                            .labelLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                      ),
                    ),
                    if (trailing != null) trailing,
                  ],
                ),
                const SizedBox(height: BauhausDesign.space4),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionRow(BuildContext context, String bankName) {
    final l10n = AppLocalizations.of(context)!;
    final normalizedName =
        bankName.trim().isEmpty ? l10n.notSet : bankName.trim();
    final hasInstitution = _hasDisplayValue(normalizedName);
    String initials = '';
    if (hasInstitution) {
      final parts = normalizedName.split(' ');
      if (parts.isNotEmpty && parts[0].isNotEmpty) {
        initials += parts[0][0];
      }
      if (parts.length > 1 && parts[1].isNotEmpty) {
        initials += parts[1][0];
      }
      initials = initials.toUpperCase();
    } else {
      initials = '?';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceOffWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              margin: const EdgeInsets.only(right: BauhausDesign.space3),
              decoration: BoxDecoration(
                color: hasInstitution
                    ? BauhausDesign.warning
                    : BauhausDesign.surfaceWhite,
                borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                border: Border.all(color: BauhausDesign.neutral),
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      color: BauhausDesign.neutral,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.institutionLabel.toUpperCase(),
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.secondary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  Text(
                    normalizedName,
                    style:
                        BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: hasInstitution
                                  ? BauhausDesign.textDark
                                  : BauhausDesign.textMuted,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getNdisStatus(Map<String, dynamic> ndis) {
    final dateStr = ndis['renewalDate'] ?? ndis['expiryDate'];
    if (dateStr == null) {
      return {
        'text': AppLocalizations.of(context)!.active,
        'color': BauhausDesign.success
      };
    }

    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final expiry = DateTime(date.year, date.month, date.day);

      if (expiry.isBefore(today)) {
        return {
          'text': AppLocalizations.of(context)!.expired,
          'color': BauhausDesign.error
        };
      }
      return {
        'text': AppLocalizations.of(context)!.active,
        'color': BauhausDesign.success
      };
    } catch (_) {
      return {
        'text': AppLocalizations.of(context)!.active,
        'color': BauhausDesign.success
      };
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return AppLocalizations.of(context)!.notSet;
    try {
      final date = DateTime.parse(dateStr);
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return dateStr;
    }
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool showCopy = false,
    bool isEmail = false,
    bool isPhone = false,
    bool isWebsite = false,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final normalizedValue = value.trim().isEmpty ? l10n.notSet : value.trim();
    final hasValue = _hasDisplayValue(normalizedValue);
    final showActions = showCopy || isEmail || isPhone || isWebsite;

    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space3),
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: BoxDecoration(
          color: BauhausDesign.surfaceOffWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
          border: Border.all(color: BauhausDesign.neutral),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.secondary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space1),
                  isWebsite
                      ? Tooltip(
                          message: normalizedValue,
                          child: Text(
                            normalizedValue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: hasValue
                                      ? BauhausDesign.textDark
                                      : BauhausDesign.textMuted,
                                ),
                          ),
                        )
                      : Text(
                          normalizedValue,
                          style: BauhausDesign.getTextTheme(context)
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: hasValue
                                    ? BauhausDesign.textDark
                                    : BauhausDesign.textMuted,
                              ),
                        ),
                ],
              ),
            ),
            if (showActions && hasValue) ...[
              const SizedBox(width: BauhausDesign.space2),
              Wrap(
                spacing: BauhausDesign.space1,
                runSpacing: BauhausDesign.space1,
                children: [
                  if (showCopy)
                    _buildRowActionChip(
                      icon: Icons.copy_rounded,
                      color: BauhausDesign.primary,
                      onTap: () {
                        _copyValueToClipboard(normalizedValue);
                      },
                    ),
                  if (isEmail)
                    _buildRowActionChip(
                      icon: Icons.email_outlined,
                      color: BauhausDesign.secondary,
                      onTap: () {
                        _openEmail(normalizedValue);
                      },
                    ),
                  if (isPhone)
                    _buildRowActionChip(
                      icon: Icons.phone_outlined,
                      color: BauhausDesign.accent,
                      onTap: () {
                        _openPhone(normalizedValue);
                      },
                    ),
                  if (isWebsite)
                    _buildRowActionChip(
                      icon: Icons.open_in_new_rounded,
                      color: BauhausDesign.info,
                      onTap: () {
                        _openWebsite(normalizedValue);
                      },
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRowActionChip({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
          border: Border.all(color: BauhausDesign.neutral),
          boxShadow: const [BauhausDesign.shadowHardXs],
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 15,
          color: color.computeLuminance() > 0.6
              ? BauhausDesign.neutral
              : BauhausDesign.surfaceWhite,
        ),
      ),
    );
  }

  bool _hasDisplayValue(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return false;
    final notSet = AppLocalizations.of(context)!.notSet.toLowerCase();
    return normalized.toLowerCase() != notSet;
  }

  Widget _buildActionIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceLight,
              borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
              border: Border.all(color: BauhausDesign.neutral),
            ),
            child: Icon(icon, color: BauhausDesign.textDark),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SectionHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: const Border(
          top: BorderSide(color: BauhausDesign.neutral, width: 2),
          bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
        ),
        boxShadow: overlapsContent ? const [BauhausDesign.shadowHardXs] : null,
      ),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SectionHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.05)
      ..strokeWidth = 1;

    const gridSize = 20.0;
    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
