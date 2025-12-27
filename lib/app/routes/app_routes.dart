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
}
