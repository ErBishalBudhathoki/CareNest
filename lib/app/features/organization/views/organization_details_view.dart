import 'dart:io';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:carenest/app/features/organization/views/organization_edit_view.dart';
import 'package:carenest/backend/api_method.dart';
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
  final _api = ApiMethod();
  bool _loading = false;
  Map<String, dynamic>? _organization;
  String _selectedTab = 'General';
  latlong2.LatLng? _organizationLocation;

  // Keys for scrolling to sections
  final _generalKey = GlobalKey();
  final _contactKey = GlobalKey();
  final _bankingKey = GlobalKey();
  final _ndisKey = GlobalKey();

  @override
  void initState() {
    super.initState();
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
      Flushbar(
        message: 'Organization details saved',
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16.0),
        borderRadius: BorderRadius.circular(8.0),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
    _loadOrganization(); // Reload after edit
  }

  String _generateShareableLink() {
    return DeepLinkHandler.generateSignupLink(widget.organizationCode ?? '');
  }

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
        const SnackBar(content: Text('Location not available')),
      );
      return;
    }

    try {
      final availableMaps = await MapLauncher.installedMaps;

      if (!mounted) return;

      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFF1E293B),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Open with',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...availableMaps.map((map) => ListTile(
                          onTap: () {
                            Navigator.pop(context);
                            map.showMarker(
                              coords: Coords(
                                _organizationLocation!.latitude,
                                _organizationLocation!.longitude,
                              ),
                              title: _organization?['name'] ?? 'Organization',
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SvgPicture.asset(
                              map.icon,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          title: Text(
                            map.mapName,
                            style: const TextStyle(color: Colors.white),
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
        backgroundColor: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Join Organization',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Scan to join ${widget.organizationName}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QrImageView(
                  data: link,
                  version: QrVersions.auto,
                  size: 200,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
        alignment:
            0.1, // Offset slightly to account for sticky header if needed
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dark Theme Colors
    const backgroundColor = Color(0xFF0F172A);
    const cardColor = Color(0xFF1E293B);
    const primaryBlue = Color(0xFF3B82F6);
    const textWhite = Colors.white;
    final textGrey = Colors.grey[400];

    // Data extraction
    final name =
        _organization?['name'] ?? widget.organizationName ?? 'Organization';
    final tradingName =
        (_organization?['tradingName']?.toString().isNotEmpty == true)
            ? _organization!['tradingName']
            : _organization?['name'] ?? 'Not set';
    debugPrint("This is trading name: " + tradingName);
    final code = _organization?['code'] ?? widget.organizationCode ?? '...';
    final abn = _organization?['abn'] ?? 'Not set';
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'DETAILS',
          style: TextStyle(
            color: textWhite,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.settings, color: textWhite),
        //     onPressed: () {
        //       // Settings action
        //     },
        //   ),
        // ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: primaryBlue))
          : Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    // Profile Header & Org Code
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: _organization?['logoUrl'] != null
                                      ? null
                                      : const LinearGradient(
                                          colors: [
                                            Color(0xFF2E3B55),
                                            Color(0xFF1E293B)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                  color: _organization?['logoUrl'] != null
                                      ? const Color(0xFF1E293B)
                                      : null,
                                  image: _organization?['logoUrl'] != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              _organization!['logoUrl']),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  border: Border.all(
                                      color: primaryBlue.withOpacity(0.3),
                                      width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryBlue.withOpacity(0.2),
                                      blurRadius: 20,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: _organization?['logoUrl'] == null
                                    ? const Icon(Icons.business,
                                        color: primaryBlue, size: 40)
                                    : null,
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check,
                                    color: Colors.white, size: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            name,
                            style: const TextStyle(
                              color: textWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Enterprise Plan • ID: ${_organization?['id']?.toString().substring(0, 4) ?? '...'}',
                            style: TextStyle(color: textGrey, fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF151C32),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: primaryBlue.withOpacity(0.3)),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryBlue.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ORGANIZATION CODE',
                                        style: TextStyle(
                                          color: primaryBlue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        code,
                                        style: const TextStyle(
                                          color: textWhite,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Share code to invite members.',
                                        style: TextStyle(
                                            color: textGrey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _showQRCodeDialog,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryBlue.withOpacity(0.4),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.qr_code,
                                            color: Colors.white, size: 20),
                                        SizedBox(height: 2),
                                        Text(
                                          'QR',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: _shareOrganizationCode,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryBlue.withOpacity(0.4),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.ios_share,
                                            color: Colors.white, size: 20),
                                        SizedBox(height: 2),
                                        Text(
                                          'SHARE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // Sticky Tabs
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SectionHeaderDelegate(
                        height: 60,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: Row(
                            children: [
                              _buildTab('General', _selectedTab == 'General'),
                              const SizedBox(width: 8),
                              _buildTab('Contact', _selectedTab == 'Contact'),
                              const SizedBox(width: 8),
                              _buildTab('Banking', _selectedTab == 'Banking'),
                              const SizedBox(width: 8),
                              _buildTab('NDIS', _selectedTab == 'NDIS'),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Content Sections
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 120), // Bottom padding for FAB
                        child: Column(
                          children: [
                            // General Information Card
                            const SizedBox(height: 16),
                            _buildSectionCard(
                              context,
                              key: _generalKey,
                              title: 'General Information',
                              icon: Icons.business,
                              iconColor: const Color(0xFF3B82F6),
                              children: [
                                _buildDetailRow('LEGAL NAME', name),
                                _buildDetailRow('TRADING AS', tradingName),
                                _buildDetailRow('TAX ID (ABN)', abn,
                                    showCopy: true),
                              ],
                            ),

                            // Contact Details Card
                            const SizedBox(height: 16),
                            _buildSectionCard(
                              context,
                              key: _contactKey,
                              title: 'Contact Details',
                              icon: Icons.contact_mail,
                              iconBackgroundColor:
                                  const Color.fromARGB(255, 45, 2, 50),
                              iconColor:
                                  const Color.fromARGB(255, 246, 92, 223),
                              children: [
                                _buildDetailRow('EMAIL ADDRESS',
                                    contact['email'] ?? 'Not set',
                                    isEmail: true),
                                _buildDetailRow('PHONE NUMBER',
                                    contact['phone'] ?? 'Not set',
                                    isPhone: true),
                                _buildDetailRow(
                                    'HEADQUARTERS',
                                    fullAddress.isEmpty
                                        ? 'Not set'
                                        : fullAddress),
                                const SizedBox(height: 12),
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 85, 46, 74),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      // Map or Placeholder
                                      _buildEmbeddedMap(),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.5),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: _openMap,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.5)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.map,
                                                    color: Colors.white,
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text('View Map',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Banking Card
                            const SizedBox(height: 16),
                            Builder(builder: (context) {
                              final accountNo = bank['accountNumber'] ?? '';

                              // Format BSB
                              final bsbRaw = bank['bsb']?.toString() ?? '';
                              final bsbDigits =
                                  bsbRaw.replaceAll(RegExp(r'[^0-9]'), '');
                              final formattedBsb = (bsbDigits.length == 6)
                                  ? '${bsbDigits.substring(0, 3)}-${bsbDigits.substring(3)}'
                                  : (bsbRaw.isEmpty ? 'Not set' : bsbRaw);

                              final isVerified = accountNo.length == 8 &&
                                  bank['bankName'] != null &&
                                  bsbDigits.length ==
                                      6; // Check valid BSB length for verification too

                              final maskedAccountNo = accountNo.length >= 4
                                  ? '**** ${accountNo.substring(accountNo.length - 4)}'
                                  : (accountNo.isEmpty ? 'Not set' : accountNo);

                              return _buildSectionCard(
                                context,
                                key: _bankingKey,
                                title: 'Banking',
                                icon: Icons.account_balance,
                                iconColor: const Color(0xFF10B981),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isVerified
                                        ? const Color(0xFF10B981)
                                            .withOpacity(0.2)
                                        : const Color(0xFFEF4444)
                                            .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: isVerified
                                            ? const Color(0xFF10B981)
                                                .withOpacity(0.5)
                                            : const Color(0xFFEF4444)
                                                .withOpacity(0.5)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isVerified) ...[
                                        const Icon(Icons.check_circle,
                                            size: 12, color: Color(0xFF10B981)),
                                        const SizedBox(width: 4),
                                      ],
                                      Text(
                                        isVerified ? 'VERIFIED' : 'UNVERIFIED',
                                        style: TextStyle(
                                          color: isVerified
                                              ? const Color(0xFF10B981)
                                              : const Color(0xFFEF4444),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                children: [
                                  _buildInstitutionRow(
                                      bank['bankName'] ?? 'Not set'),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: _buildDetailRow(
                                              'BSB', formattedBsb)),
                                      Expanded(
                                          child: _buildDetailRow(
                                              'ACCOUNT NO.', maskedAccountNo)),
                                    ],
                                  ),
                                ],
                              );
                            }),

                            // NDIS Registration Card
                            const SizedBox(height: 16),
                            _buildSectionCard(
                              context,
                              key: _ndisKey,
                              title: 'NDIS Registration',
                              icon: Icons.medical_services,
                              iconColor: const Color(0xFFEC4899),
                              children: [
                                if (ndis['isRegistered'] == true) ...[
                                  Builder(builder: (context) {
                                    final status = _getNdisStatus(ndis);
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0F172A),
                                        borderRadius: BorderRadius.circular(12),
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
                                                    'Status',
                                                    style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              status['color'],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Text(
                                                        status['text'],
                                                        style: TextStyle(
                                                          color:
                                                              status['color'],
                                                          fontSize: 14,
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
                                              color: Colors.grey[800],
                                              thickness: 1,
                                              width: 24,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Expires',
                                                    style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    _formatDate(
                                                        ndis['renewalDate'] ??
                                                            ndis['expiryDate']),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
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
                                  const SizedBox(height: 16),
                                  _buildDetailRow('REGISTRATION NUMBER',
                                      ndis['registrationNumber'] ?? 'Not set',
                                      showCopy: true),
                                ] else ...[
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'NOT REGISTERED',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border(top: BorderSide(color: cardColor)),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _navigateToEdit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          shadowColor: primaryBlue.withOpacity(0.5),
                        ),
                        icon: const Icon(Icons.edit_note, color: Colors.white),
                        label: const Text(
                          'Edit Organization',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
              'Location not set',
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }

    if (Platform.isIOS) {
      return apple_maps.AppleMap(
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
      // Note: Google Maps requires an API key in AndroidManifest.xml
      return google_maps.GoogleMap(
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

  Widget _buildTab(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => _scrollToSection(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey[800]!),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey[400],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required String title,
      required IconData icon,
      required List<Widget> children,
      Color? iconBackgroundColor,
      Color? iconColor,
      Widget? trailing,
      Key? key}) {
    return Container(
      key: key,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon,
                    color: iconColor ?? const Color(0xFF3B82F6), size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInstitutionRow(String bankName) {
    String initials = '';
    if (bankName.isNotEmpty && bankName != 'Not set') {
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
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INSTITUTION',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (bankName != 'Not set')
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBBF24), // Yellow
                    borderRadius: BorderRadius.circular(6),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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
      return {'text': 'Active', 'color': const Color(0xFF22C55E)};
    }

    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      // Compare dates only (ignore time)
      final today = DateTime(now.year, now.month, now.day);
      final expiry = DateTime(date.year, date.month, date.day);

      if (expiry.isBefore(today)) {
        return {'text': 'Expired', 'color': const Color(0xFFEF4444)}; // Red-500
      }
      return {'text': 'Active', 'color': const Color(0xFF22C55E)}; // Green-500
    } catch (_) {
      return {'text': 'Active', 'color': const Color(0xFF22C55E)};
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'Not set';
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

  Widget _buildDetailRow(String label, String value,
      {bool showCopy = false, bool isEmail = false, bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (showCopy)
                const Icon(Icons.copy, color: Color(0xFF3B82F6), size: 16),
              if (isEmail)
                const Icon(Icons.email_outlined,
                    color: Color(0xFF3B82F6), size: 16),
              if (isPhone)
                const Icon(Icons.phone_outlined,
                    color: Color(0xFF3B82F6), size: 16),
            ],
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
      color: const Color(0xFF0F172A), // Match background
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
      ..color = Colors.white.withOpacity(0.05)
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
