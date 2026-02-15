import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/utils/Services/launch_map_status.dart';

class ShiftExchangeView extends ConsumerStatefulWidget {
  const ShiftExchangeView({super.key});

  @override
  ConsumerState<ShiftExchangeView> createState() => _ShiftExchangeViewState();
}

class _ShiftExchangeViewState extends ConsumerState<ShiftExchangeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final ApiMethod _apiMethod;
  bool _isLoading = true;
  List<dynamic> _openShifts = [];
  List<dynamic> _myOffers = [];
  String? _userEmail;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();
      _userEmail = prefs.getUserEmail();
      _organizationId = prefs.getString('organizationId');

      if (_organizationId != null && _userEmail != null) {
        final myEmail = _userEmail!.toLowerCase().trim();

        final openFuture = _apiMethod.getOpenShifts(_organizationId!);
        final myFuture =
            _apiMethod.getMyShiftSwapRequests(_organizationId!, _userEmail!);

        final results = await Future.wait([openFuture, myFuture]);
        final openResponse = results[0];
        final myResponse = results[1];

        _openShifts = [];
        _myOffers = [];

        if (openResponse['success'] == true) {
          final openList = openResponse['data'] as List? ?? [];
          for (var r in openList) {
            String? creatorEmail = r['createdBy'] is Map
                ? (r['createdBy']['email'] ?? r['createdBy']['userEmail'])
                : r['createdBy'];
            if (creatorEmail?.toString().toLowerCase().trim() != myEmail) {
              _openShifts.add(r);
            }
          }
        }

        if (myResponse['success'] == true) {
          final myList = myResponse['data'] as List? ?? [];
          _myOffers = List.from(myList);
        }
      }
    } catch (e) {
      debugPrint('Error loading shift exchange data: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _claimShift(Map<String, dynamic> shift) async {
    final details = shift['details'] ?? {};
    final clientName = details['clientName'] ?? 'Unknown Client';
    final requestId = shift['_id'];

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: BauhausCard(
          padding: const EdgeInsets.all(BauhausDesign.space4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SHIFT DETAILS',
                style:
                    BauhausDesign.getTextTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: BauhausDesign.space4),
              _ShiftDetailsDialogContent(
                details: details,
                clientName: clientName,
                creatorEmail: shift['userEmail']?.toString() ??
                    shift['createdBy']?.toString(),
                apiMethod: _apiMethod,
              ),
              const SizedBox(height: BauhausDesign.space4),
              Row(
                children: [
                  Expanded(
                    child: BauhausActionButton(
                      text: "CANCEL",
                      onPressed: () => Navigator.pop(context, false),
                      variant: BauhausActionVariant.neutral,
                      isOutlined: true,
                    ),
                  ),
                  const SizedBox(width: BauhausDesign.space3),
                  Expanded(
                    child: BauhausActionButton(
                      text: "CONFIRM CLAIM",
                      onPressed: () => Navigator.pop(context, true),
                      variant: BauhausActionVariant.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirm != true) return;

    if (_userEmail == null || _userEmail!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: User email not found.')),
        );
      }
      return;
    }

    try {
      final response = await _apiMethod.claimSwapOffer(
        requestId: requestId,
        claimantId: _userEmail!,
        claimantName: _userEmail!,
        userEmail: _userEmail!,
      );

      if (response['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Shift claimed! Waiting for approval.')),
          );
          _loadData();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to claim: ${response['message']}')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error claiming shift: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BauhausIconButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
            variant: BauhausActionVariant.neutral,
            isSmall: true,
          ),
        ),
        title: Text(
          'Shift Exchange',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: BauhausDesign.neutral.withOpacity(0.2), width: 1)),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: BauhausDesign.primary,
              unselectedLabelColor: BauhausDesign.textMuted,
              indicatorColor: BauhausDesign.primary,
              indicatorWeight: 3,
              labelStyle: BauhausDesign.getTextTheme(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "OPEN SHIFTS"),
                Tab(text: "MY OFFERS"),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: BauhausDesign.primary))
          : RefreshIndicator(
              onRefresh: _loadData,
              color: BauhausDesign.primary,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildShiftList(_openShifts, isOpen: true),
                  _buildShiftList(_myOffers, isOpen: false),
                ],
              ),
            ),
    );
  }

  Widget _buildShiftList(List<dynamic> shifts, {required bool isOpen}) {
    if (shifts.isEmpty) {
      return Center(
        child: BauhausEmptyState(
          title: isOpen ? 'No open shifts' : 'No offers yet',
          message: isOpen
              ? 'There are no shifts available to claim right now.'
              : 'You haven\'t offered any shifts for exchange.',
          icon: Icons.event_busy,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(BauhausDesign.space4),
      itemCount: shifts.length,
      separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
      itemBuilder: (context, index) {
        final shift = shifts[index];
        final details = shift['details'] ?? {};
        final urgency = details['urgency'] ?? 'Medium';

        return BauhausCard(
          padding: const EdgeInsets.all(0), // Custom internal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space3),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary.withOpacity(0.1),
                  border: Border(
                      bottom: BorderSide(
                          color: BauhausDesign.neutral.withOpacity(0.1))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(details['date']),
                      style: BauhausDesign.getTextTheme(context)
                          .titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: BauhausDesign.textDark,
                          ),
                    ),
                    _buildUrgencyBadge(urgency),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context, Icons.person,
                        details['clientName'] ?? 'Unknown Client'),
                    const SizedBox(height: BauhausDesign.space2),
                    _buildInfoRow(context, Icons.access_time,
                        '${details['startTime']} - ${details['endTime']}'),
                    if (details['reason'] != null) ...[
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        'Reason: ${details['reason']}',
                        style: BauhausDesign.getTextTheme(context)
                            .bodySmall
                            ?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: BauhausDesign.textMuted,
                            ),
                      ),
                    ],
                    const SizedBox(height: BauhausDesign.space4),
                    if (isOpen)
                      SizedBox(
                        width: double.infinity,
                        child: BauhausActionButton(
                          text: 'CLAIM SHIFT',
                          onPressed: () => _claimShift(shift),
                          variant: BauhausActionVariant.primary,
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: BauhausDesign.space3,
                            vertical: BauhausDesign.space2),
                        decoration: BoxDecoration(
                          color:
                              _getStatusColor(shift['status']).withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(BauhausDesign.radiusSm),
                          border: Border.all(
                              color: _getStatusColor(shift['status'])
                                  .withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_getStatusIcon(shift['status']),
                                size: 16,
                                color: _getStatusColor(shift['status'])),
                            const SizedBox(width: 8),
                            Text(
                              'STATUS: ${shift['status']?.toString().toUpperCase() ?? 'PENDING'}',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(shift['status']),
                                  ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: BauhausDesign.primary),
        const SizedBox(width: BauhausDesign.space3),
        Text(
          text,
          style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'declined':
        return Icons.cancel;
      case 'claimed':
        return Icons.hourglass_top;
      case 'pending':
      default:
        return Icons.access_time_filled;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return BauhausDesign.success;
      case 'declined':
        return BauhausDesign.error;
      case 'claimed':
        return BauhausDesign.secondary;
      case 'pending':
      default:
        return BauhausDesign.accent;
    }
  }

  Widget _buildUrgencyBadge(String urgency) {
    Color color;
    switch (urgency.toLowerCase()) {
      case 'high':
        color = BauhausDesign.error;
        break;
      case 'low':
        color = BauhausDesign.success;
        break;
      default:
        color = BauhausDesign.secondary;
    }

    return BauhausChip(
      label: urgency.toUpperCase(),
      color: color,
      isSmall: true,
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('EEE, MMM d').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}

class _ShiftDetailsDialogContent extends StatefulWidget {
  final Map<String, dynamic> details;
  final String clientName;
  final String? creatorEmail;
  final ApiMethod apiMethod;

  const _ShiftDetailsDialogContent({
    required this.details,
    required this.clientName,
    this.creatorEmail,
    required this.apiMethod,
  });

  @override
  State<_ShiftDetailsDialogContent> createState() =>
      _ShiftDetailsDialogContentState();
}

class _ShiftDetailsDialogContentState
    extends State<_ShiftDetailsDialogContent> {
  String? _address;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    final details = widget.details;
    final address = details['clientAddress']?.toString() ?? '';
    final city = details['clientCity']?.toString() ?? '';
    final state = details['clientState']?.toString() ?? '';
    final zip = details['clientZip']?.toString() ?? '';

    if (address.isEmpty && city.isEmpty) {
      if (widget.details['clientEmail'] != null) {
        _fetchAddressFromProfile(widget.details['clientEmail']);
      }
      return;
    }

    final fullAddress =
        [address, city, state, zip].where((s) => s.isNotEmpty).join(', ');
    if (mounted) {
      setState(() {
        _address = fullAddress;
      });
    }
  }

  Future<void> _fetchAddressFromProfile(String clientEmail) async {
    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();

      final lookupEmail = widget.creatorEmail ?? prefs.getUserEmail();

      if (lookupEmail == null) return;

      final response = await widget.apiMethod
          .getClientAndAppointmentData(lookupEmail, clientEmail);

      if (response != null && response is Map && response['data'] != null) {
        final data = response['data'];
        Map<String, dynamic>? clientData;

        if (data['clientDetails'] != null &&
            (data['clientDetails'] as List).isNotEmpty) {
          clientData = data['clientDetails'][0];
        }

        if (clientData != null) {
          final address = clientData['clientAddress']?.toString() ?? '';
          final city = clientData['clientCity']?.toString() ?? '';
          final state = clientData['clientState']?.toString() ?? '';
          final zip =
              clientData['clientZipCode'] ?? clientData['clientZip'] ?? '';

          if (address.isNotEmpty || city.isNotEmpty) {
            final fullAddress = [address, city, state, zip]
                .where((s) => s.toString().isNotEmpty)
                .join(', ');
            if (mounted && fullAddress.isNotEmpty) {
              setState(() {
                _address = fullAddress;
              });
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching client profile for address: $e');
    }
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: BauhausDesign.primary),
        const SizedBox(width: BauhausDesign.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: BauhausDesign.textMuted,
                    ),
              ),
              Text(
                value,
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return '';
    try {
      final dt = DateTime.parse(date.toString());
      return DateFormat('EEE, MMM d').format(dt);
    } catch (e) {
      return date.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(context, Icons.calendar_today, 'Date',
              _formatDate(widget.details['date'])),
          const SizedBox(height: BauhausDesign.space3),
          _buildDetailRow(context, Icons.access_time, 'Time',
              '${widget.details['startTime']} - ${widget.details['endTime']}'),
          const SizedBox(height: BauhausDesign.space3),
          _buildDetailRow(context, Icons.person, 'Client', widget.clientName),
          if (_address != null && _address!.isNotEmpty) ...[
            const SizedBox(height: BauhausDesign.space3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 20, color: BauhausDesign.primary),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location',
                        style: BauhausDesign.getTextTheme(context)
                            .labelSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BauhausDesign.textMuted,
                            ),
                      ),
                      Text(
                        _address!,
                        style: BauhausDesign.getTextTheme(context)
                            .bodyMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      InkWell(
                        onTap: () => launchMap(_address!),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: BauhausDesign.space2,
                              vertical: BauhausDesign.space1),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: BauhausDesign.textDark, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.map,
                                  size: 14, color: BauhausDesign.textDark),
                              const SizedBox(width: 4),
                              Text(
                                'OPEN MAP',
                                style: BauhausDesign.getTextTheme(context)
                                    .labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: BauhausDesign.textDark,
                                    ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
          if (widget.details['reason'] != null) ...[
            const SizedBox(height: BauhausDesign.space3),
            _buildDetailRow(context, Icons.info_outline, 'Reason',
                widget.details['reason']),
          ],
          const SizedBox(height: BauhausDesign.space4),
          Text(
            'Do you want to claim this shift?',
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: BauhausDesign.textMuted,
                ),
          ),
        ],
      ),
    );
  }

  Future<LaunchMapStatus> launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String appleMapsUrl = 'maps://?q=$query';
    String googleMapsUrl = 'geo:0,0?q=$query';

    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
        await launchUrl(Uri.parse(appleMapsUrl));
        return LaunchMapStatus(
            success: true,
            title: 'Success',
            message: 'Launched Apple Maps',
            surfaceColor: BauhausDesign.success);
      } else if (await canLaunchUrl(Uri.parse('comgooglemaps://?q=$query'))) {
        await launchUrl(Uri.parse('comgooglemaps://?q=$query'));
        return LaunchMapStatus(
            success: true,
            title: 'Success',
            message: 'Launched Google Maps',
            surfaceColor: BauhausDesign.success);
      }
    } else if (Platform.isAndroid) {
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
        return LaunchMapStatus(
            success: true,
            title: 'Success',
            message: 'Launched Google Maps',
            surfaceColor: BauhausDesign.success);
      }
    }
    return LaunchMapStatus(
        success: false,
        title: 'Error',
        message: 'Could not launch map',
        surfaceColor: BauhausDesign.error);
  }
}
