import 'package:carenest/app/core/base/helper.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/features/invoice/widgets/modern_invoice_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'appointment_card_widget.dart';

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
      return EdgeInsets.all(ModernInvoiceDesign.space3);
    } else if (_isMediumScreen(context)) {
      return EdgeInsets.all(ModernInvoiceDesign.space4);
    } else {
      return EdgeInsets.all(ModernInvoiceDesign.space5);
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
              ? ModernInvoiceDesign.space3
              : ModernInvoiceDesign.space4,
          vertical: _isSmallScreen(context)
              ? ModernInvoiceDesign.space2
              : ModernInvoiceDesign.space4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ModernInvoiceDesign.space6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(ModernInvoiceDesign.space5),
              height: 24,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ModernInvoiceDesign.space2),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ModernInvoiceDesign.space5),
              height: 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ModernInvoiceDesign.space2),
              ),
            ),
            SizedBox(height: ModernInvoiceDesign.space4),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ModernInvoiceDesign.space5),
              height: 16,
              width: screenSize.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ModernInvoiceDesign.space2),
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.all(ModernInvoiceDesign.space5),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ModernInvoiceDesign.space2),
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
    //print("getFutureClientsData: ${widget.clientEmailList[0]}");
    String emails = widget.clientEmailList.join(',');
    futureClientsData = (apiMethod.fetchMultiplePatientData(emails));
    setState(() {
      setFutureClientsData = futureClientsData;
    });
    //return futureClientsData;
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
                  ? ModernInvoiceDesign.space2
                  : ModernInvoiceDesign.space4;
              final horizontalPadding = _isSmallScreen(context)
                  ? ModernInvoiceDesign.space4
                  : ModernInvoiceDesign.space5;

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
                          margin: EdgeInsets.symmetric(
                            horizontal: ModernInvoiceDesign.space1,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ModernInvoiceDesign.space6),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(ModernInvoiceDesign.space4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ModernInvoiceDesign.surface,
                                  ModernInvoiceDesign.background,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  ModernInvoiceDesign.space6),
                              border: Border.all(
                                color: ModernInvoiceDesign.primary
                                    .withValues(alpha: 0.1),
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ModernInvoiceDesign.space4,
                                    vertical: ModernInvoiceDesign.space2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ModernInvoiceDesign.primary
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(
                                        ModernInvoiceDesign.space5),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                            ModernInvoiceDesign.space2),
                                        decoration: BoxDecoration(
                                          color: ModernInvoiceDesign.primary,
                                          borderRadius: BorderRadius.circular(
                                              ModernInvoiceDesign.space2),
                                        ),
                                        child: Icon(
                                          Iconsax.calendar_1,
                                          color:
                                              ModernInvoiceDesign.textOnPrimary,
                                          size: _getIconSize(context),
                                        ),
                                      ),
                                      SizedBox(
                                          width: ModernInvoiceDesign.space2),
                                      Text(
                                        'Appointment Details',
                                        style: TextStyle(
                                          fontSize: _getFontSize(context,
                                              type: 'header'),
                                          fontWeight: FontWeight.w700,
                                          color: ModernInvoiceDesign.primary,
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
                                      padding: EdgeInsets.symmetric(
                                        vertical: ModernInvoiceDesign.space3,
                                      ),
                                      child: Column(
                                        children: [
                                          _buildModernInfoRow(
                                            context,
                                            Iconsax.user,
                                            'Client',
                                            "${snapshot.data![index].clientFirstName} ${snapshot.data![index].clientLastName}",
                                          ),
                                          SizedBox(
                                              height:
                                                  ModernInvoiceDesign.space3),
                                          _buildModernInfoRow(
                                            context,
                                            Iconsax.location,
                                            'Address',
                                            "${snapshot.data![index].clientAddress} ${snapshot.data![index].clientCity} ${snapshot.data![index].clientState} ${snapshot.data![index].clientZip}",
                                          ),
                                          SizedBox(
                                              height:
                                                  ModernInvoiceDesign.space3),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _buildModernInfoRow(
                                                  context,
                                                  Iconsax.timer_start,
                                                  'Start',
                                                  "${(setAppointmentData['data'][index]['schedule'] as List?)?.first?['startTime'] ?? 'N/A'}",
                                                  isCompact: true,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: _isSmallScreen(context)
                                                      ? ModernInvoiceDesign
                                                          .space1
                                                      : ModernInvoiceDesign
                                                          .space2),
                                              Expanded(
                                                child: _buildModernInfoRow(
                                                  context,
                                                  Iconsax.timer_pause,
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
                                    gradient: LinearGradient(
                                      colors: [
                                        ModernInvoiceDesign.primary,
                                        ModernInvoiceDesign.secondary,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        ModernInvoiceDesign.space5),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          ModernInvoiceDesign.space5),
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ModernInvoiceDesign.space4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Iconsax.eye,
                                              color: ModernInvoiceDesign
                                                  .textOnPrimary,
                                              size: _getIconSize(context),
                                            ),
                                            SizedBox(
                                                width:
                                                    ModernInvoiceDesign.space2),
                                            Text(
                                              'View Details',
                                              style: TextStyle(
                                                color: ModernInvoiceDesign
                                                    .textOnPrimary,
                                                fontSize: _getFontSize(context,
                                                    type: 'button'),
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    ModernInvoiceDesign.space2),
                                            Icon(
                                              Iconsax.arrow_right_3,
                                              color: ModernInvoiceDesign
                                                  .textOnPrimary,
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
                  SizedBox(
                      height: ModernInvoiceDesign.space4), // Reduced spacing
                  // Modern page indicator
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ModernInvoiceDesign.space4,
                      vertical: ModernInvoiceDesign.space2,
                    ),
                    decoration: BoxDecoration(
                      color: ModernInvoiceDesign.surface,
                      borderRadius:
                          BorderRadius.circular(ModernInvoiceDesign.space5),
                      boxShadow: [
                        BoxShadow(
                          color: ModernInvoiceDesign.primary
                              .withValues(alpha: 0.1),
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
                        activeDotColor: ModernInvoiceDesign.primary,
                        dotColor:
                            ModernInvoiceDesign.primary.withValues(alpha: 0.2),
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
            margin:
                EdgeInsets.symmetric(horizontal: ModernInvoiceDesign.space4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.space6),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ModernInvoiceDesign.error.withValues(alpha: 0.1),
                  ModernInvoiceDesign.error.withValues(alpha: 0.2),
                ],
              ),
              border: Border.all(
                color: ModernInvoiceDesign.error.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: ModernInvoiceDesign.error.withValues(alpha: 0.1),
                  blurRadius: 12.0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.warning_2,
                  color: ModernInvoiceDesign.error,
                  size: 48,
                ),
                SizedBox(height: ModernInvoiceDesign.space4),
                Text(
                  "Connection Error",
                  style: TextStyle(
                    color: ModernInvoiceDesign.error,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ModernInvoiceDesign.space2),
                Text(
                  "Please check your internet connection",
                  style: TextStyle(
                    color: ModernInvoiceDesign.error,
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
          margin: EdgeInsets.symmetric(horizontal: ModernInvoiceDesign.space4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ModernInvoiceDesign.space6),
            color: ModernInvoiceDesign.surface,
            boxShadow: [
              BoxShadow(
                color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                blurRadius: 12.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(ModernInvoiceDesign.space5),
                decoration: BoxDecoration(
                  color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ModernInvoiceDesign.primary),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: ModernInvoiceDesign.space4),
              Text(
                "Loading appointments...",
                style: TextStyle(
                  color: ModernInvoiceDesign.textPrimary,
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
          ? ModernInvoiceDesign.space2
          : ModernInvoiceDesign.space3), // Reduced padding
      decoration: BoxDecoration(
        color: ModernInvoiceDesign.background.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(ModernInvoiceDesign.space4),
        border: Border.all(
          color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(isCompact ? 6 : 8),
            decoration: BoxDecoration(
              color: ModernInvoiceDesign.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ModernInvoiceDesign.space2),
            ),
            child: Icon(
              icon,
              color: ModernInvoiceDesign.primary,
              size: _getIconSize(context),
            ),
          ),
          SizedBox(width: ModernInvoiceDesign.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: _getFontSize(context, type: 'caption'),
                    fontWeight: FontWeight.w600,
                    color: ModernInvoiceDesign.primary,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: _getFontSize(context, type: 'body'),
                    fontWeight: FontWeight.w500,
                    color: ModernInvoiceDesign.textPrimary,
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
