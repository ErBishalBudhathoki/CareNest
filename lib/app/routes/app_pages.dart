import 'package:flutter/material.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/app/features/Appointment/views/select_employee_view.dart';
import 'package:carenest/app/features/Appointment/widgets/shift_details_widget.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/features/admin/views/bank_details_view.dart';
import 'package:carenest/app/features/admin/views/employee_invoice_generation_view.dart';
import 'package:carenest/app/features/assignment_list/views/assignment_list_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/views/change_password_view.dart';
import 'package:carenest/app/features/auth/views/forgot_password_view.dart';
import 'package:carenest/app/features/auth/views/login_view.dart';
import 'package:carenest/app/features/auth/views/signup_view.dart';
import 'package:carenest/app/features/business/views/add_business_details_view.dart';
import 'package:carenest/app/features/business/views/business_list_view.dart';
import 'package:carenest/app/features/care_intelligence/views/behavior_support_view.dart';
import 'package:carenest/app/features/care_intelligence/views/care_intelligence_dashboard.dart';
import 'package:carenest/app/features/care_intelligence/views/care_plan_builder_view.dart';
import 'package:carenest/app/features/care_intelligence/views/health_monitoring_view.dart';
import 'package:carenest/app/features/care_intelligence/views/incident_management_view.dart';
import 'package:carenest/app/features/care_intelligence/views/medication_management_view.dart';
import 'package:carenest/app/features/care_intelligence/views/outcome_tracking_view.dart';
import 'package:carenest/app/features/care_intelligence/views/risk_assessment_view.dart';
import 'package:carenest/app/features/claiming/views/claim_dashboard_view.dart';
import 'package:carenest/app/features/client_portal/views/client_dashboard_view.dart';
import 'package:carenest/app/features/client/views/add_client_details_view.dart';
import 'package:carenest/app/features/client/views/client_list_view.dart';
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:carenest/app/features/home/views/employee_home_view.dart';
import 'package:carenest/app/features/invoice/views/automatic_invoice_generation_view.dart';
import 'package:carenest/app/features/invoice/views/employee_selection_view.dart';
import 'package:carenest/app/features/invoice/views/enhanced_invoice_generation_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_detail_view.dart';
import 'package:carenest/app/features/invoice/views/invoice_list_view.dart';
import 'package:carenest/app/features/mileage/views/mileage_tracker_view.dart';
import 'package:carenest/app/features/notes/views/add_notes_view.dart';
import 'package:carenest/app/features/notes/views/note_templates_view.dart';
import 'package:carenest/app/features/onboarding/views/onboarding_app_router.dart';
import 'package:carenest/app/features/onboarding/views/onboarding_stepper_view.dart';
import 'package:carenest/app/features/onboarding/views/onboarding_welcome_view.dart';
import 'package:carenest/app/features/realtime_portal/views/admin_family_management_view.dart';
import 'package:carenest/app/features/realtime_portal/views/appointment_timeline_view.dart';
import 'package:carenest/app/features/realtime_portal/views/family_management_view.dart';
import 'package:carenest/app/features/realtime_portal/views/live_tracking_view.dart';
import 'package:carenest/app/features/realtime_portal/views/messaging_audit_view.dart';
import 'package:carenest/app/features/realtime_portal/views/realtime_portal_dashboard.dart';
import 'package:carenest/app/features/realtime_portal/views/secure_messaging_view.dart';
import 'package:carenest/app/features/realtime_portal/views/service_confirmation_view.dart';
import 'package:carenest/app/features/requests/views/admin_requests_dashboard_view.dart';
import 'package:carenest/app/features/sil/views/sil_dashboard_view.dart';
import 'package:carenest/app/features/sil/views/sil_property_detail_view.dart';
import 'package:carenest/app/features/sil/views/sil_roster_builder_view.dart';
import 'package:carenest/app/features/teams/views/team_dashboard_view.dart';
import 'package:carenest/app/features/voice_assistant/views/voice_assistant_view.dart';
import 'package:carenest/app/features/worker/views/deprecated_worker_dashboard_view.dart';
import 'package:carenest/app/features/worker/views/worker_shift_history_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/business_intelligence_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/performance_analytics_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/quality_assurance_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/report_builder_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/resource_allocation_view.dart';
import 'package:carenest/app/features/workforce_optimization/views/workforce_planning_view.dart';
import 'package:carenest/app/shared/widgets/bottom_nav_bar_widget.dart';
import 'package:carenest/app/shared/widgets/nav_bar_widget.dart';
import 'package:carenest/app/shared/widgets/splash_screen_widget.dart';
part 'app_routes.dart';

