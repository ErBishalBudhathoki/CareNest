// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'CareNest';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get emailLabel => 'Email address';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get signInButton => 'Sign in';

  @override
  String get signingIn => 'Signing you in...';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get createAccount => 'Create account';

  @override
  String get signupPrompt => 'Don\'t have an account?';

  @override
  String get signupLink => 'Sign Up';

  @override
  String get or => 'or';

  @override
  String get securedWith256Bit => 'Secured with 256-bit SSL encryption';

  @override
  String get copyright => '© 2024 CareNest. All rights reserved.';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get signupSubtitle =>
      'Join us and start managing your invoices efficiently';

  @override
  String get personalInfoSection => 'Personal Information';

  @override
  String get firstNameHint => 'First Name';

  @override
  String get firstNameRequired => 'Please enter first name';

  @override
  String get lastNameHint => 'Last Name';

  @override
  String get lastNameRequired => 'Please enter last name';

  @override
  String get abnHint => 'ABN (11 digits)';

  @override
  String get abnInvalid => 'Please enter a valid 11-digit ABN';

  @override
  String get accountTypeSection => 'Account Type';

  @override
  String get normalUser => 'Normal User';

  @override
  String get normalUserDesc => 'Access basic invoice features';

  @override
  String get administrator => 'Administrator';

  @override
  String get administratorDesc => 'Full access and organization management';

  @override
  String get organizationSetupSection => 'Organization Setup';

  @override
  String get createNewOrg => 'Create New Organization';

  @override
  String get createNewOrgDesc => 'Set up your own organization';

  @override
  String get organizationNameHint => 'Organization Name';

  @override
  String get organizationNameRequired => 'Please enter organization name';

  @override
  String get joinOrgSection => 'Join Organization';

  @override
  String get joinExistingOrg => 'Join Existing Organization';

  @override
  String get joinExistingOrgDesc => 'Enter organization code to join';

  @override
  String get organizationCodeHint => 'Organization Code';

  @override
  String get organizationCodeRequired => 'Please enter organization code';

  @override
  String get securitySection => 'Security';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginLink => 'Login';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordHeader => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle =>
      'Don\'t worry! Enter your email address and we\'ll send you a verification code to reset your password.';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get enterEmailHint => 'Enter your email address';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get sending => 'Sending...';

  @override
  String get rememberPassword => 'Remember your password?';

  @override
  String get verificationCodeSent => 'Verification code sent successfully!';

  @override
  String get failedToSendCode =>
      'Failed to send verification code. Please try again.';

  @override
  String get verifyOtpTitle => 'Verify OTP';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get weSentCode => 'We sent a 6-digit code to your email';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get didntReceiveCode => 'Didn\'t receive code?';

  @override
  String get resend => 'Resend';

  @override
  String get warning => 'Warning';

  @override
  String get ok => 'OK';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordDesc =>
      'Create a new secure password for your account';

  @override
  String get newPasswordHint => 'New Password';

  @override
  String get passwordUpdatedSuccess => 'Password updated successfully!';

  @override
  String get passwordUpdateFailed => 'Updating password Failed!';

  @override
  String get success => 'Success';

  @override
  String get settingsTitle => 'SETTINGS';

  @override
  String get accountSection => 'Account';

  @override
  String get profileSettings => 'Profile Settings';

  @override
  String get profileSettingsSubtitle => 'Update your personal information';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordSubtitle => 'Update your account password';

  @override
  String get organizationSection => 'Organization';

  @override
  String get organizationDetails => 'Organization Details';

  @override
  String get appSettingsSection => 'App Settings';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle => 'Manage notification preferences';

  @override
  String get dateFormatTitle => 'Date Format';

  @override
  String get dateFormatSubtitle => 'Control parsing of ambiguous dates';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeSubtitle => 'Choose app appearance';

  @override
  String get ownerToolsSection => 'Owner Tools';

  @override
  String get adminDashboard => 'Admin Dashboard';

  @override
  String get adminDashboardSubtitle => 'Manage organization and app';

  @override
  String get securityDashboard => 'Security Dashboard';

  @override
  String get securityDashboardSubtitle => 'API usage and security metrics';

  @override
  String get pricingAnalytics => 'Pricing Analytics';

  @override
  String get pricingAnalyticsSubtitle => 'Analyze pricing performance';

  @override
  String get dangerZoneSection => 'Danger Zone';

  @override
  String get logoutButton => 'Logout';

  @override
  String get logoutSubtitle => 'Sign out of your account';

  @override
  String get logoutConfirmTitle => 'Logout';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to logout?';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountSubtitle => 'Permanently delete your account';

  @override
  String get deleteAccountConfirmTitle => 'Delete Account';

  @override
  String get deleteAccountConfirmMessage =>
      'This action is permanent and cannot be undone. Are you sure?';

  @override
  String get version => 'Version';

  @override
  String versionFormat(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get restrictedOwnerOnly => 'Restricted: Owner access only';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get saveButton => 'Save';

  @override
  String get deleteButton => 'Delete';

  @override
  String get editButton => 'Edit';

  @override
  String get addButton => 'Add';

  @override
  String get updateButton => 'Update';

  @override
  String get closeButton => 'Close';

  @override
  String get doneButton => 'Done';

  @override
  String get nextButton => 'Next';

  @override
  String get backButton => 'Back';

  @override
  String get submitButton => 'Submit';

  @override
  String get errorNetworkTitle => 'CONNECTION ERROR';

  @override
  String get errorNetworkMessage =>
      'Unable to connect to the server. Please check your internet connection and try again.';

  @override
  String get errorGenericTitle => 'SOMETHING WENT WRONG';

  @override
  String get errorGenericMessage =>
      'An unexpected error occurred. Please try again.';

  @override
  String get retryButton => 'TRY AGAIN';

  @override
  String get noResultsTitle => 'NO RESULTS';

  @override
  String get noResultsMessage => 'No items found matching your criteria.';

  @override
  String get loadingMessage => 'Loading...';

  @override
  String get loadingDashboard => 'Loading Dashboard...';

  @override
  String get successMessage => 'Success!';

  @override
  String get homeTitle => 'Home';

  @override
  String get adminTitle => 'Admin';

  @override
  String get invoicesTitle => 'Invoices';

  @override
  String invoiceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count invoices',
      one: '1 invoice',
      zero: 'No invoices',
    );
    return '$_temp0';
  }

  @override
  String get profileTitle => 'Profile';

  @override
  String get offlineBannerMessage =>
      'You are offline. Changes will sync when connected.';

  @override
  String get naLabel => 'N/A';

  @override
  String get bankDetailsTitle => 'Bank Details';

  @override
  String get primaryAccount => 'PRIMARY ACCOUNT';

  @override
  String get noBankDetails => 'No bank details saved yet.';

  @override
  String get addBankDetails => 'Add Your Bank Details';

  @override
  String get updateBankDetails => 'Update Bank Details';

  @override
  String get selectBankDetails => 'Select which bank details to display';

  @override
  String get employeeBankDetails => 'Employee Bank Details';

  @override
  String get employeeBankDetailsDesc =>
      'Use the employee\'s saved bank details';

  @override
  String get adminBankDetails => 'Admin Bank Details';

  @override
  String get adminBankDetailsDesc =>
      'Use admin bank details (invoices created by admin only)';

  @override
  String get bankDetailsNote =>
      'Note: Invoice creation is restricted to admin users.';

  @override
  String get bankDetailsNotSet =>
      'Employee bank details are not set yet. Please add your bank details first.';

  @override
  String get trackExpenses => 'Track Expenses';

  @override
  String get trackExpensesDesc =>
      'Keep track of your daily spending and manage reimbursements.';

  @override
  String get openDashboard => 'Open Dashboard';

  @override
  String get clockIn => 'Clock in';

  @override
  String get clockOut => 'Clock out';

  @override
  String get activeBusinesses => 'Active Businesses';

  @override
  String get totalClients => 'Total Clients';

  @override
  String get invoicesGenerated => 'Invoices Generated';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get businessOverview => 'Business Overview';

  @override
  String get businessOverviewDesc =>
      'Track your business performance at a glance';

  @override
  String get active => 'Active';

  @override
  String get pending => 'Pending';

  @override
  String get adminActive => 'Admin Active';

  @override
  String get client => 'Client';

  @override
  String get clients => 'Clients';

  @override
  String get addClient => 'Add Client';

  @override
  String get editClient => 'Edit Client';

  @override
  String get clientDetails => 'Client Details';

  @override
  String get clientName => 'Client Name';

  @override
  String get appointment => 'Appointment';

  @override
  String get appointments => 'Appointments';

  @override
  String get noAppointments => 'No appointments';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get past => 'Past';

  @override
  String get invoice => 'Invoice';

  @override
  String get createInvoice => 'Create Invoice';

  @override
  String get generateInvoice => 'Generate Invoice';

  @override
  String get invoiceDetails => 'Invoice Details';

  @override
  String get invoiceNumber => 'Invoice Number';

  @override
  String get invoiceDate => 'Invoice Date';

  @override
  String get dueDate => 'Due Date';

  @override
  String get amount => 'Amount';

  @override
  String get total => 'Total';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get tax => 'Tax';

  @override
  String get discount => 'Discount';

  @override
  String get paid => 'Paid';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get overdue => 'Overdue';

  @override
  String get employee => 'Employee';

  @override
  String get employees => 'Employees';

  @override
  String get selectEmployee => 'Select Employee';

  @override
  String get employeeTracking => 'Employee Tracking';

  @override
  String get expense => 'Expense';

  @override
  String get expenses => 'Expenses';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get expenseDetails => 'Expense Details';

  @override
  String get expenseCategory => 'Category';

  @override
  String get expenseAmount => 'Amount';

  @override
  String get expenseDate => 'Date';

  @override
  String get holiday => 'Holiday';

  @override
  String get holidays => 'Holidays';

  @override
  String get addHoliday => 'Add Holiday';

  @override
  String get holidayList => 'Holiday List';

  @override
  String get notes => 'Notes';

  @override
  String get addNotes => 'Add Notes';

  @override
  String get photo => 'Photo';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get pricing => 'Pricing';

  @override
  String get pricingManagement => 'Pricing Management';

  @override
  String get priceHistory => 'Price History';

  @override
  String get bulkOperations => 'Bulk Operations';

  @override
  String get ndisItems => 'NDIS Items';

  @override
  String get configuration => 'Configuration';

  @override
  String get validation => 'Validation';

  @override
  String get assignment => 'Assignment';

  @override
  String get assignments => 'Assignments';

  @override
  String get assignmentList => 'Assignment List';

  @override
  String get editAssignment => 'Edit Assignment';

  @override
  String get shiftAssignment => 'Shift Assignment';

  @override
  String get business => 'Business';

  @override
  String get addBusiness => 'Add Business';

  @override
  String get businessDetails => 'Business Details';

  @override
  String get businessList => 'Business List';

  @override
  String get organization => 'Organization';

  @override
  String get editOrganization => 'Edit Organization';

  @override
  String get notification => 'Notification';

  @override
  String get notifications => 'Notifications';

  @override
  String get markAllRead => 'Mark All Read';

  @override
  String get security => 'Security';

  @override
  String get apiUsage => 'API Usage';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get sort => 'Sort';

  @override
  String get clear => 'Clear';

  @override
  String get apply => 'Apply';

  @override
  String get reset => 'Reset';

  @override
  String get selectAll => 'Select All';

  @override
  String get deselectAll => 'Deselect All';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get lastMonth => 'Last Month';

  @override
  String get thisYear => 'This Year';

  @override
  String get custom => 'Custom';

  @override
  String get from => 'From';

  @override
  String get to => 'to';

  @override
  String get required => 'Required';

  @override
  String get optional => 'Optional';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get on => 'On';

  @override
  String get off => 'Off';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get storage => 'Storage';

  @override
  String get location => 'Location';

  @override
  String get permissionRequired => 'PERMISSION REQUIRED';

  @override
  String get permissionCamera => 'Camera access is required to take photos.';

  @override
  String get permissionStorage => 'Storage access is required to save files.';

  @override
  String get grantPermission => 'GRANT PERMISSION';

  @override
  String get dashboardOverview => 'Dashboard Overview';

  @override
  String get dashboardOverviewDesc => 'View pricing analytics and insights';

  @override
  String get ndisPricing => 'NDIS Pricing';

  @override
  String get ndisPricingDesc => 'Manage NDIS rates and compliance';

  @override
  String get serviceRates => 'Service Rates';

  @override
  String get serviceRatesDesc => 'Configure service pricing structures';

  @override
  String get bulkOperationsTitle => 'Bulk Operations';

  @override
  String get bulkOperationsDesc => 'Import/export and batch updates';

  @override
  String get priceHistoryTitle => 'Price History';

  @override
  String get priceHistoryDesc => 'Track pricing changes over time';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get quickActionsDesc => 'Frequently used pricing tools';

  @override
  String get pricingModules => 'Pricing Modules';

  @override
  String get chooseModule => 'Choose a module to manage your pricing';

  @override
  String get totalServices => 'Total Services';

  @override
  String get activeRates => 'Active Rates';

  @override
  String get pendingUpdates => 'Pending Updates';

  @override
  String get avgRate => 'Avg Rate';

  @override
  String get systemActive => 'System Active';

  @override
  String shortcutsAvailable(int count) {
    return '$count shortcuts available';
  }

  @override
  String ndisItemsCount(int count) {
    return '$count NDIS items';
  }

  @override
  String serviceTypesCount(int count) {
    return '$count service types';
  }

  @override
  String pendingOperations(int count) {
    return '$count pending operations';
  }

  @override
  String historicalRecords(int count) {
    return '$count historical records';
  }

  @override
  String activeMetrics(int count) {
    return '$count active metrics';
  }

  @override
  String get expenseManagement => 'EXPENSE MANAGEMENT';

  @override
  String get expenseManagementWelcome =>
      'Welcome! Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.';

  @override
  String get totalExpenses => 'Total Expenses';

  @override
  String get pendingApproval => 'Pending Approval';

  @override
  String get thisMonthExpenses => 'This Month';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get expenseList => 'Expense List';

  @override
  String get approvals => 'Approvals';

  @override
  String get recurring => 'Recurring';

  @override
  String get reports => 'Reports';

  @override
  String get noExpenseData => 'No Expense Data';

  @override
  String get addExpenseToView => 'Add expenses to view dashboard statistics';

  @override
  String get recentExpenses => 'Recent Expenses';

  @override
  String get viewAll => 'View All';

  @override
  String get invoiceDetailsTitle => 'Invoice Details';

  @override
  String get clientInformation => 'Client Information';

  @override
  String get financialSummary => 'Financial Summary';

  @override
  String get statusInformation => 'Status Information';

  @override
  String get shareInvoice => 'Share Invoice';

  @override
  String get deleteInvoice => 'Delete Invoice';

  @override
  String get viewInvoice => 'View Invoice';

  @override
  String get loadingInvoiceDetails => 'Loading invoice details...';

  @override
  String get invoiceNotFound => 'Invoice not found';

  @override
  String get errorLoadingInvoice => 'Error loading invoice';

  @override
  String unreadCount(int count) {
    return '$count unread';
  }

  @override
  String get noNotificationsYet => 'No notifications yet';

  @override
  String get allCaughtUp =>
      'You\'re all caught up! New notifications will appear here.';

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get clearAllNotifications => 'Clear All Notifications';

  @override
  String get clearAllNotificationsConfirm =>
      'Are you sure you want to clear all notifications? This action cannot be undone.';

  @override
  String get clearAll => 'Clear All';

  @override
  String get clientInformationTitle => 'Client Information';

  @override
  String get personalDetailsAndContact =>
      'Personal details and contact information';

  @override
  String get scheduleDetails => 'Schedule Details';

  @override
  String get appointmentSchedules => 'Appointment schedules';

  @override
  String get loadingAppointmentDetails => 'Loading appointment details...';

  @override
  String get noClientDataFound => 'No client data found';

  @override
  String get noClientDetailsFound => 'No client details found';

  @override
  String get timerAlreadyRunning => 'Timer Already Running';

  @override
  String get stopCurrentTimer =>
      'Please stop the current timer before starting a new one.';

  @override
  String get timeUpdatedSuccessfully => 'Time updated successfully';

  @override
  String get automaticInvoiceGeneration => 'Automatic Invoice Generation';

  @override
  String get oneClickInvoiceGeneration => 'One-Click Invoice Generation';

  @override
  String get invoiceConfiguration => 'Invoice Configuration';

  @override
  String get includeExpenses => 'Include Expenses';

  @override
  String get addExpenseItemsToInvoices => 'Add expense items to invoices';

  @override
  String get applyTax => 'Apply Tax';

  @override
  String get includeTaxCalculations => 'Include tax calculations';

  @override
  String get validatePrices => 'Validate Prices';

  @override
  String get checkPricesAgainstNDIS => 'Check prices against NDIS price caps';

  @override
  String get allowPriceCapOverride => 'Allow Price Cap Override';

  @override
  String get allowPricesAboveNDIS => 'Allow prices above NDIS caps';

  @override
  String get detailedPricingInfo => 'Detailed Pricing Info';

  @override
  String get includeComprehensivePricing =>
      'Include comprehensive pricing details';

  @override
  String get invoicePeriod => 'Invoice Period';

  @override
  String get selectPeriod => 'Select Period';

  @override
  String get noPeriodSelected => 'No period selected (using default)';

  @override
  String get allEmployees => 'All Employees';

  @override
  String get selectEmployees => 'Select Employees';

  @override
  String get noEmployeesSelected => 'No employees selected';

  @override
  String get chooseEmployees => 'Choose Employees';

  @override
  String get bankDetails => 'Bank Details';

  @override
  String get taxRate => 'Tax Rate';

  @override
  String get generatingInvoices => 'Generating Invoices...';

  @override
  String get complete => 'Complete';

  @override
  String get viewGeneratedPdfs => 'View Generated PDFs';

  @override
  String get pricingConfiguration => 'Pricing Configuration';

  @override
  String get generalSettings => 'General Settings';

  @override
  String get pricingRulesTab => 'Pricing Rules';

  @override
  String get integrationsTab => 'Integrations';

  @override
  String get advancedTab => 'Advanced';

  @override
  String get generalPricingSettings => 'General Pricing Settings';

  @override
  String get basicConfiguration => 'Basic Configuration';

  @override
  String get defaultCurrency => 'Default Currency';

  @override
  String get pricingModel => 'Pricing Model';

  @override
  String get roundingMethod => 'Rounding Method';

  @override
  String get taxCalculation => 'Tax Calculation';

  @override
  String get pricingParameters => 'Pricing Parameters';

  @override
  String get defaultMarkup => 'Default Markup (%)';

  @override
  String get maxPriceVariation => 'Max Price Variation (%)';

  @override
  String get fallbackBaseRate => 'Fallback Base Rate';

  @override
  String get systemBehavior => 'System Behavior';

  @override
  String get addRule => 'Add Rule';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get resetConfiguration => 'Reset Configuration';

  @override
  String get clearPriceHistory => 'Clear Price History';

  @override
  String get monitorPricingPerformance =>
      'Monitor pricing performance and analyze trends across your services';

  @override
  String get liveData => 'Live Data';

  @override
  String get avgRateLabel => 'Avg Rate';

  @override
  String get utilization => 'Utilization';

  @override
  String get profitMargin => 'Profit Margin';

  @override
  String get analyticsOverview => 'Analytics Overview';

  @override
  String get revenueTrend => 'Revenue Trend';

  @override
  String get serviceDistribution => 'Service Distribution';

  @override
  String get revenueAnalysis => 'Revenue Analysis';

  @override
  String get revenueByPeriod => 'Revenue by Period';

  @override
  String get revenueByServiceCategory => 'Revenue by Service Category';

  @override
  String get topPerformingServices => 'Top Performing Services';

  @override
  String get pricingTrendsByCategory => 'Pricing Trends by Category';

  @override
  String get averageRateLabel => 'Average Rate';

  @override
  String get change => 'Change';

  @override
  String get volume => 'Volume';

  @override
  String get pricingValidation => 'Pricing Validation';

  @override
  String get validationResults => 'Validation Results';

  @override
  String get validationRules => 'Validation Rules';

  @override
  String get resolve => 'Resolve';

  @override
  String get runNow => 'Run Now';

  @override
  String get configure => 'Configure';

  @override
  String get ndisItemManagement => 'NDIS Item Management';

  @override
  String get noNdisItemsFound => 'No NDIS items found.';

  @override
  String get searchByItemNameOrCode => 'Search by item name or code...';

  @override
  String get inactive => 'Inactive';

  @override
  String get filtered => 'Filtered';

  @override
  String get addItem => 'Add Item';

  @override
  String get editNdisItem => 'Edit NDIS Item';

  @override
  String get addNewNdisItem => 'Add New NDIS Item';

  @override
  String get itemCode => 'Item Code';

  @override
  String get itemName => 'Item Name';

  @override
  String get description => 'Description';

  @override
  String get category => 'Category';

  @override
  String get unit => 'Unit';

  @override
  String get unitPrice => 'Unit Price';

  @override
  String get generalInformation => 'General Information';

  @override
  String get contactDetails => 'Contact Details';

  @override
  String get banking => 'Banking';

  @override
  String get ndisRegistration => 'NDIS Registration';

  @override
  String get legalName => 'Legal Name';

  @override
  String get tradingAs => 'Trading As';

  @override
  String get taxIdAbn => 'Tax ID (ABN)';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get headquarters => 'Headquarters';

  @override
  String get viewMap => 'View Map';

  @override
  String get joinOrganization => 'Join Organization';

  @override
  String get organizationCode => 'Organization Code';

  @override
  String get verified => 'Verified';

  @override
  String get unverified => 'Unverified';

  @override
  String get clientPricingReview => 'Client Pricing Review';

  @override
  String get selectClientToViewPricing => 'Select a client to view pricing';

  @override
  String get noClientsWithAssignmentsFound =>
      'No clients with assignments found';

  @override
  String get noSupportItemsFound => 'No support items found';

  @override
  String get editPrices => 'Edit Prices';

  @override
  String get exceedsCap => 'Exceeds Cap';

  @override
  String get priceOverride => 'Price Override';

  @override
  String get noNdisItemsForOverride => 'No NDIS items found';

  @override
  String get noClientAssignmentsForOverride =>
      'No client assignments with NDIS items available for price override.';

  @override
  String get applyOverrides => 'Apply Overrides';

  @override
  String get clientSpecificPricing => 'Client-Specific Pricing';

  @override
  String get organizationWidePricing => 'Organization-Wide Pricing';

  @override
  String get currentPrice => 'Current Price';

  @override
  String get maxPrice => 'Max Price';

  @override
  String get priceExceedsCap => 'Price exceeds NDIS cap';

  @override
  String get newBusiness => 'New Business';

  @override
  String get businessInformation => 'Business Information';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get addressInformation => 'Address Information';

  @override
  String get addingBusiness => 'Adding business...';

  @override
  String get businessDetailsAddedSuccessfully =>
      'Business details added successfully';

  @override
  String get areYouSureAddBusiness =>
      'Are you sure you want to add this business?';

  @override
  String get businessName => 'Business Name';

  @override
  String get businessEmail => 'Business Email';

  @override
  String get businessPhone => 'Business Phone';

  @override
  String get businessAddress => 'Business Address';

  @override
  String get city => 'City';

  @override
  String get state => 'State';

  @override
  String get zipCode => 'Zip Code';

  @override
  String get addNewExpense => 'Add New Expense';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get expenseTitle => 'Title';

  @override
  String get recurringExpense => 'Recurring Expense';

  @override
  String get enableForRegularlyOccurring =>
      'Enable for regularly occurring expenses';

  @override
  String get frequency => 'Frequency';

  @override
  String get submitExpense => 'Submit Expense';

  @override
  String get updateExpense => 'Update Expense';

  @override
  String get expenseSubmittedSuccessfully => 'Expense submitted successfully';

  @override
  String get expenseUpdatedSuccessfully => 'Expense updated successfully';

  @override
  String get uploadingFiles => 'Uploading file(s)...';

  @override
  String get submitting => 'Submitting...';

  @override
  String get profilePhoto => 'Profile Photo';

  @override
  String get showYourBestSide => 'Show Your Best Side';

  @override
  String get photoTipsSubtitle =>
      'A great photo builds trust and makes your profile stand out.';

  @override
  String get tapToSelect => 'Tap to Select';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get uploadAndSave => 'Upload & Save';

  @override
  String get photoUploadedSuccessfully => 'Photo uploaded successfully';

  @override
  String get addNewHoliday => 'Add New Holiday';

  @override
  String get holidayDetails => 'Holiday Details';

  @override
  String get holidayName => 'Holiday Name';

  @override
  String get dayOfWeek => 'Day of Week';

  @override
  String get creatingHoliday => 'Creating Holiday...';

  @override
  String get holidayCreated => 'Holiday Created!';

  @override
  String get holidayAddedSuccessfully =>
      'Your holiday has been added successfully';

  @override
  String get serviceRateManagement => 'Service Rate Management';

  @override
  String get baseRate => 'Base Rate';

  @override
  String get weekendRate => 'Weekend Rate';

  @override
  String get publicHolidayRate => 'Public Holiday Rate';

  @override
  String get effectiveDate => 'Effective Date';

  @override
  String get region => 'Region';

  @override
  String get liveTracking => 'Live Tracking';

  @override
  String get updates => 'Updates';

  @override
  String get increases => 'Increases';

  @override
  String get decreases => 'Decreases';

  @override
  String get searchHistory => 'Search History...';

  @override
  String get was => 'Was';

  @override
  String get now => 'Now';

  @override
  String get selectEmployeesAndClients => 'Select Employees & Clients';

  @override
  String get loadingEmployeesAndClients => 'Loading employees and clients...';

  @override
  String get shiftDetails => 'Shift Details';

  @override
  String get errorLoadingEmployees => 'Error Loading Employees';

  @override
  String get noEmployeesFound => 'No Employees Found';

  @override
  String get noEmployeesAvailable =>
      'There are no employees available to select for invoice generation.';

  @override
  String get loadingClients => 'Loading clients...';

  @override
  String get noClientsAssigned => 'No clients assigned to this employee';

  @override
  String get employeesSelected => 'employees selected';

  @override
  String get readyToGenerateInvoice => 'Ready to generate invoice';

  @override
  String get continueButton => 'Continue';

  @override
  String get settings => 'Settings';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get appSettings => 'App Settings';

  @override
  String get errorLoadingAssignments => 'Error Loading Assignments';

  @override
  String get noAssignmentsFound => 'No Assignments Found';

  @override
  String get noAssignmentsMessage =>
      'Assignments for this organization will appear here.';

  @override
  String get totalWorkHoursToday => 'Total work hours today';

  @override
  String get nothingScheduledToday => 'Nothing scheduled today';

  @override
  String get myRequests => 'My Requests';

  @override
  String get timesheet => 'Timesheet';

  @override
  String get locationUnavailable => 'Location unavailable';

  @override
  String get addShiftRequest => 'Add a shift request';

  @override
  String get addTimeOffRequest => 'Add a time off request';

  @override
  String get noRequestsToDisplay => 'No requests to display';

  @override
  String get addNewRequest => 'Add a new request';

  @override
  String get declined => 'Declined';

  @override
  String get approved => 'Approved';

  @override
  String get requestSent => 'Request sent';

  @override
  String get requestSentMessage => 'Your request has been sent for approval';

  @override
  String get imDone => 'I\'m done';

  @override
  String get pleaseSelectJob => 'Please select a job';

  @override
  String get endTimeError => 'End time cannot be before start time';

  @override
  String get failedToCreateRequest => 'Failed to create request';

  @override
  String get addShiftTitle => 'Add shift';

  @override
  String get jobLabel => 'Job';

  @override
  String get selectJob => 'Select Job';

  @override
  String get startsLabel => 'Starts';

  @override
  String get endsLabel => 'Ends';

  @override
  String get totalHours => 'Total hours';

  @override
  String get invalidDuration => 'Invalid duration';

  @override
  String get addNote => 'Add a note';

  @override
  String get noteHint => 'Type your note here...';

  @override
  String get managerApprovalMessage =>
      'All requests will be sent for a manager\'s approval';

  @override
  String get sendForApproval => 'Send for approval';

  @override
  String get timeOffTitle => 'Time off';

  @override
  String get typeLabel => 'Type';

  @override
  String get selectLeaveType => 'Select Leave Type';

  @override
  String get fromLabel => 'From';

  @override
  String get toLabel => 'To';

  @override
  String get fromLabelCaps => 'FROM:';

  @override
  String get toLabelCaps => 'TO:';

  @override
  String get pleaseSelectLeaveType => 'Please select a leave type';

  @override
  String get endDateError => 'End date cannot be before start date';

  @override
  String get requestsDashboardTitle => 'REQUESTS DASHBOARD';

  @override
  String get pendingTab => 'PENDING';

  @override
  String get approvedTab => 'APPROVED';

  @override
  String get declinedTab => 'DECLINED';

  @override
  String get noRequestsFoundCaps => 'NO REQUESTS FOUND';

  @override
  String get userLabelCaps => 'USER:';

  @override
  String get declineButton => 'DECLINE';

  @override
  String get approveButton => 'APPROVE';

  @override
  String get declineRequestTitle => 'DECLINE REQUEST';

  @override
  String get reasonOptionalLabel => 'REASON (OPTIONAL)';

  @override
  String get enterReasonHint => 'Enter reason for declining';

  @override
  String get cancelButtonCaps => 'CANCEL';

  @override
  String get typeLabelCaps => 'TYPE:';

  @override
  String get jobLabelCaps => 'JOB:';

  @override
  String get dateLabelCaps => 'DATE:';

  @override
  String get timeLabelCaps => 'TIME:';

  @override
  String get regularLabel => 'Regular';

  @override
  String get otLabel => 'OT';

  @override
  String get totalLabel => 'Total';

  @override
  String get absenceLabel => 'Absence';

  @override
  String get weekTotalLabel => 'Week total';

  @override
  String get requestsLabel => 'Requests';

  @override
  String get moreButton => 'More';

  @override
  String get enhancedInvoiceTitle => 'ENHANCED INVOICE GENERATION';

  @override
  String get enhancedInvoiceSubtitle =>
      'Generate professional invoices with enhanced pricing validation';

  @override
  String get noEmployeesSelectedCaps => 'NO EMPLOYEES SELECTED';

  @override
  String selectedEmployeesInfo(Object clientCount, Object clientLabel,
      Object employeeCount, Object employeeLabel) {
    return 'SELECTED: $employeeCount $employeeLabel WITH $clientCount $clientLabel';
  }

  @override
  String get employeeLabel => 'EMPLOYEE';

  @override
  String get employeesLabel => 'EMPLOYEES';

  @override
  String get clientLabel => 'CLIENT';

  @override
  String get clientsLabel => 'CLIENTS';

  @override
  String get invoiceConfigurationTitle => 'Invoice Configuration';

  @override
  String get invoiceTypeTitle => 'Invoice Type';

  @override
  String get invoiceTypeSubtitle => 'Choose who will be billed on the invoice';

  @override
  String get clientOptionTitle => 'Client';

  @override
  String get clientOptionSubtitle => 'Bill the client';

  @override
  String get employeeOptionTitle => 'Employee';

  @override
  String get employeeOptionSubtitle => 'Bill the employee';

  @override
  String get adminOptionTitle => 'Admin';

  @override
  String get adminOptionSubtitle => 'Bank Details';

  @override
  String get invoiceTypeWarning => 'Select an invoice type before generating';

  @override
  String get includeTaxTitle => 'Include Tax (GST)';

  @override
  String get includeTaxSubtitle => 'Add tax calculations to the invoice';

  @override
  String get taxRateLabel => 'Tax Rate';

  @override
  String get bankDetailsSubtitle =>
      'Select which bank details to use on the invoice';

  @override
  String get includeExpensesTitle => 'Include Expenses';

  @override
  String get includeExpensesSubtitle => 'Add expense items to the invoice';

  @override
  String get allowPriceOverrideTitle => 'Allow Price Cap Override';

  @override
  String get allowPriceOverrideSubtitle =>
      'Enable price adjustments beyond standard caps';

  @override
  String get attachmentsTitle => 'Attachments';

  @override
  String get additionalFilesTitle => 'ADDITIONAL FILES';

  @override
  String get additionalFilesSubtitle =>
      'Attach documents, receipts, or other files';

  @override
  String get addFilesTitle => 'ADD FILES';

  @override
  String get addFilesSubtitle => 'Tap to select files or drag and drop';

  @override
  String get attachedFilesLabel => 'Attached Files';

  @override
  String get priceOverrideTitle => 'PRICE OVERRIDE';

  @override
  String get priceOverrideSubtitle =>
      'Review and adjust pricing for NDIS items before generating invoices.';

  @override
  String get refreshingPricingMessage => 'Refreshing pricing…';

  @override
  String get noNdisItemsFoundInAssignments =>
      'No NDIS items found in selected assignments.';

  @override
  String get allRatesConfiguredMessage =>
      'All selected NDIS items have configured base service rates.';

  @override
  String missingBaseRatesMessage(Object count, Object items) {
    return 'Base service rates are missing or using fallback for $count NDIS item(s): $items. Please add custom pricing or set price overrides.';
  }

  @override
  String get selectNdisItemTitle => 'SELECT NDIS ITEM';

  @override
  String get selectNdisItemTitleNormal => 'Select NDIS Item';

  @override
  String get searchNdisPlaceholderCaps =>
      'SEARCH BY ITEM NUMBER OR DESCRIPTION';

  @override
  String get searchNdisPlaceholderNormal =>
      'Search by Item Number or Description';

  @override
  String get pricingInfoTitle => 'PRICING INFO';

  @override
  String pricingInfoMessage(Object intensity, Object state) {
    return 'Pricing shown for $intensity rates in $state. Tap the price icon to set custom pricing.';
  }

  @override
  String get highIntensityCaps => 'HIGH INTENSITY';

  @override
  String get standardCaps => 'STANDARD';

  @override
  String get noNdisItemsLoadedCaps => 'NO NDIS ITEMS LOADED';

  @override
  String get noNdisItemsLoadedNormal => 'No NDIS items loaded.';

  @override
  String get noMatchingItemsFoundCaps => 'NO MATCHING ITEMS FOUND';

  @override
  String get noMatchingItemsFoundNormal => 'No matching NDIS items found.';

  @override
  String get failedToLoadNdisItems =>
      'Failed to load NDIS items. Please try again.';
}
