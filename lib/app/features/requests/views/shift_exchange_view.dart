import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/backend/api_method.dart';

import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:carenest/app/core/utils/Services/launch_map_status.dart';
import 'package:intl/intl.dart';

class ShiftExchangeView extends ConsumerStatefulWidget {
  const ShiftExchangeView({super.key});

  @override
  ConsumerState<ShiftExchangeView> createState() => _ShiftExchangeViewState();
}

class _ShiftExchangeViewState extends ConsumerState<ShiftExchangeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiMethod _apiMethod = ApiMethod();
  bool _isLoading = true;
  List<dynamic> _openShifts = [];
  List<dynamic> _myOffers = [];
  String? _userId;
  String? _userEmail;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
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
      
      // Ideally we should get userId from prefs or fetch it
      // For now, let's assume we can filter my offers by email or fetch user details
      // If userId is missing, we might need to fetch it. 
      // apiMethod doesn't expose a direct "getMyId" but we can use email.

      if (_organizationId != null && _userEmail != null) {
        final myEmail = _userEmail!.toLowerCase().trim();

        // Fetch Open Shifts (Pending only)
        final openFuture = _apiMethod.getOpenShifts(_organizationId!);
        // Fetch My Offers (All statuses)
        final myFuture = _apiMethod.getMyShiftSwapRequests(_organizationId!, _userEmail!);

        final results = await Future.wait([openFuture, myFuture]);
        final openResponse = results[0];
        final myResponse = results[1];

        _openShifts = [];
        _myOffers = [];

        // Process Open Shifts
        if (openResponse['success'] == true) {
          final openList = openResponse['data'] as List? ?? [];
          for (var r in openList) {
             // Filter out my own requests from "Open Shifts" view
             String? creatorEmail = r['createdBy'] is Map 
                 ? (r['createdBy']['email'] ?? r['createdBy']['userEmail']) 
                 : r['createdBy'];
             if (creatorEmail?.toString().toLowerCase().trim() != myEmail) {
               _openShifts.add(r);
             }
          }
        }

        // Process My Offers
        if (myResponse['success'] == true) {
          final myList = myResponse['data'] as List? ?? [];
          _myOffers = List.from(myList);
        }

        debugPrint('ShiftExchangeView: My Offers: ${_myOffers.length}, Open Shifts: ${_openShifts.length}');
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

    // Show details and confirmation
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: BauhausDesign.surfaceLight,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: BauhausDesign.textDark, width: 3),
          borderRadius: BorderRadius.zero,
        ),
        title: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: BauhausDesign.textDark, width: 2)),
            color: BauhausDesign.secondary,
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          child: Text(
            'SHIFT DETAILS',
            style: GoogleFonts.oswald(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: BauhausDesign.surfaceLight,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: _ShiftDetailsDialogContent(
          details: details,
          clientName: clientName,
          creatorEmail: shift['userEmail']?.toString() ?? shift['createdBy']?.toString(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'CANCEL', 
              style: GoogleFonts.oswald(
                color: BauhausDesign.textDark, 
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.primary,
              foregroundColor: BauhausDesign.surfaceLight,
              elevation: 0,
              side: const BorderSide(color: BauhausDesign.textDark, width: 2),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'CONFIRM CLAIM', 
              style: GoogleFonts.oswald(
                fontWeight: FontWeight.bold, 
                fontSize: 16,
                letterSpacing: 1.0,
              )
            ),
          ),
        ],
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
        claimantName: _userEmail!, // Using email as name if name unavailable
        userEmail: _userEmail!,
      );

      if (response['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Shift claimed! Waiting for approval.')),
          );
          _loadData(); // Refresh
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
          child: Container(
            decoration: BoxDecoration(
                color: BauhausDesign.surfaceLight,
                border: Border.all(color: BauhausDesign.textDark, width: 2),
                boxShadow: const [
                  BoxShadow(color: BauhausDesign.textDark, offset: Offset(2, 2))
                ]),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'SHIFT EXCHANGE',
          style: GoogleFonts.oswald(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: BauhausDesign.textDark,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: BauhausDesign.surfaceLight,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
             decoration: const BoxDecoration(
               border: Border(bottom: BorderSide(color: BauhausDesign.textDark, width: 2)),
             ),
             child: TabBar(
              controller: _tabController,
              labelColor: BauhausDesign.textDark,
              unselectedLabelColor: BauhausDesign.neutral,
              indicatorColor: BauhausDesign.primary,
              indicatorWeight: 4,
              labelStyle: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 16),
              tabs: const [
                Tab(text: "OPEN SHIFTS"),
                Tab(text: "MY OFFERS"),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: BauhausDesign.primary))
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: BauhausDesign.neutral),
            const SizedBox(height: 16),
            Text(
              isOpen ? 'No open shifts available.' : 'You haven\'t offered any shifts.',
              style: GoogleFonts.inter(fontSize: 16, color: BauhausDesign.neutral),
            ),
            if (!isOpen) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'To offer a shift, tap on an appointment in Home or Schedule, then tap "OFFER SWAP".',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14, 
                    color: BauhausDesign.neutral.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shifts.length,
      itemBuilder: (context, index) {
        final shift = shifts[index];
        final details = shift['details'] ?? {};
        final urgency = details['urgency'] ?? 'Medium';
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            border: Border.all(color: BauhausDesign.textDark, width: 2),
            boxShadow: [
              BoxShadow(
                color: BauhausDesign.textDark,
                offset: const Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: BauhausDesign.secondary, // Blue header
                  border: Border(bottom: BorderSide(color: BauhausDesign.textDark, width: 2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDate(details['date']),
                      style: GoogleFonts.oswald(
                        color: BauhausDesign.surfaceLight,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    _buildUrgencyBadge(urgency),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(Icons.person, details['clientName'] ?? 'Unknown Client'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.access_time, '${details['startTime']} - ${details['endTime']}'),
                    if (details['reason'] != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Reason: ${details['reason']}',
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          color: BauhausDesign.neutral,
                          fontSize: 12
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    if (isOpen)
                      SizedBox(
                        width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _claimShift(shift),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: BauhausDesign.primary, // Red button
                              foregroundColor: BauhausDesign.surfaceLight, // White text
                              elevation: 0,
                              side: const BorderSide(color: BauhausDesign.textDark, width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'CLAIM SHIFT',
                              style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _getStatusColor(shift['status']), // Dynamic status color
                            border: Border.all(color: BauhausDesign.textDark, width: 2),
                            boxShadow: [
                               BoxShadow(
                                  color: BauhausDesign.textDark.withOpacity(0.2),
                                  offset: const Offset(2, 2),
                                  blurRadius: 0,
                               )
                            ]
                          ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(_getStatusIcon(shift['status']), size: 16, color: BauhausDesign.textDark),
                               const SizedBox(width: 8),
                               Text(
                                'STATUS: ${shift['status']?.toString().toUpperCase() ?? 'PENDING'}',
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.bold,
                                  color: BauhausDesign.textDark,
                                  fontSize: 16
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
  
  
    Widget _buildInfoRow(IconData icon, String text) {
      return Row(
        children: [
          Icon(icon, size: 18, color: BauhausDesign.primary), // Red icons
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: BauhausDesign.textDark, fontSize: 15),
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
        return BauhausDesign.success; // Green
      case 'declined':
        return BauhausDesign.error; // Red
      case 'claimed':
        return BauhausDesign.secondary.withOpacity(0.2); // Light Blue
      case 'pending':
      default:
        return BauhausDesign.accent; // Yellow
    }
  }

  Widget _buildUrgencyBadge(String urgency) {
    Color color;
    switch (urgency.toLowerCase()) {
      case 'high':
        color = BauhausDesign.error; // Red-ish
        break;
      case 'low':
        color = BauhausDesign.success; // Green-ish
        break;
      default:
        color = BauhausDesign.secondary; // Yellow-ish
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      color: color,
      child: Text(
        urgency.toUpperCase(),
        style: GoogleFonts.oswald(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: BauhausDesign.textDark,
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr); // Assuming ISO or parseable
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

  const _ShiftDetailsDialogContent({
    required this.details,
    required this.clientName,
    this.creatorEmail,
  });

  @override
  State<_ShiftDetailsDialogContent> createState() => _ShiftDetailsDialogContentState();
}

class _ShiftDetailsDialogContentState extends State<_ShiftDetailsDialogContent> {
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

    final fullAddress = [address, city, state, zip].where((s) => s.isNotEmpty).join(', ');
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
        
        // Use creatorEmail if provided (since they own the assignment), otherwise fallback to current user
        final lookupEmail = widget.creatorEmail ?? prefs.getUserEmail();
        
        if (lookupEmail == null) return;
        
        final api = ApiMethod();
        final response = await api.getClientAndAppointmentData(lookupEmail, clientEmail);
        
        if (response != null && response is Map && response['data'] != null) {
           final data = response['data'];
           Map<String, dynamic>? clientData;
           
           // Reuse extraction logic (simplified)
           if (data['clientDetails'] != null && (data['clientDetails'] as List).isNotEmpty) {
             clientData = data['clientDetails'][0];
           }
           
           if (clientData != null) {
              final address = clientData['clientAddress']?.toString() ?? '';
              final city = clientData['clientCity']?.toString() ?? '';
              final state = clientData['clientState']?.toString() ?? '';
              final zip = clientData['clientZipCode'] ?? clientData['clientZip'] ?? ''; // Handle diverse keys
              
              if (address.isNotEmpty || city.isNotEmpty) {
                 final fullAddress = [address, city, state, zip].where((s) => s.toString().isNotEmpty).join(', ');
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

    Widget _buildDetailRow(IconData icon, String label, String value) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: BauhausDesign.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, 
                    color: BauhausDesign.textDark, 
                    fontSize: 12
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, 
                    color: BauhausDesign.textDark, 
                    fontSize: 16
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
            _buildDetailRow(Icons.calendar_today, 'Date', _formatDate(widget.details['date'])),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.access_time, 'Time', '${widget.details['startTime']} - ${widget.details['endTime']}'),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.person, 'Client', widget.clientName),
             if (_address != null && _address!.isNotEmpty) ...[
                 const SizedBox(height: 12),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Icon(Icons.location_on, size: 20, color: BauhausDesign.primary),
                     const SizedBox(width: 12),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'Location',
                             style: GoogleFonts.inter(
                               fontWeight: FontWeight.bold, 
                               color: BauhausDesign.textDark, 
                               fontSize: 12
                             ),
                           ),
                           Text(
                             _address!,
                             style: GoogleFonts.inter(
                               fontWeight: FontWeight.w500, 
                               color: BauhausDesign.textDark, 
                               fontSize: 16
                             ),
                           ),
                           const SizedBox(height: 8),
                           InkWell(
                             onTap: () => launchMap(_address!),
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                               decoration: BoxDecoration(
                                 border: Border.all(color: BauhausDesign.textDark, width: 1.5),
                                 borderRadius: BorderRadius.circular(4),
                                 color: BauhausDesign.surfaceLight,
                                 boxShadow: [
                                   BoxShadow(
                                     color: BauhausDesign.textDark,
                                     offset: const Offset(2, 2),
                                     blurRadius: 0,
                                   )
                                 ]
                               ),
                               child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   const Icon(Icons.map, size: 16, color: BauhausDesign.textDark),
                                   const SizedBox(width: 8),
                                   Text(
                                     'OPEN MAP',
                                     style: GoogleFonts.oswald(
                                       fontSize: 12,
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
              const SizedBox(height: 12),
              _buildDetailRow(Icons.info_outline, 'Reason', widget.details['reason']),
            ],
            
            const SizedBox(height: 24),
             Text(
              'Do you want to claim this shift?', 
              style: GoogleFonts.inter(
                fontSize: 14, 
                color: BauhausDesign.textDark,
                fontStyle: FontStyle.italic,
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