/// Central named-route table shared by every entrypoint
/// (main.dart, main_development.dart, main_production.dart).
///
/// Keeping the routes here — rather than duplicating them in each
/// entrypoint — prevents the three maps drifting apart (which previously
/// left newer routes, e.g. SIL and NDIS claiming, unregistered in the
/// production/internal build).
class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static Map<String, WidgetBuilder> buildRoutes() {
    return {
          '/': (context) => const SplashScreen(), // Add root route
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.admin: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final email = arguments?['email'] as String? ?? '';
            final organizationId = arguments?['organizationId'] as String?;
            final organizationName = arguments?['organizationName'] as String?;
            final organizationCode = arguments?['organizationCode'] as String?;

            // Debug prints to track organizationId flow
            debugPrint('=== ADMIN ROUTE DEBUG: email = $email ===');
            debugPrint(
              '=== ADMIN ROUTE DEBUG: organizationId = $organizationId ===',
            );
            debugPrint(
              '=== ADMIN ROUTE DEBUG: organizationName = $organizationName ===',
            );
            debugPrint(
              '=== ADMIN ROUTE DEBUG: organizationCode = $organizationCode ===',
            );

            return AdminDashboardView(
              email: email,
              organizationId: organizationId,
              organizationName: organizationName,
              organizationCode: organizationCode,
            );
          },
          Routes.employeeSelection: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String email = arguments['email'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String organizationName =
                arguments['organizationName'] as String? ?? '';
            return EmployeeSelectionView(
              email: email,
              organizationId: organizationId,
              organizationName: organizationName,
            );
          },
          Routes.login: (context) => LoginView(),
          Routes.home: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final email = arguments?['email'] as String? ?? '';
            return EmployeeHomeView(email: email);
          },
          Routes.signup: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;

            final prefilledOrgCode =
                arguments?['prefilledOrgCode'] as String? ?? '';

            return SignUpView(prefilledOrgCode: prefilledOrgCode);
          },

          Routes.forgotPassword: (context) => ForgotPasswordView(),
          Routes.changePassword: (context) => const ChangePasswordView(),
          Routes.addClientDetails: (context) => const AddClientDetails(),
          Routes.clientList: (context) => const ClientListView(),
          Routes.addBusinessDetails: (context) => const AddBusinessDetails(),
          Routes.businessList: (context) => const BusinessListView(),
          '/client-portal': (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return ClientDashboardView(
              clientId: (clientId != null && clientId.isNotEmpty)
                  ? clientId
                  : null,
            );
          },
          Routes.clientPortal: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return ClientDashboardView(
              clientId: (clientId != null && clientId.isNotEmpty)
                  ? clientId
                  : null,
            );
          },
          Routes.clientDashboard: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            final isFamilyViewer =
                arguments['isFamilyViewer'] as bool? ?? false;
            return ClientDashboardView(
              clientId: (clientId != null && clientId.isNotEmpty)
                  ? clientId
                  : null,
              isFamilyViewer: isFamilyViewer,
            );
          },
          Routes.realtimePortal: (context) => const RealtimePortalDashboard(),
          Routes.liveTracking: (context) => const LiveTrackingView(),
          Routes.appointmentTimeline: (context) =>
              const AppointmentTimelineView(),
          Routes.secureMessaging: (context) => const SecureMessagingView(),
          Routes.serviceConfirmation: (context) =>
              const ServiceConfirmationView(),
          Routes.familyManagement: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return FamilyManagementView(
              clientId: (clientId != null && clientId.isNotEmpty)
                  ? clientId
                  : null,
            );
          },
          Routes.adminFamilyManagement: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final clientId = arguments['clientId'] as String?;
            return AdminFamilyManagementView(clientId: clientId ?? '');
          },
          Routes.messagingAudit: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final appointmentId = arguments['appointmentId'] as String?;
            return MessagingAuditView(appointmentId: appointmentId);
          },
          Routes.assignC2E: (context) => const AssignC2E(),
          Routes.onboarding: (context) => const OnboardingWelcomeView(),
          Routes.onboardingStepper: (context) => const OnboardingStepperView(),
          Routes.onboardingAppIntro: (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            return OnboardingAppRouter(
              onFinished: () {
                Navigator.pushReplacementNamed(
                  context,
                  args?['nextRoute'] as String? ?? Routes.login,
                );
              },
            );
          },
          Routes.navBar: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final email =
                arguments?['email'] as String? ?? 'defaultemail@default.com';
            final firstName = arguments?['firstName'] as String? ?? 'First';
            final lastName = arguments?['lastName'] as String? ?? 'Last';
            final role = arguments?['role'] as UserRole? ?? UserRole.employee;
            return NavBarWidget(
              context: context,
              email: email,
              firstName: firstName,
              lastName: lastName,
              role: role,
            );
          },
          Routes.bottomNavBar: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final email = arguments?['email'] as String? ?? '';
            final role = arguments?['role'] as UserRole? ?? UserRole.employee;
            final organizationId =
                arguments?['organizationId'] as String? ?? '';
            final organizationName =
                arguments?['organizationName'] as String? ?? '';
            final organizationCode =
                arguments?['organizationCode'] as String? ?? '';
            final initialIndex = arguments?['initialIndex'] as int?;
            return BottomNavBarWidget(
              key: ValueKey('bottom_nav_${email}_${role.toString()}'),
              email: email,
              role: role,
              organizationId: organizationId,
              organizationName: organizationName,
              organizationCode: organizationCode,
              initialIndex: initialIndex,
            );
          },
          Routes.clientAndAppointmentDetails: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final userEmail = arguments?['userEmail'] as String? ?? '';
            final clientEmail = arguments?['clientEmail'] as String? ?? '';
            return ClientAndAppointmentDetails(
              userEmail: userEmail,
              clientEmail: clientEmail,
            );
          },
          Routes.addNotes: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final userEmail = arguments?['userEmail'] as String? ?? '';
            final clientEmail = arguments?['clientEmail'] as String? ?? '';
            return AddNotesView(userEmail: userEmail, clientEmail: clientEmail);
          },
          Routes.clockInAndOutView: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>?;
            final userEmail = arguments?['userEmail'] as String? ?? '';
            return ClockInAndOutView(email: userEmail);
          },
          // <<< --- THIS IS THE CORRECTED BLOCK --- >>>
          Routes.assignmentList: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String userEmail = arguments['userEmail'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            return AssignmentListView(
              userEmail: userEmail,
              organizationId: organizationId,
            );
          },
          Routes.shiftDetails: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final userEmail = arguments['userEmail'] as String? ?? '';
            final clientEmail = arguments['clientEmail'] as String? ?? '';
            final shiftData =
                arguments['shiftData'] as Map<String, dynamic>? ?? {};
            return Scaffold(
              appBar: AppBar(
                title: const Text('Shift Details'),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Assignment Successful!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Employee: $userEmail',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Client: $clientEmail',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Assigned Shifts:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: ShiftDetailsWidget(shiftData: shiftData)),
                  ],
                ),
              ),
            );
          },
          Routes.enhancedInvoiceGeneration: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String userEmail = arguments['userEmail'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String organizationName =
                arguments['organizationName'] as String? ?? '';
            final List<Map<String, dynamic>>? selectedEmployeesAndClients =
                arguments['selectedEmployeesAndClients']
                    as List<Map<String, dynamic>>?;
            return EnhancedInvoiceGenerationView(
              email: userEmail,
              genKey: organizationId,
              organizationName: organizationName,
              selectedEmployeesAndClients: selectedEmployeesAndClients,
            );
          },

          Routes.employeeInvoice: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String adminEmail = arguments['email'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String? organizationName =
                arguments['organizationName'] as String?;

            return EmployeeInvoiceGenerationView(
              adminEmail: adminEmail,
              organizationId: organizationId,
              organizationName: organizationName,
            );
          },
          Routes.automaticInvoiceGeneration: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String? organizationId =
                arguments['organizationId'] as String?;
            final String? organizationName =
                arguments['organizationName'] as String?;
            final String? email = arguments['email'] as String?;
            final bool autoMode = (arguments['autoMode'] as bool?) ?? false;
            final String? invoiceType = arguments['invoiceType'] as String?;

            return AutomaticInvoiceGenerationView(
              organizationId: organizationId,
              organizationName: organizationName,
              email: email,
              autoMode: autoMode,
              invoiceType: invoiceType,
            );
          },
          Routes.invoiceList: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final String userEmail = arguments['userEmail'] as String? ?? '';
            return InvoiceListView(
              organizationId: organizationId,
              userEmail: userEmail,
            );
          },
          Routes.invoiceDetails: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments
                    as Map<String, dynamic>? ??
                {};
            final String invoiceId = arguments['invoiceId'] as String? ?? '';
            final String organizationId =
                arguments['organizationId'] as String? ?? '';
            final Map<String, dynamic>? invoiceData =
                arguments['invoiceData'] as Map<String, dynamic>?;
            return InvoiceDetailView(
              invoiceId: invoiceId,
              organizationId: organizationId,
              initialInvoiceData: invoiceData,
            );
          },
          Routes.bankDetails: (context) => const BankDetailsView(),
          Routes.adminRequests: (context) => const AdminRequestsDashboardView(),
          Routes.mileageTracker: (context) => const MileageTrackerView(),
          Routes.voiceAssistant: (context) => const VoiceAssistantView(),
          // Care Intelligence Routes
          Routes.careIntelligence: (context) =>
              const CareIntelligenceDashboard(),
          Routes.riskAssessment: (context) => const RiskAssessmentView(),
          Routes.carePlanBuilder: (context) => const CarePlanBuilderView(),
          Routes.incidentManagement: (context) =>
              const IncidentManagementView(),
          Routes.medicationManagement: (context) =>
              const MedicationManagementView(),
          Routes.behaviorSupport: (context) => const BehaviorSupportView(),
          Routes.healthMonitoring: (context) => const HealthMonitoringView(),
          Routes.outcomeTracking: (context) => const OutcomeTrackingView(),
          Routes.workerDashboard: (context) =>
              const DeprecatedWorkerDashboardView(),
          Routes.workerShiftHistory: (context) =>
              const WorkerShiftHistoryView(),
          Routes.teamDashboard: (context) => const TeamDashboardView(),
          // Workforce Optimization Routes
          Routes.workforcePlanning: (context) => const WorkforcePlanningView(),
          Routes.resourceAllocation: (context) =>
              const ResourceAllocationView(),
          Routes.performanceAnalytics: (context) =>
              const PerformanceAnalyticsView(),
          Routes.qualityAssurance: (context) => const QualityAssuranceView(),
          Routes.businessIntelligence: (context) =>
              const BusinessIntelligenceView(),
          Routes.reportBuilder: (context) => const ReportBuilderView(),
          // SIL management (Phase 4)
          Routes.silDashboard: (context) => const SILDashboardView(),
          Routes.silPropertyDetail: (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments as Map? ?? const {};
            return SILPropertyDetailView(
              propertyId: args['propertyId']?.toString() ?? '',
              propertyName: args['propertyName']?.toString() ?? 'Property',
            );
          },
          Routes.silRoster: (context) {
            final args =
                ModalRoute.of(context)?.settings.arguments as Map? ?? const {};
            return SILRosterBuilderView(
              propertyId: args['propertyId']?.toString() ?? '',
              propertyName: args['propertyName']?.toString() ?? 'Property',
            );
          },
          // NDIS claiming / export (Phase 6)
          Routes.claimDashboard: (context) => const ClaimDashboardView(),
          // Progress-note templates admin (Phase 2)
          Routes.noteTemplates: (context) => const NoteTemplatesView(),
    };
  }

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
