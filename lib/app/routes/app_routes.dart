part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = '/splashScreen';
  static const admin = '/admin';
  static const login = '/login';
  static const home = '/home';
  static const signup = '/signup';
  static const forgotPassword = '/forgotPassword';
  static const addClientDetails = '/home/addClientDetails';
  static const addBusinessDetails = '/home/addBusinessDetails';
  static const businessList = '/businessList';
  static const clientList = '/clientList';
  static const assignClients = '/admin/assignClients';
  static const assignC2E = '/assignC2E';
  static const navBar = '/home/navBar';
  static const clientAndAppointmentDetails =
      '/home/ClientAndAppointmentDetails';
  static const addNotes = '/home/ClientAndAppointmentDetails/addNotes';
  static const clockInAndOutView = '/home/clockInAndOutView';
  static const photoUploadScreen = '/photoUploadScreen';
  static const changePassword = '/changePassword';
  // static const bottomNavBar = '/bottomNavBar';
  static const requests = '/home/requests';
  static const timesheet = '/home/timesheet';
  static const bottomNavBar = '/bottomNavBar';
  static const assignmentList = '/assignmentList';
  static const enhancedInvoiceGeneration = '/enhancedInvoiceGeneration';
  static const automaticInvoiceGeneration = '/automaticInvoiceGeneration';
  static const employeeSelection = '/employeeSelection';
  static const String invoiceList = '/invoiceList';
  static const String invoiceDetails = '/invoiceDetails';
  static const bankDetails = '/bank-details';
  static const adminRequests = '/admin/requests';
  static const trainingCompliance = '/trainingCompliance';
  static const String mileageTracker = '/mileageTracker';
  static const String shiftDetails = '/shiftDetails';
  static const String employeeInvoice = '/employeeInvoice';
  static const String onboarding = '/onboarding';
  static const String clientDashboard = '/clientDashboard';
  
  // Phase 1 Routes
  static const String enhancedAnalytics = '/analytics/enhanced';
  static const String notificationSettings = '/settings/notifications';
  static const String bulkActions = '/bulk-actions';
  
  // Phase 2 Routes
  static const String shiftMatching = '/scheduling/shift-matching';
  static const String autoSchedule = '/scheduling/auto-schedule';
  static const String invoiceAI = '/invoice/ai-dashboard';
  
  // Phase 3 Routes
  static const String offlineSync = '/offline/sync-dashboard';
  static const String complianceAutomation = '/compliance/automation-dashboard';
  static const String smartExpense = '/expenses/smart-dashboard';
  
  // Phase 4 Routes
  static const String clientPortal = '/client-portal/dashboard';
  static const String advancedPayroll = '/payroll/advanced-dashboard';
  static const String communicationHub = '/communication/hub-dashboard';
  
  // Phase 7 Routes - Real-Time Client Portal
  static const String realtimePortal = '/realtime-portal/dashboard';
  static const String liveTracking = '/realtime-portal/live-tracking';
  static const String appointmentTimeline = '/realtime-portal/appointment-timeline';
  static const String secureMessaging = '/realtime-portal/secure-messaging';
  static const String serviceConfirmation = '/realtime-portal/service-confirmation';
  static const String familyManagement = '/realtime-portal/family-management';
  
  // Phase 8 Routes - Workforce Optimization & Business Intelligence
  static const String workforceOptimization = '/workforce-optimization/dashboard';
  static const String workforcePlanning = '/workforce-optimization/planning';
  static const String resourceAllocation = '/workforce-optimization/allocation';
  static const String performanceAnalytics = '/workforce-optimization/performance';
  static const String qualityAssurance = '/workforce-optimization/quality';
  static const String businessIntelligence = '/workforce-optimization/business-intelligence';
  static const String reportBuilder = '/workforce-optimization/report-builder';
  
  // Phase 9 Routes - AI-Powered Care Intelligence & Risk Management
  static const String careIntelligence = '/care-intelligence/dashboard';
  static const String riskAssessment = '/care-intelligence/risk-assessment';
  static const String carePlanBuilder = '/care-intelligence/care-plan-builder';
  static const String incidentManagement = '/care-intelligence/incident-management';
  static const String medicationManagement = '/care-intelligence/medication-management';
  static const String behaviorSupport = '/care-intelligence/behavior-support';
  static const String healthMonitoring = '/care-intelligence/health-monitoring';
  static const String outcomeTracking = '/care-intelligence/outcome-tracking';

  // Phase 10 Routes - Advanced Financial Intelligence & Predictive Revenue System
  static const String financialIntelligence = '/financial-intelligence/dashboard';
  static const String revenueForecasting = '/financial-intelligence/revenue-forecasting';
  static const String pricingOptimization = '/financial-intelligence/pricing';
  static const String billingAutomation = '/financial-intelligence/billing';
  static const String cashFlowManagement = '/financial-intelligence/cashflow';
  static const String financialAnalytics = '/financial-intelligence/analytics';
  static const String budgetManagement = '/financial-intelligence/budget';
  static const String paymentProcessing = '/financial-intelligence/payments';
  static const String financialCompliance = '/financial-intelligence/compliance';
  static const String financialReporting = '/financial-intelligence/reporting';
}

