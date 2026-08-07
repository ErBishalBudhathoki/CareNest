import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';

import 'package:carenest/app/features/home/views/employee_home_view.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/photo/views/photo_upload_view.dart';
import 'package:carenest/app/features/notes/views/add_notes_view.dart';
import 'package:carenest/app/shared/widgets/nav_bar_widget.dart';
import 'package:carenest/app/shared/widgets/splash_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
import 'package:carenest/app/features/business/views/business_list_view.dart';
import 'package:carenest/app/features/client/views/client_list_view.dart';
import 'package:carenest/app/features/client_portal/views/client_dashboard_view.dart';
import 'package:carenest/app/features/analytics/views/enhanced_predictive_insights_view.dart';
import 'package:carenest/app/features/notifications/views/notification_settings_view.dart';
import 'package:carenest/app/features/bulk_actions/views/bulk_actions_view.dart';
import 'package:carenest/app/features/scheduling/views/shift_matching_view.dart';
import 'package:carenest/app/features/scheduling/views/auto_schedule_dashboard.dart';
import 'package:carenest/app/features/invoice/views/invoice_ai_dashboard.dart';
import 'package:carenest/app/features/offline/views/offline_sync_dashboard.dart';
import 'package:carenest/app/features/compliance/views/compliance_automation_dashboard.dart';
import 'package:carenest/app/features/expenses/views/smart_expense_dashboard.dart';
import 'package:carenest/app/features/payroll/views/advanced_payroll_dashboard.dart';
import 'package:carenest/app/features/communication/views/communication_hub_dashboard.dart';
import 'package:carenest/app/features/realtime_portal/views/realtime_portal_dashboard.dart';
import 'package:carenest/app/features/realtime_portal/views/live_tracking_view.dart';
import 'package:carenest/app/features/realtime_portal/views/secure_messaging_view.dart';
import 'package:carenest/app/features/realtime_portal/views/service_confirmation_view.dart';
import 'package:carenest/app/features/realtime_portal/views/family_management_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/workforce_optimization_dashboard.dart';
import 'package:carenest/app/features/workforce_optimization/views/workforce_planning_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/resource_allocation_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/performance_analytics_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/quality_assurance_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/business_intelligence_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/report_builder_view.dart';
import 'package:carenest/app/features/care_intelligence/views/care_intelligence_dashboard.dart';
import 'package:carenest/app/features/financial_intelligence/views/financial_intelligence_dashboard.dart';
import 'package:carenest/app/features/voice_assistant/views/voice_assistant_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    const SplashScreen(),
    const AdminDashboardView(email: ''),
    const LoginView(),
    const EmployeeHomeView(email: ''),
    const SignUpView(),
    const ForgotPasswordView(),
    const AddClientDetails(),
    // const AddBusinessDetails(), // Removed as per instruction
    const BusinessListView(),
    const ClientListView(),
    const AssignC2E(),
    const ClientAndAppointmentDetails(userEmail: '', clientEmail: ''),
    const AddNotesView(userEmail: '', clientEmail: ''),
    ClockInAndOutView(
      email: '',
      // timerService: TimerService(),
    ),
    PhotoUploadScreen(email: ''),
    const ChangePasswordView(),
    const RequestsView(email: ''),
    const InvoiceListView(organizationId: '', userEmail: ''),
    const ClientDashboardView(),
    // Phase 1 Views
    const EnhancedPredictiveInsightsView(),
    const NotificationSettingsView(),
    const BulkActionsView(),
    // Phase 2 Views
    const ShiftMatchingView(),
    const AutoScheduleDashboard(),
    const InvoiceAIDashboard(),
    // Phase 3 Views
    const OfflineSyncDashboard(),
    const ComplianceAutomationDashboard(),
    const SmartExpenseDashboard(),
    // Phase 4 Views
    const ClientDashboardView(),
    const AdvancedPayrollDashboard(),
    const CommunicationHubDashboard(),
    // Phase 7 Views - Real-Time Client Portal
    const RealtimePortalDashboard(),
    const LiveTrackingView(),
    const SecureMessagingView(),
    const ServiceConfirmationView(),
    const FamilyManagementView(),

    // Phase 8 - Workforce Optimization & Business Intelligence
    const WorkforceOptimizationDashboard(),
    const WorkforcePlanningView(),
    const ResourceAllocationView(),
    const PerformanceAnalyticsView(),
    const QualityAssuranceView(),
    const BusinessIntelligenceView(),
    const ReportBuilderView(),

    // Phase 9 - AI-Powered Care Intelligence & Risk Management
    const CareIntelligenceDashboard(),

    // Phase 10 - Advanced Financial Intelligence & Predictive Revenue System
    const FinancialIntelligenceDashboard(),
    const VoiceAssistantView(),

    // const AssignmentListView(),
    //const BottomNavBarWidget(email: '', role: UserRole.employee),
  ];

  // Function-based route for NavBarWidget
  static Widget navBar(
    BuildContext context,
    String email,
    String firstName,
    String lastName,
    UserRole role, {
    String? organizationId,
    String? organizationName,
    String? organizationCode,
  }) {
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
