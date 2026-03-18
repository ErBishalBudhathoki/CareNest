// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get abnHint => 'ABN (11 digits)';

  @override
  String get abnInvalid => 'Please enter a valid 11-digit ABN';

  @override
  String get absenceLabel => 'Absence';

  @override
  String get accountSection => 'Account';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get accountTypeSection => 'Account Type';

  @override
  String get active => 'Active';

  @override
  String get activeBusinesses => 'Active Businesses';

  @override
  String activeMetrics(int count) {
    return '$count active metrics';
  }

  @override
  String get activeRates => 'Active Rates';

  @override
  String get addBankDetails => 'Add Your Bank Details';

  @override
  String get addBusiness => 'Add Business';

  @override
  String get addBusinessButton => 'Add Business';

  @override
  String get addButton => 'Add';

  @override
  String get addClient => 'Add Client';

  @override
  String get addClientButton => 'Add Client';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get addExpenseItemsToInvoices => 'Add expense items to invoices';

  @override
  String get addExpenseToView => 'Add expenses to view dashboard statistics';

  @override
  String get addFilesSubtitle => 'Tap to select files or drag and drop';

  @override
  String get addFilesTitle => 'ADD FILES';

  @override
  String get addHoliday => 'Add Holiday';

  @override
  String get addingBusiness => 'Adding business...';

  @override
  String get addItem => 'Add Item';

  @override
  String get additionalFilesSubtitle =>
      'Attach documents, receipts, or other files';

  @override
  String get additionalFilesTitle => 'Additional Files';

  @override
  String get addNewExpense => 'Add New Expense';

  @override
  String get addNewHoliday => 'Add New Holiday';

  @override
  String get addNewNdisItem => 'Add New NDIS Item';

  @override
  String get addNewRequest => 'Add a new request';

  @override
  String get addNote => 'Add a note';

  @override
  String get addNotes => 'Add Notes';

  @override
  String get addressInformation => 'Address Information';

  @override
  String get addRule => 'Add Rule';

  @override
  String get addShiftRequest => 'Add a shift request';

  @override
  String get addShiftTitle => 'Add shift';

  @override
  String get addTimeOffRequest => 'Add a time off request';

  @override
  String get adminAccessRequiredMessage =>
      'Only admins can access this feature.';

  @override
  String get adminAccessRequiredTitle => 'Admin Access Required';

  @override
  String get adminActive => 'Admin Active';

  @override
  String get adminBankDetails => 'Admin Bank Details';

  @override
  String get adminBankDetailsDesc =>
      'Use admin bank details (invoices created by admin only)';

  @override
  String get adminDashboard => 'Admin Dashboard';

  @override
  String get adminDashboardSubtitle => 'Manage organization and app';

  @override
  String get administrator => 'Administrator';

  @override
  String get administratorDesc => 'Full access and organization management';

  @override
  String get adminOptionSubtitle => 'Bank Details';

  @override
  String get adminOptionTitle => 'Admin';

  @override
  String get adminTitle => 'Admin';

  @override
  String get advancedTab => 'Advanced';

  @override
  String get allCaughtUp =>
      'You\'re all caught up! New notifications will appear here.';

  @override
  String get allEmployees => 'All Employees';

  @override
  String get allInvoices => 'All Invoices';

  @override
  String get allowPriceCapOverride => 'Allow Price Cap Override';

  @override
  String get allowPriceOverrideSubtitle =>
      'Enable price adjustments beyond standard caps';

  @override
  String get allowPriceOverrideTitle => 'Allow Price Cap Override';

  @override
  String get allowPricesAboveNDIS => 'Allow prices above NDIS caps';

  @override
  String get allRatesConfiguredMessage =>
      'All selected NDIS items have configured base service rates.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get amount => 'Amount';

  @override
  String get analyticsOverview => 'Analytics Overview';

  @override
  String get apiUsage => 'API Usage';

  @override
  String get apiUsageDashboard => 'API Usage Dashboard';

  @override
  String get apiUsageDashboardDesc =>
      'Monitor API traffic and errors in real-time';

  @override
  String get apply => 'Apply';

  @override
  String get applyOverrides => 'Apply Overrides';

  @override
  String get applyTax => 'Apply Tax';

  @override
  String get appName => 'CareNest';

  @override
  String get appointment => 'Appointment';

  @override
  String get appointments => 'Appointments';

  @override
  String get appointmentSchedules => 'Appointment schedules';

  @override
  String get approvals => 'Approvals';

  @override
  String get approveButton => 'APPROVE';

  @override
  String get approved => 'Approved';

  @override
  String get approvedTab => 'APPROVED';

  @override
  String get appSettings => 'App Settings';

  @override
  String get appSettingsSection => 'App Settings';

  @override
  String get areYouSureAddBusiness =>
      'Are you sure you want to add this business?';

  @override
  String get assignment => 'Assignment';

  @override
  String get assignmentList => 'Assignment List';

  @override
  String get assignments => 'Assignments';

  @override
  String get attachedFilesLabel => 'Attached Files';

  @override
  String get attachmentsTitle => 'Attachments';

  @override
  String get auditCertifications => 'Audit Certifications';

  @override
  String get auditCertificationsDesc =>
      'Review and approve employee certifications';

  @override
  String get automaticInvoiceGeneration => 'Automatic Invoice Generation';

  @override
  String get averageRateLabel => 'Average Rate';

  @override
  String get avgRate => 'Avg Rate';

  @override
  String get avgRateLabel => 'Avg Rate';

  @override
  String get backButton => 'Back';

  @override
  String get bankDetails => 'Bank Details';

  @override
  String get bankDetailsDesc => 'Manage bank account details';

  @override
  String get bankDetailsNote =>
      'Note: Invoice creation is restricted to admin users.';

  @override
  String get bankDetailsNotSet =>
      'Employee bank details are not set yet. Please add your bank details first.';

  @override
  String get bankDetailsSubtitle =>
      'Select which bank details to use on the invoice';

  @override
  String get bankDetailsTitle => 'Bank Details';

  @override
  String get banking => 'Banking';

  @override
  String get bankingPayouts => 'BANKING & PAYOUTS';

  @override
  String get baseRate => 'Base Rate';

  @override
  String get basicConfiguration => 'Basic Configuration';

  @override
  String get bulkOperations => 'Bulk Operations';

  @override
  String get bulkOperationsDesc =>
      'Manage and optimize your service pricing across different regions and categories';

  @override
  String get bulkOperationsTitle => 'Bulk Operations';

  @override
  String get business => 'Business';

  @override
  String get businessAddress => 'Business Address';

  @override
  String get businessDetails => 'Business Details';

  @override
  String get businessDetailsAddedSuccessfully =>
      'Business details added successfully';

  @override
  String get businessEmail => 'Business Email';

  @override
  String get businessInformation => 'Business Information';

  @override
  String get businessList => 'Business List';

  @override
  String get businessName => 'Business Name';

  @override
  String get businessOverview => 'Business Overview';

  @override
  String get businessOverviewDesc =>
      'Track your business performance at a glance';

  @override
  String get businessPhone => 'Business Phone';

  @override
  String get camera => 'Camera';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get cancelButtonCaps => 'CANCEL';

  @override
  String get category => 'Category';

  @override
  String get change => 'Change';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordSubtitle => 'Update your account password';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get checkPricesAgainstNDIS => 'Check prices against NDIS price caps';

  @override
  String get chooseEmployees => 'Choose Employees';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get chooseModule => 'Choose a module to manage your pricing';

  @override
  String get city => 'City';

  @override
  String get clear => 'Clear';

  @override
  String get clearAll => 'Clear All';

  @override
  String get clearAllNotifications => 'Clear All Notifications';

  @override
  String get clearAllNotificationsConfirm =>
      'Are you sure you want to clear all notifications? This action cannot be undone.';

  @override
  String get clearPriceHistory => 'Clear Price History';

  @override
  String get client => 'Client';

  @override
  String get clientDetails => 'Client Details';

  @override
  String get clientInformation => 'Client Information';

  @override
  String get clientInformationTitle => 'Client Information';

  @override
  String get clientLabel => 'CLIENT';

  @override
  String get clientName => 'Client Name';

  @override
  String get clientOptionSubtitle => 'Bill the client';

  @override
  String get clientOptionTitle => 'Client';

  @override
  String get clientPricingReview => 'Client Pricing Review';

  @override
  String get clientPricingReviewDesc =>
      'Review and manage client pricing before invoicing';

  @override
  String get clients => 'Clients';

  @override
  String get clientsLabel => 'CLIENTS';

  @override
  String get clientSpecificPricing => 'Client-Specific Pricing';

  @override
  String get clockIn => 'Clock in';

  @override
  String get clockOut => 'Clock out';

  @override
  String get closeButton => 'Close';

  @override
  String get complete => 'Complete';

  @override
  String get complianceChecklists => 'Compliance Checklists';

  @override
  String get complianceChecklistsDesc => 'Manage compliance checklists';

  @override
  String get configFinance => 'Configuration & Finance';

  @override
  String get configuration => 'Configuration';

  @override
  String get configure => 'Configure';

  @override
  String get configureEmailSettingsFirst =>
      'Please configure Email Settings first.';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get contactDetails => 'Contact Details';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get continueButton => 'Continue';

  @override
  String get copyright => '© 2024 CareNest. All rights reserved.';

  @override
  String get createAccount => 'Create account';

  @override
  String get createFirstInvoice => 'Create your first invoice to get started';

  @override
  String get createInvoice => 'Create Invoice';

  @override
  String get createNewOrg => 'Create New Organization';

  @override
  String get createNewOrgDesc => 'Set up your own organization';

  @override
  String get creatingHoliday => 'Creating Holiday...';

  @override
  String get currentPrice => 'Current Price';

  @override
  String get custom => 'Custom';

  @override
  String get dangerZoneSection => 'Danger Zone';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get dashboardOverview => 'Dashboard Overview';

  @override
  String get dashboardOverviewDesc => 'View pricing analytics and insights';

  @override
  String get dateFormatSubtitle => 'Control parsing of ambiguous dates';

  @override
  String get dateFormatTitle => 'Date Format';

  @override
  String get dateLabelCaps => 'DATE:';

  @override
  String get dayOfWeek => 'Day of Week';

  @override
  String get declineButton => 'DECLINE';

  @override
  String get declined => 'Declined';

  @override
  String get declinedTab => 'DECLINED';

  @override
  String get declineRequestTitle => 'DECLINE REQUEST';

  @override
  String get decreases => 'Decreases';

  @override
  String get defaultCurrency => 'Default Currency';

  @override
  String get defaultMarkup => 'Default Markup';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmMessage =>
      'This action is permanent and cannot be undone. Are you sure?';

  @override
  String get deleteAccountConfirmTitle => 'Delete Account';

  @override
  String get deleteAccountSubtitle => 'Permanently delete your account';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deleteInvoice => 'Delete Invoice';

  @override
  String deleteInvoiceConfirm(String invoiceNumber) {
    return 'Are you sure you want to delete invoice $invoiceNumber? This action cannot be undone.';
  }

  @override
  String get description => 'Description';

  @override
  String get deselectAll => 'Deselect All';

  @override
  String get detailedPricingInfo => 'Detailed Pricing Info';

  @override
  String get didntReceiveCode => 'Didn\'t receive code?';

  @override
  String get disabled => 'Disabled';

  @override
  String get discount => 'Discount';

  @override
  String get doneButton => 'Done';

  @override
  String get dueDate => 'Due Date';

  @override
  String get earnings => 'Earnings';

  @override
  String get earningsDashboard => 'Earnings Dashboard';

  @override
  String get earningsDashboardDesc =>
      'View earnings, projections, and tax estimates';

  @override
  String get earningsDesc =>
      'View your pay summary, projections, and tax estimates.';

  @override
  String get editAssignment => 'Edit Assignment';

  @override
  String get editButton => 'Edit';

  @override
  String get editClient => 'Edit Client';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get editNdisItem => 'Edit NDIS Item';

  @override
  String get editOrganization => 'Edit Organization';

  @override
  String get editPrices => 'Edit Prices';

  @override
  String get effectiveDate => 'Effective Date';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailSettings => 'Email Settings';

  @override
  String get emailSettingsDesc => 'Configure invoice email settings';

  @override
  String get employee => 'Employee';

  @override
  String get employeeBankDetails => 'Employee Bank Details';

  @override
  String get employeeBankDetailsDesc =>
      'Use the employee\'s saved bank details';

  @override
  String get employeeInvoice => 'Employee Invoice';

  @override
  String get employeeLabel => 'EMPLOYEE';

  @override
  String get employeeOptionSubtitle => 'Bill the employee';

  @override
  String get employeeOptionTitle => 'Employee';

  @override
  String get employeePayRates => 'Employee Pay Rates';

  @override
  String get employeePayRatesDesc => 'Manage employee salaries & hourly rates';

  @override
  String get employees => 'Employees';

  @override
  String get employeesLabel => 'EMPLOYEES';

  @override
  String get employeesSelected => 'employees selected';

  @override
  String get employeeTracking => 'Employee Tracking';

  @override
  String get employeeTrackingDesc => 'Track employee work status & shifts';

  @override
  String get enabled => 'Enabled';

  @override
  String get enableForRegularlyOccurring =>
      'Enable for regularly occurring expenses';

  @override
  String get endDateError => 'End date cannot be before start date';

  @override
  String get endsLabel => 'Ends';

  @override
  String get endTimeError => 'End time cannot be before start time';

  @override
  String get enhancedInvoiceSubtitle =>
      'Generate invoices with pricing integration';

  @override
  String get enhancedInvoiceTitle => 'Enhanced Invoice Generation';

  @override
  String get enterEmailHint => 'Enter your email address';

  @override
  String get enterReasonHint => 'Enter reason for declining';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get errorGenericMessage =>
      'An unexpected error occurred. Please try again.';

  @override
  String get errorGenericTitle => 'SOMETHING WENT WRONG';

  @override
  String get errorLoadingAssignments => 'Error Loading Assignments';

  @override
  String get errorLoadingEmployees => 'Error Loading Employees';

  @override
  String get errorLoadingInvoice => 'Error loading invoice';

  @override
  String get errorLoadingInvoices => 'Error loading invoices';

  @override
  String get errorNetworkMessage =>
      'Unable to connect to the server. Please check your internet connection and try again.';

  @override
  String get errorNetworkTitle => 'CONNECTION ERROR';

  @override
  String get exceedsCap => 'Exceeds Cap';

  @override
  String get expense => 'Expense';

  @override
  String get expenseAmount => 'Amount';

  @override
  String get expenseCategory => 'Category';

  @override
  String get expenseDate => 'Date';

  @override
  String get expenseDetails => 'Expense Details';

  @override
  String get expenseList => 'Expense List';

  @override
  String get expenseManagement => 'EXPENSE MANAGEMENT';

  @override
  String get expenseManagementDesc => 'Track and manage organization expenses';

  @override
  String get expenseManagementWelcome =>
      'Welcome! Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.';

  @override
  String get expenses => 'Expenses';

  @override
  String get expenseSubmittedSuccessfully => 'Expense submitted successfully';

  @override
  String get expenseTitle => 'Title';

  @override
  String get expenseUpdatedSuccessfully => 'Expense updated successfully';

  @override
  String get failedToCreateRequest => 'Failed to create request';

  @override
  String get failedToLoadNdisItems => 'Failed to load NDIS items';

  @override
  String get failedToLoadStats => 'Failed to load business statistics';

  @override
  String get feedbackTitle => 'Submit Feedback';

  @override
  String get feedbackSubtitle => 'Describe the issue or share your suggestions';

  @override
  String get feedbackTitleLabel => 'Issue Title';

  @override
  String get feedbackTitleHint => 'Brief summary of the issue';

  @override
  String get feedbackTitleRequired => 'Please enter a title';

  @override
  String get feedbackDescriptionLabel => 'Description';

  @override
  String get feedbackDescriptionHint =>
      'What happened? What did you expect to happen?';

  @override
  String get feedbackDescriptionRequired => 'Please describe the issue';

  @override
  String get feedbackInfoNote =>
      'Device info will be included to help us debug.';

  @override
  String get feedbackSubmit => 'Submit Feedback';

  @override
  String get feedbackSuccess => 'Thank you for your feedback!';

  @override
  String get feedbackSuccessMessage =>
      'Your feedback helps us improve CareNest.';

  @override
  String get feedbackError => 'Failed to submit feedback. Please try again.';

  @override
  String get failedToSendCode =>
      'Failed to send verification code. Please try again.';

  @override
  String get fallbackBaseRate => 'Fallback Base Rate';

  @override
  String get filter => 'Filter';

  @override
  String get filtered => 'Filtered';

  @override
  String get financialSummary => 'Financial Summary';

  @override
  String get firstNameHint => 'First Name';

  @override
  String get firstNameRequired => 'Please enter first name';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordHeader => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle =>
      'Don\'t worry! Enter your email address and we\'ll send you a verification code to reset your password.';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get frequency => 'Frequency';

  @override
  String get from => 'From';

  @override
  String get fromLabel => 'From';

  @override
  String get fromLabelCaps => 'FROM:';

  @override
  String get gallery => 'Gallery';

  @override
  String get generalInformation => 'General Information';

  @override
  String get generalPricingSettings => 'General Pricing Settings';

  @override
  String get generalSettings => 'General Settings';

  @override
  String get generateInvoice => 'Generate Invoice';

  @override
  String get generatingInvoices => 'Generating...';

  @override
  String get getStarted => 'Get Started';

  @override
  String get getStartedDesc => 'Set up your business and client information';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get grantPermission => 'GRANT PERMISSION';

  @override
  String get headquarters => 'Headquarters';

  @override
  String get highIntensityCaps => 'HIGH INTENSITY';

  @override
  String historicalRecords(int count) {
    return '$count historical records';
  }

  @override
  String get holiday => 'Holiday';

  @override
  String get holidayAddedSuccessfully =>
      'Your holiday has been added successfully';

  @override
  String get holidayCreated => 'Holiday Created!';

  @override
  String get holidayDetails => 'Holiday Details';

  @override
  String get holidayList => 'Holiday List';

  @override
  String get holidayListDesc => 'Manage company holidays';

  @override
  String get holidayName => 'Holiday Name';

  @override
  String get holidays => 'Holidays';

  @override
  String get homeTitle => 'Home';

  @override
  String get imDone => 'I\'m done';

  @override
  String get inactive => 'Inactive';

  @override
  String get includeComprehensivePricing =>
      'Include comprehensive pricing details';

  @override
  String get includeExpenses => 'Include Expenses';

  @override
  String get includeExpensesSubtitle => 'Add expense items to the invoice';

  @override
  String get includeExpensesTitle => 'Include Expenses';

  @override
  String get includeTaxCalculations => 'Include tax calculations';

  @override
  String get includeTaxSubtitle => 'Add tax calculations to the invoice';

  @override
  String get includeTaxTitle => 'Include Tax (GST)';

  @override
  String get increases => 'Increases';

  @override
  String get integrationsTab => 'Integrations';

  @override
  String get invalidDuration => 'Invalid duration';

  @override
  String get invoice => 'Invoice';

  @override
  String get invoiceConfiguration => 'Invoice Configuration';

  @override
  String get invoiceConfigurationTitle => 'Invoice Configuration';

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
  String get invoiceDate => 'Invoice Date';

  @override
  String get invoicesTitle => 'Invoices';

  @override
  String get dueLabel => 'Due: ';

  @override
  String get invoiceDetails => 'Invoice Details';

  @override
  String get generateInvoiceTitle => 'Generate Invoice';

  @override
  String get noEmployeesSelected => 'No employees selected';

  @override
  String get invoiceTypeTitle => 'Invoice Type';

  @override
  String get invoiceTypeSubtitle => 'Choose who will be billed on the invoice';

  @override
  String get invoiceTypeClient => 'Client Invoice (bill the client)';

  @override
  String get invoiceTypeEmployee => 'Employee Invoice (bill the employee)';

  @override
  String get invoiceTypeWarning => 'Select an invoice type before generating';

  @override
  String get taxRateLabel => 'Tax Rate';

  @override
  String get bankDetailsEmployee => 'Employee Bank Details';

  @override
  String get bankDetailsAdmin => 'Admin Bank Details';

  @override
  String get expenseAttachmentsTitle => 'Expense Attachments';

  @override
  String get addFilesButton => 'Add Files';

  @override
  String attachedFilesCountLabel(Object count) {
    return 'Attached Files ($count)';
  }

  @override
  String get priceOverrideTitle => 'PRICE OVERRIDE';

  @override
  String get priceOverrideSubtitle =>
      'Review and adjust pricing for NDIS items before generating invoices.';

  @override
  String priceOverrideApplied(Object count) {
    return '$count price override(s) applied';
  }

  @override
  String get setPriceOverridesButton => 'Set Price Overrides';

  @override
  String get updatePriceOverridesButton => 'Update Price Overrides';

  @override
  String get preflightRefreshing => 'Refreshing pricing…';

  @override
  String get preflightNoNdisItems =>
      'No NDIS items found in selected assignments.';

  @override
  String preflightMissingRates(Object count, Object items) {
    return 'Base service rates are missing or using fallback for $count NDIS item(s): $items. Please add custom pricing or set price overrides.';
  }

  @override
  String get preflightSuccess =>
      'All selected NDIS items have configured base service rates.';

  @override
  String preflightError(Object error) {
    return 'Error during rate check: $error';
  }

  @override
  String get invoiceDetailsTitle => 'Invoice Details';

  @override
  String get invoiceManagement => 'INVOICE MANAGEMENT';

  @override
  String get invoiceNotFound => 'Invoice not found';

  @override
  String get invoiceNumber => 'Invoice Number';

  @override
  String get invoicePeriod => 'Invoice Period';

  @override
  String get invoicesGenerated => 'Invoices Generated';

  @override
  String get itemCode => 'Item Code';

  @override
  String get itemName => 'Item Name';

  @override
  String get jobLabel => 'Job';

  @override
  String get jobLabelCaps => 'JOB:';

  @override
  String get joinExistingOrg => 'Join Existing Organization';

  @override
  String get joinExistingOrgDesc => 'Enter organization code to join';

  @override
  String get joinOrganization => 'Join Organization';

  @override
  String get joinOrgSection => 'Join Organization';

  @override
  String get knowYourBusiness => 'Know Your\nBusiness!';

  @override
  String get knowYourClient => 'Know Your\nClient!';

  @override
  String get lastMonth => 'Last Month';

  @override
  String get lastNameHint => 'Last Name';

  @override
  String get lastNameRequired => 'Please enter last name';

  @override
  String get leaveTracker => 'Leave Tracker';

  @override
  String get leaveTrackerDesc =>
      'View balances, forecast leave, and submit requests.';

  @override
  String get legalName => 'Legal Name';

  @override
  String get liveData => 'Live Data';

  @override
  String get liveTracking => 'Live Tracking';

  @override
  String get loadingAppointmentDetails => 'Loading appointment details...';

  @override
  String get loadingClients => 'Loading clients...';

  @override
  String get loadingDashboard => 'Loading Dashboard...';

  @override
  String get loadingEmployeesAndClients => 'Loading employees and clients...';

  @override
  String get loadingInvoiceDetails => 'Loading invoice details...';

  @override
  String get loadingInvoices => 'Loading invoices...';

  @override
  String get loadingMessage => 'Loading...';

  @override
  String get location => 'Location';

  @override
  String get locationUnavailable => 'Location unavailable';

  @override
  String get loginLink => 'Login';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get logoutButton => 'Logout';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to logout?';

  @override
  String get logoutConfirmTitle => 'Logout';

  @override
  String get logoutSubtitle => 'Sign out of your account';

  @override
  String get managerApprovalMessage =>
      'All requests will be sent for a manager\'s approval';

  @override
  String get manageTraining => 'Manage Training';

  @override
  String get manageTrainingDesc => 'Create and update training modules';

  @override
  String get markAllRead => 'Mark All Read';

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get maxPrice => 'Max Price';

  @override
  String get maxPriceVariation => 'Max Price Variation';

  @override
  String get mileageAdmin => 'Mileage Admin';

  @override
  String get mileageAdminDesc => 'Review & approve employee trips';

  @override
  String get mileageTracker => 'Mileage Tracker';

  @override
  String get mileageTrackerDesc =>
      'Track your trips, calculate distance, and log reimbursable mileage.';

  @override
  String missingBaseRatesMessage(Object count, Object items) {
    return 'Base service rates are missing or using fallback for $count NDIS item(s): $items. Please add custom pricing or set price overrides.';
  }

  @override
  String get monitorPricingPerformance =>
      'Monitor your pricing performance and trends';

  @override
  String get moreButton => 'More';

  @override
  String get myRequests => 'My Requests';

  @override
  String get naLabel => 'N/A';

  @override
  String get ndisItemManagement => 'NDIS Item Management';

  @override
  String get ndisItems => 'NDIS Items';

  @override
  String ndisItemsCount(int count) {
    return '$count NDIS items';
  }

  @override
  String get ndisPricing => 'NDIS Pricing';

  @override
  String get ndisPricingDesc => 'Manage NDIS rates and compliance';

  @override
  String get ndisRegistration => 'NDIS Registration';

  @override
  String get newBusiness => 'New Business';

  @override
  String get newPasswordHint => 'New Password';

  @override
  String get nextButton => 'Next';

  @override
  String get no => 'No';

  @override
  String get noAppointments => 'No appointments';

  @override
  String get noAssignmentsFound => 'No Assignments Found';

  @override
  String get noAssignmentsMessage =>
      'Assignments for this organization will appear here.';

  @override
  String get noBankDetails => 'No bank details saved yet.';

  @override
  String get noClientAssignmentsForOverride =>
      'No client assignments with NDIS items available for price override.';

  @override
  String get noClientDataFound => 'No client data found';

  @override
  String get noClientDetailsFound => 'No client details found';

  @override
  String get noClientsAssigned => 'No clients assigned to this employee';

  @override
  String get noClientsWithAssignmentsFound =>
      'No clients with assignments found';

  @override
  String get noEmployeesAvailable =>
      'There are no employees available to select for invoice generation.';

  @override
  String get noEmployeesFound => 'No Employees Found';

  @override
  String get noEmployeesSelectedCaps => 'NO EMPLOYEES SELECTED';

  @override
  String get noExpenseData => 'No Expense Data';

  @override
  String get noInvoicesFound => 'No invoices found';

  @override
  String get noMatchingItemsFoundCaps => 'NO MATCHING ITEMS FOUND';

  @override
  String get noMatchingItemsFoundNormal => 'No matching NDIS items found.';

  @override
  String get noNdisItemsForOverride => 'No NDIS items found';

  @override
  String get noNdisItemsFound => 'No NDIS items found.';

  @override
  String get noNdisItemsFoundInAssignments =>
      'No NDIS items found in selected assignments.';

  @override
  String get noNdisItemsLoadedCaps => 'NO NDIS ITEMS LOADED';

  @override
  String get noNdisItemsLoadedNormal => 'No NDIS items loaded.';

  @override
  String get noNotificationsYet => 'No notifications yet';

  @override
  String get noPeriodSelected => 'No period selected (using default)';

  @override
  String get noRequestsFoundCaps => 'NO REQUESTS FOUND';

  @override
  String get noRequestsToDisplay => 'No requests to display';

  @override
  String get noResultsMessage => 'No items found matching your criteria.';

  @override
  String get noResultsTitle => 'NO RESULTS';

  @override
  String get normalUser => 'Normal User';

  @override
  String get normalUserDesc => 'Access basic invoice features';

  @override
  String get noSupportItemsFound => 'No support items found';

  @override
  String get noteHint => 'Type your note here...';

  @override
  String get notes => 'Notes';

  @override
  String get nothingScheduledToday => 'Nothing scheduled today';

  @override
  String get notification => 'Notification';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsSubtitle => 'Manage notification preferences';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get noUpcomingAppointments => 'NO UPCOMING APPOINTMENTS';

  @override
  String get noUpcomingShiftsMessage =>
      'You have no upcoming shifts scheduled.';

  @override
  String get noVisitHistory => 'No previous visits with this client';

  @override
  String get noCareNotes => 'No care notes available';

  @override
  String get noPreferences => 'No preferences set';

  @override
  String get appointmentDetailsCareNotes => 'Care Notes';

  @override
  String get appointmentDetailsPreferences => 'Client Preferences';

  @override
  String get appointmentDetailsVisitHistory => 'Visit History';

  @override
  String get appointmentDetailsOpenMaps => 'Get Directions';

  @override
  String get appointmentDetailsNavigationTitle => 'Navigation';

  @override
  String get appointmentDetailsCommunicationStyle => 'Communication Style';

  @override
  String get appointmentDetailsDietaryNeeds => 'Dietary Needs';

  @override
  String get appointmentDetailsSpecialRequirements => 'Special Requirements';

  @override
  String get appointmentDetailsImportantClientNeeds => 'Important client needs';

  @override
  String get appointmentDetailsViewAllHistory => 'View All History';

  @override
  String get now => 'Now';

  @override
  String get off => 'Off';

  @override
  String get offlineBannerMessage =>
      'You are offline. Changes will sync when connected.';

  @override
  String get ok => 'OK';

  @override
  String get on => 'On';

  @override
  String get oneClickInvoiceGeneration => 'One-Click Invoice Generation';

  @override
  String get open => 'OPEN';

  @override
  String get openDashboard => 'Open Dashboard';

  @override
  String get openHub => 'OPEN HUB';

  @override
  String get optional => 'Optional';

  @override
  String get or => 'or';

  @override
  String get organization => 'Organization';

  @override
  String get organizationCode => 'Organization Code';

  @override
  String get organizationCodeHint => 'Organization Code';

  @override
  String get organizationCodeRequired => 'Please enter organization code';

  @override
  String get organizationDetails => 'Organization Details';

  @override
  String get organizationManagement => 'Organization Management';

  @override
  String get organizationNameHint => 'Organization Name';

  @override
  String get organizationNameRequired => 'Please enter organization name';

  @override
  String get organizationSection => 'Organization';

  @override
  String get organizationSetupSection => 'Organization Setup';

  @override
  String get organizationWidePricing => 'Organization-Wide Pricing';

  @override
  String get orgIdNotAvailable => 'Organization ID not available';

  @override
  String get otLabel => 'OT';

  @override
  String get overdue => 'Overdue';

  @override
  String get ownerToolsSection => 'Owner Tools';

  @override
  String get paid => 'Paid';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordUpdatedSuccess => 'Password updated successfully!';

  @override
  String get passwordUpdateFailed => 'Updating password Failed!';

  @override
  String get past => 'Past';

  @override
  String get pending => 'Pending';

  @override
  String get pendingApproval => 'Pending Approval';

  @override
  String pendingOperations(int count) {
    return '$count pending operations';
  }

  @override
  String get pendingTab => 'PENDING';

  @override
  String get pendingUpdates => 'Pending Updates';

  @override
  String get permissionCamera => "Camera access is required to scan receipts for your organization's expenses.";

  @override
  String get permissionRequired => 'PERMISSION REQUIRED';

  @override
  String get permissionStorage => 'Storage access is required to save files.';

  @override
  String get personalDetailsAndContact =>
      'Personal details and contact information';

  @override
  String get personalInfoSection => 'Personal Information';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get photo => 'Photo';

  @override
  String get photoTipsSubtitle =>
      'A great photo builds trust and makes your profile stand out.';

  @override
  String get photoUploadedSuccessfully => 'Photo uploaded successfully';

  @override
  String get pleaseSelectJob => 'Please select a job';

  @override
  String get pleaseSelectLeaveType => 'Please select a leave type';

  @override
  String get priceExceedsCap => 'Price exceeds NDIS cap';

  @override
  String get priceHistory => 'Price History';

  @override
  String get priceHistoryDesc => 'Track pricing changes over time';

  @override
  String get priceHistoryTitle => 'Price History';

  @override
  String get priceOverride => 'Price Override';

  @override
  String get pricing => 'Pricing';

  @override
  String get pricingAnalytics => 'Pricing Analytics';

  @override
  String get pricingAnalyticsSubtitle => 'Analyze pricing performance';

  @override
  String get pricingConfiguration => 'Pricing Configuration';

  @override
  String pricingInfoMessage(Object intensity, Object state) {
    return 'Pricing shown for $intensity rates in $state. Tap the price icon to set custom pricing.';
  }

  @override
  String get pricingInfoTitle => 'PRICING INFO';

  @override
  String get pricingManagement => 'Pricing Management';

  @override
  String get pricingManagementDesc =>
      'Manage and optimize your service pricing across different regions and categories';

  @override
  String get pricingModel => 'Pricing Model';

  @override
  String get pricingModules => 'Pricing Modules';

  @override
  String get pricingParameters => 'Pricing Parameters';

  @override
  String get pricingRulesTab => 'Pricing Rules';

  @override
  String get pricingTrendsByCategory => 'Pricing Trends by Category';

  @override
  String get pricingValidation => 'Pricing Validation';

  @override
  String get primaryAccount => 'PRIMARY ACCOUNT';

  @override
  String get uploadProfilePhoto => 'Upload Profile Photo';

  @override
  String get organizationSaved => 'Organization details saved';

  @override
  String joinOrganizationMessage(String name) {
    return 'Join our organization: $name';
  }

  @override
  String organizationCodeParam(String code) {
    return 'Organization Code: $code';
  }

  @override
  String get orSignupLink => 'Or use this link to signup directly:';

  @override
  String get openWith => 'Open with';

  @override
  String scanToJoin(String name) {
    return 'Scan to join $name';
  }

  @override
  String get tradingNameLabel => 'TRADING NAME';

  @override
  String get companyNameLabel => 'COMPANY NAME/LEGAL NAME';

  @override
  String get abnLabel => 'ABN';

  @override
  String get openMap => 'Open Map';

  @override
  String get websiteLabel => 'WEBSITE';

  @override
  String get institutionLabel => 'INSTITUTION';

  @override
  String get bsbLabel => 'BSB';

  @override
  String get accountNoLabel => 'ACCOUNT NO.';

  @override
  String get registeredProvider => 'Registered Provider';

  @override
  String get isNdisRegistered => 'Is this organization NDIS registered?';

  @override
  String get registrationNumberLabel => 'REGISTRATION NUMBER';

  @override
  String get registrationNumberEnter => 'Enter registration number';

  @override
  String get expiryDateLabel => 'EXPIRY DATE';

  @override
  String get expiryDateHint => 'Resgistration expiry date';

  @override
  String errorPickingImage(String error) {
    return 'Error picking image: $error';
  }

  @override
  String errorUploadingLogo(String error) {
    return 'Failed to upload logo: $error';
  }

  @override
  String errorSavingOrganization(String error) {
    return 'Error saving organization: $error';
  }

  @override
  String get failedToUpdateOrganization => 'Failed to update organization';

  @override
  String get editDetailsTitle => 'EDIT DETAILS';

  @override
  String get tapToChangeLogo => 'Tap to change logo';

  @override
  String get enterTradingName => 'Enter trading name';

  @override
  String get enterAbn => 'Enter ABN';

  @override
  String get validBadge => 'VALID';

  @override
  String get addressLine1 => 'ADDRESS LINE 1';

  @override
  String get enterStreetAddress => 'Enter street address';

  @override
  String get postcodeLabel => 'POSTCODE';

  @override
  String get enterPostcode => '1234';

  @override
  String get stateRegion => 'STATE / REGION';

  @override
  String get enterBankName => 'Enter bank name';

  @override
  String get enterBsb => '000-000';

  @override
  String get enterAccountNumber => 'Account number';

  @override
  String get bankingWarning =>
      'Updating banking details may require re-verification. Payments might be delayed.';

  @override
  String get locationNotSet => 'Location not set';

  @override
  String get notRegistered => 'NOT REGISTERED';

  @override
  String get expired => 'Expired';

  @override
  String get expires => 'Expires';

  @override
  String get notSet => 'Not set';

  @override
  String get shareCodeInvite => 'Share code to invite members.';

  @override
  String get enterprisePlan => 'Enterprise Plan';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get bankNameLabel => 'BANK NAME';

  @override
  String get generalTab => 'General';

  @override
  String get contactTab => 'Contact';

  @override
  String get ndisTab => 'NDIS';

  @override
  String get verified => 'Verified';

  @override
  String get status => 'Status';

  @override
  String get assignmentComplete => 'Assignment Complete';

  @override
  String get processingAssignment => 'Processing assignment...';

  @override
  String get totalHours => 'Total hours';

  @override
  String get totalShifts => 'Total Shifts';

  @override
  String get assignedShifts => 'Assigned Shifts';

  @override
  String get goToDashboard => 'Go to Dashboard';

  @override
  String get viewAllAssignments => 'View All Assignments';

  @override
  String get shiftAssignmentComplete => 'Shift Assignment Complete!';

  @override
  String get assignmentId => 'Assignment ID';

  @override
  String get assignmentDetailsCopied =>
      'Assignment details copied to clipboard';

  @override
  String shiftIndexDetails(int index) {
    return 'Shift $index Details';
  }

  @override
  String shiftIndex(int index) {
    return 'Shift $index';
  }

  @override
  String get assignmentSuccessful => 'Assignment Successful!';

  @override
  String get assignmentSuccessfulCaps => 'ASSIGNMENT SUCCESSFUL!';

  @override
  String get dateLabel => 'Date';

  @override
  String get startLabel => 'Start';

  @override
  String get endLabel => 'End';

  @override
  String get breakLabel => 'Break';

  @override
  String get timeWorked => 'Time Worked';

  @override
  String get noData => 'No Data';

  @override
  String get noAssignmentData => 'No assignment data available';

  @override
  String get unknownEmployee => 'Unknown Employee';

  @override
  String get unknownClient => 'Unknown Client';

  @override
  String get hoursSuffix => 'hours';

  @override
  String errorInitializingAssignment(String error) {
    return 'Failed to initialize assignment: $error';
  }

  @override
  String get profilePhoto => 'Profile Photo';

  @override
  String get earningsDashboardTitle => 'EARNINGS DASHBOARD';

  @override
  String get generatePayslip => 'Generate Payslip';

  @override
  String get loadingEarnings => 'Loading Earnings...';

  @override
  String get loadingOverview => 'Loading Overview...';

  @override
  String get weeklySummary => 'Weekly Summary';

  @override
  String get monthlySummary => 'Monthly Summary';

  @override
  String get earningsHistoryThisWeek => 'EARNINGS HISTORY (THIS WEEK)';

  @override
  String get earningsHistoryThisMonth => 'EARNINGS HISTORY (THIS MONTH)';

  @override
  String get noDataForChart => 'No data for chart';

  @override
  String get taxFrequencyLabel => 'TAX FREQUENCY:';

  @override
  String get taxFreqWeekly => 'Weekly';

  @override
  String get taxFreqFortnightly => 'Fortnightly';

  @override
  String get taxFreqMonthly => 'Monthly';

  @override
  String get taxFreqAnnually => 'Annually';

  @override
  String get totalEarningsTitle => 'TOTAL EARNINGS';

  @override
  String get totalHoursTitle => 'TOTAL HOURS';

  @override
  String payRateTitle(String rate, String unit) {
    return 'PAY RATE: $rate/$unit';
  }

  @override
  String get projectedPayUpcoming => 'PROJECTED PAY (UPCOMING)';

  @override
  String get scheduledSuffix => 'scheduled';

  @override
  String get upcomingShifts => 'UPCOMING SHIFTS';

  @override
  String get payHistoryTitle => 'PAY HISTORY';

  @override
  String get weeklyToggle => 'WEEKLY';

  @override
  String get monthlyToggle => 'MONTHLY';

  @override
  String failedToLoadBusinessOverview(String error) {
    return 'Failed to load business overview: $error';
  }

  @override
  String get activeCaps => 'ACTIVE';

  @override
  String get hoursAbbrev => 'hrs';

  @override
  String get pdfGenerationFailed => 'Failed to generate invoice PDF';

  @override
  String get allowanceLaundry => 'Laundry Allowance';

  @override
  String get allowanceUniform => 'Uniform Allowance';

  @override
  String get allowanceFirstAidCasual => 'First Aid Allowance (Casual)';

  @override
  String get allowanceFirstAidWeekly => 'First Aid Allowance (Weekly)';

  @override
  String get standardHours => 'Standard Hours';

  @override
  String get overtimeFirst2h => 'Overtime (First 2h)';

  @override
  String get overtimeOver2h => 'Overtime (>2h)';

  @override
  String get overtime => 'Overtime';

  @override
  String get publicHoliday => 'Public Holiday';

  @override
  String get sundayRate => 'Sunday Rate';

  @override
  String get saturdayRate => 'Saturday Rate';

  @override
  String get employeeFallback => 'Employee';

  @override
  String get jobRoleFallback => 'Employee';

  @override
  String taxEstimatorTitle(String frequency) {
    return 'TAX ESTIMATOR ($frequency)';
  }

  @override
  String get taxEstimatorSubtitle => 'Based on ATO Resident Rates 2024-2025';

  @override
  String get grossIncome => 'Gross Income';

  @override
  String get estimatedTax => 'Estimated Tax';

  @override
  String get netPay => 'Net Pay';

  @override
  String get pricingDashboardTitle => 'PRICING DASHBOARD';

  @override
  String get pricingDashboardSubtitle => 'Manage your organization\'s pricing';

  @override
  String get ndisPricingManagementTitle => 'NDIS Pricing Management';

  @override
  String get ndisPricingManagementSubtitle =>
      'Manage custom pricing for NDIS support items';

  @override
  String get pricingConfigurationTitle => 'Pricing Configuration';

  @override
  String get systemActive => 'System Active';

  @override
  String get welcomeBack => 'Welcome back! 👋';

  @override
  String get pricingUpdateMessage =>
      'Here\'s what\'s happening with your pricing today.';

  @override
  String get keyMetrics => 'Key Metrics';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get viewAll => 'View All';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get activeItems => 'Active Items';

  @override
  String get averageRate => 'Average Rate';

  @override
  String get validationIssues => 'Validation Issues';

  @override
  String get requiresAttention => 'Requires Attention';

  @override
  String get addNewItem => 'Add New Item';

  @override
  String get createPricingItem => 'Create pricing item';

  @override
  String get bulkImport => 'Bulk Import';

  @override
  String get importFromCsv => 'Import from CSV';

  @override
  String get generateReport => 'Generate Report';

  @override
  String get exportAnalytics => 'Export analytics';

  @override
  String get configurePricing => 'Configure pricing';

  @override
  String get revenueTrend => 'Revenue Trend';

  @override
  String get searchItems => 'Search NDIS items...';

  @override
  String get searchItemsHint => 'Enter item number or name';

  @override
  String get filterByPricing => 'Filter by Pricing';

  @override
  String get filterByState => 'Filter by State';

  @override
  String get pricingFilterAll => 'All';

  @override
  String get pricingFilterCustom => 'Custom Pricing';

  @override
  String get pricingFilterStandard => 'Standard Pricing';

  @override
  String get pricingFilterHighIntensity => 'High Intensity';

  @override
  String get organizationFallbackBaseRate => 'Organization Fallback Base Rate';

  @override
  String get organizationFallbackDesc =>
      'Used when no client or organization-specific price exists.';

  @override
  String get tabGeneralSettings => 'General Settings';

  @override
  String get tabPricingRules => 'Pricing Rules';

  @override
  String get tabIntegrations => 'Integrations';

  @override
  String get tabAdvanced => 'Advanced';

  @override
  String get roundingMethod => 'Rounding Method';

  @override
  String get taxCalculation => 'Tax Calculation';

  @override
  String get systemBehavior => 'System Behavior';

  @override
  String get autoUpdatePricing => 'Auto-update Pricing';

  @override
  String get autoUpdatePricingDesc =>
      'Automatically update prices when NDIS guide changes';

  @override
  String get enablePriceValidation => 'Enable Price Validation';

  @override
  String get enablePriceValidationDesc =>
      'Validate prices against configured rules';

  @override
  String get requireApproval => 'Require Approval for Changes';

  @override
  String get requireApprovalDesc =>
      'Require manager approval for price changes';

  @override
  String get enableBulkOperations => 'Enable Bulk Operations';

  @override
  String get enableBulkOperationsDesc => 'Allow bulk import/export and updates';

  @override
  String lastModified(String date) {
    return 'Last modified: $date';
  }

  @override
  String get systemIntegrations => 'System Integrations';

  @override
  String lastSynced(String time) {
    return 'Last synced: $time';
  }

  @override
  String get advancedConfiguration => 'Advanced Configuration';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get priceHistoryRetention => 'Price History Retention (days)';

  @override
  String get bulkOperationLimit => 'Bulk Operation Limit';

  @override
  String get notificationsAndAlerts => 'Notifications & Alerts';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get enableNotificationsDesc =>
      'Receive notifications for pricing changes and alerts';

  @override
  String get enablePriceHistory => 'Enable Price History';

  @override
  String get enablePriceHistoryDesc =>
      'Maintain detailed history of all price changes';

  @override
  String get systemMaintenance => 'System Maintenance';

  @override
  String get exportConfiguration => 'Export Configuration';

  @override
  String get exportConfigurationDesc =>
      'Export current pricing configuration to file';

  @override
  String get importConfiguration => 'Import Configuration';

  @override
  String get importConfigurationDesc =>
      'Import pricing configuration from file';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get resetToDefaultsDesc => 'Reset all settings to default values';

  @override
  String get clearPriceHistoryDesc => 'Remove all historical pricing data';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String failedToSaveSettings(String error) {
    return 'Failed to save configuration: $error';
  }

  @override
  String get missingUserEmail => 'User email is missing. Cannot save pricing.';

  @override
  String get customPricingSaved => 'Custom pricing saved successfully';

  @override
  String get customPricingRemoved => 'Custom pricing removed successfully';

  @override
  String get enterValidPrice => 'Please enter a valid price';

  @override
  String get perHour => 'Per Hour';

  @override
  String get vsLastMonth => 'vs last month';

  @override
  String get thisMonth => 'This Month';

  @override
  String get clientSpecificRate => 'Client-Specific Rate';

  @override
  String get organizationRate => 'Organization Rate';

  @override
  String get missingBaseRate => 'Missing Base Rate';

  @override
  String get save => 'Save';

  @override
  String get sync => 'Sync';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get profileSettings => 'Profile Settings';

  @override
  String get profileSettingsSubtitle => 'Update your personal information';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profitMargin => 'Profit Margin';

  @override
  String get publicHolidayRate => 'Public Holiday Rate';

  @override
  String get quickActionsDesc => 'Frequently used pricing tools';

  @override
  String get readyToGenerateInvoice => 'Ready to generate invoice';

  @override
  String get reasonOptionalLabel => 'REASON (OPTIONAL)';

  @override
  String get recentExpenses => 'Recent Expenses';

  @override
  String get recurring => 'Recurring';

  @override
  String get recurringExpense => 'Recurring Expense';

  @override
  String get refreshingPricingMessage => 'Refreshing pricing…';

  @override
  String get region => 'Region';

  @override
  String get regularLabel => 'Regular';

  @override
  String get rememberPassword => 'Remember your password?';

  @override
  String get reports => 'Reports';

  @override
  String get requestsDashboard => 'Requests Dashboard';

  @override
  String get requestsDashboardDesc => 'Manage time-off and shift requests';

  @override
  String get requestsDashboardTitle => 'REQUESTS DASHBOARD';

  @override
  String get requestSent => 'Request sent';

  @override
  String get requestSentMessage => 'Your request has been sent for approval';

  @override
  String get requestsLabel => 'Requests';

  @override
  String get required => 'Required';

  @override
  String get resend => 'Resend';

  @override
  String get reset => 'Reset';

  @override
  String get resetConfiguration => 'Reset Configuration';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordDesc =>
      'Create a new secure password for your account';

  @override
  String get resolve => 'Resolve';

  @override
  String get restrictedOwnerOnly => 'Restricted: Owner access only';

  @override
  String get retryButton => 'Retry';

  @override
  String get revenueAnalysis => 'Revenue Analysis';

  @override
  String get revenueByPeriod => 'Revenue by Period';

  @override
  String get revenueByServiceCategory => 'Revenue by Service Category';

  @override
  String get runNow => 'Run Now';

  @override
  String get saveButton => 'Save';

  @override
  String get scheduleDetails => 'Schedule Details';

  @override
  String get search => 'Search';

  @override
  String get searchByItemNameOrCode => 'Search by item name or code...';

  @override
  String get searchHistory => 'Search History...';

  @override
  String get searchInvoices => 'Search Invoices';

  @override
  String get searchNdisPlaceholderCaps =>
      'SEARCH BY ITEM NUMBER OR DESCRIPTION';

  @override
  String get searchNdisPlaceholderNormal =>
      'Search by Item Number or Description';

  @override
  String get securedWith256Bit => 'Secured with 256-bit SSL encryption';

  @override
  String get security => 'Security';

  @override
  String get securityDashboard => 'Security Dashboard';

  @override
  String get securityDashboardSubtitle => 'API usage and security metrics';

  @override
  String get securitySection => 'Security';

  @override
  String get selectAll => 'Select All';

  @override
  String get selectBankDetails => 'Select which bank details to display';

  @override
  String get selectClientToViewPricing => 'Select a client to view pricing';

  @override
  String selectedEmployeesInfo(Object clientCount, Object clientLabel,
      Object employeeCount, Object employeeLabel) {
    return 'SELECTED: $employeeCount $employeeLabel WITH $clientCount $clientLabel';
  }

  @override
  String get selectEmployee => 'Select Employee';

  @override
  String get selectEmployees => 'Select Employees';

  @override
  String get selectEmployeesAndClients => 'Select Employees & Clients';

  @override
  String get selectJob => 'Select Job';

  @override
  String get selectLeaveType => 'Select Leave Type';

  @override
  String get selectNdisItemTitle => 'SELECT NDIS ITEM';

  @override
  String get selectNdisItemTitleNormal => 'Select NDIS Item';

  @override
  String get selectPeriod => 'Select Period';

  @override
  String get sendForApproval => 'Send for approval';

  @override
  String get sending => 'Sending...';

  @override
  String get sendVerificationCode => 'Send Verification Code';

  @override
  String get serviceDistribution => 'Service Distribution';

  @override
  String get serviceRateManagement => 'Service Rate Management';

  @override
  String get serviceRates => 'Service Rates';

  @override
  String get serviceRatesDesc => 'Configure service pricing structures';

  @override
  String serviceTypesCount(int count) {
    return '$count service types';
  }

  @override
  String get settings => 'Settings';

  @override
  String get settingsTitle => 'SETTINGS';

  @override
  String get shareInvoice => 'Share Invoice';

  @override
  String get shiftAssignment => 'Shift Assignment';

  @override
  String get shiftDetails => 'Shift Details';

  @override
  String get shiftExchange => 'Shift Exchange';

  @override
  String get shiftExchangeDesc =>
      'Offer swaps or claim open shifts from colleagues.';

  @override
  String shortcutsAvailable(int count) {
    return '$count shortcuts available';
  }

  @override
  String get showYourBestSide => 'Show Your Best Side';

  @override
  String get signInButton => 'Sign in';

  @override
  String get signingIn => 'Signing you in...';

  @override
  String get signupLink => 'Sign Up';

  @override
  String get signupPrompt => 'Don\'t have an account?';

  @override
  String get signupSubtitle =>
      'Join us and start managing your invoices efficiently';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get sort => 'Sort';

  @override
  String get standardCaps => 'STANDARD';

  @override
  String get startsLabel => 'Starts';

  @override
  String get startTracking => 'START TRACKING';

  @override
  String get state => 'State';

  @override
  String get statusAll => 'All';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusInformation => 'Status Information';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusOverdue => 'Overdue';

  @override
  String get statusPaid => 'Paid';

  @override
  String get statusSent => 'Sent';

  @override
  String get stopCurrentTimer =>
      'Please stop the current timer before starting a new one.';

  @override
  String get storage => 'Storage';

  @override
  String get submitButton => 'Submit';

  @override
  String get submitExpense => 'Submit Expense';

  @override
  String get submitting => 'Submitting...';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get success => 'Success';

  @override
  String get successMessage => 'Success!';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get tapToSelect => 'Tap to Select';

  @override
  String get tax => 'Tax';

  @override
  String get taxIdAbn => 'Tax ID (ABN)';

  @override
  String get taxRate => 'Tax Rate';

  @override
  String get themeSubtitle => 'Choose app appearance';

  @override
  String get themeTitle => 'Theme';

  @override
  String get thisMonthExpenses => 'This Month';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisYear => 'This Year';

  @override
  String get timeClock => 'Time Clock';

  @override
  String get timeClockDesc =>
      'Track your work hours. Clock in at start, out at finish.';

  @override
  String get timeLabelCaps => 'TIME:';

  @override
  String get timeOffTitle => 'Time off';

  @override
  String get timerAlreadyRunning => 'Timer Already Running';

  @override
  String get timesheet => 'Timesheet';

  @override
  String get timeUpdatedSuccessfully => 'Time updated successfully';

  @override
  String get to => 'to';

  @override
  String get today => 'Today';

  @override
  String get toLabel => 'to';

  @override
  String get toLabelCaps => 'TO:';

  @override
  String get topPerformingServices => 'Top Performing Services';

  @override
  String get total => 'Total';

  @override
  String get totalClients => 'Total Clients';

  @override
  String get totalExpenses => 'Total Expenses';

  @override
  String get totalLabel => 'Total';

  @override
  String get totalServices => 'Total Services';

  @override
  String get totalWorkHoursToday => 'Total work hours today';

  @override
  String get trackExpenses => 'Track Expenses';

  @override
  String get trackExpensesDesc =>
      'Keep track of your daily spending and manage reimbursements.';

  @override
  String get tradingAs => 'Trading As';

  @override
  String get trainingCompliance => 'Training & Compliance';

  @override
  String get trainingComplianceDesc =>
      'Manage certifications, complete training, and track compliance.';

  @override
  String get typeLabel => 'Type';

  @override
  String get typeLabelCaps => 'TYPE:';

  @override
  String get unit => 'Unit';

  @override
  String get unitPrice => 'Unit Price';

  @override
  String get unpaid => 'Unpaid';

  @override
  String unreadCount(int count) {
    return '$count unread';
  }

  @override
  String get unverified => 'Unverified';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get updateBankDetails => 'Update Bank Details';

  @override
  String get updateButton => 'Update';

  @override
  String get updateExpense => 'Update Expense';

  @override
  String get updates => 'Updates';

  @override
  String get uploadAndSave => 'Upload & Save';

  @override
  String get uploadingFiles => 'Uploading file(s)...';

  @override
  String get uploadPhoto => 'Upload Photo';

  @override
  String get userLabelCaps => 'USER:';

  @override
  String get utilization => 'Utilization';

  @override
  String get validatePrices => 'Validate Prices';

  @override
  String get validation => 'Validation';

  @override
  String get validationResults => 'Validation Results';

  @override
  String get validationRules => 'Validation Rules';

  @override
  String get verificationCodeSent => 'Verification code sent successfully!';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get verifyOtpTitle => 'Verify OTP';

  @override
  String get version => 'Version';

  @override
  String versionFormat(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get viewAssignments => 'View Assignments';

  @override
  String get viewAssignmentsDesc => 'View all employee assignments';

  @override
  String get viewEarnings => 'VIEW EARNINGS';

  @override
  String get viewGeneratedPdfs => 'View Generated PDFs';

  @override
  String get viewInvoice => 'View Invoice';

  @override
  String get viewMap => 'View Map';

  @override
  String get viewOffers => 'VIEW OFFERS';

  @override
  String get volume => 'Volume';

  @override
  String get warning => 'Warning';

  @override
  String get was => 'Was';

  @override
  String get weekendRate => 'Weekend Rate';

  @override
  String weekTotalLabel(String hours) {
    return 'Week total $hours';
  }

  @override
  String get weSentCode => 'We sent a 6-digit code to your email';

  @override
  String get workforceAnalytics => 'Workforce Analytics';

  @override
  String get workforceAnalyticsDesc => 'View financial & operational metrics';

  @override
  String get yes => 'Yes';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get zipCode => 'Zip Code';

  @override
  String get cancel => 'Cancel';

  @override
  String get generate => 'Generate';

  @override
  String get generateSubtitle => 'Create new invoice for clients';

  @override
  String get allInvoicesSubtitle => 'Auto-generate for all users';

  @override
  String get employeeInvoiceSubtitle =>
      'Generate pay-rate invoices for employees';

  @override
  String get enhancedInvoice => 'Enhanced Invoice';

  @override
  String get invoiceList => 'Invoice List';

  @override
  String get invoiceListSubtitle => 'View and manage generated invoices';

  @override
  String get deleteInvoiceTitle => 'Delete Invoice';

  @override
  String get missingItemsDetected => 'Missing Base Rates Detected';

  @override
  String get missingItemsTitle => 'Missing Items';

  @override
  String get missingBaseRatesTitle => 'Missing Base Rates';

  @override
  String itemsMissingOrgRate(Object count) {
    return 'Items missing organization base rate ($count):';
  }

  @override
  String get itemsMissingClientRate =>
      'Items missing client-specific base rate:';

  @override
  String get addOrgRateButton => 'Add Org Rate';

  @override
  String get addClientRateButton => 'Add Client Rate';

  @override
  String get pricingSourceTooltip => 'Pricing source for this item';

  @override
  String get supportItemNameUnavailable => 'Support item name unavailable';

  @override
  String get addOrgBaseRateTitle => 'Add Organization Base Rate';

  @override
  String addClientBaseRateTitle(Object clientName) {
    return 'Add Client Base Rate – $clientName';
  }

  @override
  String get priceFieldLabel => 'Price (e.g., 65.17)';

  @override
  String get invalidPriceError => 'Please enter a valid price';

  @override
  String get baseRateSaveSuccess => 'Base rate saved successfully';

  @override
  String get clientBaseRateSaveSuccess => 'Client base rate saved successfully';

  @override
  String baseRateSaveError(Object error) {
    return 'Failed to save base rate: $error';
  }

  @override
  String clientBaseRateSaveError(Object error) {
    return 'Failed to save client base rate: $error';
  }

  @override
  String get missingClientIdError => 'Missing client ID for saving pricing';

  @override
  String get baseRatesVerified => 'Base Rates Verified';

  @override
  String get recheckRates => 'Re-check Rates';

  @override
  String get viewMissingItems => 'View Missing Items';

  @override
  String get openPricingManagement => 'Open Pricing Management';

  @override
  String get setFallbackRate => 'Set Fallback Rate';

  @override
  String get requireClientRates => 'Require client-specific base rates';

  @override
  String get useClientBaseRates => 'Use client-specific base rates';

  @override
  String get invoicePeriodTitle => 'Invoice Period';

  @override
  String get selectPeriodButton => 'Select Period';

  @override
  String get clearButton => 'Clear';

  @override
  String get generateInvoicesButton => 'Generate Invoices';

  @override
  String get generatedInvoicesTitle => 'Generated Invoices';

  @override
  String get noInvoicesGenerated => 'No invoices generated yet.';

  @override
  String get tapToViewPdf => 'Tap to view PDF';

  @override
  String get viewPdfTooltip => 'View PDF';

  @override
  String get sendInvoiceTooltip => 'Send Invoice';

  @override
  String errorPickingFiles(Object error) {
    return 'Error picking files: $error';
  }

  @override
  String get bankDetailsMissingTitle => 'Bank Details Missing';

  @override
  String get bankDetailsMissingMessage =>
      'We could not find bank details for your organization.\n\nSince you selected \"Use Admin Bank Details\", please ensure valid bank details are saved in the Settings or Admin Tools.';

  @override
  String get okButton => 'OK';

  @override
  String errorGeneratingInvoices(Object error) {
    return 'Error generating invoices: $error';
  }

  @override
  String errorLoadingAssignmentsError(Object error) {
    return 'Error loading client assignments: $error';
  }

  @override
  String get organizationFallback => 'Organization';

  @override
  String get invoicesSentSuccess => 'Invoices sent successfully!';

  @override
  String get invoicesSentError => 'Failed to send invoices';

  @override
  String errorSendingInvoices(Object error) {
    return 'Error sending invoices: $error';
  }

  @override
  String errorViewingPdf(Object error) {
    return 'Error viewing PDF: $error';
  }

  @override
  String get ndisCapExceededTitle => 'NDIS Price Cap Exceeded';

  @override
  String get ndisCapExceededMessage =>
      'The following items exceed NDIS price caps:';

  @override
  String get ndisCapActionTitle => 'What would you like to do?';

  @override
  String get ndisCapActionGoBack => 'Go back to adjust prices';

  @override
  String get ndisCapActionProceed => 'Proceed with invoice generation anyway';

  @override
  String get goBackButton => 'Go Back';

  @override
  String get proceedButton => 'Proceed';

  @override
  String get currentPriceLabel => 'Current Price:';

  @override
  String get ndisCapLabel => 'NDIS Cap';

  @override
  String get excessLabel => 'Excess:';

  @override
  String get baseRateTooltip =>
      'We treat fallback sources (base-rate, ndis_default, fallback) as missing\nso you can configure organization/client-specific base rates.\nUse the View Missing Items list to add custom pricing.';

  @override
  String get expensesTitle => 'Expense Management';

  @override
  String get expensesTabDashboard => 'Dashboard';

  @override
  String get expensesTabList => 'Expense List';

  @override
  String get expensesTabAdd => 'Add Expense';

  @override
  String get expensesTabApprovals => 'Approvals';

  @override
  String get expensesTabRecurring => 'Recurring';

  @override
  String get expensesTabReports => 'Reports';

  @override
  String get expensesWelcomeTitle => 'Welcome!';

  @override
  String get expensesWelcomeMessage =>
      'Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.';

  @override
  String get expensesWelcomeDismiss => 'Dismiss';

  @override
  String get statsTotalExpenses => 'Total Expenses';

  @override
  String get statsPendingApproval => 'Pending Approval';

  @override
  String get statsThisMonth => 'This Month';

  @override
  String get dashboardRecentExpenses => 'Recent Expenses';

  @override
  String get dashboardViewAll => 'View All';

  @override
  String get dashboardQuickActions => 'Quick Actions';

  @override
  String get dashboardAddExpenseDesc => 'Create a new expense entry';

  @override
  String get dashboardApprovalsDesc => 'Review pending expenses';

  @override
  String get dashboardReportsDesc => 'View expense analytics';

  @override
  String get expensesEmptyTitle => 'No Expenses Found';

  @override
  String get expensesEmptyMessage => 'Add your first expense to get started';

  @override
  String get expensesEmptyDashboardTitle => 'No Expense Data';

  @override
  String get expensesEmptyDashboardMessage =>
      'Add expenses to view dashboard statistics';

  @override
  String get expensesAddButton => 'Add New Expense';

  @override
  String expensesFailedLoad(String error) {
    return 'Failed to load expenses: $error';
  }

  @override
  String get expensesSettingsComingSoon => 'Expense settings coming soon...';

  @override
  String get expensesAllExpenses => 'All Expenses';

  @override
  String get addExpenseTitle => 'Add New Expense';

  @override
  String get editExpenseTitle => 'Edit Expense';

  @override
  String get expenseDetailsTitle => 'Expense Details';

  @override
  String get expenseTitleLabel => 'Title';

  @override
  String get expenseTitleHint => 'Enter expense title';

  @override
  String get expenseTitleError => 'Please enter a title';

  @override
  String get expenseAmountLabel => 'Amount';

  @override
  String get expenseAmountHint => 'Enter amount';

  @override
  String get expenseAmountError => 'Please enter an amount';

  @override
  String get expenseAmountInvalid => 'Please enter a valid number';

  @override
  String get expenseCategoryLabel => 'Category';

  @override
  String get expenseClientLabel => 'Client (Optional)';

  @override
  String get expenseClientHint => 'Select a client';

  @override
  String expenseClientError(String error) {
    return 'Error loading clients: $error';
  }

  @override
  String get expenseDateLabel => 'Date';

  @override
  String get expenseDescriptionLabel => 'Description';

  @override
  String get expenseDescriptionHint => 'Enter expense description';

  @override
  String get expenseRecurringLabel => 'Recurring Expense';

  @override
  String get expenseRecurringSubtitle =>
      'Enable for regularly occurring expenses';

  @override
  String get expenseFrequencyLabel => 'Frequency';

  @override
  String get expenseButtonSubmit => 'Submit Expense';

  @override
  String get expenseButtonUpdate => 'Update Expense';

  @override
  String get expenseButtonSubmitting => 'Submitting...';

  @override
  String get expenseButtonUploading => 'Uploading files...';

  @override
  String expenseUploadProgress(int count) {
    return 'Uploading $count file(s)...';
  }

  @override
  String get expenseUpdateSuccess => 'Expense updated successfully';

  @override
  String get expenseSubmitSuccess => 'Expense submitted successfully';

  @override
  String get expenseSubmitGenericError => 'Failed to submit expense';

  @override
  String get expenseUploadError =>
      'File upload failed. Please check your internet connection and try again.';

  @override
  String get expenseNetworkError =>
      'Network error. Please check your connection and try again.';

  @override
  String get expenseSizeError =>
      'One or more files are too large. Please reduce file size and try again.';

  @override
  String get expenseRetryButton => 'Retry';

  @override
  String get expensesDetailsTitle => 'Expense Details';

  @override
  String get approveAction => 'Approve';

  @override
  String get rejectAction => 'Reject';

  @override
  String get deleteAction => 'Delete';

  @override
  String get deleteExpenseTitle => 'Delete Expense';

  @override
  String get deleteExpenseMessage =>
      'Are you sure you want to delete this expense? This action cannot be undone.';

  @override
  String get expenseApprovedSnack => 'Expense approved';

  @override
  String get expenseRejectedSnack => 'Expense rejected';

  @override
  String get expenseDeletedSnack => 'Expense deleted';

  @override
  String get submittedByLabel => 'Submitted by';

  @override
  String get reviewedByLabel => 'Reviewed by';

  @override
  String get createdLabel => 'Created';

  @override
  String get lastUpdatedLabel => 'Last Updated';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get addClientDesc => 'Add client information to get started';

  @override
  String get streetAddressHint => 'Street Address';

  @override
  String get streetAddressRequired => 'Please enter street address';

  @override
  String get cityRequired => 'Please enter city';

  @override
  String get stateRequired => 'Please enter state';

  @override
  String get zipCodeHint => 'ZIP Code';

  @override
  String get zipCodeRequired => 'Please enter ZIP code';

  @override
  String get confirmAddClient => 'Are you sure you want to add this client?';

  @override
  String get clientAddedSuccess => 'Client added successfully!';

  @override
  String get clientAddFailed => 'Failed to add client. Please try again.';

  @override
  String get newClientTitle => 'New Client';

  @override
  String get oopsTitle => 'Oops!';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get noClientsFoundTitle => 'No Clients Found';

  @override
  String get noClientsFoundSubtitle => 'Add your first client to get started';

  @override
  String get phoneRequired => 'Please enter phone number';

  @override
  String get businessesTitle => 'Businesses';

  @override
  String get loadingBusinesses => 'Loading businesses...';

  @override
  String get noBusinessesFoundTitle => 'No Businesses Found';

  @override
  String get noBusinessesFoundSubtitle =>
      'Add your first business to get started';

  @override
  String get addingBusinessMessage => 'Adding business...';

  @override
  String get businessAddedSuccess => 'Business details added successfully';

  @override
  String get businessAddFailed => 'Failed to add business. Please try again.';

  @override
  String get addBusinessTitle => 'Add Business';

  @override
  String get newBusinessTitle => 'New Business';

  @override
  String get addBusinessDesc => 'Add business information to get started';

  @override
  String get businessNameRequired => 'Please enter business name';

  @override
  String get businessEmailRequired => 'Please enter business email';

  @override
  String get businessPhoneRequired => 'Please enter business phone';

  @override
  String get businessAddressRequired => 'Please enter business address';

  @override
  String get confirmAddBusiness =>
      'Are you sure you want to add this business?';

  @override
  String get resetConfigurationTitle => 'Reset Configuration';

  @override
  String get resetConfigurationConfirm =>
      'Are you sure you want to reset all settings to their default values? This action cannot be undone.';

  @override
  String get configurationResetSuccess => 'Configuration reset to defaults';

  @override
  String get pricingRuleDeleted => 'Pricing rule deleted';

  @override
  String syncingIntegration(String name) {
    return 'Syncing $name...';
  }

  @override
  String get priceHistoryClearedTitle => 'Clear Price History';

  @override
  String get priceHistoryClearedConfirm =>
      'Are you sure you want to clear all price history data? This action cannot be undone.';

  @override
  String get priceHistoryClearedSuccess => 'Price history cleared';

  @override
  String get noChangesToSave => 'No changes to save';

  @override
  String get addPricingRuleDialog =>
      'Add new pricing rule dialog would open here';

  @override
  String editPricingRuleDialog(String name) {
    return 'Edit rule: $name';
  }

  @override
  String get chartVisualizationPlaceholder =>
      'Chart visualization\nwould appear here';

  @override
  String get lineChart => 'Line Chart';

  @override
  String get barChart => 'Bar Chart';

  @override
  String get pieChart => 'Pie Chart';

  @override
  String get areaChart => 'Area Chart';

  @override
  String get failedToLoadEmployees => 'Failed to load employees';

  @override
  String get pricingAnalyticsTitle => 'Pricing Analytics';

  @override
  String get quickInsights => 'Quick Insights';

  @override
  String get revenueBreakdown => 'Revenue Breakdown';

  @override
  String get revenueTrendChartDesc =>
      'Displays the revenue trend over the selected period';

  @override
  String get serviceDistributionChartDesc =>
      'Breakdown of revenue by service category';

  @override
  String get revenueByPeriodChartDesc =>
      'Revenue comparison over different time periods';

  @override
  String get revenueCategoryChartDesc =>
      'Revenue breakdown by service category';

  @override
  String get metricRevenue => 'Revenue';

  @override
  String get metricHours => 'Hours';

  @override
  String get metricRate => 'Rate';

  @override
  String get metricMargin => 'Margin';

  @override
  String get trendIncreasing => 'Increasing';

  @override
  String get trendStable => 'Stable';

  @override
  String get trendDecreasing => 'Decreasing';

  @override
  String get ndisCore => 'NDIS Core';

  @override
  String get capacityBuilding => 'Capacity Building';

  @override
  String get other => 'Other';

  @override
  String get changeLabel => 'Change';

  @override
  String get trackPricingChanges => 'Track pricing changes over time';

  @override
  String get totalChanges => 'Total Changes';

  @override
  String get priceIncreases => 'Price Increases';

  @override
  String get priceDecreases => 'Price Decreases';

  @override
  String get avgChange => 'Avg Change';

  @override
  String get tabPriceChanges => 'Price Changes';

  @override
  String get tabTrends => 'Trends';

  @override
  String get tabAnalytics => 'Analytics';

  @override
  String get searchHistoryHint => 'Search price history...';

  @override
  String get timeRangeLabel => 'Time Range';

  @override
  String get categoryLabel => 'Category';

  @override
  String get allCategories => 'All';

  @override
  String get coreSupport => 'Core Support';

  @override
  String get capitalSupport => 'Capital Support';

  @override
  String get timeRange7Days => '7 days';

  @override
  String get timeRange30Days => '30 days';

  @override
  String get timeRange90Days => '90 days';

  @override
  String get timeRange6Months => '6 months';

  @override
  String get timeRange1Year => '1 year';

  @override
  String get statusActive => 'Active';

  @override
  String get statusPending => 'Pending';

  @override
  String get oldPrice => 'Old Price';

  @override
  String get newPrice => 'New Price';

  @override
  String get percentage => 'Percentage';

  @override
  String get reasonLabel => 'Reason';

  @override
  String get changedByLabel => 'Changed By';

  @override
  String get changeDateLabel => 'Changed';

  @override
  String get effectiveDateLabel => 'Effective';

  @override
  String get priceTrendsTitle => 'Price Trends';

  @override
  String get visualChartsAndTrends => 'Visual charts and trends analysis';

  @override
  String get priceAnalyticsTitle => 'Price Analytics';

  @override
  String get detailedAnalyticsInsights => 'Detailed analytics and insights';

  @override
  String get dataRefreshedSuccess => 'Data refreshed successfully';

  @override
  String get exportingHistory => 'Exporting price history to CSV...';

  @override
  String get pricingValidationTitle => 'Pricing Validation';

  @override
  String get tabValidationResults => 'Validation Results';

  @override
  String get tabValidationRules => 'Validation Rules';

  @override
  String get tabReports => 'Reports';

  @override
  String get validationResultsTabTitle => 'VALIDATION RESULTS TAB';

  @override
  String get validationRulesTabTitle => 'VALIDATION RULES TAB';

  @override
  String get reportsTabTitle => 'REPORTS TAB';

  @override
  String get totalIssues => 'Total Issues';

  @override
  String get resolvedData => 'Resolved';

  @override
  String get activeRules => 'Active Rules';

  @override
  String get searchValidationHint => 'Search validation results...';

  @override
  String get severityLabel => 'Severity';

  @override
  String get allValidationTypes => 'All';

  @override
  String get priceRange => 'Price Range';

  @override
  String get duplicateEntry => 'Duplicate Entry';

  @override
  String get missingData => 'Missing Data';

  @override
  String get rateConsistency => 'Rate Consistency';

  @override
  String get severityError => 'Error';

  @override
  String get severityWarning => 'Warning';

  @override
  String get severityInfo => 'Info';

  @override
  String get messageLabel => 'Message';

  @override
  String get timestampLabel => 'Timestamp';

  @override
  String get detailsLabel => 'Details';

  @override
  String get itemLabel => 'Item';

  @override
  String itemTimestampLabel(String itemCode, String timestamp) {
    return 'Item: $itemCode • $timestamp';
  }

  @override
  String fromLastWeekStat(String count) {
    return '$count from last week';
  }

  @override
  String resolutionRateStat(String percentage) {
    return '$percentage% resolution rate';
  }

  @override
  String updatedTodayStat(String count) {
    return '$count updated today';
  }

  @override
  String get closeAction => 'Close';

  @override
  String get resolveAction => 'Resolve';

  @override
  String get viewDetailsAction => 'View Details';

  @override
  String get statusResolved => 'Resolved';

  @override
  String get statusUnderReview => 'Under Review';

  @override
  String get statusUnresolved => 'Unresolved';

  @override
  String get violationsLabel => 'violations';

  @override
  String get editAction => 'Edit';

  @override
  String get disableAction => 'Disable';

  @override
  String get enableAction => 'Enable';

  @override
  String get runNowAction => 'Run Now';

  @override
  String get validationReportsTitle => 'Validation Reports';

  @override
  String get dailyValidationSummary => 'Daily Validation Summary';

  @override
  String get dailyValidationSummaryDesc =>
      'Comprehensive daily report of all validation activities';

  @override
  String get weeklyTrendsAnalysis => 'Weekly Trends Analysis';

  @override
  String get weeklyTrendsAnalysisDesc =>
      'Weekly analysis of validation trends and patterns';

  @override
  String get rulePerformanceReport => 'Rule Performance Report';

  @override
  String get rulePerformanceReportDesc =>
      'Performance metrics for all validation rules';

  @override
  String get customReportBuilder => 'Custom Report Builder';

  @override
  String get customReportBuilderDesc =>
      'Create custom validation reports with specific criteria';

  @override
  String get validationIssueResolved =>
      'Validation issue resolved successfully';

  @override
  String validationDetailsTitle(String id) {
    return 'Validation Details - $id';
  }

  @override
  String get bulkOperationsSmallDesc =>
      'Import and export data in batch operations';

  @override
  String get refreshAction => 'Refresh';

  @override
  String get helpAction => 'Help';

  @override
  String get newAction => 'New';

  @override
  String get totalOperations => 'Total Operations';

  @override
  String get completedOps => 'Completed';

  @override
  String get failedOps => 'Failed';

  @override
  String get successRate => 'Success Rate';

  @override
  String get tabImport => 'Import';

  @override
  String get tabExport => 'Export';

  @override
  String get tabBulk => 'Bulk';

  @override
  String get tabHistory => 'History';

  @override
  String get tabDataSubtitle => 'Data';

  @override
  String get tabUpdatesSubtitle => 'Updates';

  @override
  String get importDataTitle => 'Import Data';

  @override
  String get importDataDesc =>
      'Upload CSV or Excel files to import pricing data in bulk';

  @override
  String get ndisItemsCardTitle => 'NDIS Items';

  @override
  String get ndisItemsCardSubtitle => 'item codes';

  @override
  String get serviceRatesCardTitle => 'Service Rates';

  @override
  String get serviceRatesCardSubtitle => 'rate structures';

  @override
  String get priceUpdatesCardTitle => 'Price Updates';

  @override
  String get priceUpdatesCardSubtitle => 'bulk adjustments';

  @override
  String get regionalRatesCardTitle => 'Regional Rates';

  @override
  String get regionalRatesCardSubtitle => 'pricing variations';

  @override
  String get itemsUnit => 'items';

  @override
  String get ratesUnit => 'rates';

  @override
  String get updatesUnit => 'updates';

  @override
  String get regionsUnit => 'regions';

  @override
  String get processingImportMsg => 'Processing import...';

  @override
  String completeMsg(int percentage) {
    return '$percentage% complete';
  }

  @override
  String get downloadTemplatesTitle => 'Download Templates';

  @override
  String get downloadTemplatesDesc =>
      'Get properly formatted CSV templates for seamless data import';

  @override
  String get ndisTemplateTitle => 'NDIS Items';

  @override
  String get ndisTemplateDesc =>
      'Complete NDIS service items with codes and descriptions';

  @override
  String get ratesTemplateTitle => 'Service Rates';

  @override
  String get ratesTemplateDesc => 'Pricing rates for all service categories';

  @override
  String get updatesTemplateTitle => 'Price Updates';

  @override
  String get updatesTemplateDesc => 'Bulk price adjustments and modifications';

  @override
  String get regionalTemplateTitle => 'Regional Rates';

  @override
  String get regionalTemplateDesc => 'Location-based pricing variations';

  @override
  String get exportDataTitle => 'Export Data';

  @override
  String get exportDataDesc => 'Export your pricing data to various formats';

  @override
  String get allPricingDataTitle => 'All Pricing Data';

  @override
  String get allPricingDataSubtitle => 'complete database';

  @override
  String get recordsUnit => 'records';

  @override
  String get ndisItemsOnlyTitle => 'NDIS Items Only';

  @override
  String get ndisItemsOnlySubtitle => 'items and rates';

  @override
  String get regionalDataTitle => 'Regional Data';

  @override
  String get regionalDataSubtitle => 'pricing variations';

  @override
  String get bulkUpdatesTitle => 'Bulk Updates';

  @override
  String get bulkUpdatesDesc => 'Perform mass updates on your pricing data';

  @override
  String get priceAdjustmentTitle => 'Price Adjustment';

  @override
  String get priceAdjustmentSubtitle => 'Apply percentage increases/decreases';

  @override
  String get regionalUpdatesTitle => 'Regional Updates';

  @override
  String get regionalUpdatesSubtitle => 'Update rates for specific regions';

  @override
  String get categoryUpdatesTitle => 'Category Updates';

  @override
  String get categoryUpdatesSubtitle => 'Update entire service categories';

  @override
  String get statusChangesTitle => 'Status Changes';

  @override
  String get statusChangesSubtitle => 'Activate/deactivate multiple items';

  @override
  String get basedUnit => 'Based';

  @override
  String get wideUnit => 'Wide';

  @override
  String get toggleUnit => 'Toggle';

  @override
  String get operationHistoryTitle => 'Operation History';

  @override
  String get operationHistoryDesc => 'View history of all bulk operations';

  @override
  String get processedLabel => 'Processed';

  @override
  String get successfulLabel => 'Successful';

  @override
  String get durationLabel => 'Duration';

  @override
  String get startedLabel => 'Started';

  @override
  String get byLabel => 'By';

  @override
  String importCompletedMsg(String type) {
    return 'Import completed successfully for $type';
  }

  @override
  String importFailedMsg(String error) {
    return 'Import failed: $error';
  }

  @override
  String exportingMsg(String type) {
    return 'Exporting $type...';
  }

  @override
  String initiatingMsg(String type) {
    return 'Initiating $type...';
  }

  @override
  String downloadingMsg(String template) {
    return 'Downloading $template...';
  }

  @override
  String get bulkOperationsHelpTitle => 'Bulk Operations Help';

  @override
  String get quickActionsTitle => 'Quick Actions';

  @override
  String get importDataQuickAction => 'Import Data';

  @override
  String get importDataQuickDesc => 'Upload CSV or Excel files';

  @override
  String get exportDataQuickAction => 'Export Data';

  @override
  String get exportDataQuickDesc => 'Download current data';

  @override
  String get ndisItemManagementTitle => 'NDIS Item Management';

  @override
  String get exportComingSoon => 'Export functionality coming soon...';

  @override
  String get importComingSoon => 'Import functionality coming soon...';

  @override
  String selectedCount(String count) {
    return '$count selected';
  }

  @override
  String get tipBulkActions =>
      'Tip: Use the checkboxes to select multiple items for bulk actions.';

  @override
  String get dismissAction => 'Dismiss';

  @override
  String get statTotal => 'Total';

  @override
  String get statActive => 'Active';

  @override
  String get statInactive => 'Inactive';

  @override
  String get statFiltered => 'Filtered';

  @override
  String categoryValueLabel(String category) {
    return 'Category: $category';
  }

  @override
  String get addItemAction => 'Add Item';

  @override
  String get editNdisItemTitle => 'Edit NDIS Item';

  @override
  String get addNewNdisItemTitle => 'Add New NDIS Item';

  @override
  String get itemCodeLabel => 'Item Code';

  @override
  String get itemNameLabel => 'Item Name';

  @override
  String get itemCodeHint => 'e.g., 01_001_0103_1_1';

  @override
  String get itemNameHint => 'e.g., Assistance with personal activities';

  @override
  String get itemDescriptionHint => 'Brief description of the service';

  @override
  String get unitLabel => 'Unit';

  @override
  String get unitPriceLabel => 'Unit Price (\$)';

  @override
  String get unitPriceHint => '0.00';

  @override
  String get updateAction => 'Update';

  @override
  String get createAction => 'Create';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get revenueTrendTitle => 'Revenue Trend';

  @override
  String get serviceDistributionTitle => 'Service Distribution';

  @override
  String get revenueByPeriodTitle => 'Revenue by Period';

  @override
  String get revenueByCategoryTitle => 'Revenue by Service Category';

  @override
  String revenueInsightLabel(String percentage) {
    return '• Revenue increased by $percentage% compared to last period';
  }

  @override
  String topServiceInsightLabel(String serviceName) {
    return '• $serviceName is the top revenue generator';
  }

  @override
  String avgRateInsightLabel(String percentage) {
    return '• Average service rate decreased by $percentage% - consider rate review';
  }

  @override
  String utilizationInsightLabel(String percentage) {
    return '• Utilization rate improved by $percentage% - good efficiency trend';
  }

  @override
  String vsLastMonthStat(String percentage) {
    return '$percentage% vs last month';
  }

  @override
  String improvementStat(String percentage) {
    return '$percentage% improvement';
  }

  @override
  String growthStat(String percentage) {
    return '$percentage% growth';
  }

  @override
  String get clientPricingReviewTitle => 'Client Pricing Review';

  @override
  String get failedToLoadClients => 'Failed to load clients';

  @override
  String get noClientsFound => 'No clients found';

  @override
  String get noClientsFoundDesc =>
      'No clients with assignments found in this organization.';

  @override
  String get selectClientPrompt => 'Select a client';

  @override
  String get chooseClientFromListDesc =>
      'Choose a client from the list to view pricing.';

  @override
  String get noSupportItemsTitle => 'No support items';

  @override
  String get noItemsFoundForClientDesc => 'No items found for this client.';

  @override
  String get editPricesAction => 'Edit Prices';

  @override
  String get exceedsLabel => 'Exceeds';

  @override
  String get overCapLabel => 'Over cap';

  @override
  String get withinCapLabel => 'Within cap';

  @override
  String get currentRateLabel => 'Current Rate';

  @override
  String get diffLabel => 'Diff';

  @override
  String get notAvailableLabel => 'N/A';

  @override
  String get priceSourceCustom => 'Custom Price';

  @override
  String get priceSourceNdis => 'NDIS Price';

  @override
  String get priceSourceManual => 'Manual override';

  @override
  String get priceSourceUnknown => 'Unknown source';

  @override
  String get priceSourceMissing => 'Missing pricing';

  @override
  String errorLoadingClients(String error) {
    return 'Error loading clients: $error';
  }

  @override
  String clientsCountTitle(String count) {
    return 'Clients ($count)';
  }

  @override
  String assignmentsCountLabel(String count) {
    return '$count assignments';
  }

  @override
  String get backAction => 'Back';

  @override
  String get okLabel => 'OK';

  @override
  String get currentLabel => 'Current';

  @override
  String get sourceLabel => 'Source';

  @override
  String get ndisLabel => 'NDIS';

  @override
  String get timeRangeLast30Days => 'Last 30 Days';

  @override
  String codeLabelValue(String code) {
    return 'Code: $code';
  }

  @override
  String get bulkUpdatesQuickAction => 'Bulk Updates';

  @override
  String get bulkUpdatesQuickDesc => 'Mass update pricing data';

  @override
  String editValidationRuleMsg(String name) {
    return 'Edit validation rule: $name';
  }

  @override
  String get validationRuleStatusUpdated => 'Validation rule status updated';

  @override
  String get runningValidationRule => 'Running validation rule...';

  @override
  String generatingReport(String type) {
    return 'Generating $type report...';
  }

  @override
  String get openingCustomReportBuilder => 'Opening custom report builder...';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get dashboardOverviewTitle => 'Dashboard Overview';

  @override
  String get dashboardOverviewSubtitle => 'View pricing analytics and insights';

  @override
  String get ndisPricingTitle => 'NDIS Pricing';

  @override
  String get ndisPricingSubtitle => 'Manage NDIS rates and compliance';

  @override
  String ndisItemsStat(String count) {
    return '$count NDIS items';
  }

  @override
  String get serviceRatesTitle => 'Service Rates';

  @override
  String get serviceRatesSubtitle => 'Configure service pricing structures';

  @override
  String serviceTypesStat(String count) {
    return '$count service types';
  }

  @override
  String get bulkOperationsSubtitle => 'Import/export and batch updates';

  @override
  String pendingOpsStat(String count) {
    return '$count pending operations';
  }

  @override
  String get priceHistorySubtitle => 'Track pricing changes over time';

  @override
  String historicalRecordsStat(String count) {
    return '$count historical records';
  }

  @override
  String get quickActionsSubtitle => 'Frequently used pricing tools';

  @override
  String shortcutsAvailableStat(String count) {
    return '$count shortcuts available';
  }

  @override
  String get pricingManagementTitle => 'Pricing Management';

  @override
  String get pricingSettingsTooltip => 'Pricing Settings';

  @override
  String get manageAndOptimizeDesc =>
      'Manage and optimize your service pricing';

  @override
  String get orgContextMissingError =>
      'Organization context missing. Cannot open Pricing Settings.';

  @override
  String get totalServicesLabel => 'Total Services';

  @override
  String thisMonthStat(String count) {
    return '$count this month';
  }

  @override
  String get activeRatesLabel => 'Active Rates';

  @override
  String urgentStat(String count) {
    return '$count urgent';
  }

  @override
  String get pendingUpdatesLabel => 'Pending Updates';

  @override
  String get vsLastQuarterStat => 'vs last quarter';

  @override
  String get projectedMonthlyStat => 'projected monthly';

  @override
  String get pricingModulesTitle => 'Pricing Modules';

  @override
  String get chooseModuleDesc => 'Choose a module to manage your pricing';

  @override
  String get moduleStatusNeedsAction => 'Needs Action';

  @override
  String get moduleStatusHealthy => 'Healthy';

  @override
  String get moduleStatusReady => 'Ready';

  @override
  String get moduleStatusIdle => 'Idle';

  @override
  String get moduleStatusRecentlyUpdated => 'Recently Updated';

  @override
  String get moduleBadgeOverview => 'Overview';

  @override
  String get moduleBadgeNdis => 'NDIS Catalog';

  @override
  String get moduleBadgeRates => 'Rate Coverage';

  @override
  String get moduleBadgeBulk => 'Bulk Queue';

  @override
  String get moduleBadgeHistory => 'Change History';

  @override
  String get moduleBadgeActions => 'Action Center';

  @override
  String get moduleMetricRevenue => 'Revenue';

  @override
  String get moduleMetricCoverage => 'Coverage';

  @override
  String get moduleMetricCompliance => 'Compliance';

  @override
  String get moduleMetricCatalogItems => 'Catalog Items';

  @override
  String get moduleMetricCustomPrices => 'Custom Prices';

  @override
  String get moduleMetricConfiguredRates => 'Configured Rates';

  @override
  String get moduleMetricAvgBaseRate => 'Avg Base Rate';

  @override
  String get moduleMetricBulkCandidates => 'Bulk Candidates';

  @override
  String get moduleMetricRecommendedBatch => 'Recommended Batch';

  @override
  String get moduleMetricWeeklyChanges => 'Weekly Changes';

  @override
  String get moduleMetricTrackedEntries => 'Tracked Entries';

  @override
  String get moduleMetricActionableItems => 'Actionable Items';

  @override
  String get moduleMetricAvailableActions => 'Available Modules';

  @override
  String get moduleNoTrackedChanges => 'No tracked changes yet';

  @override
  String get moduleNoDataYet => 'No data available yet';

  @override
  String moduleLastUpdatedDays(String days) {
    return 'Last updated ${days}d ago';
  }

  @override
  String moduleRatesCoverage(String configured, String total) {
    return '$configured/$total rates configured';
  }

  @override
  String moduleKeyInsightCoverage(String custom, String total) {
    return '$custom/$total items with custom pricing';
  }

  @override
  String moduleKeyInsightViolations(String count) {
    return '$count compliance issues need review';
  }

  @override
  String get moduleKeyInsightHealthy => 'Compliance signals are healthy';

  @override
  String moduleKeyInsightQuotable(String count) {
    return '$count quotable supports need tracked handling';
  }

  @override
  String moduleKeyInsightMissingRates(String count) {
    return '$count employees still missing pay rates';
  }

  @override
  String get moduleKeyInsightAllRatesConfigured =>
      'All employee rates are configured';

  @override
  String moduleKeyInsightBacklog(String pending, String total) {
    return '$pending of $total items are pending updates';
  }

  @override
  String moduleKeyInsightBatchSuggestion(String batch) {
    return 'Suggested batch size: $batch';
  }

  @override
  String moduleKeyInsightHistory(String count) {
    return '$count priced items are tracked in history';
  }

  @override
  String get moduleKeyInsightActionCenter =>
      'Central queue for pricing follow-ups';

  @override
  String moduleKeyInsightPendingActions(String count) {
    return '$count items need immediate action';
  }

  @override
  String get moduleKeyInsightClearQueue => 'No pending actions in queue';

  @override
  String get activeLabel => 'Active';

  @override
  String get bulkPriceUpdateTitle => 'Bulk Price Update';

  @override
  String get bulkPriceUpdateSubtitle => 'Update multiple prices at once';

  @override
  String get exportPricingDataTitle => 'Export Pricing Data';

  @override
  String get exportPricingDataSubtitle =>
      'Download current pricing information';

  @override
  String get priceAnalyticsSubtitle => 'View pricing trends and insights';

  @override
  String get ndisComplianceCheckTitle => 'NDIS Compliance Check';

  @override
  String get ndisComplianceCheckSubtitle => 'Verify NDIS pricing compliance';

  @override
  String activeMetricsTitle(String count) {
    return '$count active metrics';
  }

  @override
  String get stateFilterAll => 'All States';

  @override
  String pricingInfoBanner(String state) {
    return 'Pricing shown for Standard rates in $state. Custom pricing will override standard rates for your organization.';
  }

  @override
  String get loadingNdisItems => 'Loading NDIS items';

  @override
  String noNdisItemsFoundMatch(String query) {
    return 'No NDIS items found matching \"$query\"';
  }

  @override
  String get clearFiltersAction => 'Clear filters';

  @override
  String get removeCustomPricingTooltip => 'Remove custom pricing';

  @override
  String get setCustomPriceTooltip => 'Set custom price';

  @override
  String get standardNdisRateLabel => 'Standard NDIS Rate';

  @override
  String get standardRateUnavailable =>
      'Standard rate unavailable for selected state';

  @override
  String get pleaseEnterCustomPrice => 'Please enter a custom price to proceed';

  @override
  String get enterPriceAction => 'Enter Price';

  @override
  String get setCustomPriceOrgLabel => 'Set custom price for this organization';

  @override
  String get customPriceHourlyLabel => 'Custom Price (\$/hour)';

  @override
  String get enterHourlyRateHint => 'Enter hourly rate';

  @override
  String get pleaseEnterPrice => 'Please enter a price';

  @override
  String get invalidPrice => 'Invalid price';

  @override
  String get priceUnusuallyHigh => 'Price unusually high';

  @override
  String get saveCustomPriceAction => 'Save Custom Price';

  @override
  String get customPricingAppliedOrgWide =>
      'Custom pricing will be applied organization-wide.';

  @override
  String get resetToDefaultsTooltip => 'Reset to Defaults';

  @override
  String get fallbackBaseRateSection => 'Fallback Base Rate';

  @override
  String get pricingRulesTitle => 'Pricing Rules';

  @override
  String get addRuleAction => 'Add Rule';

  @override
  String get rulePriorityHigh => 'High';

  @override
  String get rulePriorityMedium => 'Medium';

  @override
  String get rulePriorityLow => 'Low';

  @override
  String get ruleStatusConnected => 'Connected';

  @override
  String get ruleStatusDisconnected => 'Disconnected';

  @override
  String get ruleNeverSync => 'Never';

  @override
  String get optionNearestCent => 'Round to nearest cent';

  @override
  String get optionRoundUp => 'Round up';

  @override
  String get optionRoundDown => 'Round down';

  @override
  String get optionNoRounding => 'No rounding';

  @override
  String get optionNdisStandard => 'NDIS Standard';

  @override
  String get optionCustom => 'Custom';

  @override
  String get optionHybrid => 'Hybrid';

  @override
  String get optionGstInclusive => 'GST Inclusive';

  @override
  String get optionGstExclusive => 'GST Exclusive';

  @override
  String get fallbackRateHint => 'e.g., 35.00';

  @override
  String get fallbackCurrencyHint => 'AUD';

  @override
  String get validPositiveAmountError =>
      'Please enter a valid positive amount.';

  @override
  String get fallbackRateUpdatedSuccess => 'Fallback base rate updated';

  @override
  String get exportingConfigurationMsg => 'Exporting configuration...';

  @override
  String configureIntegrationHint(String name) {
    return 'Configure $name integration';
  }

  @override
  String get importConfigurationDialogHint =>
      'Import configuration dialog would open here';

  @override
  String get allFilter => 'All';

  @override
  String get regionLabel => 'Region';

  @override
  String get serviceRateManagementTitle => 'Service Rate Management';

  @override
  String get serviceRateManagementSubtitle =>
      'Manage and optimize your service pricing across different regions and categories';

  @override
  String get systemActiveLabel => 'System Active';

  @override
  String get searchServiceRatesHint => 'Search service rates...';

  @override
  String get filterAction => 'Filter';

  @override
  String get addRateAction => 'Add Rate';

  @override
  String get totalRatesStat => 'Total Rates';

  @override
  String get activeRatesStat => 'Active Rates';

  @override
  String get pendingUpdatesStat => 'Pending Updates';

  @override
  String get avgBaseRateStat => 'Avg Base Rate';

  @override
  String get totalRatesSubtitle => '+12 this month';

  @override
  String get activeRatesSubtitle => '3 urgent';

  @override
  String get pendingUpdatesSubtitle => 'vs last quarter';

  @override
  String get avgBaseRateSubtitle => 'projected monthly';

  @override
  String get noServiceRatesFoundTitle => 'No Service Rates Found';

  @override
  String get noServiceRatesFoundSubtitle =>
      'Try adjusting your search criteria or add new service rates to get started.';

  @override
  String get addNewRateAction => 'Add New Rate';

  @override
  String get baseRateLabel => 'Base Rate';

  @override
  String get weekendRateLabel => 'Weekend Rate';

  @override
  String get holidayRateLabel => 'Holiday Rate';

  @override
  String get perHourSuffix => '/hr';

  @override
  String get exportingRatesMsg => 'Exporting rates to CSV...';

  @override
  String get addNewServiceRateTitle => 'Add New Service Rate';

  @override
  String get addNewRateFeatureComingSoon =>
      'Create a new service rate configuration. This feature will be fully implemented in the next update.';

  @override
  String get comingSoonMsg => 'New rate feature coming soon!';

  @override
  String get deleteRateTitle => 'Delete Rate';

  @override
  String deleteRateConfirm(String serviceName) {
    return 'Are you sure you want to delete the rate for $serviceName?';
  }

  @override
  String get rateDeletedSuccess => 'Rate deleted successfully';

  @override
  String get filterServiceRatesTitle => 'Filter Service Rates';

  @override
  String get filtersClearedMsg => 'Filters cleared';

  @override
  String get filtersAppliedMsg => 'Filters applied';

  @override
  String get todayLabel => 'Today';

  @override
  String get thisWeekLabel => 'This Week';

  @override
  String get thisQuarterLabel => 'This Quarter';

  @override
  String get janInitial => 'Jan';

  @override
  String get febInitial => 'Feb';

  @override
  String get marInitial => 'Mar';

  @override
  String get aprInitial => 'Apr';

  @override
  String get mayInitial => 'May';

  @override
  String get junInitial => 'Jun';

  @override
  String get julInitial => 'Jul';

  @override
  String get augInitial => 'Aug';

  @override
  String get sepInitial => 'Sep';

  @override
  String get octInitial => 'Oct';

  @override
  String get novInitial => 'Nov';

  @override
  String get decInitial => 'Dec';

  @override
  String get newPricingItemAdded => 'New pricing item added';

  @override
  String get rateUpdatedActivity => 'Rate updated';

  @override
  String get validationCompletedActivity => 'Validation completed';

  @override
  String get reportGeneratedActivity => 'Report generated';

  @override
  String get pricingOverviewTitle => 'Pricing Overview';

  @override
  String get pricingOverviewSubtitle =>
      'Comprehensive pricing management and analytics dashboard';

  @override
  String get totalServicesStat => 'Total Services';

  @override
  String get avgRateStat => 'Avg Rate';

  @override
  String get activeRatesStatLabel => 'Active Rates';

  @override
  String get revenueStat => 'Revenue';

  @override
  String newThisMonthStat(String count) {
    return '$count new this month';
  }

  @override
  String vsLastMonthStatRange(String percentage) {
    return '$percentage% vs last month';
  }

  @override
  String percentageOfTotalStat(String percentage) {
    return '$percentage% of total';
  }

  @override
  String growthStatLabel(String percentage) {
    return '$percentage% growth';
  }

  @override
  String get addRateSubtitle => 'Create pricing rule';

  @override
  String get bulkUpdateSubtitle => 'Update multiple rates';

  @override
  String get priceHistorySubtitleLabel => 'View rate changes';

  @override
  String get pricingInsightsSubtitle => 'Pricing insights';

  @override
  String get newBadge => 'New';

  @override
  String get pendingApprovalFilter => 'Pending Approval';

  @override
  String get expiredFilter => 'Expired';

  @override
  String get searchPricingRulesHint => 'Search pricing rules...';

  @override
  String get currentRatesTab => 'Current Rates';

  @override
  String get rateHistoryTab => 'Rate History';

  @override
  String get configurationsTab => 'Configurations';

  @override
  String get serviceColumn => 'Service';

  @override
  String get rateColumn => 'Rate';

  @override
  String get lastUpdatedColumn => 'Last Updated';

  @override
  String get editRateTooltip => 'Edit Rate';

  @override
  String get viewHistoryTooltip => 'View History';

  @override
  String get noPricingRatesFound => 'No pricing rates found';

  @override
  String get rateHistoryContent => 'Rate History Content';

  @override
  String get configurationsContent => 'Configurations Content';

  @override
  String get actionsLabel => 'Actions';

  @override
  String get employeePayRatesTitle => 'Employee Pay Rates';

  @override
  String get payRatesUpdatedSuccess => 'Pay rates updated successfully';

  @override
  String errorUpdatingRate(String error) {
    return 'Error updating rate: $error';
  }

  @override
  String setPayRatesTitle(String name) {
    return 'Set Pay Rates: $name';
  }

  @override
  String get hourlyLabel => 'Hourly';

  @override
  String get salaryLabel => 'Salary';

  @override
  String get permanentLabel => 'Permanent';

  @override
  String get casualLabel => 'Casual';

  @override
  String get notSetLabel => 'Not Set';

  @override
  String get perAnnumLabel => 'Per Annum';

  @override
  String get perHourLabel => 'Per Hour';

  @override
  String get classificationEmploymentSection => 'Classification & Employment';

  @override
  String get baseRateSection => 'Base Rate';

  @override
  String get penaltyRatesSection => 'Penalty Rates (Total Hourly)';

  @override
  String get overtimeSection => 'Overtime (Total Hourly)';

  @override
  String get allowancesSection => 'Allowances (Enabled)';

  @override
  String get streamLabel => 'Stream';

  @override
  String get employmentTypeLabel => 'Employment Type';

  @override
  String get levelLabel => 'Level';

  @override
  String get payPointLabel => 'Pay Point';

  @override
  String get selectStreamFirstHint => 'Choose a stream to unlock levels.';

  @override
  String get selectLevelFirstHint => 'Choose a level to show pay points.';

  @override
  String get baseRateHourlyLabel => 'Base Rate (Hourly)';

  @override
  String get payTypeLabel => 'Pay Type';

  @override
  String get saturdayPenaltyLabel => 'Saturday (150%)';

  @override
  String get sundayPenaltyLabel => 'Sunday (200%)';

  @override
  String get publicHolidayPenaltyLabel => 'Public Holiday (250%)';

  @override
  String get eveningShiftLabel => 'Evening Shift';

  @override
  String get nightShiftLabel => 'Night Shift';

  @override
  String get overtimeFirst2hLabel => 'First 2 Hours (150%)';

  @override
  String get overtimeAfter2hLabel => 'After 2 Hours (200%)';

  @override
  String rateBelowAwardWarning(String minRate) {
    return 'Rate is below Award minimum ($minRate)';
  }

  @override
  String get saveRatesAction => 'Save Rates';

  @override
  String get requiredField => 'Required';

  @override
  String get invalidValue => 'Invalid';

  @override
  String get automaticInvoiceGenerationTitle => 'Automatic Invoice Generation';

  @override
  String get organizationLabel => 'Organization';

  @override
  String get oneClickGenerationTitle => 'ONE-CLICK GENERATION';

  @override
  String get automaticInvoiceGenerationDesc =>
      'This will automatically generate invoices for all employees and their assigned clients in your organization. No manual selection required.';

  @override
  String get includeExpensesOption => 'Include Expenses';

  @override
  String get includeExpensesOptionDesc => 'Add expense items to invoices';

  @override
  String get applyTaxOption => 'Apply Tax';

  @override
  String get applyTaxOptionDesc => 'Include tax calculations';

  @override
  String get validatePricesOption => 'Validate Prices';

  @override
  String get validatePricesOptionDesc => 'Check prices against NDIS price caps';

  @override
  String get allowPriceCapOverrideOption => 'Allow Price Cap Override';

  @override
  String get allowPriceCapOverrideOptionDesc => 'Allow prices above NDIS caps';

  @override
  String get detailedPricingInfoOption => 'Detailed Pricing Info';

  @override
  String get detailedPricingInfoOptionDesc =>
      'Include comprehensive pricing details';

  @override
  String get noPeriodSelectedText => 'No period selected (using default)';

  @override
  String get allEmployeesOption => 'All Employees';

  @override
  String get selectEmployeesOption => 'Select Employees';

  @override
  String get noEmployeesSelectedText => 'No employees selected';

  @override
  String employeesSelectedCount(String count) {
    return '$count selected';
  }

  @override
  String get chooseEmployeesButton => 'Choose Employees';

  @override
  String get employeesTitle => 'Employees';

  @override
  String get employeeBankDetailsOption => 'Employee Bank Details';

  @override
  String get adminBankDetailsOption => 'Admin Bank Details';

  @override
  String get generatingInvoicesTitle => 'Generating Invoices...';

  @override
  String get generateAllInvoicesButton => 'Generate All Invoices';

  @override
  String get generationCompleteTitle => 'Generation Complete!';

  @override
  String get generationCompleteDesc =>
      'All invoices have been generated successfully.';

  @override
  String get totalEmployeesStat => 'Total Employees';

  @override
  String get totalClientsStat => 'Total Clients';

  @override
  String get validPairsStat => 'Valid Pairs';

  @override
  String get generatedInvoicesStat => 'Generated Invoices';

  @override
  String get generateAgainButton => 'Generate Again';

  @override
  String get generationFailedTitle => 'Generation Failed';

  @override
  String get tryAgainButton => 'Try Again';

  @override
  String get errorOrgIdNotFound => 'Organization ID not found';

  @override
  String get errorSelectAtLeastOneEmployee =>
      'Please select at least one employee';

  @override
  String get errorNegativeTaxRate =>
      'Tax rate cannot be negative when tax is applied';

  @override
  String get errorInvalidDateRange => 'End date must be on or after start date';

  @override
  String get selectEmployeesModalTitle => 'Select Employees';

  @override
  String get confirmSelectionButton => 'Confirm Selection';

  @override
  String invoicesReadyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count invoices ready',
      one: '1 invoice ready',
    );
    return '$_temp0';
  }

  @override
  String get errorPdfFileNotFound => 'PDF file not found';

  @override
  String get chooseEmpAndClientsDesc =>
      'Choose employees and their clients for invoice';

  @override
  String get noEmployeesAvailableDesc =>
      'There are no employees available to select for invoice generation.';

  @override
  String get loadingClientsText => 'Loading clients...';

  @override
  String get noClientsAssignedText => 'No clients assigned to this employee';

  @override
  String get selectClientsHeader => 'SELECT CLIENTS';

  @override
  String get readyToGenerateInvoiceText => 'Ready to generate invoice';

  @override
  String employeeCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'employees',
      one: 'employee',
    );
    return '$_temp0';
  }

  @override
  String clientCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'clients',
      one: 'client',
    );
    return '$_temp0';
  }

  @override
  String get sourceOrganization => 'Organization';

  @override
  String get sourceClientSpecific => 'Client-specific custom price';

  @override
  String get sourceNdisCap => 'NDIS Cap';

  @override
  String get sourceManualOverride => 'Manual override';

  @override
  String get sourceFallback => 'Fallback';

  @override
  String get taxRateHint => '10.0';

  @override
  String get fileTypePdf => 'PDF';

  @override
  String get fileTypeDoc => 'DOC';

  @override
  String get fileTypeImg => 'IMG';

  @override
  String get fileTypeTxt => 'TXT';

  @override
  String get pricingSourceFallback => 'Fallback';

  @override
  String get pricingSourceClientSpecific => 'Client Specific';

  @override
  String get pricingTypeFixed => 'Fixed';

  @override
  String get ndisCapStandard => 'Standard';

  @override
  String get ndisCapHighIntensity => 'High Intensity';

  @override
  String get defaultState => 'NSW';

  @override
  String clientInfoTemplate(String clientName, String clientState) {
    return 'Client: $clientName ($clientState)';
  }

  @override
  String itemInfoTemplate(String itemName, String itemNumber) {
    return '$itemName ($itemNumber)';
  }

  @override
  String get currencySymbol => '\$';

  @override
  String priceDisplay(String symbol, String price) {
    return '$symbol$price';
  }

  @override
  String get requestedInvoiceNotFound =>
      'The requested invoice could not be found.';

  @override
  String get statusInformationTitle => 'Status Information';

  @override
  String get financialSummaryTitle => 'Financial Summary';

  @override
  String get invoiceTypeLabel => 'Invoice Type';

  @override
  String get issueDateLabel => 'Issue Date';

  @override
  String get dueDateLabel => 'Due Date';

  @override
  String get subtotalLabel => 'Subtotal';

  @override
  String get taxAmountLabel => 'Tax Amount';

  @override
  String get totalAmountLabel => 'Total Amount';

  @override
  String get invoiceStatusLabel => 'Invoice Status';

  @override
  String get paymentStatusLabel => 'Payment Status';

  @override
  String get deliveryStatusLabel => 'Delivery Status';

  @override
  String get shareableLinkLabel => 'Shareable Link';

  @override
  String get pdfDocumentLabel => 'PDF Document';

  @override
  String get availableLabel => 'Available';

  @override
  String get viewInvoiceButton => 'View Invoice';

  @override
  String get deleteInvoiceButton => 'Delete Invoice';

  @override
  String get deleteInvoiceConfirmTitle => 'Delete Invoice';

  @override
  String deleteInvoiceConfirmMessage(String number) {
    return 'Are you sure you want to delete invoice $number? This action cannot be undone.';
  }

  @override
  String get deletingInvoiceMessage => 'Deleting invoice...';

  @override
  String get invoiceDeletedSuccess => 'Invoice deleted successfully';

  @override
  String invoiceDeleteError(String error) {
    return 'Failed to delete invoice: $error';
  }

  @override
  String sharingInvoiceMessage(String number) {
    return 'Sharing invoice $number...';
  }

  @override
  String get invoiceSharedSuccess => 'Invoice shared';

  @override
  String loadingInvoiceMessage(String number) {
    return 'Loading invoice $number...';
  }

  @override
  String pdfRegeneratedMessage(String number) {
    return 'PDF regenerated for invoice $number';
  }

  @override
  String get pdfLoadError => 'Failed to load invoice PDF';

  @override
  String pdfViewError(String error) {
    return 'Error viewing invoice: $error';
  }

  @override
  String get actionsTitle => 'Actions';

  @override
  String get nameLabel => 'Name';

  @override
  String get sent => 'Sent';

  @override
  String get invoiceNumberLabel => 'Invoice Number';

  @override
  String get share => 'Share';

  @override
  String get reviewAndOverridePrices => 'Review and Override Prices';

  @override
  String get modifiedLabel => 'MODIFIED';

  @override
  String get noDescriptionAvailable => 'No description available';

  @override
  String get resetPriceTooltip => 'Reset Price';

  @override
  String get scheduleLabel => 'Schedule';

  @override
  String get pricingScopeLabel => 'Pricing Scope';

  @override
  String get clientSpecificRateLabel => 'Client-Specific Rate';

  @override
  String get orgWideRateLabel => 'Organization-Wide Rate';

  @override
  String get enterNewPriceHint => 'Enter new price';

  @override
  String get lineTotalLabel => 'Line Total';

  @override
  String wasPriceLabel(String price) {
    return 'Was: $price';
  }

  @override
  String maximumPriceLabel(String price) {
    return 'Maximum: $price';
  }

  @override
  String get exceedsCapWarning => 'Exceeds cap!';

  @override
  String errorLoadingLineItems(String error) {
    return 'Error loading line items: $error';
  }

  @override
  String get missingUserContext => 'Missing user context: userEmail';

  @override
  String get invalidPriceEntered => 'Invalid price entered';

  @override
  String get persistenceConfirmationFailed => 'Persistence confirmation failed';

  @override
  String failedToApplyOverrides(int count) {
    return 'Failed to apply $count override(s).';
  }

  @override
  String priceOverridesAppliedMessage(int count) {
    return 'Price overrides applied for $count item(s)';
  }

  @override
  String get noDate => 'No date';

  @override
  String get saveFailed => 'Save failed';

  @override
  String get overridePriceLabel => 'Override Price';

  @override
  String get sourceCustom => 'Custom';

  @override
  String get fetchingOrgDataStep => 'Fetching organization data...';

  @override
  String get fetchingEmployeesStep => 'Fetching employees...';

  @override
  String get fetchingClientsStep => 'Fetching clients...';

  @override
  String get buildingRelationshipsStep =>
      'Building employee-client relationships...';

  @override
  String processingEmployeeStep(String name) {
    return 'Processing employee: $name';
  }

  @override
  String get generatingInvoicesStep => 'Generating invoices...';

  @override
  String get generationCompletedStep => 'Invoice generation completed';

  @override
  String get errorOccurredStep => 'Error occurred';

  @override
  String failedToFetchEmployeesError(String error) {
    return 'Failed to fetch employees: $error';
  }

  @override
  String get noEmployeesFoundError =>
      'No employees found for this organization';

  @override
  String get noSelectedEmployeesError =>
      'No selected employees found to generate invoices';

  @override
  String get noClientsFoundError => 'No clients found for this organization';

  @override
  String get noValidRelationshipsError =>
      'No valid employee-client relationships found';

  @override
  String failedToGetAssignmentsLog(String email, String error) {
    return 'Failed to get assignments for $email: $error';
  }

  @override
  String noAssignmentsFoundLog(String email) {
    return 'No assignments found for employee: $email';
  }

  @override
  String get endDateBeforeStartDateError =>
      'End date must be on or after start date';

  @override
  String get periodExceedsLimitError =>
      'Selected period cannot exceed 3 months';

  @override
  String get futureEndDateError => 'End date cannot be in the future';

  @override
  String get taxRateNegativeError =>
      'Tax rate cannot be negative when tax is applied';

  @override
  String get invoiceTypeRequiredError => 'Invoice type must be selected';

  @override
  String get bankDetailsRequiredError =>
      'Bank details are missing for both employee and admin. Please add bank details before generating invoices.';

  @override
  String get webEncryptionLimitationError =>
      'Error generating invoices: Web platform limitation with encryption. Please use the mobile or desktop app for this feature.';

  @override
  String get noValidClientsError =>
      'No valid clients found for invoice generation';

  @override
  String get noAssignedClientsError =>
      'No assigned clients found. Please check your assignments.';

  @override
  String errorRetrievingClientData(Object error) {
    return 'Error retrieving client data: $error';
  }

  @override
  String errorRetrievingInvoiceData(Object error) {
    return 'Error retrieving invoice data: $error';
  }

  @override
  String errorProcessingInvoiceData(Object error) {
    return 'Error processing invoice data: $error';
  }

  @override
  String get invoiceGenerationCancelled =>
      'Invoice generation cancelled by user';

  @override
  String errorProcessingLineItem(Object error, Object name) {
    return 'Error processing line item for $name: $error';
  }

  @override
  String failedToProcessValidationSummary(Object error) {
    return 'Failed to process validation summary: $error';
  }

  @override
  String get unknownValidationError => 'Unknown validation error';

  @override
  String validationFailed(Object error) {
    return 'Validation failed: $error';
  }

  @override
  String get noItemsToValidate => 'No items to validate';

  @override
  String invalidAssignmentsStructure(Object email) {
    return 'Invalid assignments data structure for $email';
  }

  @override
  String failedToGetAssignments(Object error) {
    return 'Failed to get assignments: $error';
  }

  @override
  String errorRetrievingAssignments(Object email, Object error) {
    return 'Error retrieving assignments for $email: $error';
  }

  @override
  String noAssignmentFoundForClient(Object id, Object name) {
    return 'No assignment found for client $name ($id)';
  }

  @override
  String errorProcessingClient(Object error) {
    return 'Error processing client: $error';
  }

  @override
  String get noClientsProcessedError =>
      'No clients could be processed. Please check assignments and try again.';

  @override
  String get noOrganizationIdAvailable => 'No organization ID available';

  @override
  String errorFetchingWorkedTime(Object error) {
    return 'Error fetching worked time: $error';
  }

  @override
  String errorSendingInvoiceEmail(Object error) {
    return 'Error sending invoice email: $error';
  }

  @override
  String get organizationIdRequiredError =>
      'Cannot save invoices: organizationId is null or empty';

  @override
  String get noInvoicesToSave => 'No invoices to save';

  @override
  String failedToSaveInvoice(Object error, Object name) {
    return 'Failed to save invoice for client: $name, error: $error';
  }

  @override
  String get sourceOrganizationWide => 'Organization-wide custom price';

  @override
  String get sourceStandardRate => 'Standard price';

  @override
  String get sourceFallbackBaseRate => 'Organization fallback base rate';

  @override
  String get sourceManualEntry => 'Manual price entry';

  @override
  String get complianceStatusUnknown => 'unknown';

  @override
  String get validationSourceService => 'price_validation_service';

  @override
  String get defaultUnit => 'unit';

  @override
  String get unknownItem => 'Unknown Item';

  @override
  String get personalCareAssistance => 'Personal Care Assistance';

  @override
  String get providerNamePlaceholder => 'Provider Name';

  @override
  String completedWithErrors(Object count) {
    return 'Completed with $count errors';
  }

  @override
  String savedCustomPrices(Object count) {
    return 'Successfully saved $count custom prices';
  }

  @override
  String get requestsTitle => 'Requests';

  @override
  String get createRequest => 'Create Request';

  @override
  String get newRequest => 'New Request';

  @override
  String get requestTypeShift => 'Shift';

  @override
  String get requestTypeTimeOff => 'Time Off';

  @override
  String get requestTypeShiftExchange => 'Shift Exchange';

  @override
  String get shiftRequestSubtitle => 'New shift request';

  @override
  String get timeOffRequestSubtitle => 'Request leave';

  @override
  String get shiftExchangeSubtitle => 'Swap or offer shifts';

  @override
  String get statusApproved => 'Approved';

  @override
  String get searchRequestsHint => 'Search requests...';

  @override
  String get selectDateRange => 'Select Date Range';

  @override
  String get noRequestsFound => 'No requests found';

  @override
  String get noRequestsMessage => 'Create a new request to get started.';

  @override
  String get noMatchingRequests => 'No matching requests';

  @override
  String get noMatchingRequestsMessage => 'Try adjusting your filters.';

  @override
  String requestError(String error) {
    return 'Error: $error';
  }

  @override
  String get endDateBeforeStartDate => 'End date cannot be before start date';

  @override
  String get leaveTypeLabel => 'Leave Type';

  @override
  String get errorLoadingTypes => 'Error loading types';

  @override
  String get reasonHint => 'Reason for leave...';

  @override
  String get submitRequest => 'Submit Request';

  @override
  String get endTimeBeforeStartTime => 'End time cannot be before start time';

  @override
  String get addShift => 'Add shift';

  @override
  String get errorLoadingRoles => 'Error loading roles';

  @override
  String get noteLabel => 'Note';

  @override
  String get typeNoteHint => 'Type your note here...';

  @override
  String get requestApprovalInfo =>
      'All requests will be sent for a manager\'s approval';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String get createButton => 'Create';

  @override
  String get allShifts => 'All Shifts';

  @override
  String get statusPendingShift => 'Pending';

  @override
  String get statusApprovedShift => 'Approved';

  @override
  String get statusCompletedShift => 'Completed';

  @override
  String get failedToLoadShifts => 'Failed to Load Shifts';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get noShiftsScheduled => 'No Shifts Scheduled';

  @override
  String get createShiftToStart => 'Create a new shift to get started';

  @override
  String get createShift => 'Create Shift';

  @override
  String get noClient => 'No Client';

  @override
  String get unassigned => 'Unassigned';

  @override
  String get shiftAssignedSuccessfully => 'Shift assigned successfully';

  @override
  String get failedToAssignShift => 'Failed to assign shift';

  @override
  String get failedToCreateShift => 'Failed to create shift';

  @override
  String get createNewShift => 'Create New Shift';

  @override
  String get clientEmailLabel => 'Client Email';

  @override
  String get dateTimeLabel => 'Date & Time';

  @override
  String get notesLabel => 'Notes';

  @override
  String get additionalDetailsHint => 'Additional details...';

  @override
  String get smartAssign => 'Smart Assign';

  @override
  String get failedToLoadRecommendations => 'Failed to load recommendations';

  @override
  String errorLoadingRecommendations(String error) {
    return 'Error loading recommendations: $error';
  }

  @override
  String get noAvailableEmployees => 'No Available Employees';

  @override
  String get allEmployeesConflict =>
      'All employees have conflicts during this time slot';

  @override
  String get assigning => 'Assigning...';

  @override
  String get assignButton => 'Assign';

  @override
  String get scheduleAssignmentTitle => 'Schedule Assignment';

  @override
  String get assignmentDetails => 'Assignment Details';

  @override
  String get assignmentDetailsSubtitle =>
      'Review the details of the assignment below';

  @override
  String get scheduleConfiguration => 'Schedule Configuration';

  @override
  String get scheduleConfigurationSubtitle =>
      'Set the date, time, and other details';

  @override
  String get appointmentDateLabel => 'Appointment Date';

  @override
  String get breakDurationLabel => 'Break Duration';

  @override
  String get ndisServiceItemLabel => 'NDIS Service Item';

  @override
  String get selectNdisServiceItem => 'Select NDIS Service Item';

  @override
  String get changeNdisItem => 'Change NDIS Item';

  @override
  String get selectNdisItem => 'Please select an NDIS Service Item';

  @override
  String customPrice(String price) {
    return 'Custom Price: \$$price';
  }

  @override
  String get highIntensityCare => 'High Intensity Care';

  @override
  String addedOn(String date) {
    return 'Added on $date';
  }

  @override
  String get breakAllowed => 'Break Allowed';

  @override
  String get highIntensity => 'High Intensity';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select';

  @override
  String get addedSchedules => 'Added Schedules';

  @override
  String get noSchedulesAdded => 'No schedules added yet';

  @override
  String get noSchedulesMessage =>
      'Create your first schedule to get started with assignment management';

  @override
  String get validationErrors => 'Validation Errors';

  @override
  String get addSchedule => 'Add Schedule';

  @override
  String get submitAssignment => 'Submit Assignment';

  @override
  String get validationError => 'Validation Error';

  @override
  String get successTitle => 'Success';

  @override
  String get errorTitle => 'Error';

  @override
  String get yesOption => 'Yes';

  @override
  String get noOption => 'No';

  @override
  String get cannotSchedulePast => 'Cannot schedule appointments in the past';

  @override
  String get startBeforeEnd => 'Start time must be before end time';

  @override
  String get minimumDuration30 => 'Minimum appointment duration is 30 minutes';

  @override
  String get timeConflictExisting =>
      'Time conflict with existing schedule on this date';

  @override
  String get addAtLeastOne => 'Please add at least one schedule';

  @override
  String get scheduleDataInconsistent =>
      'Schedule data is inconsistent. Please refresh and try again.';

  @override
  String scheduleError(String number, String error) {
    return 'Schedule $number: $error';
  }

  @override
  String timeConflictBetween(String schedule1, String schedule2, String date) {
    return 'Time conflict between schedules $schedule1 and $schedule2 on $date';
  }

  @override
  String get dateCannotBePast => 'Date cannot be in the past';

  @override
  String get invalidScheduleData => 'Invalid schedule data format';

  @override
  String get invalidTimeFormat => 'Invalid time format';

  @override
  String get minimumDuration => 'Minimum duration is 30 minutes';

  @override
  String get timeValidationError => 'Time validation error';

  @override
  String get ndisItemRequired => 'NDIS Service Item is required';

  @override
  String get startTimeLabel => 'Start Time';

  @override
  String get endTimeLabel => 'End Time';

  @override
  String get apiSecurity => 'API Security';

  @override
  String get realTimeTooltip => 'Real-time';

  @override
  String get reloadAllTooltip => 'Reload All';

  @override
  String get totalApiCalls => 'Total API Calls';

  @override
  String get avgResponseTime => 'Avg Response Time';

  @override
  String get activeUsers => 'Active Users';

  @override
  String get securityStatus => 'Security Status';

  @override
  String get blockedIpAddresses => 'Blocked IP Addresses';

  @override
  String ipsCurrentlyBlocked(String count) {
    return '$count IPs currently blocked';
  }

  @override
  String get failedAttempts => 'Failed Attempts';

  @override
  String recentFailedAttempts(String count) {
    return '$count recent failed attempts';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String expiresDetailLabel(String date) {
    return 'Expires: $date';
  }

  @override
  String get unblockThisIp => 'Unblock this IP';

  @override
  String get topEndpoints => 'Top Endpoints';

  @override
  String calls(String count, String avgTime) {
    return 'Calls: $count • Avg: ${avgTime}ms';
  }

  @override
  String get topUsers => 'Top Users';

  @override
  String callsAndLast(String calls, String lastActivity) {
    return 'Calls: $calls • Last: $lastActivity';
  }

  @override
  String get rateLimit => 'Rate Limit';

  @override
  String get noRateLimitConfig => 'No rate limit configuration data';

  @override
  String get rateLimitedUsers => 'Rate-limited Users (by IP)';

  @override
  String entries(String count) {
    return '$count entries';
  }

  @override
  String get resetAll => 'Reset All';

  @override
  String get noRateLimitedUsers => 'No users are currently rate limited';

  @override
  String attempts(String count) {
    return 'Attempts: $count';
  }

  @override
  String last(String date) {
    return 'Last: $date';
  }

  @override
  String blockedUntil(String date) {
    return 'Blocked until: $date';
  }

  @override
  String get activeConnections => 'Active Connections';

  @override
  String get noActiveConnections => 'No active connections';

  @override
  String connected(String time) {
    return 'Connected: $time';
  }

  @override
  String get liveSse => 'Live (SSE)';

  @override
  String get organizationIdNotAvailable => 'Organization ID not available';

  @override
  String get requestFailed => 'Request failed';

  @override
  String failedToLoadApiUsage(String error) {
    return 'Failed to load API usage data: $error';
  }

  @override
  String liveStreamUnavailable(String statusCode) {
    return 'Live stream unavailable ($statusCode)';
  }

  @override
  String ipUnblockedSuccess(String ip) {
    return 'IP address $ip unblocked successfully';
  }

  @override
  String failedToUnblockIp(String message) {
    return 'Failed to unblock IP: $message';
  }

  @override
  String errorUnblockingIp(String error) {
    return 'Error unblocking IP: $error';
  }

  @override
  String rateLimitResetFor(String ip) {
    return 'Rate limit reset for $ip';
  }

  @override
  String failedToResetRateLimit(String message) {
    return 'Failed to reset rate limit: $message';
  }

  @override
  String errorResettingRateLimit(String error) {
    return 'Error resetting rate limit: $error';
  }

  @override
  String get allRateLimitsReset => 'All rate limits reset';

  @override
  String failedToResetAll(String message) {
    return 'Failed to reset all: $message';
  }

  @override
  String errorResettingAll(String error) {
    return 'Error resetting all: $error';
  }

  @override
  String requestsPerMinutes(String max, String minutes) {
    return '$max requests per $minutes minutes';
  }

  @override
  String get versionLabel => 'Version';

  @override
  String versionWithBuild(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get dateFormatInfoMessage =>
      'Choose how to interpret ambiguous numeric dates (e.g., 1/2/2025).';

  @override
  String get formatOptions => 'FORMAT OPTIONS';

  @override
  String get monthDayYearUs => 'Month/Day/Year (US)';

  @override
  String get monthDayYearExample => 'Example: 1/2/2025 → January 2, 2025';

  @override
  String get dayMonthYear => 'Day/Month/Year';

  @override
  String get dayMonthYearExample => 'Example: 1/2/2025 → February 1, 2025';

  @override
  String get dateFormatSaved => 'Date format preference saved';

  @override
  String get dateFormatAppBarTitle => 'Date Format';

  @override
  String get themeAppBarTitle => 'THEME';

  @override
  String get themeInfoMessage => 'Choose your preferred appearance mode.';

  @override
  String get appearance => 'APPEARANCE';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get systemDefault => 'System Default';

  @override
  String get timesheetTitle => 'Timesheet';

  @override
  String get moreLabel => 'More';

  @override
  String get historyTitle => 'History';

  @override
  String get noHistoryTitle => 'No History';

  @override
  String get noHistorySubtitle => 'No timesheet history found';

  @override
  String shiftsCount(int count) {
    return '$count Shifts';
  }

  @override
  String get viewDetailsButton => 'VIEW DETAILS';

  @override
  String get trainingComplianceTitle => 'Training & Compliance';

  @override
  String get certificationsTitle => 'Certifications';

  @override
  String get certificationsSubtitle => 'Upload and manage your certifications';

  @override
  String get trainingModulesTitle => 'Training Modules';

  @override
  String get trainingModulesSubtitle => 'Complete mandatory training';

  @override
  String get complianceChecklistsTitle => 'Compliance Checklists';

  @override
  String get complianceChecklistsSubtitle =>
      'Daily and weekly compliance checks';

  @override
  String get uploadButton => 'Upload';

  @override
  String get noCertificationsMessage =>
      'No certifications found.\nUpload one to get started.';

  @override
  String issuerLabel(String issuer) {
    return 'Issuer: $issuer';
  }

  @override
  String expiresLabel(String date) {
    return 'Expires: $date';
  }

  @override
  String notesDetailLabel(String notes) {
    return 'Notes: $notes';
  }

  @override
  String get uploadCertificationTitle => 'Upload Certification';

  @override
  String get certificationNameLabel => 'Certification Name';

  @override
  String get issuerFieldLabel => 'Issuer';

  @override
  String get requiredValidation => 'Required';

  @override
  String get selectExpiryDate => 'Select Expiry Date';

  @override
  String get selectFile => 'Select File (PDF, JPG, PNG)';

  @override
  String get notesOptionalLabel => 'Notes (Optional)';

  @override
  String get uploadButtonAction => 'Upload';

  @override
  String get selectExpiryDateError => 'Please select expiry date';

  @override
  String get selectFileError => 'Please select a file';

  @override
  String get noTrainingModulesMessage => 'No training modules available.';

  @override
  String get reviewButton => 'Review';

  @override
  String get startButton => 'Start';

  @override
  String contentLabel(String type) {
    return 'Content: $type';
  }

  @override
  String linkLabel(String url) {
    return 'Link: $url';
  }

  @override
  String get markAsCompletedButton => 'Mark as Completed';

  @override
  String get noChecklistsMessage => 'No checklists available.';

  @override
  String get viewButton => 'View';

  @override
  String get startChecklistButton => 'Start Checklist';

  @override
  String get saveProgressButton => 'Save Progress';

  @override
  String get manageChecklistsTitle => 'Manage Checklists';

  @override
  String get addChecklistButton => 'Add Checklist';

  @override
  String get noChecklistsFound => 'No checklists found.';

  @override
  String get addChecklistTitle => 'Add Checklist';

  @override
  String get titleLabel => 'Title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get itemsLabel => 'Items';

  @override
  String itemNumberLabel(int number) {
    return 'Item $number';
  }

  @override
  String get addItemButton => 'Add Item';

  @override
  String get manageTrainingTitle => 'Manage Training';

  @override
  String get addModuleButton => 'Add Module';

  @override
  String get noModulesFound => 'No modules found.';

  @override
  String get addModuleTitle => 'Add Training Module';

  @override
  String get contentTypeLabel => 'Content Type';

  @override
  String get contentUrlLabel => 'Content URL';

  @override
  String get durationMinutesLabel => 'Duration (minutes)';

  @override
  String get isMandatoryLabel => 'Is Mandatory';

  @override
  String get certificationAuditTitle => 'Certification Audit';

  @override
  String get allCertificationsTitle => 'All Certifications';

  @override
  String get noCertificationsFound => 'No certifications found.';

  @override
  String get activeStatus => 'Active';

  @override
  String get expiredStatus => 'Expired';

  @override
  String get expiringSoonStatus => 'Expiring Soon';

  @override
  String get videoType => 'Video';

  @override
  String get articleType => 'Article';

  @override
  String get completedStatus => 'Completed';

  @override
  String get inProgressStatus => 'In Progress';

  @override
  String get notStartedStatus => 'Not Started';

  @override
  String get newRequestTitle => 'New Request';

  @override
  String get selectDateRangeLabel => 'Select Date Range';

  @override
  String get totalHoursEstimatedLabel => 'Total Hours (Estimated)';

  @override
  String get submitRequestButton => 'Submit Request';

  @override
  String get selectLeaveTypeHint => 'Select leave type';

  @override
  String get datesLabel => 'Dates';

  @override
  String get currentBalances => 'Current Balances';

  @override
  String get quickCaptureTitle => 'QUICK CAPTURE';

  @override
  String get receiptScanned => 'Receipt Scanned!';

  @override
  String receiptDetected(String amount, String category) {
    return 'We detected: \$$amount - $category';
  }

  @override
  String get confirmAndEdit => 'CONFIRM & EDIT';

  @override
  String get retake => 'RETAKE';

  @override
  String get capturedReceipt => 'Captured Receipt';

  @override
  String get offlineSyncTitle => 'OFFLINE SYNC';

  @override
  String get offlineStatus => 'STATUS: OFFLINE';

  @override
  String lastSyncedTimeAgo(String timeAgo) {
    return 'Last synced: $timeAgo';
  }

  @override
  String get pendingUploads => 'PENDING UPLOADS';

  @override
  String get synced => 'Synced';

  @override
  String get complianceAuditTitle => 'COMPLIANCE AUDIT';

  @override
  String get overallScore => 'OVERALL SCORE';

  @override
  String get attentionRequired => 'ATTENTION REQUIRED';

  @override
  String get allDocumentsUpToDate => 'All documents are up to date.';

  @override
  String get expiredCaps => 'EXPIRED';

  @override
  String get multiOrgRollupTitle => 'MULTI-ORG ROLLUP';

  @override
  String get unknownOrg => 'Unknown Org';

  @override
  String get clientsCaps => 'CLIENTS';

  @override
  String get invoicesCaps => 'INVOICES';

  @override
  String get revenueCaps => 'REVENUE';

  @override
  String get roleManagementTitle => 'ROLE MANAGEMENT';

  @override
  String get accessGranted => 'Access Granted';

  @override
  String get accessDenied => 'Access Denied';

  @override
  String get saveChangesCaps => 'SAVE CHANGES';

  @override
  String get permissionsUpdated => 'Permissions Updated Successfully';

  @override
  String get workerDashboardTitle => 'WORKER DASHBOARD';

  @override
  String get nextShiftCaps => 'NEXT SHIFT';

  @override
  String get actionsCaps => 'ACTIONS';

  @override
  String get recentExpensesCaps => 'RECENT EXPENSES';

  @override
  String get noRecentExpenses => 'No recent expenses';

  @override
  String get noUpcomingShifts => 'No upcoming shifts';

  @override
  String get ruleNdisPriceCapValidationName => 'NDIS Price Cap Validation';

  @override
  String get ruleNdisPriceCapValidationDescription =>
      'Ensures prices do not exceed NDIS price guide limits';

  @override
  String get ruleMinimumRateValidationName => 'Minimum Rate Validation';

  @override
  String get ruleMinimumRateValidationDescription =>
      'Validates minimum hourly rates for different service types';

  @override
  String get ruleGeographicLoadingName => 'Geographic Loading Rules';

  @override
  String get ruleGeographicLoadingDescription =>
      'Applies geographic loading based on service location';

  @override
  String get integrationNdisPriceGuideApiName => 'NDIS Price Guide API';

  @override
  String get integrationNdisPriceGuideApiDescription =>
      'Automatic synchronization with NDIS price guide updates';

  @override
  String get integrationAccountingSystemName => 'Accounting System';

  @override
  String get integrationAccountingSystemDescription =>
      'Integration with external accounting software';

  @override
  String get integrationCrmSystemName => 'CRM System';

  @override
  String get integrationCrmSystemDescription =>
      'Customer relationship management system integration';

  @override
  String failedLoadFallbackBaseRate(String error) {
    return 'Failed to load fallback base rate: $error';
  }

  @override
  String get failedUpdateFallbackBaseRate =>
      'Failed to update fallback base rate';

  @override
  String errorUpdatingFallbackBaseRate(String error) {
    return 'Error updating fallback base rate: $error';
  }

  @override
  String get supportCoordinationCategory => 'Support Coordination';

  @override
  String get unitHour => 'Hour';

  @override
  String get unitDay => 'Day';

  @override
  String get unitWeek => 'Week';

  @override
  String get unitMonth => 'Month';

  @override
  String get unitEach => 'Each';

  @override
  String get unitKilometer => 'Kilometer';

  @override
  String get deleteSelectedAction => 'Delete selected';

  @override
  String get ndisItemCardSemantics => 'NDIS item card';

  @override
  String perUnit(String unit) {
    return 'per $unit';
  }

  @override
  String get enterItemCodeError => 'Please enter item code';

  @override
  String get enterItemNameError => 'Please enter item name';

  @override
  String get enterUnitPriceError => 'Please enter unit price';

  @override
  String get ndisItemCreatedSuccess => 'NDIS item created successfully!';

  @override
  String get ndisItemUpdatedSuccess => 'NDIS item updated successfully!';

  @override
  String get itemStatusActivated => 'activated';

  @override
  String get itemStatusDeactivated => 'deactivated';

  @override
  String itemStatusChanged(String status) {
    return 'Item $status successfully!';
  }

  @override
  String get deleteItemTitle => 'Delete Item';

  @override
  String deleteItemConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get itemDeletedSuccess => 'Item deleted successfully!';

  @override
  String get deleteSelectedItemsTitle => 'Delete Selected Items';

  @override
  String deleteSelectedItemsConfirm(String count) {
    return 'Are you sure you want to delete $count selected items?';
  }

  @override
  String get selectedItemsDeletedSuccess =>
      'Selected items deleted successfully!';
}
