import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:carenest/app/features/organization/views/organization_edit_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
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

  Future<void> _loadOrganization() async {
    if (widget.organizationId == null) return;
    setState(() => _loading = true);
    try {
      final resp = await _api.getOrganizationDetails(widget.organizationId!);
      final org =
          (resp['organization'] ?? resp['data']) as Map<String, dynamic>?;
      if (org != null) {
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

    if (result == true && mounted) {
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
    }
    _loadOrganization(); // Reload after edit
  }

  String _generateShareableLink() {
    return DeepLinkHandler.generateSignupLink(widget.organizationCode ?? '');
  }

  Future<void> _shareOrganizationCode() async {
    final l10n = AppLocalizations.of(context)!;
    final shareText = '''
${l10n.joinOrganizationMessage(widget.organizationName ?? l10n.organization)}

${l10n.organizationCodeParam(widget.organizationCode ?? '')}

${l10n.orSignupLink}
${_generateShareableLink()}
''';

    await Share.share(
      shareText,
      subject: '${l10n.joinOrganization} ${widget.organizationName}',
    );
  }

  Future<void> _loadLocation() async {
    if (_organization == null) return;
    final address = _organization?['address'] as Map<String, dynamic>? ?? {};
    final fullAddress = [
      address['street'],
      address['city'],
      address['state'],
      address['postcode'],
      address['country']
    ].where((e) => e != null && e.toString().isNotEmpty).join(', ');

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

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.1,
      );
    }
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

    final fullAddress = [
      address['street'],
      address['city'],
      address['state'],
      address['postcode'],
      address['country']
    ].where((e) => e != null && e.toString().isNotEmpty).join(', ');

    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        leading: BauhausIconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icons.arrow_back_ios_new,
          variant: BauhausActionVariant.ghost,
          isSmall: true,
        ),
        title: Text(
          l10n.organizationDetails.toUpperCase(),
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
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
          : Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    // Profile Header & Org Code
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: BauhausDesign.space6),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: BauhausDesign.surfaceWhite,
                                  image: _organization?['logoUrl'] != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              _organization!['logoUrl']),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  border: Border.all(
                                      color: BauhausDesign.neutral, width: 1),
                                ),
                                child: _organization?['logoUrl'] == null
                                    ? const Icon(Icons.business_rounded,
                                        color: BauhausDesign.primary, size: 40)
                                    : null,
                              ),
                              if (_organization?['isVerified'] ==
                                  true) // Assuming field
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: BauhausDesign.success,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check,
                                      color: Colors.white, size: 12),
                                ),
                            ],
                          ),
                          const SizedBox(height: BauhausDesign.space4),
                          Text(
                            name,
                            style: BauhausDesign.getTextTheme(context)
                                .headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: BauhausDesign.space1),
                          Text(
                            '${l10n.enterprisePlan} • ID: ${_organization?['id']?.toString().substring(0, 4) ?? '...'}',
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: BauhausDesign.textMuted,
                                ),
                          ),
                          const SizedBox(height: BauhausDesign.space6),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: BauhausDesign.space4),
                            child: BauhausCard(
                              padding:
                                  const EdgeInsets.all(BauhausDesign.space4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          l10n.organizationCode.toUpperCase(),
                                          style: BauhausDesign.getTextTheme(
                                                  context)
                                              .labelSmall
                                              ?.copyWith(
                                                color: BauhausDesign.primary,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                        ),
                                        const SizedBox(
                                            height: BauhausDesign.space2),
                                        Text(
                                          code,
                                          style: BauhausDesign.getTextTheme(
                                                  context)
                                              .headlineMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                              ),
                                        ),
                                        const SizedBox(
                                            height: BauhausDesign.space1),
                                        Text(
                                          l10n.shareCodeInvite,
                                          style: BauhausDesign.getTextTheme(
                                                  context)
                                              .bodySmall
                                              ?.copyWith(
                                                color: BauhausDesign.textMuted,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _buildActionIcon(
                                    icon: Icons.qr_code,
                                    label: 'QR',
                                    onTap: _showQRCodeDialog,
                                  ),
                                  const SizedBox(width: BauhausDesign.space3),
                                  _buildActionIcon(
                                    icon: Icons.ios_share,
                                    label: 'SHARE',
                                    onTap: _shareOrganizationCode,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: BauhausDesign.space6),
                        ],
                      ),
                    ),

                    // Sticky Tab Header
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SectionHeaderDelegate(
                        height: 60,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: BauhausDesign.space4),
                          child: Row(
                            children: [
                              _buildTab(
                                  AppLocalizations.of(context)!.generalTab,
                                  'General',
                                  _selectedTab == 'General'),
                              const SizedBox(width: BauhausDesign.space3),
                              _buildTab(
                                  AppLocalizations.of(context)!.contactTab,
                                  'Contact',
                                  _selectedTab == 'Contact'),
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
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const SizedBox(height: BauhausDesign.space4),

                          // General Information
                          _buildSectionCard(
                            context,
                            key: _generalKey,
                            title: AppLocalizations.of(context)!
                                .generalInformation,
                            icon: Icons.info_outline,
                            iconColor: BauhausDesign.primary,
                            iconBackgroundColor:
                                BauhausDesign.primary.withOpacity(0.1),
                            children: [
                              _buildDetailRow(
                                  context,
                                  AppLocalizations.of(context)!
                                      .tradingNameLabel,
                                  tradingName),
                              _buildDetailRow(
                                  context,
                                  AppLocalizations.of(context)!
                                      .companyNameLabel,
                                  name), // Fallback if same
                              _buildDetailRow(context,
                                  AppLocalizations.of(context)!.abnLabel, abn),
                              // Map Section
                              const SizedBox(height: BauhausDesign.space4),
                              Text(
                                AppLocalizations.of(context)!
                                    .location
                                    .toUpperCase(),
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(
                                      color: BauhausDesign.textMuted,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      BauhausDesign.radiusMd),
                                  border:
                                      Border.all(color: BauhausDesign.neutral),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  children: [
                                    _buildEmbeddedMap(),
                                    Positioned(
                                      bottom: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: _openMap,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: BauhausDesign.surfaceWhite,
                                            borderRadius: BorderRadius.circular(
                                                BauhausDesign.radiusSm),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.map,
                                                  size: 14,
                                                  color:
                                                      BauhausDesign.textDark),
                                              const SizedBox(width: 4),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .openMap,
                                                style:
                                                    BauhausDesign.getTextTheme(
                                                            context)
                                                        .labelSmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: BauhausDesign.space2),
                              Text(
                                fullAddress,
                                style: BauhausDesign.getTextTheme(context)
                                    .bodyMedium,
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
                            iconColor:
                                BauhausDesign.secondary, // Or purple/accent
                            iconBackgroundColor:
                                BauhausDesign.secondary.withOpacity(0.1),
                            children: [
                              _buildDetailRow(
                                context,
                                AppLocalizations.of(context)!
                                    .emailLabel
                                    .toUpperCase(),
                                contact['email'] ?? 'Not set',
                                isEmail: true,
                                showCopy: true,
                              ),
                              _buildDetailRow(
                                context,
                                AppLocalizations.of(context)!
                                    .phoneNumber
                                    .toUpperCase(),
                                contact['phone'] ?? 'Not set',
                                isPhone: true,
                                showCopy: true,
                              ),
                              _buildDetailRow(
                                context,
                                AppLocalizations.of(context)!.websiteLabel,
                                contact['website'] ?? 'Not set',
                                showCopy: true,
                              ),
                            ],
                          ),

                          const SizedBox(height: BauhausDesign.space4),

                          // Banking Details
                          _buildSectionCard(
                            context,
                            key: _bankingKey,
                            title:
                                AppLocalizations.of(context)!.bankDetailsTitle,
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
                                  borderRadius: BorderRadius.circular(
                                      BauhausDesign.radiusSm),
                                  border: Border.all(
                                      color: isVerified
                                          ? BauhausDesign.success
                                              .withOpacity(0.5)
                                          : BauhausDesign.error
                                              .withOpacity(0.5)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isVerified) ...[
                                      const Icon(Icons.check_circle,
                                          size: 12,
                                          color: BauhausDesign.success),
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
                                          AppLocalizations.of(context)!
                                              .bsbLabel,
                                          bank['bsb'] ?? '...')),
                                  Expanded(
                                      child: _buildDetailRow(
                                          context,
                                          AppLocalizations.of(context)!
                                              .accountNoLabel,
                                          bank['accountNumber'] ?? '...')),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: BauhausDesign.space4),

                          // NDIS Registration
                          _buildSectionCard(
                            context,
                            key: _ndisKey,
                            title:
                                AppLocalizations.of(context)!.ndisRegistration,
                            icon: Icons.medical_services_outlined,
                            iconColor: const Color(0xFFEC4899), // Pink
                            iconBackgroundColor:
                                const Color(0xFFEC4899).withOpacity(0.1),
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
                                      border: Border.all(
                                          color: BauhausDesign.neutral),
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
                                                  style: BauhausDesign
                                                          .getTextTheme(context)
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
                                                              .getTextTheme(
                                                                  context)
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            color:
                                                                status['color']
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
                                                  style: BauhausDesign
                                                          .getTextTheme(context)
                                                      .labelSmall
                                                      ?.copyWith(
                                                          color: BauhausDesign
                                                              .textMuted),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  _formatDate(
                                                      ndis['renewalDate'] ??
                                                          ndis['expiryDate']),
                                                  style: BauhausDesign
                                                          .getTextTheme(context)
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: BauhausDesign.neutral,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .notRegistered,
                                      style: BauhausDesign.getTextTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(
                              height: 100), // Bottom padding for FAB/Button
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    decoration: BoxDecoration(
                      color: BauhausDesign.surfaceLight,
                      border: const Border(
                          top: BorderSide(color: BauhausDesign.neutral)),
                    ),
                    child: BauhausActionButton(
                      onPressed: _navigateToEdit,
                      text: AppLocalizations.of(context)!.editOrganization,
                      icon: Icons.edit_note,
                      isFullWidth: true,
                    ),
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

  Widget _buildTab(String label, String key, bool isSelected) {
    return GestureDetector(
      onTap: () => _scrollToSection(key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? BauhausDesign.primary : BauhausDesign.surfaceWhite,
          borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
          border: isSelected ? null : Border.all(color: BauhausDesign.neutral),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: BauhausDesign.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: BauhausDesign.getTextTheme(context).labelMedium?.copyWith(
                color: isSelected ? Colors.white : BauhausDesign.textMuted,
                fontWeight: FontWeight.bold,
              ),
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
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusLg),
        border: Border.all(color: BauhausDesign.neutral),
        boxShadow: const [BauhausDesign.shadowSoft],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? BauhausDesign.surfaceLight,
                  borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                ),
                child: Icon(icon,
                    color: iconColor ?? BauhausDesign.primary, size: 20),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Text(
                title.toUpperCase(),
                style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing,
              ],
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInstitutionRow(BuildContext context, String bankName) {
    String initials = '';
    if (bankName.isNotEmpty &&
        bankName != AppLocalizations.of(context)!.notSet) {
      final parts = bankName.trim().split(' ');
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
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.institutionLabel,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: BauhausDesign.space2),
          Row(
            children: [
              if (bankName != AppLocalizations.of(context)!.notSet)
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: BauhausDesign.warning,
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              Expanded(
                child: Text(
                  bankName,
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                ),
              ),
            ],
          ),
        ],
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                  color: BauhausDesign.textMuted,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
          ),
          const SizedBox(height: BauhausDesign.space1),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style:
                      BauhausDesign.getTextTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                ),
              ),
              if (showCopy)
                Icon(Icons.copy, color: BauhausDesign.primary, size: 16),
              if (isEmail)
                Icon(Icons.email_outlined,
                    color: BauhausDesign.primary, size: 16),
              if (isPhone)
                Icon(Icons.phone_outlined,
                    color: BauhausDesign.primary, size: 16),
            ],
          ),
        ],
      ),
    );
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
      color: BauhausDesign.surfaceLight,
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
