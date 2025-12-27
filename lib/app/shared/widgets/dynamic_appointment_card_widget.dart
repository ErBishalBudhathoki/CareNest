import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';

class DynamicAppointmentCardWidget extends StatefulWidget {
  final List clientEmailList;
  final int listLength;
  final String currentUserEmail;

  const DynamicAppointmentCardWidget({
    super.key,
    required this.clientEmailList,
    required this.listLength,
    required this.currentUserEmail,
  });

  @override
  State<StatefulWidget> createState() {
    return _DynamicAppointmentCardWidgetState();
  }
}

class _DynamicAppointmentCardWidgetState
    extends State<DynamicAppointmentCardWidget> {
  // Color constants
  static const Color _primaryColor = Color(0xFF6366F1);
  static const Color _successColor = Color(0xFF34C759);
  static const Color _errorColor = Color(0xFFEF4444);
  static const Color _gray50 = Color(0xFFF9FAFB);
  static const Color _gray800 = Color(0xFF1F2937);

  // Spacing constants (xs=4, sm=8, md=16, lg=24, xl=32)
  static const double _spacingXs = 4.0;
  static const double _spacingSm = 8.0;
  static const double _spacingMd = 16.0;
  static const double _spacingLg = 24.0;
  static const double _spacingXl = 32.0;

  // Enhanced responsive breakpoints
  bool _isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  bool _isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 900;
  }

  bool _isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }

  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  // Dynamic sizing based on screen type - ADJUSTED HEIGHT
  double _getCardHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (_isSmallScreen(context)) {
      return screenHeight * 0.38; // Increased from 0.32 to provide more space
    } else if (_isMediumScreen(context)) {
      return screenHeight * 0.28;
    } else {
      return screenHeight * 0.26;
    }
  }

  double _getIconSize(BuildContext context) {
    if (_isSmallScreen(context)) return 16;
    if (_isMediumScreen(context)) return 20;
    return 24;
  }

  double _getFontSize(BuildContext context, {required String type}) {
    final multiplier = _isSmallScreen(context)
        ? 0.9
        : _isMediumScreen(context)
            ? 1.0
            : 1.1;
    switch (type) {
      case 'header':
        return (16 * multiplier).clamp(14, 20);
      case 'body':
        return (14 * multiplier).clamp(12, 18);
      case 'caption':
        return (12 * multiplier).clamp(10, 16);
      case 'button':
        return (16 * multiplier).clamp(14, 20);
      default:
        return 14;
    }
  }

  EdgeInsets _getAdaptivePadding(BuildContext context) {
    if (_isSmallScreen(context)) {
      return const EdgeInsets.all(_spacingSm);
    } else if (_isMediumScreen(context)) {
      return const EdgeInsets.all(_spacingMd);
    } else {
      return const EdgeInsets.all(_spacingLg);
    }
  }

  Widget _buildShimmerLoader(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cardHeight = _getCardHeight(context);
    final adaptivePadding = _getAdaptivePadding(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: cardHeight,
        margin: EdgeInsets.symmetric(
          horizontal: _isSmallScreen(context)
              ? _spacingSm
              : _spacingMd,
          vertical: _isSmallScreen(context)
              ? _spacingXs
              : _spacingMd,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_spacingLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(_spacingLg),
              height: 24,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_spacingSm),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: _spacingLg),
              height: 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_spacingSm),
              ),
            ),
            const SizedBox(height: _spacingMd),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: _spacingLg),
              height: 16,
              width: screenSize.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_spacingSm),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(_spacingLg),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_spacingSm),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late Future<List<Patient>> futureClientsData;
  late Future<List> futureData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var setAppointmentData;
  var setFutureClientsData;
  var appointmentData = {};
  late List<dynamic> clients = [];
  ApiMethod apiMethod = ApiMethod();

  late int selectedPage;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    print("getFutureClientsData: ${widget.clientEmailList.toString()}");
    for (var i = 0; i < widget.listLength; i++) {
      print("getFutureClientsData: ${widget.clientEmailList[i]}");
    }
    print(
        "Dynamic: ${widget.currentUserEmail} ${widget.listLength.toString()}");
    getFutureClientsData();
    getAppointmentData();
  }

  Future<dynamic> getFutureClientsData() async {
    String emails = widget.clientEmailList.join(',');
    futureClientsData = (apiMethod.fetchMultiplePatientData(emails));
    setState(() {
      setFutureClientsData = futureClientsData;
    });
    print("Future Clients Data: $futureClientsData");
    return [setFutureClientsData];
  }

  Future<dynamic> getAppointmentData() async {
    appointmentData =
        (await apiMethod.getAppointmentData(widget.currentUserEmail)) as Map;

    // Assuming appointmentData['data'] contains a list of clients
    clients = appointmentData['data'];

    // Sort or order clients based on your criteria, e.g., by email
    clients.sort((a, b) => a['clientEmail'].compareTo(b['clientEmail']));
    debugPrint("Sorted client: $clients");
    setState(() {
      setAppointmentData = appointmentData;
      print('DYCW ${appointmentData['data'][0]['startTimeList'][0]}');
    });
    print("Appointment Data: ${appointmentData.length}");
    return [appointmentData];
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = double.infinity;
    final screenHeight = screenSize.height;
    final cardHeight = screenHeight * 0.25;
    print(
        "Client email list: ${(widget.clientEmailList).length} ${widget.clientEmailList}\n");
    setFutureClientsData.then((list) {
      print('Length of setFutureClientsData: ${list.length}\n');
    });
    Future.delayed(const Duration(seconds: 1));
    return FutureBuilder<List<Patient>>(
      future: setFutureClientsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            setAppointmentData == null) {
          return _buildShimmerLoader(context);
        }
        if (snapshot.hasData && setAppointmentData != null) {
          debugPrint("Snapshot Data: ${snapshot.data!.length}");
          return LayoutBuilder(
            builder: (context, constraints) {
              // Calculate dynamic height and padding using responsive system
              final cardHeight = _getCardHeight(context);
              final adaptivePadding = _getAdaptivePadding(context);
              final verticalPadding = _isSmallScreen(context)
                  ? _spacingSm
                  : _spacingMd;
              final horizontalPadding = _isSmallScreen(context)
                  ? _spacingMd
                  : _spacingLg;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: cardHeight,
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: _spacingXs,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_spacingLg),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(_spacingMd),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  _gray50,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(_spacingLg),
                              border: Border.all(
                                color: _primaryColor.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Better distribution
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header section
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: _spacingMd,
                                    vertical: _spacingSm,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(_spacingLg),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(_spacingSm),
                                        decoration: BoxDecoration(
                                          color: _primaryColor,
                                          borderRadius: BorderRadius.circular(_spacingSm),
                                        ),
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: Colors.white,
                                          size: _getIconSize(context),
                                        ),
                                      ),
                                      const SizedBox(width: _spacingSm),
                                      Text(
                                        'Appointment Details',
                                        style: TextStyle(
                                          fontSize: _getFontSize(context,
                                              type: 'header'),
                                          fontWeight: FontWeight.w700,
                                          color: _primaryColor,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Content section with better spacing
                                Expanded(
                                  child: SingleChildScrollView(
                                    // FIX: Added to prevent overflow on smaller screens
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: _spacingSm,
                                      ),
                                      child: Column(
                                        children: [
                                          _buildModernInfoRow(
                                            context,
                                            Icons.person_outline,
                                            'Client',
                                            "${snapshot.data![index].clientFirstName} ${snapshot.data![index].clientLastName}",
                                          ),
                                          const SizedBox(height: _spacingSm),
                                          _buildModernInfoRow(
                                            context,
                                            Icons.location_on_outlined,
                                            'Address',
                                            "${snapshot.data![index].clientAddress} ${snapshot.data![index].clientCity} ${snapshot.data![index].clientState} ${snapshot.data![index].clientZip}",
                                          ),
                                          const SizedBox(height: _spacingSm),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildModernInfoRow(
                                                  context,
                                                  Icons.play_circle_outline,
                                                  'Start',
                                                  "${(setAppointmentData['data'][index]['schedule'] as List?)?.first?['startTime'] ?? 'N/A'}",
                                                  isCompact: true,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: _isSmallScreen(context)
                                                      ? 4.0
                                                      : 8.0),
                                              Expanded(
                                                child: _buildModernInfoRow(
                                                  context,
                                                  Icons.pause_circle_outline,
                                                  'End',
                                                  "${(setAppointmentData['data'][index]['schedule'] as List?)?.first?['endTime'] ?? 'N/A'}",
                                                  isCompact: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Button section - no extra spacing
                                Container(
                                  height: _isSmallScreen(context) ? 48 : 56,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        _primaryColor,
                                        _successColor,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(_spacingLg),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(_spacingLg),
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ClientAndAppointmentDetails(
                                              userEmail:
                                                  widget.currentUserEmail,
                                              clientEmail: clients[index]
                                                  ['clientEmail'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: _spacingMd,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.visibility_outlined,
                                              color: Colors.white,
                                              size: _getIconSize(context),
                                            ),
                                            const SizedBox(width: _spacingSm),
                                            Text(
                                              'View Details',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: _getFontSize(context,
                                                    type: 'button'),
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            const SizedBox(width: _spacingSm),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: _getIconSize(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: _spacingMd), // Reduced spacing
                  // Modern page indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _spacingMd,
                      vertical: _spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(_spacingLg),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryColor.withOpacity(0.1),
                          blurRadius: 8.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SmoothPageIndicator(
                      controller: pageController,
                      count: snapshot.data!.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: _isSmallScreen(context) ? 8.0 : 10.0,
                        dotWidth: _isSmallScreen(context) ? 8.0 : 10.0,
                        expansionFactor: 3,
                        spacing: 6.0,
                        activeDotColor: _primaryColor,
                        dotColor: _primaryColor.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            height: context.height * 0.35,
            margin: const EdgeInsets.symmetric(horizontal: _spacingMd),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_spacingLg),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _errorColor.withOpacity(0.1),
                  _errorColor.withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: _errorColor.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _errorColor.withOpacity(0.1),
                  blurRadius: 12.0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber_outlined,
                  color: _errorColor,
                  size: 48,
                ),
                const SizedBox(height: _spacingMd),
                const Text(
                  "Connection Error",
                  style: TextStyle(
                    color: _errorColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: _spacingSm),
                const Text(
                  "Please check your internet connection",
                  style: TextStyle(
                    color: _errorColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return Container(
          height: context.height * 0.35,
          margin: const EdgeInsets.symmetric(horizontal: _spacingMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_spacingLg),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: _primaryColor.withOpacity(0.1),
                blurRadius: 12.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(_spacingLg),
                decoration: BoxDecoration(
                  color: _primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: _spacingMd),
              const Text(
                "Loading appointments...",
                style: TextStyle(
                  color: _gray800,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Modern info row widget with improved design - REDUCED PADDING
  Widget _buildModernInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String text, {
    bool isCompact = false,
  }) {
    return Container(
      padding: EdgeInsets.all(isCompact
          ? _spacingSm
          : _spacingSm), // Reduced padding
      decoration: BoxDecoration(
        color: _gray50.withOpacity(0.1),
        borderRadius: BorderRadius.circular(_spacingMd),
        border: Border.all(
          color: _primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(isCompact ? 6 : 8),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(_spacingSm),
            ),
            child: Icon(
              icon,
              color: _primaryColor,
              size: _getIconSize(context),
            ),
          ),
          const SizedBox(width: _spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: _getFontSize(context, type: 'caption'),
                    fontWeight: FontWeight.w600,
                    color: _primaryColor,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: _getFontSize(context, type: 'body'),
                    fontWeight: FontWeight.w500,
                    color: _gray800,
                    height: 1.3,
                  ),
                  maxLines: isCompact ? 1 : (_isSmallScreen(context) ? 1 : 2),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
