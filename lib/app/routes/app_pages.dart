import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/home/views/home_view.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/busineess/views/add_business_details_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/admin/views/bank_details_view.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/photo/views/photo_upload_view.dart';
import 'package:carenest/app/features/notes/views/add_notes_view.dart';
import 'package:carenest/app/shared/widgets/bottom_navBar_widget.dart';
import 'package:carenest/app/shared/widgets/navBar_widget.dart';
import 'package:carenest/app/shared/widgets/splashScreen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/assignment_list/views/assignment_list_view.dart';
import 'package:carenest/app/features/pricing/views/pricing_management_view.dart';
import 'package:carenest/app/features/expenses/views/expense_management_view.dart';
import 'package:carenest/app/features/invoice/views/enhanced_invoice_generation_view.dart';
import 'package:carenest/app/features/invoice/views/employee_selection_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    const SplashScreen(),
    const AdminDashboardView(email: ''),
    const BankDetailsView(),
    const LoginView(),
    const HomeView(email: ''),
    const SignUpView(),
    const ForgotPasswordView(),
    const AddClientDetails(),
    const AddBusinessDetails(),
    const AssignC2E(),
    const ClientAndAppointmentDetails(
      userEmail: '',
      clientEmail: '',
    ),
    const AddNotesView(userEmail: '', clientEmail: ''),
    ClockInAndOutView(
      email: '',
      // timerService: TimerService(),
    ),
    PhotoUploadScreen(email: ''),
    const ChangePasswordView(),
    const RequestsView(
      email: '',
    ),
    const InvoiceListView(
      organizationId: '',
      userEmail: '',
    ),
    // const AssignmentListView(),
    //const BottomNavBarWidget(email: '', role: UserRole.normal),
  ];

  // Function-based route for NavBarWidget
  static Widget navBar(BuildContext context, String email, String firstName,
      String lastName, UserRole role,
      {String? organizationId,
      String? organizationName,
      String? organizationCode}) {
    return NavBarWidget(
      context: context,
      email: email,
      firstName: firstName,
      lastName: lastName,
      role: role,
      organizationId: organizationId,
      organizationName: organizationName,
      organizationCode: organizationCode,
    );
  }
}
