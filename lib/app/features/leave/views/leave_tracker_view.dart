import 'package:carenest/app/features/leave/views/leave_request_form.dart';
import 'package:carenest/app/shared/design_system/bauhaus_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class LeaveTrackerView extends ConsumerStatefulWidget {
  final String userEmail;

  const LeaveTrackerView({super.key, required this.userEmail});

  @override
  ConsumerState<LeaveTrackerView> createState() => _LeaveTrackerViewState();
}

class _LeaveTrackerViewState extends ConsumerState<LeaveTrackerView> {
  final ApiMethod apiMethod = ApiMethod();
  Map<String, dynamic>? leaveBalances;
  List<dynamic> leaveRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    final balances = await apiMethod.getLeaveBalances(widget.userEmail);
    final requests = await apiMethod.getLeaveRequests(widget.userEmail);

    if (mounted) {
      setState(() {
        leaveBalances = balances['success'] == true ? balances['balances'] : null;
        leaveRequests = requests['success'] == true ? requests['requests'] : [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.surfaceLight,
      appBar: AppBar(
        title: Text(
          'LEAVE TRACKER',
          style: GoogleFonts.oswald(
            color: BauhausDesign.textDark,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: BauhausDesign.surfaceLight,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: BauhausDesign.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(color: BauhausDesign.textDark, height: 2),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: BauhausDesign.textDark))
          : RefreshIndicator(
              onRefresh: _loadData,
              color: BauhausDesign.textDark,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader("CURRENT BALANCES"),
                    const SizedBox(height: 16),
                    _buildBalanceCard(
                      "ANNUAL LEAVE",
                      leaveBalances?['annualLeave'] ?? 0.0,
                      BauhausDesign.secondary,
                    ),
                    const SizedBox(height: 12),
                    _buildBalanceCard(
                      "PERSONAL / SICK LEAVE",
                      leaveBalances?['personalLeave'] ?? 0.0,
                      BauhausDesign.accent,
                    ),
                    const SizedBox(height: 12),
                    _buildBalanceCard(
                      "LONG SERVICE LEAVE",
                      leaveBalances?['longServiceLeave'] ?? 0.0,
                      BauhausDesign.error,
                    ),

                    const SizedBox(height: 32),
                     _buildSectionHeader("FORECAST"),
                     const SizedBox(height: 16),
                     _buildForecastWidget(),

                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BauhausDesign.textDark,
                          foregroundColor: BauhausDesign.surfaceLight,
                          shape: const RoundedRectangleBorder(),
                          elevation: 0,
                        ),
                        onPressed: () async {
                           await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeaveRequestForm(userEmail: widget.userEmail),
                            ),
                          );
                          _loadData(); // Refresh on return
                        },
                        child: Text(
                          "NEW REQUEST",
                          style: GoogleFonts.oswald(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                    _buildSectionHeader("REQUEST HISTORY"),
                    const SizedBox(height: 16),
                    _buildHistoryList(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: BauhausDesign.textDark, width: 4)),
      ),
      child: Text(
        title,
        style: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: BauhausDesign.textDark,
        ),
      ),
    );
  }

  Widget _buildBalanceCard(String title, dynamic hours, Color accentColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceLight,
        border: Border.all(color: BauhausDesign.textDark, width: 2),
         boxShadow: const [
          BoxShadow(
            color: BauhausDesign.neutral,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: BauhausDesign.textDark,
                  ),
                ),
                Text(
                  "Available Hours",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: BauhausDesign.neutral,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor,
              border: Border.all(color: BauhausDesign.textDark, width: 2),
            ),
            child: Text(
              "${double.parse(hours.toString()).toStringAsFixed(2)} HRS",
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: BauhausDesign.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastWidget() {
    // Simple mock forecast for MVP
    // Ideally user picks a date
    final now = DateTime.now();
    final nextMonth = now.add(const Duration(days: 30));
    final accrued = (leaveBalances?['annualLeave'] ?? 0.0) + 12.0; // Assume ~12 hrs monthly accrual for full time

    return Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: BauhausDesign.surfaceLight,
         border: Border.all(color: BauhausDesign.textDark, width: 1),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             "ESTIMATED BALANCE BY ${DateFormat('dd MMM yyyy').format(nextMonth)}",
             style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
           ),
           const SizedBox(height: 8),
           RichText(
             text: TextSpan(
               children: [
                 TextSpan(
                   text: double.parse(accrued.toString()).toStringAsFixed(2),
                   style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
                 ),
                 TextSpan(
                   text: " HRS (Annual)",
                   style: GoogleFonts.inter(fontSize: 14, color: BauhausDesign.neutral, fontWeight: FontWeight.w500),
                 ),
               ],
             ),
           ),
           const SizedBox(height: 8),
           Text(
             "Based on standard SCHADS accrual rates.",
             style: GoogleFonts.inter(fontSize: 12, fontStyle: FontStyle.italic, color: BauhausDesign.neutral),
           ),
         ],
       ),
    );
  }

  Widget _buildHistoryList() {
    if (leaveRequests.isEmpty) {
      return Center(
        child: Text(
          "No leave history found.",
          style: GoogleFonts.inter(color: BauhausDesign.neutral, fontStyle: FontStyle.italic),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: leaveRequests.length,
      itemBuilder: (context, index) {
        final req = leaveRequests[index];
        Color statusColor = BauhausDesign.neutral;
        if (req['status'] == 'Approved') statusColor = BauhausDesign.success;
        if (req['status'] == 'Rejected') statusColor = BauhausDesign.error;
        if (req['status'] == 'Pending') statusColor = BauhausDesign.warning;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceLight,
            border: Border.all(color: BauhausDesign.textDark, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    req['leaveType'] ?? 'Unknown',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 16, color: BauhausDesign.textDark),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      border: Border.all(color: BauhausDesign.textDark, width: 1),
                    ),
                    child: Text(
                      (req['status'] ?? 'Unknown').toUpperCase(),
                      style: GoogleFonts.oswald(fontSize: 12, fontWeight: FontWeight.bold, color: BauhausDesign.textDark),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "${DateFormat('dd MMM').format(DateTime.parse(req['startDate']))} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(req['endDate']))}",
                style: GoogleFonts.inter(fontSize: 14, color: BauhausDesign.textDark),
              ),
              if (req['reason'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Reason: ${req['reason']}",
                    style: GoogleFonts.inter(fontSize: 12, color: BauhausDesign.neutral),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
