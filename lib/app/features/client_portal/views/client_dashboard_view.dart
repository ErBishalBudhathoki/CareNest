import 'package:carenest/app/core/utils/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'client_invoice_list_view.dart';

import 'client_appointment_view.dart';

class ClientDashboardView extends ConsumerStatefulWidget {
  const ClientDashboardView({super.key});

  @override
  ConsumerState<ClientDashboardView> createState() => _ClientDashboardViewState();
}

class _ClientDashboardViewState extends ConsumerState<ClientDashboardView> {
  int _currentIndex = 0;

  final _pages = const [
    ClientInvoiceListView(),
    ClientAppointmentView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Request notification permission after the dashboard is loaded
      if (mounted) {
        await PermissionManager.requestNotificationPermission(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        backgroundColor: BauhausDesign.surfaceWhite,
        elevation: 0,
        title: Text(
          'CLIENT PORTAL',
          style: GoogleFonts.oswald(
            color: BauhausDesign.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: BauhausDesign.neutral),
            onPressed: () async {
              // Assuming LoginViewModel has a logout method or we use shared prefs directly
              // Or we can just pop to login if we have a way.
              // For now, let's navigate to LoginView and clear stack.
              // Ideally, we should call a logout method in LoginViewModel.
              // But LoginViewModel handles login logic, usually there is an AuthViewModel or similar.
              // Let's assume we can just go back to LoginView for now.
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginView()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: BauhausDesign.neutral,
            height: 1.0,
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: BauhausDesign.neutral, width: 1.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: BauhausDesign.surfaceWhite,
          selectedItemColor: BauhausDesign.primary,
          unselectedItemColor: BauhausDesign.neutral,
          selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.inter(),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'Invoices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Appointments',
            ),
          ],
        ),
      ),
    );
  }
}
