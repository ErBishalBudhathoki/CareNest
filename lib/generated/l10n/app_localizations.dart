import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @abnHint.
  ///
  /// In en, this message translates to:
  /// **'ABN (11 digits)'**
  String get abnHint;

  /// No description provided for @abnInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 11-digit ABN'**
  String get abnInvalid;

  /// No description provided for @abnLabel.
  ///
  /// In en, this message translates to:
  /// **'ABN'**
  String get abnLabel;

  /// No description provided for @absenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Absence'**
  String get absenceLabel;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get accessDenied;

  /// No description provided for @accessGranted.
  ///
  /// In en, this message translates to:
  /// **'Access Granted'**
  String get accessGranted;

  /// No description provided for @accountNoLabel.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT NO.'**
  String get accountNoLabel;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @accountTypeSection.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountTypeSection;

  /// No description provided for @actionsCaps.
  ///
  /// In en, this message translates to:
  /// **'ACTIONS'**
  String get actionsCaps;

  /// No description provided for @actionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsLabel;

  /// No description provided for @actionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actionsTitle;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @activeBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Active Businesses'**
  String get activeBusinesses;

  /// No description provided for @activeCaps.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get activeCaps;

  /// No description provided for @activeConnections.
  ///
  /// In en, this message translates to:
  /// **'Active Connections'**
  String get activeConnections;

  /// No description provided for @activeItems.
  ///
  /// In en, this message translates to:
  /// **'Active Items'**
  String get activeItems;

  /// No description provided for @activeLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeLabel;

  /// No description provided for @activeMetrics.
  ///
  /// In en, this message translates to:
  /// **'{count} active metrics'**
  String activeMetrics(int count);

  /// No description provided for @activeMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'{count} active metrics'**
  String activeMetricsTitle(String count);

  /// No description provided for @activeRates.
  ///
  /// In en, this message translates to:
  /// **'Active Rates'**
  String get activeRates;

  /// No description provided for @activeRatesLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Rates'**
  String get activeRatesLabel;

  /// No description provided for @activeRatesStat.
  ///
  /// In en, this message translates to:
  /// **'Active Rates'**
  String get activeRatesStat;

  /// No description provided for @activeRatesStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Rates'**
  String get activeRatesStatLabel;

  /// No description provided for @activeRatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'3 urgent'**
  String get activeRatesSubtitle;

  /// No description provided for @activeRules.
  ///
  /// In en, this message translates to:
  /// **'Active Rules'**
  String get activeRules;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeStatus;

  /// No description provided for @activeUsers.
  ///
  /// In en, this message translates to:
  /// **'Active Users'**
  String get activeUsers;

  /// No description provided for @addAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one schedule'**
  String get addAtLeastOne;

  /// No description provided for @addBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Your Bank Details'**
  String get addBankDetails;

  /// No description provided for @addBusiness.
  ///
  /// In en, this message translates to:
  /// **'Add Business'**
  String get addBusiness;

  /// No description provided for @addBusinessButton.
  ///
  /// In en, this message translates to:
  /// **'Add Business'**
  String get addBusinessButton;

  /// No description provided for @addBusinessDesc.
  ///
  /// In en, this message translates to:
  /// **'Add business information to get started'**
  String get addBusinessDesc;

  /// No description provided for @addBusinessTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Business'**
  String get addBusinessTitle;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @addChecklistButton.
  ///
  /// In en, this message translates to:
  /// **'Add Checklist'**
  String get addChecklistButton;

  /// No description provided for @addChecklistTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Checklist'**
  String get addChecklistTitle;

  /// No description provided for @addClient.
  ///
  /// In en, this message translates to:
  /// **'Add Client'**
  String get addClient;

  /// No description provided for @addClientBaseRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Client Base Rate – {clientName}'**
  String addClientBaseRateTitle(Object clientName);

  /// No description provided for @addClientButton.
  ///
  /// In en, this message translates to:
  /// **'Add Client'**
  String get addClientButton;

  /// No description provided for @addClientDesc.
  ///
  /// In en, this message translates to:
  /// **'Add client information to get started'**
  String get addClientDesc;

  /// No description provided for @addClientRateButton.
  ///
  /// In en, this message translates to:
  /// **'Add Client Rate'**
  String get addClientRateButton;

  /// No description provided for @addedOn.
  ///
  /// In en, this message translates to:
  /// **'Added on {date}'**
  String addedOn(String date);

  /// No description provided for @addedSchedules.
  ///
  /// In en, this message translates to:
  /// **'Added Schedules'**
  String get addedSchedules;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @addExpenseItemsToInvoices.
  ///
  /// In en, this message translates to:
  /// **'Add expense items to invoices'**
  String get addExpenseItemsToInvoices;

  /// No description provided for @addExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Expense'**
  String get addExpenseTitle;

  /// No description provided for @addExpenseToView.
  ///
  /// In en, this message translates to:
  /// **'Add expenses to view dashboard statistics'**
  String get addExpenseToView;

  /// No description provided for @addFilesButton.
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get addFilesButton;

  /// No description provided for @addFilesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to select files or drag and drop'**
  String get addFilesSubtitle;

  /// No description provided for @addFilesTitle.
  ///
  /// In en, this message translates to:
  /// **'ADD FILES'**
  String get addFilesTitle;

  /// No description provided for @addHoliday.
  ///
  /// In en, this message translates to:
  /// **'Add Holiday'**
  String get addHoliday;

  /// No description provided for @addingBusiness.
  ///
  /// In en, this message translates to:
  /// **'Adding business...'**
  String get addingBusiness;

  /// No description provided for @addingBusinessMessage.
  ///
  /// In en, this message translates to:
  /// **'Adding business...'**
  String get addingBusinessMessage;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @addItemAction.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItemAction;

  /// No description provided for @addItemButton.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItemButton;

  /// No description provided for @additionalDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Additional details...'**
  String get additionalDetailsHint;

  /// No description provided for @additionalFilesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Attach documents, receipts, or other files'**
  String get additionalFilesSubtitle;

  /// No description provided for @additionalFilesTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Files'**
  String get additionalFilesTitle;

  /// No description provided for @addModuleButton.
  ///
  /// In en, this message translates to:
  /// **'Add Module'**
  String get addModuleButton;

  /// No description provided for @addModuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Training Module'**
  String get addModuleTitle;

  /// No description provided for @addNewExpense.
  ///
  /// In en, this message translates to:
  /// **'Add New Expense'**
  String get addNewExpense;

  /// No description provided for @addNewHoliday.
  ///
  /// In en, this message translates to:
  /// **'Add New Holiday'**
  String get addNewHoliday;

  /// No description provided for @addNewItem.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get addNewItem;

  /// No description provided for @addNewNdisItem.
  ///
  /// In en, this message translates to:
  /// **'Add New NDIS Item'**
  String get addNewNdisItem;

  /// No description provided for @addNewNdisItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New NDIS Item'**
  String get addNewNdisItemTitle;

  /// No description provided for @addNewRateAction.
  ///
  /// In en, this message translates to:
  /// **'Add New Rate'**
  String get addNewRateAction;

  /// No description provided for @addNewRateFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Create a new service rate configuration. This feature will be fully implemented in the next update.'**
  String get addNewRateFeatureComingSoon;

  /// No description provided for @addNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Add a new request'**
  String get addNewRequest;

  /// No description provided for @addNewServiceRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Service Rate'**
  String get addNewServiceRateTitle;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get addNote;

  /// No description provided for @addNotes.
  ///
  /// In en, this message translates to:
  /// **'Add Notes'**
  String get addNotes;

  /// No description provided for @addOrgBaseRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Organization Base Rate'**
  String get addOrgBaseRateTitle;

  /// No description provided for @addOrgRateButton.
  ///
  /// In en, this message translates to:
  /// **'Add Org Rate'**
  String get addOrgRateButton;

  /// No description provided for @addPricingRuleDialog.
  ///
  /// In en, this message translates to:
  /// **'Add new pricing rule dialog would open here'**
  String get addPricingRuleDialog;

  /// No description provided for @addRateAction.
  ///
  /// In en, this message translates to:
  /// **'Add Rate'**
  String get addRateAction;

  /// No description provided for @addRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create pricing rule'**
  String get addRateSubtitle;

  /// No description provided for @addressInformation.
  ///
  /// In en, this message translates to:
  /// **'Address Information'**
  String get addressInformation;

  /// No description provided for @addressLine1.
  ///
  /// In en, this message translates to:
  /// **'ADDRESS LINE 1'**
  String get addressLine1;

  /// No description provided for @addRule.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRule;

  /// No description provided for @addRuleAction.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRuleAction;

  /// No description provided for @addSchedule.
  ///
  /// In en, this message translates to:
  /// **'Add Schedule'**
  String get addSchedule;

  /// No description provided for @addShift.
  ///
  /// In en, this message translates to:
  /// **'Add shift'**
  String get addShift;

  /// No description provided for @addShiftRequest.
  ///
  /// In en, this message translates to:
  /// **'Add a shift request'**
  String get addShiftRequest;

  /// No description provided for @addShiftTitle.
  ///
  /// In en, this message translates to:
  /// **'Add shift'**
  String get addShiftTitle;

  /// No description provided for @addTimeOffRequest.
  ///
  /// In en, this message translates to:
  /// **'Add a time off request'**
  String get addTimeOffRequest;

  /// No description provided for @adminAccessRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Only admins can access this feature.'**
  String get adminAccessRequiredMessage;

  /// No description provided for @adminAccessRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Access Required'**
  String get adminAccessRequiredTitle;

  /// No description provided for @adminActive.
  ///
  /// In en, this message translates to:
  /// **'Admin Active'**
  String get adminActive;

  /// No description provided for @adminBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Admin Bank Details'**
  String get adminBankDetails;

  /// No description provided for @adminBankDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Use admin bank details (invoices created by admin only)'**
  String get adminBankDetailsDesc;

  /// No description provided for @adminBankDetailsOption.
  ///
  /// In en, this message translates to:
  /// **'Admin Bank Details'**
  String get adminBankDetailsOption;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboard;

  /// No description provided for @adminDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage organization and app'**
  String get adminDashboardSubtitle;

  /// No description provided for @administrator.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get administrator;

  /// No description provided for @administratorDesc.
  ///
  /// In en, this message translates to:
  /// **'Full access and organization management'**
  String get administratorDesc;

  /// No description provided for @adminOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get adminOptionSubtitle;

  /// No description provided for @adminOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminOptionTitle;

  /// No description provided for @adminTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminTitle;

  /// No description provided for @advancedConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Advanced Configuration'**
  String get advancedConfiguration;

  /// No description provided for @advancedTab.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advancedTab;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCategories;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up! New notifications will appear here.'**
  String get allCaughtUp;

  /// No description provided for @allCertificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'All Certifications'**
  String get allCertificationsTitle;

  /// No description provided for @allDocumentsUpToDate.
  ///
  /// In en, this message translates to:
  /// **'All documents are up to date.'**
  String get allDocumentsUpToDate;

  /// No description provided for @allEmployees.
  ///
  /// In en, this message translates to:
  /// **'All Employees'**
  String get allEmployees;

  /// No description provided for @allEmployeesConflict.
  ///
  /// In en, this message translates to:
  /// **'All employees have conflicts during this time slot'**
  String get allEmployeesConflict;

  /// No description provided for @allEmployeesOption.
  ///
  /// In en, this message translates to:
  /// **'All Employees'**
  String get allEmployeesOption;

  /// No description provided for @allFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFilter;

  /// No description provided for @allInvoices.
  ///
  /// In en, this message translates to:
  /// **'All Invoices'**
  String get allInvoices;

  /// No description provided for @allInvoicesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-generate for all users'**
  String get allInvoicesSubtitle;

  /// No description provided for @allowanceFirstAidCasual.
  ///
  /// In en, this message translates to:
  /// **'First Aid Allowance (Casual)'**
  String get allowanceFirstAidCasual;

  /// No description provided for @allowanceFirstAidWeekly.
  ///
  /// In en, this message translates to:
  /// **'First Aid Allowance (Weekly)'**
  String get allowanceFirstAidWeekly;

  /// No description provided for @allowanceLaundry.
  ///
  /// In en, this message translates to:
  /// **'Laundry Allowance'**
  String get allowanceLaundry;

  /// No description provided for @allowancesSection.
  ///
  /// In en, this message translates to:
  /// **'Allowances (Enabled)'**
  String get allowancesSection;

  /// No description provided for @allowanceUniform.
  ///
  /// In en, this message translates to:
  /// **'Uniform Allowance'**
  String get allowanceUniform;

  /// No description provided for @allowPriceCapOverride.
  ///
  /// In en, this message translates to:
  /// **'Allow Price Cap Override'**
  String get allowPriceCapOverride;

  /// No description provided for @allowPriceCapOverrideOption.
  ///
  /// In en, this message translates to:
  /// **'Allow Price Cap Override'**
  String get allowPriceCapOverrideOption;

  /// No description provided for @allowPriceCapOverrideOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow prices above NDIS caps'**
  String get allowPriceCapOverrideOptionDesc;

  /// No description provided for @allowPriceOverrideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable price adjustments beyond standard caps'**
  String get allowPriceOverrideSubtitle;

  /// No description provided for @allowPriceOverrideTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Price Cap Override'**
  String get allowPriceOverrideTitle;

  /// No description provided for @allowPricesAboveNDIS.
  ///
  /// In en, this message translates to:
  /// **'Allow prices above NDIS caps'**
  String get allowPricesAboveNDIS;

  /// No description provided for @allPricingDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'complete database'**
  String get allPricingDataSubtitle;

  /// No description provided for @allPricingDataTitle.
  ///
  /// In en, this message translates to:
  /// **'All Pricing Data'**
  String get allPricingDataTitle;

  /// No description provided for @allRateLimitsReset.
  ///
  /// In en, this message translates to:
  /// **'All rate limits reset'**
  String get allRateLimitsReset;

  /// No description provided for @allRatesConfiguredMessage.
  ///
  /// In en, this message translates to:
  /// **'All selected NDIS items have configured base service rates.'**
  String get allRatesConfiguredMessage;

  /// No description provided for @allShifts.
  ///
  /// In en, this message translates to:
  /// **'All Shifts'**
  String get allShifts;

  /// No description provided for @allValidationTypes.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allValidationTypes;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @analyticsOverview.
  ///
  /// In en, this message translates to:
  /// **'Analytics Overview'**
  String get analyticsOverview;

  /// No description provided for @apiSecurity.
  ///
  /// In en, this message translates to:
  /// **'API Security'**
  String get apiSecurity;

  /// No description provided for @apiUsage.
  ///
  /// In en, this message translates to:
  /// **'API Usage'**
  String get apiUsage;

  /// No description provided for @apiUsageDashboard.
  ///
  /// In en, this message translates to:
  /// **'API Usage Dashboard'**
  String get apiUsageDashboard;

  /// No description provided for @apiUsageDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor API traffic and errors in real-time'**
  String get apiUsageDashboardDesc;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get appearance;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @applyOverrides.
  ///
  /// In en, this message translates to:
  /// **'Apply Overrides'**
  String get applyOverrides;

  /// No description provided for @applyTax.
  ///
  /// In en, this message translates to:
  /// **'Apply Tax'**
  String get applyTax;

  /// No description provided for @applyTaxOption.
  ///
  /// In en, this message translates to:
  /// **'Apply Tax'**
  String get applyTaxOption;

  /// No description provided for @applyTaxOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Include tax calculations'**
  String get applyTaxOptionDesc;

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'CareNest'**
  String get appName;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @appointmentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Appointment Date'**
  String get appointmentDateLabel;

  /// No description provided for @appointmentDetailsCareNotes.
  ///
  /// In en, this message translates to:
  /// **'Care Notes'**
  String get appointmentDetailsCareNotes;

  /// No description provided for @appointmentDetailsCommunicationStyle.
  ///
  /// In en, this message translates to:
  /// **'Communication Style'**
  String get appointmentDetailsCommunicationStyle;

  /// No description provided for @appointmentDetailsDietaryNeeds.
  ///
  /// In en, this message translates to:
  /// **'Dietary Needs'**
  String get appointmentDetailsDietaryNeeds;

  /// No description provided for @appointmentDetailsImportantClientNeeds.
  ///
  /// In en, this message translates to:
  /// **'Important client needs'**
  String get appointmentDetailsImportantClientNeeds;

  /// No description provided for @appointmentDetailsNavigationTitle.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get appointmentDetailsNavigationTitle;

  /// No description provided for @appointmentDetailsOpenMaps.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get appointmentDetailsOpenMaps;

  /// No description provided for @appointmentDetailsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Client Preferences'**
  String get appointmentDetailsPreferences;

  /// No description provided for @appointmentDetailsSpecialRequirements.
  ///
  /// In en, this message translates to:
  /// **'Special Requirements'**
  String get appointmentDetailsSpecialRequirements;

  /// No description provided for @appointmentDetailsViewAllHistory.
  ///
  /// In en, this message translates to:
  /// **'View All History'**
  String get appointmentDetailsViewAllHistory;

  /// No description provided for @appointmentDetailsVisitHistory.
  ///
  /// In en, this message translates to:
  /// **'Visit History'**
  String get appointmentDetailsVisitHistory;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @appointmentSchedules.
  ///
  /// In en, this message translates to:
  /// **'Appointment schedules'**
  String get appointmentSchedules;

  /// No description provided for @approvals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get approvals;

  /// No description provided for @approveAction.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveAction;

  /// No description provided for @approveButton.
  ///
  /// In en, this message translates to:
  /// **'APPROVE'**
  String get approveButton;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @approvedTab.
  ///
  /// In en, this message translates to:
  /// **'APPROVED'**
  String get approvedTab;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @appSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettingsSection;

  /// No description provided for @aprInitial.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get aprInitial;

  /// No description provided for @areaChart.
  ///
  /// In en, this message translates to:
  /// **'Area Chart'**
  String get areaChart;

  /// No description provided for @areYouSureAddBusiness.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to add this business?'**
  String get areYouSureAddBusiness;

  /// No description provided for @articleType.
  ///
  /// In en, this message translates to:
  /// **'Article'**
  String get articleType;

  /// No description provided for @assignButton.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get assignButton;

  /// No description provided for @assignedShifts.
  ///
  /// In en, this message translates to:
  /// **'Assigned Shifts'**
  String get assignedShifts;

  /// No description provided for @assigning.
  ///
  /// In en, this message translates to:
  /// **'Assigning...'**
  String get assigning;

  /// No description provided for @assignment.
  ///
  /// In en, this message translates to:
  /// **'Assignment'**
  String get assignment;

  /// No description provided for @assignmentComplete.
  ///
  /// In en, this message translates to:
  /// **'Assignment Complete'**
  String get assignmentComplete;

  /// No description provided for @assignmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Assignment Details'**
  String get assignmentDetails;

  /// No description provided for @assignmentDetailsCopied.
  ///
  /// In en, this message translates to:
  /// **'Assignment details copied to clipboard'**
  String get assignmentDetailsCopied;

  /// No description provided for @assignmentDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review the details of the assignment below'**
  String get assignmentDetailsSubtitle;

  /// No description provided for @assignmentId.
  ///
  /// In en, this message translates to:
  /// **'Assignment ID'**
  String get assignmentId;

  /// No description provided for @assignmentList.
  ///
  /// In en, this message translates to:
  /// **'Assignment List'**
  String get assignmentList;

  /// No description provided for @assignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get assignments;

  /// No description provided for @assignmentsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} assignments'**
  String assignmentsCountLabel(String count);

  /// No description provided for @assignmentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Assignment Successful!'**
  String get assignmentSuccessful;

  /// No description provided for @assignmentSuccessfulCaps.
  ///
  /// In en, this message translates to:
  /// **'ASSIGNMENT SUCCESSFUL!'**
  String get assignmentSuccessfulCaps;

  /// No description provided for @attachedFilesCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Attached Files ({count})'**
  String attachedFilesCountLabel(Object count);

  /// No description provided for @attachedFilesLabel.
  ///
  /// In en, this message translates to:
  /// **'Attached Files'**
  String get attachedFilesLabel;

  /// No description provided for @attachmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachmentsTitle;

  /// No description provided for @attempts.
  ///
  /// In en, this message translates to:
  /// **'Attempts: {count}'**
  String attempts(String count);

  /// No description provided for @attentionRequired.
  ///
  /// In en, this message translates to:
  /// **'ATTENTION REQUIRED'**
  String get attentionRequired;

  /// No description provided for @auditCertifications.
  ///
  /// In en, this message translates to:
  /// **'Audit Certifications'**
  String get auditCertifications;

  /// No description provided for @auditCertificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Review and approve employee certifications'**
  String get auditCertificationsDesc;

  /// No description provided for @augInitial.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get augInitial;

  /// No description provided for @automaticInvoiceGeneration.
  ///
  /// In en, this message translates to:
  /// **'Automatic Invoice Generation'**
  String get automaticInvoiceGeneration;

  /// No description provided for @automaticInvoiceGenerationDesc.
  ///
  /// In en, this message translates to:
  /// **'This will automatically generate invoices for all employees and their assigned clients in your organization. No manual selection required.'**
  String get automaticInvoiceGenerationDesc;

  /// No description provided for @automaticInvoiceGenerationTitle.
  ///
  /// In en, this message translates to:
  /// **'Automatic Invoice Generation'**
  String get automaticInvoiceGenerationTitle;

  /// No description provided for @autoUpdatePricing.
  ///
  /// In en, this message translates to:
  /// **'Auto-update Pricing'**
  String get autoUpdatePricing;

  /// No description provided for @autoUpdatePricingDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically update prices when NDIS guide changes'**
  String get autoUpdatePricingDesc;

  /// No description provided for @availableLabel.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get availableLabel;

  /// No description provided for @averageRate.
  ///
  /// In en, this message translates to:
  /// **'Average Rate'**
  String get averageRate;

  /// No description provided for @averageRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Average Rate'**
  String get averageRateLabel;

  /// No description provided for @avgBaseRateStat.
  ///
  /// In en, this message translates to:
  /// **'Avg Base Rate'**
  String get avgBaseRateStat;

  /// No description provided for @avgBaseRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'projected monthly'**
  String get avgBaseRateSubtitle;

  /// No description provided for @avgChange.
  ///
  /// In en, this message translates to:
  /// **'Avg Change'**
  String get avgChange;

  /// No description provided for @avgRate.
  ///
  /// In en, this message translates to:
  /// **'Avg Rate'**
  String get avgRate;

  /// No description provided for @avgRateInsightLabel.
  ///
  /// In en, this message translates to:
  /// **'• Average service rate decreased by {percentage}% - consider rate review'**
  String avgRateInsightLabel(String percentage);

  /// No description provided for @avgRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg Rate'**
  String get avgRateLabel;

  /// No description provided for @avgRateStat.
  ///
  /// In en, this message translates to:
  /// **'Avg Rate'**
  String get avgRateStat;

  /// No description provided for @avgResponseTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Response Time'**
  String get avgResponseTime;

  /// No description provided for @backAction.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backAction;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetails;

  /// No description provided for @bankDetailsAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin Bank Details'**
  String get bankDetailsAdmin;

  /// No description provided for @bankDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage bank account details'**
  String get bankDetailsDesc;

  /// No description provided for @bankDetailsEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee Bank Details'**
  String get bankDetailsEmployee;

  /// No description provided for @bankDetailsMissingMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not find bank details for your organization.\n\nSince you selected \"Use Admin Bank Details\", please ensure valid bank details are saved in the Settings or Admin Tools.'**
  String get bankDetailsMissingMessage;

  /// No description provided for @bankDetailsMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Details Missing'**
  String get bankDetailsMissingTitle;

  /// No description provided for @bankDetailsNote.
  ///
  /// In en, this message translates to:
  /// **'Note: Invoice creation is restricted to admin users.'**
  String get bankDetailsNote;

  /// No description provided for @bankDetailsNotSet.
  ///
  /// In en, this message translates to:
  /// **'Employee bank details are not set yet. Please add your bank details first.'**
  String get bankDetailsNotSet;

  /// No description provided for @bankDetailsRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Bank details are missing for both employee and admin. Please add bank details before generating invoices.'**
  String get bankDetailsRequiredError;

  /// No description provided for @bankDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select which bank details to use on the invoice'**
  String get bankDetailsSubtitle;

  /// No description provided for @bankDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetailsTitle;

  /// No description provided for @banking.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get banking;

  /// No description provided for @bankingPayouts.
  ///
  /// In en, this message translates to:
  /// **'BANKING & PAYOUTS'**
  String get bankingPayouts;

  /// No description provided for @bankingWarning.
  ///
  /// In en, this message translates to:
  /// **'Updating banking details may require re-verification. Payments might be delayed.'**
  String get bankingWarning;

  /// No description provided for @bankNameLabel.
  ///
  /// In en, this message translates to:
  /// **'BANK NAME'**
  String get bankNameLabel;

  /// No description provided for @barChart.
  ///
  /// In en, this message translates to:
  /// **'Bar Chart'**
  String get barChart;

  /// No description provided for @basedUnit.
  ///
  /// In en, this message translates to:
  /// **'Based'**
  String get basedUnit;

  /// No description provided for @baseRate.
  ///
  /// In en, this message translates to:
  /// **'Base Rate'**
  String get baseRate;

  /// No description provided for @baseRateHourlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Base Rate (Hourly)'**
  String get baseRateHourlyLabel;

  /// No description provided for @baseRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Base Rate'**
  String get baseRateLabel;

  /// No description provided for @baseRateSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save base rate: {error}'**
  String baseRateSaveError(Object error);

  /// No description provided for @baseRateSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Base rate saved successfully'**
  String get baseRateSaveSuccess;

  /// No description provided for @baseRateSection.
  ///
  /// In en, this message translates to:
  /// **'Base Rate'**
  String get baseRateSection;

  /// No description provided for @baseRatesVerified.
  ///
  /// In en, this message translates to:
  /// **'Base Rates Verified'**
  String get baseRatesVerified;

  /// No description provided for @baseRateTooltip.
  ///
  /// In en, this message translates to:
  /// **'We treat fallback sources (base-rate, ndis_default, fallback) as missing\nso you can configure organization/client-specific base rates.\nUse the View Missing Items list to add custom pricing.'**
  String get baseRateTooltip;

  /// No description provided for @basicConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Basic Configuration'**
  String get basicConfiguration;

  /// No description provided for @blockedIpAddresses.
  ///
  /// In en, this message translates to:
  /// **'Blocked IP Addresses'**
  String get blockedIpAddresses;

  /// No description provided for @blockedUntil.
  ///
  /// In en, this message translates to:
  /// **'Blocked until: {date}'**
  String blockedUntil(String date);

  /// No description provided for @breakAllowed.
  ///
  /// In en, this message translates to:
  /// **'Break Allowed'**
  String get breakAllowed;

  /// No description provided for @breakDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Break Duration'**
  String get breakDurationLabel;

  /// No description provided for @breakLabel.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get breakLabel;

  /// No description provided for @bsbLabel.
  ///
  /// In en, this message translates to:
  /// **'BSB'**
  String get bsbLabel;

  /// No description provided for @buildingRelationshipsStep.
  ///
  /// In en, this message translates to:
  /// **'Building employee-client relationships...'**
  String get buildingRelationshipsStep;

  /// No description provided for @bulkImport.
  ///
  /// In en, this message translates to:
  /// **'Bulk Import'**
  String get bulkImport;

  /// No description provided for @bulkOperationLimit.
  ///
  /// In en, this message translates to:
  /// **'Bulk Operation Limit'**
  String get bulkOperationLimit;

  /// No description provided for @bulkOperations.
  ///
  /// In en, this message translates to:
  /// **'Bulk Operations'**
  String get bulkOperations;

  /// No description provided for @bulkOperationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage and optimize your service pricing across different regions and categories'**
  String get bulkOperationsDesc;

  /// No description provided for @bulkOperationsHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk Operations Help'**
  String get bulkOperationsHelpTitle;

  /// No description provided for @bulkOperationsSmallDesc.
  ///
  /// In en, this message translates to:
  /// **'Import and export data in batch operations'**
  String get bulkOperationsSmallDesc;

  /// No description provided for @bulkOperationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import/export and batch updates'**
  String get bulkOperationsSubtitle;

  /// No description provided for @bulkOperationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk Operations'**
  String get bulkOperationsTitle;

  /// No description provided for @bulkPriceUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update multiple prices at once'**
  String get bulkPriceUpdateSubtitle;

  /// No description provided for @bulkPriceUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk Price Update'**
  String get bulkPriceUpdateTitle;

  /// No description provided for @bulkUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Perform mass updates on your pricing data'**
  String get bulkUpdatesDesc;

  /// No description provided for @bulkUpdatesQuickAction.
  ///
  /// In en, this message translates to:
  /// **'Bulk Updates'**
  String get bulkUpdatesQuickAction;

  /// No description provided for @bulkUpdatesQuickDesc.
  ///
  /// In en, this message translates to:
  /// **'Mass update pricing data'**
  String get bulkUpdatesQuickDesc;

  /// No description provided for @bulkUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk Updates'**
  String get bulkUpdatesTitle;

  /// No description provided for @bulkUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update multiple rates'**
  String get bulkUpdateSubtitle;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @businessAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Business details added successfully'**
  String get businessAddedSuccess;

  /// No description provided for @businessAddFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add business. Please try again.'**
  String get businessAddFailed;

  /// No description provided for @businessAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Address'**
  String get businessAddress;

  /// No description provided for @businessAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter business address'**
  String get businessAddressRequired;

  /// No description provided for @businessDetails.
  ///
  /// In en, this message translates to:
  /// **'Business Details'**
  String get businessDetails;

  /// No description provided for @businessDetailsAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Business details added successfully'**
  String get businessDetailsAddedSuccessfully;

  /// No description provided for @businessEmail.
  ///
  /// In en, this message translates to:
  /// **'Business Email'**
  String get businessEmail;

  /// No description provided for @businessEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter business email'**
  String get businessEmailRequired;

  /// No description provided for @businessesTitle.
  ///
  /// In en, this message translates to:
  /// **'Businesses'**
  String get businessesTitle;

  /// No description provided for @businessInformation.
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get businessInformation;

  /// No description provided for @businessList.
  ///
  /// In en, this message translates to:
  /// **'Business List'**
  String get businessList;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @businessNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter business name'**
  String get businessNameRequired;

  /// No description provided for @businessOverview.
  ///
  /// In en, this message translates to:
  /// **'Business Overview'**
  String get businessOverview;

  /// No description provided for @businessOverviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor your business performance at a glance'**
  String get businessOverviewDesc;

  /// No description provided for @businessPhone.
  ///
  /// In en, this message translates to:
  /// **'Business Phone'**
  String get businessPhone;

  /// No description provided for @businessPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter business phone'**
  String get businessPhoneRequired;

  /// No description provided for @byLabel.
  ///
  /// In en, this message translates to:
  /// **'By'**
  String get byLabel;

  /// No description provided for @calls.
  ///
  /// In en, this message translates to:
  /// **'Calls: {count} • Avg: {avgTime}ms'**
  String calls(String count, String avgTime);

  /// No description provided for @callsAndLast.
  ///
  /// In en, this message translates to:
  /// **'Calls: {calls} • Last: {lastActivity}'**
  String callsAndLast(String calls, String lastActivity);

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @cancelButtonCaps.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancelButtonCaps;

  /// No description provided for @cannotSchedulePast.
  ///
  /// In en, this message translates to:
  /// **'Cannot schedule appointments in the past'**
  String get cannotSchedulePast;

  /// No description provided for @capacityBuilding.
  ///
  /// In en, this message translates to:
  /// **'Capacity Building'**
  String get capacityBuilding;

  /// No description provided for @capitalSupport.
  ///
  /// In en, this message translates to:
  /// **'Capital Support'**
  String get capitalSupport;

  /// No description provided for @capturedReceipt.
  ///
  /// In en, this message translates to:
  /// **'Captured Receipt'**
  String get capturedReceipt;

  /// No description provided for @casualLabel.
  ///
  /// In en, this message translates to:
  /// **'Casual'**
  String get casualLabel;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @categoryUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update entire service categories'**
  String get categoryUpdatesSubtitle;

  /// No description provided for @categoryUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Category Updates'**
  String get categoryUpdatesTitle;

  /// No description provided for @categoryValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String categoryValueLabel(String category);

  /// No description provided for @certificationAuditTitle.
  ///
  /// In en, this message translates to:
  /// **'Certification Audit'**
  String get certificationAuditTitle;

  /// No description provided for @certificationNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Certification Name'**
  String get certificationNameLabel;

  /// No description provided for @certificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload and manage your certifications'**
  String get certificationsSubtitle;

  /// No description provided for @certificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get certificationsTitle;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @changeDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Changed'**
  String get changeDateLabel;

  /// No description provided for @changedByLabel.
  ///
  /// In en, this message translates to:
  /// **'Changed By'**
  String get changedByLabel;

  /// No description provided for @changeLabel.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeLabel;

  /// No description provided for @changeNdisItem.
  ///
  /// In en, this message translates to:
  /// **'Change NDIS Item'**
  String get changeNdisItem;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your account password'**
  String get changePasswordSubtitle;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @chartVisualizationPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Chart visualization\nwould appear here'**
  String get chartVisualizationPlaceholder;

  /// No description provided for @checkPricesAgainstNDIS.
  ///
  /// In en, this message translates to:
  /// **'Check prices against NDIS price caps'**
  String get checkPricesAgainstNDIS;

  /// No description provided for @chooseClientFromListDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose a client from the list to view pricing.'**
  String get chooseClientFromListDesc;

  /// No description provided for @chooseEmpAndClientsDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose employees and their clients for invoice'**
  String get chooseEmpAndClientsDesc;

  /// No description provided for @chooseEmployees.
  ///
  /// In en, this message translates to:
  /// **'Choose Employees'**
  String get chooseEmployees;

  /// No description provided for @chooseEmployeesButton.
  ///
  /// In en, this message translates to:
  /// **'Choose Employees'**
  String get chooseEmployeesButton;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @chooseModule.
  ///
  /// In en, this message translates to:
  /// **'Choose a module to manage your pricing'**
  String get chooseModule;

  /// No description provided for @chooseModuleDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose a module to manage your pricing'**
  String get chooseModuleDesc;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @cityRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter city'**
  String get cityRequired;

  /// No description provided for @classificationEmploymentSection.
  ///
  /// In en, this message translates to:
  /// **'Classification & Employment'**
  String get classificationEmploymentSection;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @clearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Clear All Notifications'**
  String get clearAllNotifications;

  /// No description provided for @clearAllNotificationsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all notifications? This action cannot be undone.'**
  String get clearAllNotificationsConfirm;

  /// No description provided for @clearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButton;

  /// No description provided for @clearFiltersAction.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFiltersAction;

  /// No description provided for @clearPriceHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear Price History'**
  String get clearPriceHistory;

  /// No description provided for @clearPriceHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove all historical pricing data'**
  String get clearPriceHistoryDesc;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @clientAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Client added successfully!'**
  String get clientAddedSuccess;

  /// No description provided for @clientAddFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add client. Please try again.'**
  String get clientAddFailed;

  /// No description provided for @clientBaseRateSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save client base rate: {error}'**
  String clientBaseRateSaveError(Object error);

  /// No description provided for @clientBaseRateSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Client base rate saved successfully'**
  String get clientBaseRateSaveSuccess;

  /// No description provided for @clientCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{client} other{clients}}'**
  String clientCount(num count);

  /// No description provided for @clientDetails.
  ///
  /// In en, this message translates to:
  /// **'Client Details'**
  String get clientDetails;

  /// No description provided for @clientEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Client Email'**
  String get clientEmailLabel;

  /// No description provided for @clientInformation.
  ///
  /// In en, this message translates to:
  /// **'Client Information'**
  String get clientInformation;

  /// No description provided for @clientInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Client Information'**
  String get clientInformationTitle;

  /// No description provided for @clientInfoTemplate.
  ///
  /// In en, this message translates to:
  /// **'Client: {clientName} ({clientState})'**
  String clientInfoTemplate(String clientName, String clientState);

  /// No description provided for @clientLabel.
  ///
  /// In en, this message translates to:
  /// **'CLIENT'**
  String get clientLabel;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get clientName;

  /// No description provided for @clientOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bill the client'**
  String get clientOptionSubtitle;

  /// No description provided for @clientOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get clientOptionTitle;

  /// No description provided for @clientPricingReview.
  ///
  /// In en, this message translates to:
  /// **'Client Pricing Review'**
  String get clientPricingReview;

  /// No description provided for @clientPricingReviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Review and manage client pricing before invoicing'**
  String get clientPricingReviewDesc;

  /// No description provided for @clientPricingReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Client Pricing Review'**
  String get clientPricingReviewTitle;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @clientsCaps.
  ///
  /// In en, this message translates to:
  /// **'CLIENTS'**
  String get clientsCaps;

  /// No description provided for @clientsCountTitle.
  ///
  /// In en, this message translates to:
  /// **'Clients ({count})'**
  String clientsCountTitle(String count);

  /// No description provided for @clientsLabel.
  ///
  /// In en, this message translates to:
  /// **'CLIENTS'**
  String get clientsLabel;

  /// No description provided for @clientSpecificPricing.
  ///
  /// In en, this message translates to:
  /// **'Client-Specific Pricing'**
  String get clientSpecificPricing;

  /// No description provided for @clientSpecificRate.
  ///
  /// In en, this message translates to:
  /// **'Client-Specific Rate'**
  String get clientSpecificRate;

  /// No description provided for @clientSpecificRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Client-Specific Rate'**
  String get clientSpecificRateLabel;

  /// No description provided for @clockIn.
  ///
  /// In en, this message translates to:
  /// **'Clock in'**
  String get clockIn;

  /// No description provided for @clockOut.
  ///
  /// In en, this message translates to:
  /// **'Clock out'**
  String get clockOut;

  /// No description provided for @closeAction.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeAction;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @codeLabelValue.
  ///
  /// In en, this message translates to:
  /// **'Code: {code}'**
  String codeLabelValue(String code);

  /// No description provided for @comingSoonMsg.
  ///
  /// In en, this message translates to:
  /// **'New rate feature coming soon!'**
  String get comingSoonMsg;

  /// No description provided for @companyNameLabel.
  ///
  /// In en, this message translates to:
  /// **'COMPANY NAME/LEGAL NAME'**
  String get companyNameLabel;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @completedOps.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedOps;

  /// No description provided for @completedStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatus;

  /// No description provided for @completedWithErrors.
  ///
  /// In en, this message translates to:
  /// **'Completed with {count} errors'**
  String completedWithErrors(Object count);

  /// No description provided for @completeMsg.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% complete'**
  String completeMsg(int percentage);

  /// No description provided for @complianceAuditTitle.
  ///
  /// In en, this message translates to:
  /// **'COMPLIANCE AUDIT'**
  String get complianceAuditTitle;

  /// No description provided for @complianceChecklists.
  ///
  /// In en, this message translates to:
  /// **'Compliance Checklists'**
  String get complianceChecklists;

  /// No description provided for @complianceChecklistsDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage compliance checklists'**
  String get complianceChecklistsDesc;

  /// No description provided for @complianceChecklistsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily and weekly compliance checks'**
  String get complianceChecklistsSubtitle;

  /// No description provided for @complianceChecklistsTitle.
  ///
  /// In en, this message translates to:
  /// **'Compliance Checklists'**
  String get complianceChecklistsTitle;

  /// No description provided for @complianceStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get complianceStatusUnknown;

  /// No description provided for @configFinance.
  ///
  /// In en, this message translates to:
  /// **'Configuration & Finance'**
  String get configFinance;

  /// No description provided for @configuration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// No description provided for @configurationResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Configuration reset to defaults'**
  String get configurationResetSuccess;

  /// No description provided for @configurationsContent.
  ///
  /// In en, this message translates to:
  /// **'Configurations Content'**
  String get configurationsContent;

  /// No description provided for @configurationsTab.
  ///
  /// In en, this message translates to:
  /// **'Configurations'**
  String get configurationsTab;

  /// No description provided for @configure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// No description provided for @configureEmailSettingsFirst.
  ///
  /// In en, this message translates to:
  /// **'Please configure Email Settings first.'**
  String get configureEmailSettingsFirst;

  /// No description provided for @configureIntegrationHint.
  ///
  /// In en, this message translates to:
  /// **'Configure {name} integration'**
  String configureIntegrationHint(String name);

  /// No description provided for @configurePricing.
  ///
  /// In en, this message translates to:
  /// **'Configure pricing'**
  String get configurePricing;

  /// No description provided for @confirmAddBusiness.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to add this business?'**
  String get confirmAddBusiness;

  /// No description provided for @confirmAddClient.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to add this client?'**
  String get confirmAddClient;

  /// No description provided for @confirmAndEdit.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM & EDIT'**
  String get confirmAndEdit;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordHint;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @confirmSelectionButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Selection'**
  String get confirmSelectionButton;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected: {time}'**
  String connected(String time);

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get contactDetails;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @contactTab.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactTab;

  /// No description provided for @contentLabel.
  ///
  /// In en, this message translates to:
  /// **'Content: {type}'**
  String contentLabel(String type);

  /// No description provided for @contentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get contentTypeLabel;

  /// No description provided for @contentUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Content URL'**
  String get contentUrlLabel;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 CareNest. All rights reserved.'**
  String get copyright;

  /// No description provided for @coreSupport.
  ///
  /// In en, this message translates to:
  /// **'Core Support'**
  String get coreSupport;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @createAction.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createAction;

  /// No description provided for @createButton.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButton;

  /// No description provided for @createdLabel.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get createdLabel;

  /// No description provided for @createFirstInvoice.
  ///
  /// In en, this message translates to:
  /// **'Create your first invoice to get started'**
  String get createFirstInvoice;

  /// No description provided for @createInvoice.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get createInvoice;

  /// No description provided for @createNewOrg.
  ///
  /// In en, this message translates to:
  /// **'Create New Organization'**
  String get createNewOrg;

  /// No description provided for @createNewOrgDesc.
  ///
  /// In en, this message translates to:
  /// **'Set up your own organization'**
  String get createNewOrgDesc;

  /// No description provided for @createNewShift.
  ///
  /// In en, this message translates to:
  /// **'Create New Shift'**
  String get createNewShift;

  /// No description provided for @createPricingItem.
  ///
  /// In en, this message translates to:
  /// **'Create pricing item'**
  String get createPricingItem;

  /// No description provided for @createRequest.
  ///
  /// In en, this message translates to:
  /// **'Create Request'**
  String get createRequest;

  /// No description provided for @createShift.
  ///
  /// In en, this message translates to:
  /// **'Create Shift'**
  String get createShift;

  /// No description provided for @createShiftToStart.
  ///
  /// In en, this message translates to:
  /// **'Create a new shift to get started'**
  String get createShiftToStart;

  /// No description provided for @creatingHoliday.
  ///
  /// In en, this message translates to:
  /// **'Creating Holiday...'**
  String get creatingHoliday;

  /// No description provided for @currencySymbol.
  ///
  /// In en, this message translates to:
  /// **'\$'**
  String get currencySymbol;

  /// No description provided for @currentBalances.
  ///
  /// In en, this message translates to:
  /// **'Current Balances'**
  String get currentBalances;

  /// No description provided for @currentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get currentLabel;

  /// No description provided for @currentPrice.
  ///
  /// In en, this message translates to:
  /// **'Current Price'**
  String get currentPrice;

  /// No description provided for @currentPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Price:'**
  String get currentPriceLabel;

  /// No description provided for @currentRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Rate'**
  String get currentRateLabel;

  /// No description provided for @currentRatesTab.
  ///
  /// In en, this message translates to:
  /// **'Current Rates'**
  String get currentRatesTab;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @customPrice.
  ///
  /// In en, this message translates to:
  /// **'Custom Price: \${price}'**
  String customPrice(String price);

  /// No description provided for @customPriceHourlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom Price (\$/hour)'**
  String get customPriceHourlyLabel;

  /// No description provided for @customPricingAppliedOrgWide.
  ///
  /// In en, this message translates to:
  /// **'Custom pricing will be applied organization-wide.'**
  String get customPricingAppliedOrgWide;

  /// No description provided for @customPricingRemoved.
  ///
  /// In en, this message translates to:
  /// **'Custom pricing removed successfully'**
  String get customPricingRemoved;

  /// No description provided for @customPricingSaved.
  ///
  /// In en, this message translates to:
  /// **'Custom pricing saved successfully'**
  String get customPricingSaved;

  /// No description provided for @customReportBuilder.
  ///
  /// In en, this message translates to:
  /// **'Custom Report Builder'**
  String get customReportBuilder;

  /// No description provided for @customReportBuilderDesc.
  ///
  /// In en, this message translates to:
  /// **'Create custom validation reports with specific criteria'**
  String get customReportBuilderDesc;

  /// No description provided for @dailyValidationSummary.
  ///
  /// In en, this message translates to:
  /// **'Daily Validation Summary'**
  String get dailyValidationSummary;

  /// No description provided for @dailyValidationSummaryDesc.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive daily report of all validation activities'**
  String get dailyValidationSummaryDesc;

  /// No description provided for @dangerZoneSection.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZoneSection;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @dashboardAddExpenseDesc.
  ///
  /// In en, this message translates to:
  /// **'Create a new expense entry'**
  String get dashboardAddExpenseDesc;

  /// No description provided for @dashboardApprovalsDesc.
  ///
  /// In en, this message translates to:
  /// **'Review pending expenses'**
  String get dashboardApprovalsDesc;

  /// No description provided for @dashboardOverview.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Overview'**
  String get dashboardOverview;

  /// No description provided for @dashboardOverviewDesc.
  ///
  /// In en, this message translates to:
  /// **'View pricing analytics and insights'**
  String get dashboardOverviewDesc;

  /// No description provided for @dashboardOverviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View pricing analytics and insights'**
  String get dashboardOverviewSubtitle;

  /// No description provided for @dashboardOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Overview'**
  String get dashboardOverviewTitle;

  /// No description provided for @dashboardQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get dashboardQuickActions;

  /// No description provided for @dashboardRecentExpenses.
  ///
  /// In en, this message translates to:
  /// **'Recent Expenses'**
  String get dashboardRecentExpenses;

  /// No description provided for @dashboardReportsDesc.
  ///
  /// In en, this message translates to:
  /// **'View expense analytics'**
  String get dashboardReportsDesc;

  /// No description provided for @dashboardViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get dashboardViewAll;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @dataRefreshedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data refreshed successfully'**
  String get dataRefreshedSuccess;

  /// No description provided for @dateCannotBePast.
  ///
  /// In en, this message translates to:
  /// **'Date cannot be in the past'**
  String get dateCannotBePast;

  /// No description provided for @dateFormatAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormatAppBarTitle;

  /// No description provided for @dateFormatInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose how to interpret ambiguous numeric dates (e.g., 1/2/2025).'**
  String get dateFormatInfoMessage;

  /// No description provided for @dateFormatSaved.
  ///
  /// In en, this message translates to:
  /// **'Date format preference saved'**
  String get dateFormatSaved;

  /// No description provided for @dateFormatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control parsing of ambiguous dates'**
  String get dateFormatSubtitle;

  /// No description provided for @dateFormatTitle.
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormatTitle;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @dateLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'DATE:'**
  String get dateLabelCaps;

  /// No description provided for @datesLabel.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get datesLabel;

  /// No description provided for @dateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTimeLabel;

  /// No description provided for @dayMonthYear.
  ///
  /// In en, this message translates to:
  /// **'Day/Month/Year'**
  String get dayMonthYear;

  /// No description provided for @dayMonthYearExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 1/2/2025 → February 1, 2025'**
  String get dayMonthYearExample;

  /// No description provided for @dayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeek;

  /// No description provided for @decInitial.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get decInitial;

  /// No description provided for @declineButton.
  ///
  /// In en, this message translates to:
  /// **'DECLINE'**
  String get declineButton;

  /// No description provided for @declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// No description provided for @declinedTab.
  ///
  /// In en, this message translates to:
  /// **'DECLINED'**
  String get declinedTab;

  /// No description provided for @declineRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'DECLINE REQUEST'**
  String get declineRequestTitle;

  /// No description provided for @decreases.
  ///
  /// In en, this message translates to:
  /// **'Decreases'**
  String get decreases;

  /// No description provided for @defaultCurrency.
  ///
  /// In en, this message translates to:
  /// **'Default Currency'**
  String get defaultCurrency;

  /// No description provided for @defaultMarkup.
  ///
  /// In en, this message translates to:
  /// **'Default Markup'**
  String get defaultMarkup;

  /// No description provided for @defaultState.
  ///
  /// In en, this message translates to:
  /// **'NSW'**
  String get defaultState;

  /// No description provided for @defaultUnit.
  ///
  /// In en, this message translates to:
  /// **'unit'**
  String get defaultUnit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This starts account deletion in-app. After approval, your account is deactivated and records required for payroll, tax, audit, and care obligations are retained for up to 90 days before permanent deletion. Do you want to continue?'**
  String get deleteAccountConfirmMessage;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start account deletion and 90-day retention process'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @deleteExpenseMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this expense? This action cannot be undone.'**
  String get deleteExpenseMessage;

  /// No description provided for @deleteExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get deleteExpenseTitle;

  /// No description provided for @deleteInvoice.
  ///
  /// In en, this message translates to:
  /// **'Delete Invoice'**
  String get deleteInvoice;

  /// No description provided for @deleteInvoiceButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Invoice'**
  String get deleteInvoiceButton;

  /// No description provided for @deleteInvoiceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete invoice {invoiceNumber}? This action cannot be undone.'**
  String deleteInvoiceConfirm(String invoiceNumber);

  /// No description provided for @deleteInvoiceConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete invoice {number}? This action cannot be undone.'**
  String deleteInvoiceConfirmMessage(String number);

  /// No description provided for @deleteInvoiceConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Invoice'**
  String get deleteInvoiceConfirmTitle;

  /// No description provided for @deleteInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Invoice'**
  String get deleteInvoiceTitle;

  /// No description provided for @deleteItemConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteItemConfirm(String name);

  /// No description provided for @deleteItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Item'**
  String get deleteItemTitle;

  /// No description provided for @deleteRateConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the rate for {serviceName}?'**
  String deleteRateConfirm(String serviceName);

  /// No description provided for @deleteRateTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Rate'**
  String get deleteRateTitle;

  /// No description provided for @deleteSelectedAction.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get deleteSelectedAction;

  /// No description provided for @deleteSelectedItemsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} selected items?'**
  String deleteSelectedItemsConfirm(String count);

  /// No description provided for @deleteSelectedItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected Items'**
  String get deleteSelectedItemsTitle;

  /// No description provided for @deletingInvoiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Deleting invoice...'**
  String get deletingInvoiceMessage;

  /// No description provided for @deliveryStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery Status'**
  String get deliveryStatusLabel;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// No description provided for @detailedAnalyticsInsights.
  ///
  /// In en, this message translates to:
  /// **'Detailed analytics and insights'**
  String get detailedAnalyticsInsights;

  /// No description provided for @detailedPricingInfo.
  ///
  /// In en, this message translates to:
  /// **'Detailed Pricing Info'**
  String get detailedPricingInfo;

  /// No description provided for @detailedPricingInfoOption.
  ///
  /// In en, this message translates to:
  /// **'Detailed Pricing Info'**
  String get detailedPricingInfoOption;

  /// No description provided for @detailedPricingInfoOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Include comprehensive pricing details'**
  String get detailedPricingInfoOptionDesc;

  /// No description provided for @detailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsLabel;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get didntReceiveCode;

  /// No description provided for @diffLabel.
  ///
  /// In en, this message translates to:
  /// **'Diff'**
  String get diffLabel;

  /// No description provided for @disableAction.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disableAction;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @dismissAction.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismissAction;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @downloadingMsg.
  ///
  /// In en, this message translates to:
  /// **'Downloading {template}...'**
  String downloadingMsg(String template);

  /// No description provided for @downloadTemplatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Get properly formatted CSV templates for seamless data import'**
  String get downloadTemplatesDesc;

  /// No description provided for @downloadTemplatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Download Templates'**
  String get downloadTemplatesTitle;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @dueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDateLabel;

  /// No description provided for @dueLabel.
  ///
  /// In en, this message translates to:
  /// **'Due: '**
  String get dueLabel;

  /// No description provided for @duplicateEntry.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Entry'**
  String get duplicateEntry;

  /// No description provided for @durationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationLabel;

  /// No description provided for @durationMinutesLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration (minutes)'**
  String get durationMinutesLabel;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @earningsDashboard.
  ///
  /// In en, this message translates to:
  /// **'Earnings Dashboard'**
  String get earningsDashboard;

  /// No description provided for @earningsDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'View earnings, projections, and tax estimates'**
  String get earningsDashboardDesc;

  /// No description provided for @earningsDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'EARNINGS DASHBOARD'**
  String get earningsDashboardTitle;

  /// No description provided for @earningsDesc.
  ///
  /// In en, this message translates to:
  /// **'View your pay summary, projections, and tax estimates.'**
  String get earningsDesc;

  /// No description provided for @earningsHistoryThisMonth.
  ///
  /// In en, this message translates to:
  /// **'EARNINGS HISTORY (THIS MONTH)'**
  String get earningsHistoryThisMonth;

  /// No description provided for @earningsHistoryThisWeek.
  ///
  /// In en, this message translates to:
  /// **'EARNINGS HISTORY (THIS WEEK)'**
  String get earningsHistoryThisWeek;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @editAssignment.
  ///
  /// In en, this message translates to:
  /// **'Edit Assignment'**
  String get editAssignment;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @editClient.
  ///
  /// In en, this message translates to:
  /// **'Edit Client'**
  String get editClient;

  /// No description provided for @editContactDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Contact Details'**
  String get editContactDetails;

  /// No description provided for @editDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'EDIT DETAILS'**
  String get editDetailsTitle;

  /// No description provided for @editExpense.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// No description provided for @editExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpenseTitle;

  /// No description provided for @editNdisItem.
  ///
  /// In en, this message translates to:
  /// **'Edit NDIS Item'**
  String get editNdisItem;

  /// No description provided for @editNdisItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit NDIS Item'**
  String get editNdisItemTitle;

  /// No description provided for @editOrganization.
  ///
  /// In en, this message translates to:
  /// **'Edit Organization'**
  String get editOrganization;

  /// No description provided for @editPrices.
  ///
  /// In en, this message translates to:
  /// **'Edit Prices'**
  String get editPrices;

  /// No description provided for @editPricesAction.
  ///
  /// In en, this message translates to:
  /// **'Edit Prices'**
  String get editPricesAction;

  /// No description provided for @editPricingRuleDialog.
  ///
  /// In en, this message translates to:
  /// **'Edit rule: {name}'**
  String editPricingRuleDialog(String name);

  /// No description provided for @editRateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit Rate'**
  String get editRateTooltip;

  /// No description provided for @editValidationRuleMsg.
  ///
  /// In en, this message translates to:
  /// **'Edit validation rule: {name}'**
  String editValidationRuleMsg(String name);

  /// No description provided for @effectiveDate.
  ///
  /// In en, this message translates to:
  /// **'Effective Date'**
  String get effectiveDate;

  /// No description provided for @effectiveDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Effective'**
  String get effectiveDateLabel;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailSettings.
  ///
  /// In en, this message translates to:
  /// **'Email Settings'**
  String get emailSettings;

  /// No description provided for @emailSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Configure invoice email settings'**
  String get emailSettingsDesc;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @employeeBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Employee Bank Details'**
  String get employeeBankDetails;

  /// No description provided for @employeeBankDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Use the employee\'s saved bank details'**
  String get employeeBankDetailsDesc;

  /// No description provided for @employeeBankDetailsOption.
  ///
  /// In en, this message translates to:
  /// **'Employee Bank Details'**
  String get employeeBankDetailsOption;

  /// No description provided for @employeeCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{employee} other{employees}}'**
  String employeeCount(num count);

  /// No description provided for @employeeFallback.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employeeFallback;

  /// No description provided for @employeeInvoice.
  ///
  /// In en, this message translates to:
  /// **'Employee Invoice'**
  String get employeeInvoice;

  /// No description provided for @employeeInvoiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate pay-rate invoices for employees'**
  String get employeeInvoiceSubtitle;

  /// No description provided for @employeeLabel.
  ///
  /// In en, this message translates to:
  /// **'EMPLOYEE'**
  String get employeeLabel;

  /// No description provided for @employeeOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bill the employee'**
  String get employeeOptionSubtitle;

  /// No description provided for @employeeOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employeeOptionTitle;

  /// No description provided for @employeePayRates.
  ///
  /// In en, this message translates to:
  /// **'Employee Pay Rates'**
  String get employeePayRates;

  /// No description provided for @employeePayRatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage employee salaries & hourly rates'**
  String get employeePayRatesDesc;

  /// No description provided for @employeePayRatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Employee Pay Rates'**
  String get employeePayRatesTitle;

  /// No description provided for @employees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get employees;

  /// No description provided for @employeesLabel.
  ///
  /// In en, this message translates to:
  /// **'EMPLOYEES'**
  String get employeesLabel;

  /// No description provided for @employeesSelected.
  ///
  /// In en, this message translates to:
  /// **'employees selected'**
  String get employeesSelected;

  /// No description provided for @employeesSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String employeesSelectedCount(String count);

  /// No description provided for @employeesTitle.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get employeesTitle;

  /// No description provided for @employeeTracking.
  ///
  /// In en, this message translates to:
  /// **'Employee Insights'**
  String get employeeTracking;

  /// No description provided for @employeeTrackingDesc.
  ///
  /// In en, this message translates to:
  /// **'View employee insights, work status & shifts'**
  String get employeeTrackingDesc;

  /// No description provided for @employmentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Employment Type'**
  String get employmentTypeLabel;

  /// No description provided for @enableAction.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enableAction;

  /// No description provided for @enableBulkOperations.
  ///
  /// In en, this message translates to:
  /// **'Enable Bulk Operations'**
  String get enableBulkOperations;

  /// No description provided for @enableBulkOperationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow bulk import/export and updates'**
  String get enableBulkOperationsDesc;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @enableForRegularlyOccurring.
  ///
  /// In en, this message translates to:
  /// **'Enable for regularly occurring expenses'**
  String get enableForRegularlyOccurring;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @enableNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications for pricing changes and alerts'**
  String get enableNotificationsDesc;

  /// No description provided for @enablePriceHistory.
  ///
  /// In en, this message translates to:
  /// **'Enable Price History'**
  String get enablePriceHistory;

  /// No description provided for @enablePriceHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Maintain detailed history of all price changes'**
  String get enablePriceHistoryDesc;

  /// No description provided for @enablePriceValidation.
  ///
  /// In en, this message translates to:
  /// **'Enable Price Validation'**
  String get enablePriceValidation;

  /// No description provided for @enablePriceValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Validate prices against configured rules'**
  String get enablePriceValidationDesc;

  /// No description provided for @endDateBeforeStartDate.
  ///
  /// In en, this message translates to:
  /// **'End date cannot be before start date'**
  String get endDateBeforeStartDate;

  /// No description provided for @endDateBeforeStartDateError.
  ///
  /// In en, this message translates to:
  /// **'End date must be on or after start date'**
  String get endDateBeforeStartDateError;

  /// No description provided for @endDateError.
  ///
  /// In en, this message translates to:
  /// **'End date cannot be before start date'**
  String get endDateError;

  /// No description provided for @endLabel.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get endLabel;

  /// No description provided for @endsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get endsLabel;

  /// No description provided for @endTimeBeforeStartTime.
  ///
  /// In en, this message translates to:
  /// **'End time cannot be before start time'**
  String get endTimeBeforeStartTime;

  /// No description provided for @endTimeError.
  ///
  /// In en, this message translates to:
  /// **'End time cannot be before start time'**
  String get endTimeError;

  /// No description provided for @endTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTimeLabel;

  /// No description provided for @enhancedInvoice.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Invoice'**
  String get enhancedInvoice;

  /// No description provided for @enhancedInvoiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate invoices with pricing integration'**
  String get enhancedInvoiceSubtitle;

  /// No description provided for @enhancedInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Invoice Generation'**
  String get enhancedInvoiceTitle;

  /// No description provided for @enterAbn.
  ///
  /// In en, this message translates to:
  /// **'Enter ABN'**
  String get enterAbn;

  /// No description provided for @enterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get enterAccountNumber;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter bank name'**
  String get enterBankName;

  /// No description provided for @enterBsb.
  ///
  /// In en, this message translates to:
  /// **'000-000'**
  String get enterBsb;

  /// No description provided for @enterEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmailHint;

  /// No description provided for @enterHourlyRateHint.
  ///
  /// In en, this message translates to:
  /// **'Enter hourly rate'**
  String get enterHourlyRateHint;

  /// No description provided for @enterItemCodeError.
  ///
  /// In en, this message translates to:
  /// **'Please enter item code'**
  String get enterItemCodeError;

  /// No description provided for @enterItemNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter item name'**
  String get enterItemNameError;

  /// No description provided for @enterNewPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new price'**
  String get enterNewPriceHint;

  /// No description provided for @enterPostcode.
  ///
  /// In en, this message translates to:
  /// **'1234'**
  String get enterPostcode;

  /// No description provided for @enterPriceAction.
  ///
  /// In en, this message translates to:
  /// **'Enter Price'**
  String get enterPriceAction;

  /// No description provided for @enterprisePlan.
  ///
  /// In en, this message translates to:
  /// **'Enterprise Plan'**
  String get enterprisePlan;

  /// No description provided for @enterReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter reason for declining'**
  String get enterReasonHint;

  /// No description provided for @enterStreetAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter street address'**
  String get enterStreetAddress;

  /// No description provided for @enterTradingName.
  ///
  /// In en, this message translates to:
  /// **'Enter trading name'**
  String get enterTradingName;

  /// No description provided for @enterUnitPriceError.
  ///
  /// In en, this message translates to:
  /// **'Please enter unit price'**
  String get enterUnitPriceError;

  /// No description provided for @enterValidPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get enterValidPrice;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @entries.
  ///
  /// In en, this message translates to:
  /// **'{count} entries'**
  String entries(String count);

  /// No description provided for @errorFetchingWorkedTime.
  ///
  /// In en, this message translates to:
  /// **'Error fetching worked time: {error}'**
  String errorFetchingWorkedTime(Object error);

  /// No description provided for @errorGeneratingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Error generating invoices: {error}'**
  String errorGeneratingInvoices(Object error);

  /// No description provided for @errorGenericMessage.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get errorGenericMessage;

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'SOMETHING WENT WRONG'**
  String get errorGenericTitle;

  /// No description provided for @errorInitializingAssignment.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize assignment: {error}'**
  String errorInitializingAssignment(String error);

  /// No description provided for @errorInvalidDateRange.
  ///
  /// In en, this message translates to:
  /// **'End date must be on or after start date'**
  String get errorInvalidDateRange;

  /// No description provided for @errorLoadingAssignments.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Assignments'**
  String get errorLoadingAssignments;

  /// No description provided for @errorLoadingAssignmentsError.
  ///
  /// In en, this message translates to:
  /// **'Error loading client assignments: {error}'**
  String errorLoadingAssignmentsError(Object error);

  /// No description provided for @errorLoadingClients.
  ///
  /// In en, this message translates to:
  /// **'Error loading clients: {error}'**
  String errorLoadingClients(String error);

  /// No description provided for @errorLoadingEmployees.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Employees'**
  String get errorLoadingEmployees;

  /// No description provided for @errorLoadingInvoice.
  ///
  /// In en, this message translates to:
  /// **'Error loading invoice'**
  String get errorLoadingInvoice;

  /// No description provided for @errorLoadingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Error loading invoices'**
  String get errorLoadingInvoices;

  /// No description provided for @errorLoadingLineItems.
  ///
  /// In en, this message translates to:
  /// **'Error loading line items: {error}'**
  String errorLoadingLineItems(String error);

  /// No description provided for @errorLoadingRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Error loading recommendations: {error}'**
  String errorLoadingRecommendations(String error);

  /// No description provided for @errorLoadingRoles.
  ///
  /// In en, this message translates to:
  /// **'Error loading roles'**
  String get errorLoadingRoles;

  /// No description provided for @errorLoadingTypes.
  ///
  /// In en, this message translates to:
  /// **'Error loading types'**
  String get errorLoadingTypes;

  /// No description provided for @errorNegativeTaxRate.
  ///
  /// In en, this message translates to:
  /// **'Tax rate cannot be negative when tax is applied'**
  String get errorNegativeTaxRate;

  /// No description provided for @errorNetworkMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the server. Please check your internet connection and try again.'**
  String get errorNetworkMessage;

  /// No description provided for @errorNetworkTitle.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION ERROR'**
  String get errorNetworkTitle;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @errorOccurredStep.
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurredStep;

  /// No description provided for @errorOrgIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Organization ID not found'**
  String get errorOrgIdNotFound;

  /// No description provided for @errorPdfFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'PDF file not found'**
  String get errorPdfFileNotFound;

  /// No description provided for @errorPickingFiles.
  ///
  /// In en, this message translates to:
  /// **'Error picking files: {error}'**
  String errorPickingFiles(Object error);

  /// No description provided for @errorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'Error picking image: {error}'**
  String errorPickingImage(String error);

  /// No description provided for @errorProcessingClient.
  ///
  /// In en, this message translates to:
  /// **'Error processing client: {error}'**
  String errorProcessingClient(Object error);

  /// No description provided for @errorProcessingInvoiceData.
  ///
  /// In en, this message translates to:
  /// **'Error processing invoice data: {error}'**
  String errorProcessingInvoiceData(Object error);

  /// No description provided for @errorProcessingLineItem.
  ///
  /// In en, this message translates to:
  /// **'Error processing line item for {name}: {error}'**
  String errorProcessingLineItem(Object error, Object name);

  /// No description provided for @errorResettingAll.
  ///
  /// In en, this message translates to:
  /// **'Error resetting all: {error}'**
  String errorResettingAll(String error);

  /// No description provided for @errorResettingRateLimit.
  ///
  /// In en, this message translates to:
  /// **'Error resetting rate limit: {error}'**
  String errorResettingRateLimit(String error);

  /// No description provided for @errorRetrievingAssignments.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving assignments for {email}: {error}'**
  String errorRetrievingAssignments(Object email, Object error);

  /// No description provided for @errorRetrievingClientData.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving client data: {error}'**
  String errorRetrievingClientData(Object error);

  /// No description provided for @errorRetrievingInvoiceData.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving invoice data: {error}'**
  String errorRetrievingInvoiceData(Object error);

  /// No description provided for @errorSavingOrganization.
  ///
  /// In en, this message translates to:
  /// **'Error saving organization: {error}'**
  String errorSavingOrganization(String error);

  /// No description provided for @errorSelectAtLeastOneEmployee.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one employee'**
  String get errorSelectAtLeastOneEmployee;

  /// No description provided for @errorSendingInvoiceEmail.
  ///
  /// In en, this message translates to:
  /// **'Error sending invoice email: {error}'**
  String errorSendingInvoiceEmail(Object error);

  /// No description provided for @errorSendingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Error sending invoices: {error}'**
  String errorSendingInvoices(Object error);

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @errorUnblockingIp.
  ///
  /// In en, this message translates to:
  /// **'Error unblocking IP: {error}'**
  String errorUnblockingIp(String error);

  /// No description provided for @errorUpdatingFallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Error updating fallback base rate: {error}'**
  String errorUpdatingFallbackBaseRate(String error);

  /// No description provided for @errorUpdatingRate.
  ///
  /// In en, this message translates to:
  /// **'Error updating rate: {error}'**
  String errorUpdatingRate(String error);

  /// No description provided for @errorUploadingLogo.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload logo: {error}'**
  String errorUploadingLogo(String error);

  /// No description provided for @errorViewingPdf.
  ///
  /// In en, this message translates to:
  /// **'Error viewing PDF: {error}'**
  String errorViewingPdf(Object error);

  /// No description provided for @estimatedTax.
  ///
  /// In en, this message translates to:
  /// **'Estimated Tax'**
  String get estimatedTax;

  /// No description provided for @eveningShiftLabel.
  ///
  /// In en, this message translates to:
  /// **'Evening Shift'**
  String get eveningShiftLabel;

  /// No description provided for @exceedsCap.
  ///
  /// In en, this message translates to:
  /// **'Exceeds Cap'**
  String get exceedsCap;

  /// No description provided for @exceedsCapWarning.
  ///
  /// In en, this message translates to:
  /// **'Exceeds cap!'**
  String get exceedsCapWarning;

  /// No description provided for @exceedsLabel.
  ///
  /// In en, this message translates to:
  /// **'Exceeds'**
  String get exceedsLabel;

  /// No description provided for @excessLabel.
  ///
  /// In en, this message translates to:
  /// **'Excess:'**
  String get excessLabel;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @expenseAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get expenseAmount;

  /// No description provided for @expenseAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get expenseAmountError;

  /// No description provided for @expenseAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get expenseAmountHint;

  /// No description provided for @expenseAmountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get expenseAmountInvalid;

  /// No description provided for @expenseAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get expenseAmountLabel;

  /// No description provided for @expenseApprovedSnack.
  ///
  /// In en, this message translates to:
  /// **'Expense approved'**
  String get expenseApprovedSnack;

  /// No description provided for @expenseAttachmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense Attachments'**
  String get expenseAttachmentsTitle;

  /// No description provided for @expenseButtonSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Expense'**
  String get expenseButtonSubmit;

  /// No description provided for @expenseButtonSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get expenseButtonSubmitting;

  /// No description provided for @expenseButtonUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Expense'**
  String get expenseButtonUpdate;

  /// No description provided for @expenseButtonUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading files...'**
  String get expenseButtonUploading;

  /// No description provided for @expenseCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get expenseCategory;

  /// No description provided for @expenseCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get expenseCategoryLabel;

  /// No description provided for @expenseClientError.
  ///
  /// In en, this message translates to:
  /// **'Error loading clients: {error}'**
  String expenseClientError(String error);

  /// No description provided for @expenseClientHint.
  ///
  /// In en, this message translates to:
  /// **'Select a client'**
  String get expenseClientHint;

  /// No description provided for @expenseClientLabel.
  ///
  /// In en, this message translates to:
  /// **'Client (Optional)'**
  String get expenseClientLabel;

  /// No description provided for @expenseDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get expenseDate;

  /// No description provided for @expenseDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get expenseDateLabel;

  /// No description provided for @expenseDeletedSnack.
  ///
  /// In en, this message translates to:
  /// **'Expense deleted'**
  String get expenseDeletedSnack;

  /// No description provided for @expenseDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter expense description'**
  String get expenseDescriptionHint;

  /// No description provided for @expenseDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get expenseDescriptionLabel;

  /// No description provided for @expenseDetails.
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetails;

  /// No description provided for @expenseDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetailsTitle;

  /// No description provided for @expenseFrequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get expenseFrequencyLabel;

  /// No description provided for @expenseList.
  ///
  /// In en, this message translates to:
  /// **'Expense List'**
  String get expenseList;

  /// No description provided for @expenseManagement.
  ///
  /// In en, this message translates to:
  /// **'EXPENSE MANAGEMENT'**
  String get expenseManagement;

  /// No description provided for @expenseManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor and manage organization expenses'**
  String get expenseManagementDesc;

  /// No description provided for @expenseManagementWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.'**
  String get expenseManagementWelcome;

  /// No description provided for @expenseNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection and try again.'**
  String get expenseNetworkError;

  /// No description provided for @expenseRecurringLabel.
  ///
  /// In en, this message translates to:
  /// **'Recurring Expense'**
  String get expenseRecurringLabel;

  /// No description provided for @expenseRecurringSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable for regularly occurring expenses'**
  String get expenseRecurringSubtitle;

  /// No description provided for @expenseRejectedSnack.
  ///
  /// In en, this message translates to:
  /// **'Expense rejected'**
  String get expenseRejectedSnack;

  /// No description provided for @expenseRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get expenseRetryButton;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @expensesAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add New Expense'**
  String get expensesAddButton;

  /// No description provided for @expensesAllExpenses.
  ///
  /// In en, this message translates to:
  /// **'All Expenses'**
  String get expensesAllExpenses;

  /// No description provided for @expensesDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expensesDetailsTitle;

  /// No description provided for @expensesEmptyDashboardMessage.
  ///
  /// In en, this message translates to:
  /// **'Add expenses to view dashboard statistics'**
  String get expensesEmptyDashboardMessage;

  /// No description provided for @expensesEmptyDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'No Expense Data'**
  String get expensesEmptyDashboardTitle;

  /// No description provided for @expensesEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your first expense to get started'**
  String get expensesEmptyMessage;

  /// No description provided for @expensesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Expenses Found'**
  String get expensesEmptyTitle;

  /// No description provided for @expensesFailedLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load expenses: {error}'**
  String expensesFailedLoad(String error);

  /// No description provided for @expenseSizeError.
  ///
  /// In en, this message translates to:
  /// **'One or more files are too large. Please reduce file size and try again.'**
  String get expenseSizeError;

  /// No description provided for @expensesSettingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Expense settings coming soon...'**
  String get expensesSettingsComingSoon;

  /// No description provided for @expensesTabAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get expensesTabAdd;

  /// No description provided for @expensesTabApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get expensesTabApprovals;

  /// No description provided for @expensesTabDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get expensesTabDashboard;

  /// No description provided for @expensesTabList.
  ///
  /// In en, this message translates to:
  /// **'Expense List'**
  String get expensesTabList;

  /// No description provided for @expensesTabRecurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get expensesTabRecurring;

  /// No description provided for @expensesTabReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get expensesTabReports;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Expense Management'**
  String get expensesTitle;

  /// No description provided for @expenseSubmitGenericError.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit expense'**
  String get expenseSubmitGenericError;

  /// No description provided for @expenseSubmitSuccess.
  ///
  /// In en, this message translates to:
  /// **'Expense submitted successfully'**
  String get expenseSubmitSuccess;

  /// No description provided for @expenseSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Expense submitted successfully'**
  String get expenseSubmittedSuccessfully;

  /// No description provided for @expensesWelcomeDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get expensesWelcomeDismiss;

  /// No description provided for @expensesWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.'**
  String get expensesWelcomeMessage;

  /// No description provided for @expensesWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get expensesWelcomeTitle;

  /// No description provided for @expenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get expenseTitle;

  /// No description provided for @expenseTitleError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get expenseTitleError;

  /// No description provided for @expenseTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter expense title'**
  String get expenseTitleHint;

  /// No description provided for @expenseTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get expenseTitleLabel;

  /// No description provided for @expenseUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Expense updated successfully'**
  String get expenseUpdatedSuccessfully;

  /// No description provided for @expenseUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Expense updated successfully'**
  String get expenseUpdateSuccess;

  /// No description provided for @expenseUploadError.
  ///
  /// In en, this message translates to:
  /// **'File upload failed. Please check your internet connection and try again.'**
  String get expenseUploadError;

  /// No description provided for @expenseUploadProgress.
  ///
  /// In en, this message translates to:
  /// **'Uploading {count} file(s)...'**
  String expenseUploadProgress(int count);

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @expiredCaps.
  ///
  /// In en, this message translates to:
  /// **'EXPIRED'**
  String get expiredCaps;

  /// No description provided for @expiredFilter.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expiredFilter;

  /// No description provided for @expiredStatus.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expiredStatus;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @expiresDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires: {date}'**
  String expiresDetailLabel(String date);

  /// No description provided for @expiresLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires: {date}'**
  String expiresLabel(String date);

  /// No description provided for @expiringSoonStatus.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get expiringSoonStatus;

  /// No description provided for @expiryDateHint.
  ///
  /// In en, this message translates to:
  /// **'Resgistration expiry date'**
  String get expiryDateHint;

  /// No description provided for @expiryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'EXPIRY DATE'**
  String get expiryDateLabel;

  /// No description provided for @exportAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Export analytics'**
  String get exportAnalytics;

  /// No description provided for @exportComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Export functionality coming soon...'**
  String get exportComingSoon;

  /// No description provided for @exportConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Export Configuration'**
  String get exportConfiguration;

  /// No description provided for @exportConfigurationDesc.
  ///
  /// In en, this message translates to:
  /// **'Export current pricing configuration to file'**
  String get exportConfigurationDesc;

  /// No description provided for @exportDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Export your pricing data to various formats'**
  String get exportDataDesc;

  /// No description provided for @exportDataQuickAction.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportDataQuickAction;

  /// No description provided for @exportDataQuickDesc.
  ///
  /// In en, this message translates to:
  /// **'Download current data'**
  String get exportDataQuickDesc;

  /// No description provided for @exportDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportDataTitle;

  /// No description provided for @exportingConfigurationMsg.
  ///
  /// In en, this message translates to:
  /// **'Exporting configuration...'**
  String get exportingConfigurationMsg;

  /// No description provided for @exportingHistory.
  ///
  /// In en, this message translates to:
  /// **'Exporting price history to CSV...'**
  String get exportingHistory;

  /// No description provided for @exportingMsg.
  ///
  /// In en, this message translates to:
  /// **'Exporting {type}...'**
  String exportingMsg(String type);

  /// No description provided for @exportingRatesMsg.
  ///
  /// In en, this message translates to:
  /// **'Exporting rates to CSV...'**
  String get exportingRatesMsg;

  /// No description provided for @exportPricingDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Download current pricing information'**
  String get exportPricingDataSubtitle;

  /// No description provided for @exportPricingDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Pricing Data'**
  String get exportPricingDataTitle;

  /// No description provided for @failedAttempts.
  ///
  /// In en, this message translates to:
  /// **'Failed Attempts'**
  String get failedAttempts;

  /// No description provided for @failedLoadFallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Failed to load fallback base rate: {error}'**
  String failedLoadFallbackBaseRate(String error);

  /// No description provided for @failedOps.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failedOps;

  /// No description provided for @failedToApplyOverrides.
  ///
  /// In en, this message translates to:
  /// **'Failed to apply {count} override(s).'**
  String failedToApplyOverrides(int count);

  /// No description provided for @failedToAssignShift.
  ///
  /// In en, this message translates to:
  /// **'Failed to assign shift'**
  String get failedToAssignShift;

  /// No description provided for @failedToCreateRequest.
  ///
  /// In en, this message translates to:
  /// **'Failed to create request'**
  String get failedToCreateRequest;

  /// No description provided for @failedToCreateShift.
  ///
  /// In en, this message translates to:
  /// **'Failed to create shift'**
  String get failedToCreateShift;

  /// No description provided for @failedToFetchEmployeesError.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch employees: {error}'**
  String failedToFetchEmployeesError(String error);

  /// No description provided for @failedToGetAssignments.
  ///
  /// In en, this message translates to:
  /// **'Failed to get assignments: {error}'**
  String failedToGetAssignments(Object error);

  /// No description provided for @failedToGetAssignmentsLog.
  ///
  /// In en, this message translates to:
  /// **'Failed to get assignments for {email}: {error}'**
  String failedToGetAssignmentsLog(String email, String error);

  /// No description provided for @failedToLoadApiUsage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load API usage data: {error}'**
  String failedToLoadApiUsage(String error);

  /// No description provided for @failedToLoadBusinessOverview.
  ///
  /// In en, this message translates to:
  /// **'Failed to load business overview: {error}'**
  String failedToLoadBusinessOverview(String error);

  /// No description provided for @failedToLoadClients.
  ///
  /// In en, this message translates to:
  /// **'Failed to load clients'**
  String get failedToLoadClients;

  /// No description provided for @failedToLoadEmployees.
  ///
  /// In en, this message translates to:
  /// **'Failed to load employees'**
  String get failedToLoadEmployees;

  /// No description provided for @failedToLoadNdisItems.
  ///
  /// In en, this message translates to:
  /// **'Failed to load NDIS items'**
  String get failedToLoadNdisItems;

  /// No description provided for @failedToLoadRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Failed to load recommendations'**
  String get failedToLoadRecommendations;

  /// No description provided for @failedToLoadShifts.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Shifts'**
  String get failedToLoadShifts;

  /// No description provided for @failedToLoadStats.
  ///
  /// In en, this message translates to:
  /// **'Failed to load business statistics'**
  String get failedToLoadStats;

  /// No description provided for @failedToProcessValidationSummary.
  ///
  /// In en, this message translates to:
  /// **'Failed to process validation summary: {error}'**
  String failedToProcessValidationSummary(Object error);

  /// No description provided for @failedToResetAll.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset all: {message}'**
  String failedToResetAll(String message);

  /// No description provided for @failedToResetRateLimit.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset rate limit: {message}'**
  String failedToResetRateLimit(String message);

  /// No description provided for @failedToSaveInvoice.
  ///
  /// In en, this message translates to:
  /// **'Failed to save invoice for client: {name}, error: {error}'**
  String failedToSaveInvoice(Object error, Object name);

  /// No description provided for @failedToSaveSettings.
  ///
  /// In en, this message translates to:
  /// **'Failed to save configuration: {error}'**
  String failedToSaveSettings(String error);

  /// No description provided for @failedToSendCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification code. Please try again.'**
  String get failedToSendCode;

  /// No description provided for @failedToUnblockIp.
  ///
  /// In en, this message translates to:
  /// **'Failed to unblock IP: {message}'**
  String failedToUnblockIp(String message);

  /// No description provided for @failedToUpdateOrganization.
  ///
  /// In en, this message translates to:
  /// **'Failed to update organization'**
  String get failedToUpdateOrganization;

  /// No description provided for @failedUpdateFallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Failed to update fallback base rate'**
  String get failedUpdateFallbackBaseRate;

  /// No description provided for @fallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Fallback Base Rate'**
  String get fallbackBaseRate;

  /// No description provided for @fallbackBaseRateSection.
  ///
  /// In en, this message translates to:
  /// **'Fallback Base Rate'**
  String get fallbackBaseRateSection;

  /// No description provided for @fallbackCurrencyHint.
  ///
  /// In en, this message translates to:
  /// **'AUD'**
  String get fallbackCurrencyHint;

  /// No description provided for @fallbackRateHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 35.00'**
  String get fallbackRateHint;

  /// No description provided for @fallbackRateUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Fallback base rate updated'**
  String get fallbackRateUpdatedSuccess;

  /// No description provided for @febInitial.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get febInitial;

  /// No description provided for @feedbackDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'What happened? What did you expect to happen?'**
  String get feedbackDescriptionHint;

  /// No description provided for @feedbackDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get feedbackDescriptionLabel;

  /// No description provided for @feedbackDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue'**
  String get feedbackDescriptionRequired;

  /// No description provided for @feedbackError.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit feedback. Please try again.'**
  String get feedbackError;

  /// No description provided for @feedbackInfoNote.
  ///
  /// In en, this message translates to:
  /// **'Device info will be included to help us debug.'**
  String get feedbackInfoNote;

  /// No description provided for @feedbackSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get feedbackSubmit;

  /// No description provided for @feedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue or share your suggestions'**
  String get feedbackSubtitle;

  /// No description provided for @feedbackSuccess.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback!'**
  String get feedbackSuccess;

  /// No description provided for @feedbackSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps us improve CareNest.'**
  String get feedbackSuccessMessage;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get feedbackTitle;

  /// No description provided for @feedbackTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Brief summary of the issue'**
  String get feedbackTitleHint;

  /// No description provided for @feedbackTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Issue Title'**
  String get feedbackTitleLabel;

  /// No description provided for @feedbackTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get feedbackTitleRequired;

  /// No description provided for @fetchingClientsStep.
  ///
  /// In en, this message translates to:
  /// **'Fetching clients...'**
  String get fetchingClientsStep;

  /// No description provided for @fetchingEmployeesStep.
  ///
  /// In en, this message translates to:
  /// **'Fetching employees...'**
  String get fetchingEmployeesStep;

  /// No description provided for @fetchingOrgDataStep.
  ///
  /// In en, this message translates to:
  /// **'Fetching organization data...'**
  String get fetchingOrgDataStep;

  /// No description provided for @fileTypeDoc.
  ///
  /// In en, this message translates to:
  /// **'DOC'**
  String get fileTypeDoc;

  /// No description provided for @fileTypeImg.
  ///
  /// In en, this message translates to:
  /// **'IMG'**
  String get fileTypeImg;

  /// No description provided for @fileTypePdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get fileTypePdf;

  /// No description provided for @fileTypeTxt.
  ///
  /// In en, this message translates to:
  /// **'TXT'**
  String get fileTypeTxt;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filterAction.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterAction;

  /// No description provided for @filterByPricing.
  ///
  /// In en, this message translates to:
  /// **'Filter by Pricing'**
  String get filterByPricing;

  /// No description provided for @filterByState.
  ///
  /// In en, this message translates to:
  /// **'Filter by State'**
  String get filterByState;

  /// No description provided for @filtered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get filtered;

  /// No description provided for @filtersAppliedMsg.
  ///
  /// In en, this message translates to:
  /// **'Filters applied'**
  String get filtersAppliedMsg;

  /// No description provided for @filtersClearedMsg.
  ///
  /// In en, this message translates to:
  /// **'Filters cleared'**
  String get filtersClearedMsg;

  /// No description provided for @filterServiceRatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Service Rates'**
  String get filterServiceRatesTitle;

  /// No description provided for @financialSummary.
  ///
  /// In en, this message translates to:
  /// **'Financial Summary'**
  String get financialSummary;

  /// No description provided for @financialSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Financial Summary'**
  String get financialSummaryTitle;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameHint;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter first name'**
  String get firstNameRequired;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordHeader.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordHeader;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry! Enter your email address and we\'ll send you a verification code to reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @formatOptions.
  ///
  /// In en, this message translates to:
  /// **'FORMAT OPTIONS'**
  String get formatOptions;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @fromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromLabel;

  /// No description provided for @fromLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'FROM:'**
  String get fromLabelCaps;

  /// No description provided for @fromLastWeekStat.
  ///
  /// In en, this message translates to:
  /// **'{count} from last week'**
  String fromLastWeekStat(String count);

  /// No description provided for @futureEndDateError.
  ///
  /// In en, this message translates to:
  /// **'End date cannot be in the future'**
  String get futureEndDateError;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInformation;

  /// No description provided for @generalPricingSettings.
  ///
  /// In en, this message translates to:
  /// **'General Pricing Settings'**
  String get generalPricingSettings;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @generalTab.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalTab;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// No description provided for @generateAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Generate Again'**
  String get generateAgainButton;

  /// No description provided for @generateAllInvoicesButton.
  ///
  /// In en, this message translates to:
  /// **'Generate All Invoices'**
  String get generateAllInvoicesButton;

  /// No description provided for @generatedInvoicesStat.
  ///
  /// In en, this message translates to:
  /// **'Generated Invoices'**
  String get generatedInvoicesStat;

  /// No description provided for @generatedInvoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Generated Invoices'**
  String get generatedInvoicesTitle;

  /// No description provided for @generateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Generate Invoice'**
  String get generateInvoice;

  /// No description provided for @generateInvoicesButton.
  ///
  /// In en, this message translates to:
  /// **'Generate Invoices'**
  String get generateInvoicesButton;

  /// No description provided for @generateInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate Invoice'**
  String get generateInvoiceTitle;

  /// No description provided for @generatePayslip.
  ///
  /// In en, this message translates to:
  /// **'Generate Payslip'**
  String get generatePayslip;

  /// No description provided for @generateReport.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get generateReport;

  /// No description provided for @generateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create new invoice for clients'**
  String get generateSubtitle;

  /// No description provided for @generatingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Generating...'**
  String get generatingInvoices;

  /// No description provided for @generatingInvoicesStep.
  ///
  /// In en, this message translates to:
  /// **'Generating invoices...'**
  String get generatingInvoicesStep;

  /// No description provided for @generatingInvoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Generating Invoices...'**
  String get generatingInvoicesTitle;

  /// No description provided for @generatingReport.
  ///
  /// In en, this message translates to:
  /// **'Generating {type} report...'**
  String generatingReport(String type);

  /// No description provided for @generationCompleteDesc.
  ///
  /// In en, this message translates to:
  /// **'All invoices have been generated successfully.'**
  String get generationCompleteDesc;

  /// No description provided for @generationCompletedStep.
  ///
  /// In en, this message translates to:
  /// **'Invoice generation completed'**
  String get generationCompletedStep;

  /// No description provided for @generationCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Generation Complete!'**
  String get generationCompleteTitle;

  /// No description provided for @generationFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Generation Failed'**
  String get generationFailedTitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @getStartedDesc.
  ///
  /// In en, this message translates to:
  /// **'Set up your business and client information'**
  String get getStartedDesc;

  /// No description provided for @goBackButton.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBackButton;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @goToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Go to Dashboard'**
  String get goToDashboard;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'GRANT PERMISSION'**
  String get grantPermission;

  /// No description provided for @grossIncome.
  ///
  /// In en, this message translates to:
  /// **'Gross Income'**
  String get grossIncome;

  /// No description provided for @growthStat.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% growth'**
  String growthStat(String percentage);

  /// No description provided for @growthStatLabel.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% growth'**
  String growthStatLabel(String percentage);

  /// No description provided for @headquarters.
  ///
  /// In en, this message translates to:
  /// **'Headquarters'**
  String get headquarters;

  /// No description provided for @helpAction.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get helpAction;

  /// No description provided for @highIntensity.
  ///
  /// In en, this message translates to:
  /// **'High Intensity'**
  String get highIntensity;

  /// No description provided for @highIntensityCaps.
  ///
  /// In en, this message translates to:
  /// **'HIGH INTENSITY'**
  String get highIntensityCaps;

  /// No description provided for @highIntensityCare.
  ///
  /// In en, this message translates to:
  /// **'High Intensity Care'**
  String get highIntensityCare;

  /// No description provided for @historicalRecords.
  ///
  /// In en, this message translates to:
  /// **'{count} historical records'**
  String historicalRecords(int count);

  /// No description provided for @historicalRecordsStat.
  ///
  /// In en, this message translates to:
  /// **'{count} historical records'**
  String historicalRecordsStat(String count);

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @holidayAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your holiday has been added successfully'**
  String get holidayAddedSuccessfully;

  /// No description provided for @holidayCreated.
  ///
  /// In en, this message translates to:
  /// **'Holiday Created!'**
  String get holidayCreated;

  /// No description provided for @holidayDetails.
  ///
  /// In en, this message translates to:
  /// **'Holiday Details'**
  String get holidayDetails;

  /// No description provided for @holidayList.
  ///
  /// In en, this message translates to:
  /// **'Holiday List'**
  String get holidayList;

  /// No description provided for @holidayListDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage company holidays'**
  String get holidayListDesc;

  /// No description provided for @holidayName.
  ///
  /// In en, this message translates to:
  /// **'Holiday Name'**
  String get holidayName;

  /// No description provided for @holidayRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Holiday Rate'**
  String get holidayRateLabel;

  /// No description provided for @holidays.
  ///
  /// In en, this message translates to:
  /// **'Holidays'**
  String get holidays;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @hourlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get hourlyLabel;

  /// No description provided for @hoursAbbrev.
  ///
  /// In en, this message translates to:
  /// **'hrs'**
  String get hoursAbbrev;

  /// No description provided for @hoursSuffix.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hoursSuffix;

  /// No description provided for @imDone.
  ///
  /// In en, this message translates to:
  /// **'I\'m done'**
  String get imDone;

  /// No description provided for @importComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Import functionality coming soon...'**
  String get importComingSoon;

  /// No description provided for @importCompletedMsg.
  ///
  /// In en, this message translates to:
  /// **'Import completed successfully for {type}'**
  String importCompletedMsg(String type);

  /// No description provided for @importConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Import Configuration'**
  String get importConfiguration;

  /// No description provided for @importConfigurationDesc.
  ///
  /// In en, this message translates to:
  /// **'Import pricing configuration from file'**
  String get importConfigurationDesc;

  /// No description provided for @importConfigurationDialogHint.
  ///
  /// In en, this message translates to:
  /// **'Import configuration dialog would open here'**
  String get importConfigurationDialogHint;

  /// No description provided for @importDataDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload CSV or Excel files to import pricing data in bulk'**
  String get importDataDesc;

  /// No description provided for @importDataQuickAction.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importDataQuickAction;

  /// No description provided for @importDataQuickDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload CSV or Excel files'**
  String get importDataQuickDesc;

  /// No description provided for @importDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importDataTitle;

  /// No description provided for @importFailedMsg.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailedMsg(String error);

  /// No description provided for @importFromCsv.
  ///
  /// In en, this message translates to:
  /// **'Import from CSV'**
  String get importFromCsv;

  /// No description provided for @improvementStat.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% improvement'**
  String improvementStat(String percentage);

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @includeComprehensivePricing.
  ///
  /// In en, this message translates to:
  /// **'Include comprehensive pricing details'**
  String get includeComprehensivePricing;

  /// No description provided for @includeExpenses.
  ///
  /// In en, this message translates to:
  /// **'Include Expenses'**
  String get includeExpenses;

  /// No description provided for @includeExpensesOption.
  ///
  /// In en, this message translates to:
  /// **'Include Expenses'**
  String get includeExpensesOption;

  /// No description provided for @includeExpensesOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Add expense items to invoices'**
  String get includeExpensesOptionDesc;

  /// No description provided for @includeExpensesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add expense items to the invoice'**
  String get includeExpensesSubtitle;

  /// No description provided for @includeExpensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Include Expenses'**
  String get includeExpensesTitle;

  /// No description provided for @includeTaxCalculations.
  ///
  /// In en, this message translates to:
  /// **'Include tax calculations'**
  String get includeTaxCalculations;

  /// No description provided for @includeTaxSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add tax calculations to the invoice'**
  String get includeTaxSubtitle;

  /// No description provided for @includeTaxTitle.
  ///
  /// In en, this message translates to:
  /// **'Include Tax (GST)'**
  String get includeTaxTitle;

  /// No description provided for @increases.
  ///
  /// In en, this message translates to:
  /// **'Increases'**
  String get increases;

  /// No description provided for @initiatingMsg.
  ///
  /// In en, this message translates to:
  /// **'Initiating {type}...'**
  String initiatingMsg(String type);

  /// No description provided for @inProgressStatus.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressStatus;

  /// No description provided for @institutionLabel.
  ///
  /// In en, this message translates to:
  /// **'INSTITUTION'**
  String get institutionLabel;

  /// No description provided for @integrationAccountingSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Integration with external accounting software'**
  String get integrationAccountingSystemDescription;

  /// No description provided for @integrationAccountingSystemName.
  ///
  /// In en, this message translates to:
  /// **'Accounting System'**
  String get integrationAccountingSystemName;

  /// No description provided for @integrationCrmSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'Customer relationship management system integration'**
  String get integrationCrmSystemDescription;

  /// No description provided for @integrationCrmSystemName.
  ///
  /// In en, this message translates to:
  /// **'CRM System'**
  String get integrationCrmSystemName;

  /// No description provided for @integrationNdisPriceGuideApiDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatic synchronization with NDIS price guide updates'**
  String get integrationNdisPriceGuideApiDescription;

  /// No description provided for @integrationNdisPriceGuideApiName.
  ///
  /// In en, this message translates to:
  /// **'NDIS Price Guide API'**
  String get integrationNdisPriceGuideApiName;

  /// No description provided for @integrationsTab.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get integrationsTab;

  /// No description provided for @invalidAssignmentsStructure.
  ///
  /// In en, this message translates to:
  /// **'Invalid assignments data structure for {email}'**
  String invalidAssignmentsStructure(Object email);

  /// No description provided for @invalidDuration.
  ///
  /// In en, this message translates to:
  /// **'Invalid duration'**
  String get invalidDuration;

  /// No description provided for @invalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Invalid price'**
  String get invalidPrice;

  /// No description provided for @invalidPriceEntered.
  ///
  /// In en, this message translates to:
  /// **'Invalid price entered'**
  String get invalidPriceEntered;

  /// No description provided for @invalidPriceError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price'**
  String get invalidPriceError;

  /// No description provided for @invalidScheduleData.
  ///
  /// In en, this message translates to:
  /// **'Invalid schedule data format'**
  String get invalidScheduleData;

  /// No description provided for @invalidTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid time format'**
  String get invalidTimeFormat;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalidValue;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @invoiceConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Invoice Configuration'**
  String get invoiceConfiguration;

  /// No description provided for @invoiceConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Configuration'**
  String get invoiceConfigurationTitle;

  /// No description provided for @invoiceCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No invoices} =1{1 invoice} other{{count} invoices}}'**
  String invoiceCount(int count);

  /// No description provided for @invoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice Date'**
  String get invoiceDate;

  /// No description provided for @invoiceDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Invoice deleted successfully'**
  String get invoiceDeletedSuccess;

  /// No description provided for @invoiceDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete invoice: {error}'**
  String invoiceDeleteError(String error);

  /// No description provided for @invoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetails;

  /// No description provided for @invoiceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetailsTitle;

  /// No description provided for @invoiceGenerationCancelled.
  ///
  /// In en, this message translates to:
  /// **'Invoice generation cancelled by user'**
  String get invoiceGenerationCancelled;

  /// No description provided for @invoiceList.
  ///
  /// In en, this message translates to:
  /// **'Invoice List'**
  String get invoiceList;

  /// No description provided for @invoiceListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage generated invoices'**
  String get invoiceListSubtitle;

  /// No description provided for @invoiceManagement.
  ///
  /// In en, this message translates to:
  /// **'INVOICE MANAGEMENT'**
  String get invoiceManagement;

  /// No description provided for @invoiceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Invoice not found'**
  String get invoiceNotFound;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get invoiceNumber;

  /// No description provided for @invoiceNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get invoiceNumberLabel;

  /// No description provided for @invoicePeriod.
  ///
  /// In en, this message translates to:
  /// **'Invoice Period'**
  String get invoicePeriod;

  /// No description provided for @invoicePeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Period'**
  String get invoicePeriodTitle;

  /// No description provided for @invoicesCaps.
  ///
  /// In en, this message translates to:
  /// **'INVOICES'**
  String get invoicesCaps;

  /// No description provided for @invoicesGenerated.
  ///
  /// In en, this message translates to:
  /// **'Invoices Generated'**
  String get invoicesGenerated;

  /// No description provided for @invoiceSharedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Invoice shared'**
  String get invoiceSharedSuccess;

  /// No description provided for @invoicesReadyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 invoice ready} other{{count} invoices ready}}'**
  String invoicesReadyCount(int count);

  /// No description provided for @invoicesSentError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send invoices'**
  String get invoicesSentError;

  /// No description provided for @invoicesSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Invoices sent successfully!'**
  String get invoicesSentSuccess;

  /// No description provided for @invoiceStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice Status'**
  String get invoiceStatusLabel;

  /// No description provided for @invoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesTitle;

  /// No description provided for @invoiceTypeClient.
  ///
  /// In en, this message translates to:
  /// **'Client Invoice (bill the client)'**
  String get invoiceTypeClient;

  /// No description provided for @invoiceTypeEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee Invoice (bill the employee)'**
  String get invoiceTypeEmployee;

  /// No description provided for @invoiceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice Type'**
  String get invoiceTypeLabel;

  /// No description provided for @invoiceTypeRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Invoice type must be selected'**
  String get invoiceTypeRequiredError;

  /// No description provided for @invoiceTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose who will be billed on the invoice'**
  String get invoiceTypeSubtitle;

  /// No description provided for @invoiceTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Type'**
  String get invoiceTypeTitle;

  /// No description provided for @invoiceTypeWarning.
  ///
  /// In en, this message translates to:
  /// **'Select an invoice type before generating'**
  String get invoiceTypeWarning;

  /// No description provided for @ipsCurrentlyBlocked.
  ///
  /// In en, this message translates to:
  /// **'{count} IPs currently blocked'**
  String ipsCurrentlyBlocked(String count);

  /// No description provided for @ipUnblockedSuccess.
  ///
  /// In en, this message translates to:
  /// **'IP address {ip} unblocked successfully'**
  String ipUnblockedSuccess(String ip);

  /// No description provided for @isMandatoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Is Mandatory'**
  String get isMandatoryLabel;

  /// No description provided for @isNdisRegistered.
  ///
  /// In en, this message translates to:
  /// **'Is this organization NDIS registered?'**
  String get isNdisRegistered;

  /// No description provided for @issueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get issueDateLabel;

  /// No description provided for @issuerFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get issuerFieldLabel;

  /// No description provided for @issuerLabel.
  ///
  /// In en, this message translates to:
  /// **'Issuer: {issuer}'**
  String issuerLabel(String issuer);

  /// No description provided for @itemCode.
  ///
  /// In en, this message translates to:
  /// **'Item Code'**
  String get itemCode;

  /// No description provided for @itemCodeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 01_001_0103_1_1'**
  String get itemCodeHint;

  /// No description provided for @itemCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Item Code'**
  String get itemCodeLabel;

  /// No description provided for @itemDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Item deleted successfully!'**
  String get itemDeletedSuccess;

  /// No description provided for @itemDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Brief description of the service'**
  String get itemDescriptionHint;

  /// No description provided for @itemInfoTemplate.
  ///
  /// In en, this message translates to:
  /// **'{itemName} ({itemNumber})'**
  String itemInfoTemplate(String itemName, String itemNumber);

  /// No description provided for @itemLabel.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get itemLabel;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @itemNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Assistance with personal activities'**
  String get itemNameHint;

  /// No description provided for @itemNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemNameLabel;

  /// No description provided for @itemNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Item {number}'**
  String itemNumberLabel(int number);

  /// No description provided for @itemsLabel.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get itemsLabel;

  /// No description provided for @itemsMissingClientRate.
  ///
  /// In en, this message translates to:
  /// **'Items missing client-specific base rate:'**
  String get itemsMissingClientRate;

  /// No description provided for @itemsMissingOrgRate.
  ///
  /// In en, this message translates to:
  /// **'Items missing organization base rate ({count}):'**
  String itemsMissingOrgRate(Object count);

  /// No description provided for @itemStatusActivated.
  ///
  /// In en, this message translates to:
  /// **'activated'**
  String get itemStatusActivated;

  /// No description provided for @itemStatusChanged.
  ///
  /// In en, this message translates to:
  /// **'Item {status} successfully!'**
  String itemStatusChanged(String status);

  /// No description provided for @itemStatusDeactivated.
  ///
  /// In en, this message translates to:
  /// **'deactivated'**
  String get itemStatusDeactivated;

  /// No description provided for @itemsUnit.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get itemsUnit;

  /// No description provided for @itemTimestampLabel.
  ///
  /// In en, this message translates to:
  /// **'Item: {itemCode} • {timestamp}'**
  String itemTimestampLabel(String itemCode, String timestamp);

  /// No description provided for @janInitial.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get janInitial;

  /// No description provided for @jobLabel.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get jobLabel;

  /// No description provided for @jobLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'JOB:'**
  String get jobLabelCaps;

  /// No description provided for @jobRoleFallback.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get jobRoleFallback;

  /// No description provided for @joinExistingOrg.
  ///
  /// In en, this message translates to:
  /// **'Join Existing Organization'**
  String get joinExistingOrg;

  /// No description provided for @joinExistingOrgDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter organization code to join'**
  String get joinExistingOrgDesc;

  /// No description provided for @joinOrganization.
  ///
  /// In en, this message translates to:
  /// **'Join Organization'**
  String get joinOrganization;

  /// No description provided for @joinOrganizationMessage.
  ///
  /// In en, this message translates to:
  /// **'Join our organization: {name}'**
  String joinOrganizationMessage(String name);

  /// No description provided for @joinOrgSection.
  ///
  /// In en, this message translates to:
  /// **'Join Organization'**
  String get joinOrgSection;

  /// No description provided for @julInitial.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get julInitial;

  /// No description provided for @junInitial.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get junInitial;

  /// No description provided for @keyMetrics.
  ///
  /// In en, this message translates to:
  /// **'Key Metrics'**
  String get keyMetrics;

  /// No description provided for @knowYourBusiness.
  ///
  /// In en, this message translates to:
  /// **'Know Your\nBusiness!'**
  String get knowYourBusiness;

  /// No description provided for @knowYourClient.
  ///
  /// In en, this message translates to:
  /// **'Know Your\nClient!'**
  String get knowYourClient;

  /// No description provided for @last.
  ///
  /// In en, this message translates to:
  /// **'Last: {date}'**
  String last(String date);

  /// No description provided for @lastModified.
  ///
  /// In en, this message translates to:
  /// **'Last modified: {date}'**
  String lastModified(String date);

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameHint;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter last name'**
  String get lastNameRequired;

  /// No description provided for @lastSynced.
  ///
  /// In en, this message translates to:
  /// **'Last synced: {time}'**
  String lastSynced(String time);

  /// No description provided for @lastSyncedTimeAgo.
  ///
  /// In en, this message translates to:
  /// **'Last synced: {timeAgo}'**
  String lastSyncedTimeAgo(String timeAgo);

  /// No description provided for @lastUpdatedColumn.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdatedColumn;

  /// No description provided for @lastUpdatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdatedLabel;

  /// No description provided for @leaveTracker.
  ///
  /// In en, this message translates to:
  /// **'Leave Insights'**
  String get leaveTracker;

  /// No description provided for @leaveTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'View balances, forecast leave, and submit requests.'**
  String get leaveTrackerDesc;

  /// No description provided for @leaveTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Leave Type'**
  String get leaveTypeLabel;

  /// No description provided for @legalName.
  ///
  /// In en, this message translates to:
  /// **'Legal Name'**
  String get legalName;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get levelLabel;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @lineChart.
  ///
  /// In en, this message translates to:
  /// **'Line Chart'**
  String get lineChart;

  /// No description provided for @lineTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Line Total'**
  String get lineTotalLabel;

  /// No description provided for @linkLabel.
  ///
  /// In en, this message translates to:
  /// **'Link: {url}'**
  String linkLabel(String url);

  /// No description provided for @liveData.
  ///
  /// In en, this message translates to:
  /// **'Live Data'**
  String get liveData;

  /// No description provided for @liveSse.
  ///
  /// In en, this message translates to:
  /// **'Live (SSE)'**
  String get liveSse;

  /// No description provided for @liveStreamUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Live stream unavailable ({statusCode})'**
  String liveStreamUnavailable(String statusCode);

  /// No description provided for @liveTracking.
  ///
  /// In en, this message translates to:
  /// **'Live Insights'**
  String get liveTracking;

  /// No description provided for @loadingAppointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Loading appointment details...'**
  String get loadingAppointmentDetails;

  /// No description provided for @loadingBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Loading businesses...'**
  String get loadingBusinesses;

  /// No description provided for @loadingClients.
  ///
  /// In en, this message translates to:
  /// **'Loading clients...'**
  String get loadingClients;

  /// No description provided for @loadingClientsText.
  ///
  /// In en, this message translates to:
  /// **'Loading clients...'**
  String get loadingClientsText;

  /// No description provided for @loadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Loading Dashboard...'**
  String get loadingDashboard;

  /// No description provided for @loadingEarnings.
  ///
  /// In en, this message translates to:
  /// **'Loading Earnings...'**
  String get loadingEarnings;

  /// No description provided for @loadingEmployeesAndClients.
  ///
  /// In en, this message translates to:
  /// **'Loading employees and clients...'**
  String get loadingEmployeesAndClients;

  /// No description provided for @loadingInvoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Loading invoice details...'**
  String get loadingInvoiceDetails;

  /// No description provided for @loadingInvoiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading invoice {number}...'**
  String loadingInvoiceMessage(String number);

  /// No description provided for @loadingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Loading invoices...'**
  String get loadingInvoices;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingMessage;

  /// No description provided for @loadingNdisItems.
  ///
  /// In en, this message translates to:
  /// **'Loading NDIS items'**
  String get loadingNdisItems;

  /// No description provided for @loadingOverview.
  ///
  /// In en, this message translates to:
  /// **'Loading Overview...'**
  String get loadingOverview;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @locationNotSet.
  ///
  /// In en, this message translates to:
  /// **'Location not set'**
  String get locationNotSet;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLink;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcome;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmMessage;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get logoutSubtitle;

  /// No description provided for @manageAndOptimizeDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage and optimize your service pricing'**
  String get manageAndOptimizeDesc;

  /// No description provided for @manageChecklistsTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Checklists'**
  String get manageChecklistsTitle;

  /// No description provided for @managerApprovalMessage.
  ///
  /// In en, this message translates to:
  /// **'All requests will be sent for a manager\'s approval'**
  String get managerApprovalMessage;

  /// No description provided for @manageTraining.
  ///
  /// In en, this message translates to:
  /// **'Manage Training'**
  String get manageTraining;

  /// No description provided for @manageTrainingDesc.
  ///
  /// In en, this message translates to:
  /// **'Create and update training modules'**
  String get manageTrainingDesc;

  /// No description provided for @manageTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Training'**
  String get manageTrainingTitle;

  /// No description provided for @marInitial.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get marInitial;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All Read'**
  String get markAllRead;

  /// No description provided for @markAsCompletedButton.
  ///
  /// In en, this message translates to:
  /// **'Mark as Completed'**
  String get markAsCompletedButton;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsRead;

  /// No description provided for @maximumPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum: {price}'**
  String maximumPriceLabel(String price);

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get maxPrice;

  /// No description provided for @maxPriceVariation.
  ///
  /// In en, this message translates to:
  /// **'Max Price Variation'**
  String get maxPriceVariation;

  /// No description provided for @mayInitial.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get mayInitial;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @metricHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get metricHours;

  /// No description provided for @metricMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get metricMargin;

  /// No description provided for @metricRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get metricRate;

  /// No description provided for @metricRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get metricRevenue;

  /// No description provided for @mileageAdmin.
  ///
  /// In en, this message translates to:
  /// **'Mileage Admin'**
  String get mileageAdmin;

  /// No description provided for @mileageAdminDesc.
  ///
  /// In en, this message translates to:
  /// **'Review & approve employee trips'**
  String get mileageAdminDesc;

  /// No description provided for @mileageTracker.
  ///
  /// In en, this message translates to:
  /// **'Mileage Insights'**
  String get mileageTracker;

  /// No description provided for @mileageTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor your trips, calculate distance, and log reimbursable mileage.'**
  String get mileageTrackerDesc;

  /// No description provided for @minimumDuration.
  ///
  /// In en, this message translates to:
  /// **'Minimum duration is 30 minutes'**
  String get minimumDuration;

  /// No description provided for @minimumDuration30.
  ///
  /// In en, this message translates to:
  /// **'Minimum appointment duration is 30 minutes'**
  String get minimumDuration30;

  /// No description provided for @missingBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Missing Base Rate'**
  String get missingBaseRate;

  /// No description provided for @missingBaseRatesMessage.
  ///
  /// In en, this message translates to:
  /// **'Base service rates are missing or using fallback for {count} NDIS item(s): {items}. Please add custom pricing or set price overrides.'**
  String missingBaseRatesMessage(Object count, Object items);

  /// No description provided for @missingBaseRatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Missing Base Rates'**
  String get missingBaseRatesTitle;

  /// No description provided for @missingClientIdError.
  ///
  /// In en, this message translates to:
  /// **'Missing client ID for saving pricing'**
  String get missingClientIdError;

  /// No description provided for @missingData.
  ///
  /// In en, this message translates to:
  /// **'Missing Data'**
  String get missingData;

  /// No description provided for @missingItemsDetected.
  ///
  /// In en, this message translates to:
  /// **'Missing Base Rates Detected'**
  String get missingItemsDetected;

  /// No description provided for @missingItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'Missing Items'**
  String get missingItemsTitle;

  /// No description provided for @missingUserContext.
  ///
  /// In en, this message translates to:
  /// **'Missing user context: userEmail'**
  String get missingUserContext;

  /// No description provided for @missingUserEmail.
  ///
  /// In en, this message translates to:
  /// **'User email is missing. Cannot save pricing.'**
  String get missingUserEmail;

  /// No description provided for @modifiedLabel.
  ///
  /// In en, this message translates to:
  /// **'MODIFIED'**
  String get modifiedLabel;

  /// No description provided for @moduleBadgeActions.
  ///
  /// In en, this message translates to:
  /// **'Action Center'**
  String get moduleBadgeActions;

  /// No description provided for @moduleBadgeBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk Queue'**
  String get moduleBadgeBulk;

  /// No description provided for @moduleBadgeHistory.
  ///
  /// In en, this message translates to:
  /// **'Change History'**
  String get moduleBadgeHistory;

  /// No description provided for @moduleBadgeNdis.
  ///
  /// In en, this message translates to:
  /// **'NDIS Catalog'**
  String get moduleBadgeNdis;

  /// No description provided for @moduleBadgeOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get moduleBadgeOverview;

  /// No description provided for @moduleBadgeRates.
  ///
  /// In en, this message translates to:
  /// **'Rate Coverage'**
  String get moduleBadgeRates;

  /// No description provided for @moduleKeyInsightActionCenter.
  ///
  /// In en, this message translates to:
  /// **'Central queue for pricing follow-ups'**
  String get moduleKeyInsightActionCenter;

  /// No description provided for @moduleKeyInsightAllRatesConfigured.
  ///
  /// In en, this message translates to:
  /// **'All employee rates are configured'**
  String get moduleKeyInsightAllRatesConfigured;

  /// No description provided for @moduleKeyInsightBacklog.
  ///
  /// In en, this message translates to:
  /// **'{pending} of {total} items are pending updates'**
  String moduleKeyInsightBacklog(String pending, String total);

  /// No description provided for @moduleKeyInsightBatchSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggested batch size: {batch}'**
  String moduleKeyInsightBatchSuggestion(String batch);

  /// No description provided for @moduleKeyInsightClearQueue.
  ///
  /// In en, this message translates to:
  /// **'No pending actions in queue'**
  String get moduleKeyInsightClearQueue;

  /// No description provided for @moduleKeyInsightCoverage.
  ///
  /// In en, this message translates to:
  /// **'{custom}/{total} items with custom pricing'**
  String moduleKeyInsightCoverage(String custom, String total);

  /// No description provided for @moduleKeyInsightHealthy.
  ///
  /// In en, this message translates to:
  /// **'Compliance signals are healthy'**
  String get moduleKeyInsightHealthy;

  /// No description provided for @moduleKeyInsightHistory.
  ///
  /// In en, this message translates to:
  /// **'{count} priced items are tracked in history'**
  String moduleKeyInsightHistory(String count);

  /// No description provided for @moduleKeyInsightMissingRates.
  ///
  /// In en, this message translates to:
  /// **'{count} employees still missing pay rates'**
  String moduleKeyInsightMissingRates(String count);

  /// No description provided for @moduleKeyInsightPendingActions.
  ///
  /// In en, this message translates to:
  /// **'{count} items need immediate action'**
  String moduleKeyInsightPendingActions(String count);

  /// No description provided for @moduleKeyInsightQuotable.
  ///
  /// In en, this message translates to:
  /// **'{count} quotable supports need tracked handling'**
  String moduleKeyInsightQuotable(String count);

  /// No description provided for @moduleKeyInsightViolations.
  ///
  /// In en, this message translates to:
  /// **'{count} compliance issues need review'**
  String moduleKeyInsightViolations(String count);

  /// No description provided for @moduleLastUpdatedDays.
  ///
  /// In en, this message translates to:
  /// **'Last updated {days}d ago'**
  String moduleLastUpdatedDays(String days);

  /// No description provided for @moduleMetricActionableItems.
  ///
  /// In en, this message translates to:
  /// **'Actionable Items'**
  String get moduleMetricActionableItems;

  /// No description provided for @moduleMetricAvailableActions.
  ///
  /// In en, this message translates to:
  /// **'Available Modules'**
  String get moduleMetricAvailableActions;

  /// No description provided for @moduleMetricAvgBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Avg Base Rate'**
  String get moduleMetricAvgBaseRate;

  /// No description provided for @moduleMetricBulkCandidates.
  ///
  /// In en, this message translates to:
  /// **'Bulk Candidates'**
  String get moduleMetricBulkCandidates;

  /// No description provided for @moduleMetricCatalogItems.
  ///
  /// In en, this message translates to:
  /// **'Catalog Items'**
  String get moduleMetricCatalogItems;

  /// No description provided for @moduleMetricCompliance.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get moduleMetricCompliance;

  /// No description provided for @moduleMetricConfiguredRates.
  ///
  /// In en, this message translates to:
  /// **'Configured Rates'**
  String get moduleMetricConfiguredRates;

  /// No description provided for @moduleMetricCoverage.
  ///
  /// In en, this message translates to:
  /// **'Coverage'**
  String get moduleMetricCoverage;

  /// No description provided for @moduleMetricCustomPrices.
  ///
  /// In en, this message translates to:
  /// **'Custom Prices'**
  String get moduleMetricCustomPrices;

  /// No description provided for @moduleMetricRecommendedBatch.
  ///
  /// In en, this message translates to:
  /// **'Recommended Batch'**
  String get moduleMetricRecommendedBatch;

  /// No description provided for @moduleMetricRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get moduleMetricRevenue;

  /// No description provided for @moduleMetricTrackedEntries.
  ///
  /// In en, this message translates to:
  /// **'Insights Entries'**
  String get moduleMetricTrackedEntries;

  /// No description provided for @moduleMetricWeeklyChanges.
  ///
  /// In en, this message translates to:
  /// **'Weekly Changes'**
  String get moduleMetricWeeklyChanges;

  /// No description provided for @moduleNoDataYet.
  ///
  /// In en, this message translates to:
  /// **'No data available yet'**
  String get moduleNoDataYet;

  /// No description provided for @moduleNoTrackedChanges.
  ///
  /// In en, this message translates to:
  /// **'No insights changes yet'**
  String get moduleNoTrackedChanges;

  /// No description provided for @moduleRatesCoverage.
  ///
  /// In en, this message translates to:
  /// **'{configured}/{total} rates configured'**
  String moduleRatesCoverage(String configured, String total);

  /// No description provided for @moduleStatusHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get moduleStatusHealthy;

  /// No description provided for @moduleStatusIdle.
  ///
  /// In en, this message translates to:
  /// **'Idle'**
  String get moduleStatusIdle;

  /// No description provided for @moduleStatusNeedsAction.
  ///
  /// In en, this message translates to:
  /// **'Needs Action'**
  String get moduleStatusNeedsAction;

  /// No description provided for @moduleStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get moduleStatusReady;

  /// No description provided for @moduleStatusRecentlyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Recently Updated'**
  String get moduleStatusRecentlyUpdated;

  /// No description provided for @monitorPricingPerformance.
  ///
  /// In en, this message translates to:
  /// **'Monitor your pricing performance and trends'**
  String get monitorPricingPerformance;

  /// No description provided for @monthDayYearExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 1/2/2025 → January 2, 2025'**
  String get monthDayYearExample;

  /// No description provided for @monthDayYearUs.
  ///
  /// In en, this message translates to:
  /// **'Month/Day/Year (US)'**
  String get monthDayYearUs;

  /// No description provided for @monthlySummary.
  ///
  /// In en, this message translates to:
  /// **'Monthly Summary'**
  String get monthlySummary;

  /// No description provided for @monthlyToggle.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY'**
  String get monthlyToggle;

  /// No description provided for @moreButton.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreButton;

  /// No description provided for @moreLabel.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreLabel;

  /// No description provided for @multiOrgRollupTitle.
  ///
  /// In en, this message translates to:
  /// **'MULTI-ORG ROLLUP'**
  String get multiOrgRollupTitle;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get myRequests;

  /// No description provided for @naLabel.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get naLabel;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @ndisCapActionGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go back to adjust prices'**
  String get ndisCapActionGoBack;

  /// No description provided for @ndisCapActionProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed with invoice generation anyway'**
  String get ndisCapActionProceed;

  /// No description provided for @ndisCapActionTitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do?'**
  String get ndisCapActionTitle;

  /// No description provided for @ndisCapExceededMessage.
  ///
  /// In en, this message translates to:
  /// **'The following items exceed NDIS price caps:'**
  String get ndisCapExceededMessage;

  /// No description provided for @ndisCapExceededTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Price Cap Exceeded'**
  String get ndisCapExceededTitle;

  /// No description provided for @ndisCapHighIntensity.
  ///
  /// In en, this message translates to:
  /// **'High Intensity'**
  String get ndisCapHighIntensity;

  /// No description provided for @ndisCapLabel.
  ///
  /// In en, this message translates to:
  /// **'NDIS Cap'**
  String get ndisCapLabel;

  /// No description provided for @ndisCapStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get ndisCapStandard;

  /// No description provided for @ndisComplianceCheckSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify NDIS pricing compliance'**
  String get ndisComplianceCheckSubtitle;

  /// No description provided for @ndisComplianceCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Compliance Check'**
  String get ndisComplianceCheckTitle;

  /// No description provided for @ndisCore.
  ///
  /// In en, this message translates to:
  /// **'NDIS Core'**
  String get ndisCore;

  /// No description provided for @ndisItemCardSemantics.
  ///
  /// In en, this message translates to:
  /// **'NDIS item card'**
  String get ndisItemCardSemantics;

  /// No description provided for @ndisItemCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'NDIS item created successfully!'**
  String get ndisItemCreatedSuccess;

  /// No description provided for @ndisItemManagement.
  ///
  /// In en, this message translates to:
  /// **'NDIS Item Management'**
  String get ndisItemManagement;

  /// No description provided for @ndisItemManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Item Management'**
  String get ndisItemManagementTitle;

  /// No description provided for @ndisItemRequired.
  ///
  /// In en, this message translates to:
  /// **'NDIS Service Item is required'**
  String get ndisItemRequired;

  /// No description provided for @ndisItems.
  ///
  /// In en, this message translates to:
  /// **'NDIS Items'**
  String get ndisItems;

  /// No description provided for @ndisItemsCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'item codes'**
  String get ndisItemsCardSubtitle;

  /// No description provided for @ndisItemsCardTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Items'**
  String get ndisItemsCardTitle;

  /// No description provided for @ndisItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} NDIS items'**
  String ndisItemsCount(int count);

  /// No description provided for @ndisItemsOnlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'items and rates'**
  String get ndisItemsOnlySubtitle;

  /// No description provided for @ndisItemsOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Items Only'**
  String get ndisItemsOnlyTitle;

  /// No description provided for @ndisItemsStat.
  ///
  /// In en, this message translates to:
  /// **'{count} NDIS items'**
  String ndisItemsStat(String count);

  /// No description provided for @ndisItemUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'NDIS item updated successfully!'**
  String get ndisItemUpdatedSuccess;

  /// No description provided for @ndisLabel.
  ///
  /// In en, this message translates to:
  /// **'NDIS'**
  String get ndisLabel;

  /// No description provided for @ndisPricing.
  ///
  /// In en, this message translates to:
  /// **'NDIS Pricing'**
  String get ndisPricing;

  /// No description provided for @ndisPricingDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage NDIS rates and compliance'**
  String get ndisPricingDesc;

  /// No description provided for @ndisPricingManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage custom pricing for NDIS support items'**
  String get ndisPricingManagementSubtitle;

  /// No description provided for @ndisPricingManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Pricing Management'**
  String get ndisPricingManagementTitle;

  /// No description provided for @ndisPricingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage NDIS rates and compliance'**
  String get ndisPricingSubtitle;

  /// No description provided for @ndisPricingTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Pricing'**
  String get ndisPricingTitle;

  /// No description provided for @ndisRegistration.
  ///
  /// In en, this message translates to:
  /// **'NDIS Registration'**
  String get ndisRegistration;

  /// No description provided for @ndisServiceItemLabel.
  ///
  /// In en, this message translates to:
  /// **'NDIS Service Item'**
  String get ndisServiceItemLabel;

  /// No description provided for @ndisTab.
  ///
  /// In en, this message translates to:
  /// **'NDIS'**
  String get ndisTab;

  /// No description provided for @ndisTemplateDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete NDIS service items with codes and descriptions'**
  String get ndisTemplateDesc;

  /// No description provided for @ndisTemplateTitle.
  ///
  /// In en, this message translates to:
  /// **'NDIS Items'**
  String get ndisTemplateTitle;

  /// No description provided for @netPay.
  ///
  /// In en, this message translates to:
  /// **'Net Pay'**
  String get netPay;

  /// No description provided for @newAction.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newAction;

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newBadge;

  /// No description provided for @newBusiness.
  ///
  /// In en, this message translates to:
  /// **'New Business'**
  String get newBusiness;

  /// No description provided for @newBusinessTitle.
  ///
  /// In en, this message translates to:
  /// **'New Business'**
  String get newBusinessTitle;

  /// No description provided for @newClientTitle.
  ///
  /// In en, this message translates to:
  /// **'New Client'**
  String get newClientTitle;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordHint;

  /// No description provided for @newPrice.
  ///
  /// In en, this message translates to:
  /// **'New Price'**
  String get newPrice;

  /// No description provided for @newPricingItemAdded.
  ///
  /// In en, this message translates to:
  /// **'New pricing item added'**
  String get newPricingItemAdded;

  /// No description provided for @newRequest.
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get newRequest;

  /// No description provided for @newRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'New Request'**
  String get newRequestTitle;

  /// No description provided for @newThisMonthStat.
  ///
  /// In en, this message translates to:
  /// **'{count} new this month'**
  String newThisMonthStat(String count);

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @nextShiftCaps.
  ///
  /// In en, this message translates to:
  /// **'NEXT SHIFT'**
  String get nextShiftCaps;

  /// No description provided for @nightShiftLabel.
  ///
  /// In en, this message translates to:
  /// **'Night Shift'**
  String get nightShiftLabel;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noActiveConnections.
  ///
  /// In en, this message translates to:
  /// **'No active connections'**
  String get noActiveConnections;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments'**
  String get noAppointments;

  /// No description provided for @noAssignedClientsError.
  ///
  /// In en, this message translates to:
  /// **'No assigned clients found. Please check your assignments.'**
  String get noAssignedClientsError;

  /// No description provided for @noAssignmentData.
  ///
  /// In en, this message translates to:
  /// **'No assignment data available'**
  String get noAssignmentData;

  /// No description provided for @noAssignmentFoundForClient.
  ///
  /// In en, this message translates to:
  /// **'No assignment found for client {name} ({id})'**
  String noAssignmentFoundForClient(Object id, Object name);

  /// No description provided for @noAssignmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No Assignments Found'**
  String get noAssignmentsFound;

  /// No description provided for @noAssignmentsFoundLog.
  ///
  /// In en, this message translates to:
  /// **'No assignments found for employee: {email}'**
  String noAssignmentsFoundLog(String email);

  /// No description provided for @noAssignmentsMessage.
  ///
  /// In en, this message translates to:
  /// **'Assignments for this organization will appear here.'**
  String get noAssignmentsMessage;

  /// No description provided for @noAvailableEmployees.
  ///
  /// In en, this message translates to:
  /// **'No Available Employees'**
  String get noAvailableEmployees;

  /// No description provided for @noBankDetails.
  ///
  /// In en, this message translates to:
  /// **'No bank details saved yet.'**
  String get noBankDetails;

  /// No description provided for @noBusinessesFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first business to get started'**
  String get noBusinessesFoundSubtitle;

  /// No description provided for @noBusinessesFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No Businesses Found'**
  String get noBusinessesFoundTitle;

  /// No description provided for @noCareNotes.
  ///
  /// In en, this message translates to:
  /// **'No care notes available'**
  String get noCareNotes;

  /// No description provided for @noCertificationsFound.
  ///
  /// In en, this message translates to:
  /// **'No certifications found.'**
  String get noCertificationsFound;

  /// No description provided for @noCertificationsMessage.
  ///
  /// In en, this message translates to:
  /// **'No certifications found.\nUpload one to get started.'**
  String get noCertificationsMessage;

  /// No description provided for @noChangesToSave.
  ///
  /// In en, this message translates to:
  /// **'No changes to save'**
  String get noChangesToSave;

  /// No description provided for @noChecklistsFound.
  ///
  /// In en, this message translates to:
  /// **'No checklists found.'**
  String get noChecklistsFound;

  /// No description provided for @noChecklistsMessage.
  ///
  /// In en, this message translates to:
  /// **'No checklists available.'**
  String get noChecklistsMessage;

  /// No description provided for @noClient.
  ///
  /// In en, this message translates to:
  /// **'No Client'**
  String get noClient;

  /// No description provided for @noClientAssignmentsForOverride.
  ///
  /// In en, this message translates to:
  /// **'No client assignments with NDIS items available for price override.'**
  String get noClientAssignmentsForOverride;

  /// No description provided for @noClientDataFound.
  ///
  /// In en, this message translates to:
  /// **'No client data found'**
  String get noClientDataFound;

  /// No description provided for @noClientDetailsFound.
  ///
  /// In en, this message translates to:
  /// **'No client details found'**
  String get noClientDetailsFound;

  /// No description provided for @noClientsAssigned.
  ///
  /// In en, this message translates to:
  /// **'No clients assigned to this employee'**
  String get noClientsAssigned;

  /// No description provided for @noClientsAssignedText.
  ///
  /// In en, this message translates to:
  /// **'No clients assigned to this employee'**
  String get noClientsAssignedText;

  /// No description provided for @noClientsFound.
  ///
  /// In en, this message translates to:
  /// **'No clients found'**
  String get noClientsFound;

  /// No description provided for @noClientsFoundDesc.
  ///
  /// In en, this message translates to:
  /// **'No clients with assignments found in this organization.'**
  String get noClientsFoundDesc;

  /// No description provided for @noClientsFoundError.
  ///
  /// In en, this message translates to:
  /// **'No clients found for this organization'**
  String get noClientsFoundError;

  /// No description provided for @noClientsFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first client to get started'**
  String get noClientsFoundSubtitle;

  /// No description provided for @noClientsFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No Clients Found'**
  String get noClientsFoundTitle;

  /// No description provided for @noClientsProcessedError.
  ///
  /// In en, this message translates to:
  /// **'No clients could be processed. Please check assignments and try again.'**
  String get noClientsProcessedError;

  /// No description provided for @noClientsWithAssignmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No clients with assignments found'**
  String get noClientsWithAssignmentsFound;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @noDataForChart.
  ///
  /// In en, this message translates to:
  /// **'No data for chart'**
  String get noDataForChart;

  /// No description provided for @noDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get noDate;

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get noDescriptionAvailable;

  /// No description provided for @noEmployeesAvailable.
  ///
  /// In en, this message translates to:
  /// **'There are no employees available to select for invoice generation.'**
  String get noEmployeesAvailable;

  /// No description provided for @noEmployeesAvailableDesc.
  ///
  /// In en, this message translates to:
  /// **'There are no employees available to select for invoice generation.'**
  String get noEmployeesAvailableDesc;

  /// No description provided for @noEmployeesFound.
  ///
  /// In en, this message translates to:
  /// **'No Employees Found'**
  String get noEmployeesFound;

  /// No description provided for @noEmployeesFoundError.
  ///
  /// In en, this message translates to:
  /// **'No employees found for this organization'**
  String get noEmployeesFoundError;

  /// No description provided for @noEmployeesSelected.
  ///
  /// In en, this message translates to:
  /// **'No employees selected'**
  String get noEmployeesSelected;

  /// No description provided for @noEmployeesSelectedCaps.
  ///
  /// In en, this message translates to:
  /// **'NO EMPLOYEES SELECTED'**
  String get noEmployeesSelectedCaps;

  /// No description provided for @noEmployeesSelectedText.
  ///
  /// In en, this message translates to:
  /// **'No employees selected'**
  String get noEmployeesSelectedText;

  /// No description provided for @noExpenseData.
  ///
  /// In en, this message translates to:
  /// **'No Expense Data'**
  String get noExpenseData;

  /// No description provided for @noHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'No timesheet history found'**
  String get noHistorySubtitle;

  /// No description provided for @noHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No History'**
  String get noHistoryTitle;

  /// No description provided for @noInvoicesFound.
  ///
  /// In en, this message translates to:
  /// **'No invoices found'**
  String get noInvoicesFound;

  /// No description provided for @noInvoicesGenerated.
  ///
  /// In en, this message translates to:
  /// **'No invoices generated yet.'**
  String get noInvoicesGenerated;

  /// No description provided for @noInvoicesToSave.
  ///
  /// In en, this message translates to:
  /// **'No invoices to save'**
  String get noInvoicesToSave;

  /// No description provided for @noItemsFoundForClientDesc.
  ///
  /// In en, this message translates to:
  /// **'No items found for this client.'**
  String get noItemsFoundForClientDesc;

  /// No description provided for @noItemsToValidate.
  ///
  /// In en, this message translates to:
  /// **'No items to validate'**
  String get noItemsToValidate;

  /// No description provided for @noMatchingItemsFoundCaps.
  ///
  /// In en, this message translates to:
  /// **'NO MATCHING ITEMS FOUND'**
  String get noMatchingItemsFoundCaps;

  /// No description provided for @noMatchingItemsFoundNormal.
  ///
  /// In en, this message translates to:
  /// **'No matching NDIS items found.'**
  String get noMatchingItemsFoundNormal;

  /// No description provided for @noMatchingRequests.
  ///
  /// In en, this message translates to:
  /// **'No matching requests'**
  String get noMatchingRequests;

  /// No description provided for @noMatchingRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters.'**
  String get noMatchingRequestsMessage;

  /// No description provided for @noModulesFound.
  ///
  /// In en, this message translates to:
  /// **'No modules found.'**
  String get noModulesFound;

  /// No description provided for @noNdisItemsForOverride.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found'**
  String get noNdisItemsForOverride;

  /// No description provided for @noNdisItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found.'**
  String get noNdisItemsFound;

  /// No description provided for @noNdisItemsFoundInAssignments.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found in selected assignments.'**
  String get noNdisItemsFoundInAssignments;

  /// No description provided for @noNdisItemsFoundMatch.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found matching \"{query}\"'**
  String noNdisItemsFoundMatch(String query);

  /// No description provided for @noNdisItemsLoadedCaps.
  ///
  /// In en, this message translates to:
  /// **'NO NDIS ITEMS LOADED'**
  String get noNdisItemsLoadedCaps;

  /// No description provided for @noNdisItemsLoadedNormal.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items loaded.'**
  String get noNdisItemsLoadedNormal;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// No description provided for @noOption.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noOption;

  /// No description provided for @noOrganizationIdAvailable.
  ///
  /// In en, this message translates to:
  /// **'No organization ID available'**
  String get noOrganizationIdAvailable;

  /// No description provided for @noPeriodSelected.
  ///
  /// In en, this message translates to:
  /// **'No period selected (using default)'**
  String get noPeriodSelected;

  /// No description provided for @noPeriodSelectedText.
  ///
  /// In en, this message translates to:
  /// **'No period selected (using default)'**
  String get noPeriodSelectedText;

  /// No description provided for @noPreferences.
  ///
  /// In en, this message translates to:
  /// **'No preferences set'**
  String get noPreferences;

  /// No description provided for @noPricingRatesFound.
  ///
  /// In en, this message translates to:
  /// **'No pricing rates found'**
  String get noPricingRatesFound;

  /// No description provided for @noRateLimitConfig.
  ///
  /// In en, this message translates to:
  /// **'No rate limit configuration data'**
  String get noRateLimitConfig;

  /// No description provided for @noRateLimitedUsers.
  ///
  /// In en, this message translates to:
  /// **'No users are currently rate limited'**
  String get noRateLimitedUsers;

  /// No description provided for @noRecentExpenses.
  ///
  /// In en, this message translates to:
  /// **'No recent expenses'**
  String get noRecentExpenses;

  /// No description provided for @noRequestsFound.
  ///
  /// In en, this message translates to:
  /// **'No requests found'**
  String get noRequestsFound;

  /// No description provided for @noRequestsFoundCaps.
  ///
  /// In en, this message translates to:
  /// **'NO REQUESTS FOUND'**
  String get noRequestsFoundCaps;

  /// No description provided for @noRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'Create a new request to get started.'**
  String get noRequestsMessage;

  /// No description provided for @noRequestsToDisplay.
  ///
  /// In en, this message translates to:
  /// **'No requests to display'**
  String get noRequestsToDisplay;

  /// No description provided for @noResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'No items found matching your criteria.'**
  String get noResultsMessage;

  /// No description provided for @noResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'NO RESULTS'**
  String get noResultsTitle;

  /// No description provided for @normalUser.
  ///
  /// In en, this message translates to:
  /// **'Normal User'**
  String get normalUser;

  /// No description provided for @normalUserDesc.
  ///
  /// In en, this message translates to:
  /// **'Access basic invoice features'**
  String get normalUserDesc;

  /// No description provided for @noSchedulesAdded.
  ///
  /// In en, this message translates to:
  /// **'No schedules added yet'**
  String get noSchedulesAdded;

  /// No description provided for @noSchedulesMessage.
  ///
  /// In en, this message translates to:
  /// **'Create your first schedule to get started with assignment management'**
  String get noSchedulesMessage;

  /// No description provided for @noSelectedEmployeesError.
  ///
  /// In en, this message translates to:
  /// **'No selected employees found to generate invoices'**
  String get noSelectedEmployeesError;

  /// No description provided for @noServiceRatesFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search criteria or add new service rates to get started.'**
  String get noServiceRatesFoundSubtitle;

  /// No description provided for @noServiceRatesFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'No Service Rates Found'**
  String get noServiceRatesFoundTitle;

  /// No description provided for @noShiftsScheduled.
  ///
  /// In en, this message translates to:
  /// **'No Shifts Scheduled'**
  String get noShiftsScheduled;

  /// No description provided for @noSupportItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No support items found'**
  String get noSupportItemsFound;

  /// No description provided for @noSupportItemsTitle.
  ///
  /// In en, this message translates to:
  /// **'No support items'**
  String get noSupportItemsTitle;

  /// No description provided for @notAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailableLabel;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Type your note here...'**
  String get noteHint;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes: {notes}'**
  String notesDetailLabel(String notes);

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @notesOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptionalLabel;

  /// No description provided for @nothingScheduledToday.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled today'**
  String get nothingScheduledToday;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsAndAlerts.
  ///
  /// In en, this message translates to:
  /// **'Notifications & Alerts'**
  String get notificationsAndAlerts;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get notificationsSubtitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @noTrainingModulesMessage.
  ///
  /// In en, this message translates to:
  /// **'No training modules available.'**
  String get noTrainingModulesMessage;

  /// No description provided for @notRegistered.
  ///
  /// In en, this message translates to:
  /// **'NOT REGISTERED'**
  String get notRegistered;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @notSetLabel.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get notSetLabel;

  /// No description provided for @notStartedStatus.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get notStartedStatus;

  /// No description provided for @noUpcomingAppointments.
  ///
  /// In en, this message translates to:
  /// **'NO UPCOMING APPOINTMENTS'**
  String get noUpcomingAppointments;

  /// No description provided for @noUpcomingShifts.
  ///
  /// In en, this message translates to:
  /// **'No upcoming shifts'**
  String get noUpcomingShifts;

  /// No description provided for @noUpcomingShiftsMessage.
  ///
  /// In en, this message translates to:
  /// **'You have no upcoming shifts scheduled.'**
  String get noUpcomingShiftsMessage;

  /// No description provided for @noValidClientsError.
  ///
  /// In en, this message translates to:
  /// **'No valid clients found for invoice generation'**
  String get noValidClientsError;

  /// No description provided for @noValidRelationshipsError.
  ///
  /// In en, this message translates to:
  /// **'No valid employee-client relationships found'**
  String get noValidRelationshipsError;

  /// No description provided for @novInitial.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get novInitial;

  /// No description provided for @noVisitHistory.
  ///
  /// In en, this message translates to:
  /// **'No previous visits with this client'**
  String get noVisitHistory;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @octInitial.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get octInitial;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @offlineBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Changes will sync when connected.'**
  String get offlineBannerMessage;

  /// No description provided for @offlineStatus.
  ///
  /// In en, this message translates to:
  /// **'STATUS: OFFLINE'**
  String get offlineStatus;

  /// No description provided for @offlineSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'OFFLINE SYNC'**
  String get offlineSyncTitle;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @okLabel.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okLabel;

  /// No description provided for @oldPrice.
  ///
  /// In en, this message translates to:
  /// **'Old Price'**
  String get oldPrice;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @oneClickGenerationTitle.
  ///
  /// In en, this message translates to:
  /// **'ONE-CLICK GENERATION'**
  String get oneClickGenerationTitle;

  /// No description provided for @oneClickInvoiceGeneration.
  ///
  /// In en, this message translates to:
  /// **'One-Click Invoice Generation'**
  String get oneClickInvoiceGeneration;

  /// No description provided for @oopsTitle.
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oopsTitle;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'OPEN'**
  String get open;

  /// No description provided for @openDashboard.
  ///
  /// In en, this message translates to:
  /// **'Open Dashboard'**
  String get openDashboard;

  /// No description provided for @openHub.
  ///
  /// In en, this message translates to:
  /// **'OPEN HUB'**
  String get openHub;

  /// No description provided for @openingCustomReportBuilder.
  ///
  /// In en, this message translates to:
  /// **'Opening custom report builder...'**
  String get openingCustomReportBuilder;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open Map'**
  String get openMap;

  /// No description provided for @openPricingManagement.
  ///
  /// In en, this message translates to:
  /// **'Open Pricing Management'**
  String get openPricingManagement;

  /// No description provided for @openWith.
  ///
  /// In en, this message translates to:
  /// **'Open with'**
  String get openWith;

  /// No description provided for @operationHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'View history of all bulk operations'**
  String get operationHistoryDesc;

  /// No description provided for @operationHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Operation History'**
  String get operationHistoryTitle;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @optionCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get optionCustom;

  /// No description provided for @optionGstExclusive.
  ///
  /// In en, this message translates to:
  /// **'GST Exclusive'**
  String get optionGstExclusive;

  /// No description provided for @optionGstInclusive.
  ///
  /// In en, this message translates to:
  /// **'GST Inclusive'**
  String get optionGstInclusive;

  /// No description provided for @optionHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get optionHybrid;

  /// No description provided for @optionNdisStandard.
  ///
  /// In en, this message translates to:
  /// **'NDIS Standard'**
  String get optionNdisStandard;

  /// No description provided for @optionNearestCent.
  ///
  /// In en, this message translates to:
  /// **'Round to nearest cent'**
  String get optionNearestCent;

  /// No description provided for @optionNoRounding.
  ///
  /// In en, this message translates to:
  /// **'No rounding'**
  String get optionNoRounding;

  /// No description provided for @optionRoundDown.
  ///
  /// In en, this message translates to:
  /// **'Round down'**
  String get optionRoundDown;

  /// No description provided for @optionRoundUp.
  ///
  /// In en, this message translates to:
  /// **'Round up'**
  String get optionRoundUp;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @organizationCode.
  ///
  /// In en, this message translates to:
  /// **'Organization Code'**
  String get organizationCode;

  /// No description provided for @organizationCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Organization Code'**
  String get organizationCodeHint;

  /// No description provided for @organizationCodeParam.
  ///
  /// In en, this message translates to:
  /// **'Organization Code: {code}'**
  String organizationCodeParam(String code);

  /// No description provided for @organizationCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter organization code'**
  String get organizationCodeRequired;

  /// No description provided for @organizationDetails.
  ///
  /// In en, this message translates to:
  /// **'Organization Details'**
  String get organizationDetails;

  /// No description provided for @organizationEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Organization Email'**
  String get organizationEmailLabel;

  /// No description provided for @organizationFallback.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organizationFallback;

  /// No description provided for @organizationFallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Organization Fallback Base Rate'**
  String get organizationFallbackBaseRate;

  /// No description provided for @organizationFallbackDesc.
  ///
  /// In en, this message translates to:
  /// **'Used when no client or organization-specific price exists.'**
  String get organizationFallbackDesc;

  /// No description provided for @organizationIdNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Organization ID not available'**
  String get organizationIdNotAvailable;

  /// No description provided for @organizationIdRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Cannot save invoices: organizationId is null or empty'**
  String get organizationIdRequiredError;

  /// No description provided for @organizationLabel.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organizationLabel;

  /// No description provided for @organizationManagement.
  ///
  /// In en, this message translates to:
  /// **'Organization Management'**
  String get organizationManagement;

  /// No description provided for @organizationNameHint.
  ///
  /// In en, this message translates to:
  /// **'Organization Name'**
  String get organizationNameHint;

  /// No description provided for @organizationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter organization name'**
  String get organizationNameRequired;

  /// No description provided for @organizationVerificationNeedsEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'No dedicated organization email is set yet. Add an organization contact email in Edit Details to enable separate organization verification.'**
  String get organizationVerificationNeedsEmailMessage;

  /// No description provided for @organizationVerificationPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Send a verification email to confirm {email} as the public organization address.'**
  String organizationVerificationPendingMessage(Object email);

  /// No description provided for @organizationVerificationPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'ORGANIZATION VERIFICATION PENDING'**
  String get organizationVerificationPendingTitle;

  /// No description provided for @organizationVerificationSentFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to send organization verification email.'**
  String get organizationVerificationSentFailure;

  /// No description provided for @organizationVerificationSentMessage.
  ///
  /// In en, this message translates to:
  /// **'A verification email was already sent to {email} on {date}. Use resend if it did not arrive.'**
  String organizationVerificationSentMessage(Object email, Object date);

  /// No description provided for @organizationVerificationSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Organization verification email sent.'**
  String get organizationVerificationSentSuccess;

  /// No description provided for @organizationVerificationVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'This organization email is verified and can be used as the public contact address: {email}.'**
  String organizationVerificationVerifiedMessage(Object email);

  /// No description provided for @organizationVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'ORGANIZATION VERIFIED'**
  String get organizationVerifiedTitle;

  /// No description provided for @organizationRate.
  ///
  /// In en, this message translates to:
  /// **'Organization Rate'**
  String get organizationRate;

  /// No description provided for @organizationSaved.
  ///
  /// In en, this message translates to:
  /// **'Organization details saved'**
  String get organizationSaved;

  /// No description provided for @organizationSection.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organizationSection;

  /// No description provided for @organizationSetupSection.
  ///
  /// In en, this message translates to:
  /// **'Organization Setup'**
  String get organizationSetupSection;

  /// No description provided for @organizationWidePricing.
  ///
  /// In en, this message translates to:
  /// **'Organization-Wide Pricing'**
  String get organizationWidePricing;

  /// No description provided for @orgContextMissingError.
  ///
  /// In en, this message translates to:
  /// **'Organization context missing. Cannot open Pricing Settings.'**
  String get orgContextMissingError;

  /// No description provided for @orgIdNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Organization ID not available'**
  String get orgIdNotAvailable;

  /// No description provided for @orgWideRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Organization-Wide Rate'**
  String get orgWideRateLabel;

  /// No description provided for @orSignupLink.
  ///
  /// In en, this message translates to:
  /// **'Or use this link to signup directly:'**
  String get orSignupLink;

  /// No description provided for @ownerAdminEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner / Admin Email'**
  String get ownerAdminEmailLabel;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @otLabel.
  ///
  /// In en, this message translates to:
  /// **'OT'**
  String get otLabel;

  /// No description provided for @overallScore.
  ///
  /// In en, this message translates to:
  /// **'OVERALL SCORE'**
  String get overallScore;

  /// No description provided for @overCapLabel.
  ///
  /// In en, this message translates to:
  /// **'Over cap'**
  String get overCapLabel;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @overridePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Override Price'**
  String get overridePriceLabel;

  /// No description provided for @overtime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get overtime;

  /// No description provided for @overtimeAfter2hLabel.
  ///
  /// In en, this message translates to:
  /// **'After 2 Hours (200%)'**
  String get overtimeAfter2hLabel;

  /// No description provided for @overtimeFirst2h.
  ///
  /// In en, this message translates to:
  /// **'Overtime (First 2h)'**
  String get overtimeFirst2h;

  /// No description provided for @overtimeFirst2hLabel.
  ///
  /// In en, this message translates to:
  /// **'First 2 Hours (150%)'**
  String get overtimeFirst2hLabel;

  /// No description provided for @overtimeOver2h.
  ///
  /// In en, this message translates to:
  /// **'Overtime (>2h)'**
  String get overtimeOver2h;

  /// No description provided for @overtimeSection.
  ///
  /// In en, this message translates to:
  /// **'Overtime (Total Hourly)'**
  String get overtimeSection;

  /// No description provided for @ownerToolsSection.
  ///
  /// In en, this message translates to:
  /// **'Owner Tools'**
  String get ownerToolsSection;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully!'**
  String get passwordUpdatedSuccess;

  /// No description provided for @passwordUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Updating password Failed!'**
  String get passwordUpdateFailed;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @payHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'PAY HISTORY'**
  String get payHistoryTitle;

  /// No description provided for @paymentStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatusLabel;

  /// No description provided for @payPointLabel.
  ///
  /// In en, this message translates to:
  /// **'Pay Point'**
  String get payPointLabel;

  /// No description provided for @payRatesUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pay rates updated successfully'**
  String get payRatesUpdatedSuccess;

  /// No description provided for @payRateTitle.
  ///
  /// In en, this message translates to:
  /// **'PAY RATE: {rate}/{unit}'**
  String payRateTitle(String rate, String unit);

  /// No description provided for @payTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pay Type'**
  String get payTypeLabel;

  /// No description provided for @pdfDocumentLabel.
  ///
  /// In en, this message translates to:
  /// **'PDF Document'**
  String get pdfDocumentLabel;

  /// No description provided for @pdfGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate invoice PDF'**
  String get pdfGenerationFailed;

  /// No description provided for @pdfLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load invoice PDF'**
  String get pdfLoadError;

  /// No description provided for @pdfRegeneratedMessage.
  ///
  /// In en, this message translates to:
  /// **'PDF regenerated for invoice {number}'**
  String pdfRegeneratedMessage(String number);

  /// No description provided for @pdfViewError.
  ///
  /// In en, this message translates to:
  /// **'Error viewing invoice: {error}'**
  String pdfViewError(String error);

  /// No description provided for @penaltyRatesSection.
  ///
  /// In en, this message translates to:
  /// **'Penalty Rates (Total Hourly)'**
  String get penaltyRatesSection;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @pendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pendingApproval;

  /// No description provided for @pendingApprovalFilter.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pendingApprovalFilter;

  /// No description provided for @pendingOperations.
  ///
  /// In en, this message translates to:
  /// **'{count} pending operations'**
  String pendingOperations(int count);

  /// No description provided for @pendingOpsStat.
  ///
  /// In en, this message translates to:
  /// **'{count} pending operations'**
  String pendingOpsStat(String count);

  /// No description provided for @pendingTab.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pendingTab;

  /// No description provided for @pendingUpdates.
  ///
  /// In en, this message translates to:
  /// **'Pending Updates'**
  String get pendingUpdates;

  /// No description provided for @pendingUpdatesLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending Updates'**
  String get pendingUpdatesLabel;

  /// No description provided for @pendingUpdatesStat.
  ///
  /// In en, this message translates to:
  /// **'Pending Updates'**
  String get pendingUpdatesStat;

  /// No description provided for @pendingUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'vs last quarter'**
  String get pendingUpdatesSubtitle;

  /// No description provided for @pendingUploads.
  ///
  /// In en, this message translates to:
  /// **'PENDING UPLOADS'**
  String get pendingUploads;

  /// No description provided for @perAnnumLabel.
  ///
  /// In en, this message translates to:
  /// **'Per Annum'**
  String get perAnnumLabel;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentage;

  /// No description provided for @percentageOfTotalStat.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% of total'**
  String percentageOfTotalStat(String percentage);

  /// No description provided for @perHour.
  ///
  /// In en, this message translates to:
  /// **'Per Hour'**
  String get perHour;

  /// No description provided for @perHourLabel.
  ///
  /// In en, this message translates to:
  /// **'Per Hour'**
  String get perHourLabel;

  /// No description provided for @perHourSuffix.
  ///
  /// In en, this message translates to:
  /// **'/hr'**
  String get perHourSuffix;

  /// No description provided for @periodExceedsLimitError.
  ///
  /// In en, this message translates to:
  /// **'Selected period cannot exceed 3 months'**
  String get periodExceedsLimitError;

  /// No description provided for @permanentLabel.
  ///
  /// In en, this message translates to:
  /// **'Permanent'**
  String get permanentLabel;

  /// No description provided for @permissionCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera access is required to scan receipts for your organization\'s expenses.'**
  String get permissionCamera;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'PERMISSION REQUIRED'**
  String get permissionRequired;

  /// No description provided for @permissionStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage access is required to save files.'**
  String get permissionStorage;

  /// No description provided for @permissionsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Permissions Updated Successfully'**
  String get permissionsUpdated;

  /// No description provided for @persistenceConfirmationFailed.
  ///
  /// In en, this message translates to:
  /// **'Persistence confirmation failed'**
  String get persistenceConfirmationFailed;

  /// No description provided for @personalCareAssistance.
  ///
  /// In en, this message translates to:
  /// **'Personal Care Assistance'**
  String get personalCareAssistance;

  /// No description provided for @personalDetailsAndContact.
  ///
  /// In en, this message translates to:
  /// **'Personal details and contact information'**
  String get personalDetailsAndContact;

  /// No description provided for @personalInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfoSection;

  /// No description provided for @perUnit.
  ///
  /// In en, this message translates to:
  /// **'per {unit}'**
  String perUnit(String unit);

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get phoneRequired;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @photoTipsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A great photo builds trust and makes your profile stand out.'**
  String get photoTipsSubtitle;

  /// No description provided for @photoUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded successfully'**
  String get photoUploadedSuccessfully;

  /// No description provided for @pieChart.
  ///
  /// In en, this message translates to:
  /// **'Pie Chart'**
  String get pieChart;

  /// No description provided for @pleaseEnterCustomPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter a custom price to proceed'**
  String get pleaseEnterCustomPrice;

  /// No description provided for @pleaseEnterPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter a price'**
  String get pleaseEnterPrice;

  /// No description provided for @pleaseSelectJob.
  ///
  /// In en, this message translates to:
  /// **'Please select a job'**
  String get pleaseSelectJob;

  /// No description provided for @pleaseSelectLeaveType.
  ///
  /// In en, this message translates to:
  /// **'Please select a leave type'**
  String get pleaseSelectLeaveType;

  /// No description provided for @postcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'POSTCODE'**
  String get postcodeLabel;

  /// No description provided for @preflightError.
  ///
  /// In en, this message translates to:
  /// **'Error during rate check: {error}'**
  String preflightError(Object error);

  /// No description provided for @preflightMissingRates.
  ///
  /// In en, this message translates to:
  /// **'Base service rates are missing or using fallback for {count} NDIS item(s): {items}. Please add custom pricing or set price overrides.'**
  String preflightMissingRates(Object count, Object items);

  /// No description provided for @preflightNoNdisItems.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found in selected assignments.'**
  String get preflightNoNdisItems;

  /// No description provided for @preflightRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing pricing…'**
  String get preflightRefreshing;

  /// No description provided for @preflightSuccess.
  ///
  /// In en, this message translates to:
  /// **'All selected NDIS items have configured base service rates.'**
  String get preflightSuccess;

  /// No description provided for @priceAdjustmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Apply percentage increases/decreases'**
  String get priceAdjustmentSubtitle;

  /// No description provided for @priceAdjustmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Adjustment'**
  String get priceAdjustmentTitle;

  /// No description provided for @priceAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View pricing trends and insights'**
  String get priceAnalyticsSubtitle;

  /// No description provided for @priceAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Analytics'**
  String get priceAnalyticsTitle;

  /// No description provided for @priceDecreases.
  ///
  /// In en, this message translates to:
  /// **'Price Decreases'**
  String get priceDecreases;

  /// No description provided for @priceDisplay.
  ///
  /// In en, this message translates to:
  /// **'{symbol}{price}'**
  String priceDisplay(String symbol, String price);

  /// No description provided for @priceExceedsCap.
  ///
  /// In en, this message translates to:
  /// **'Price exceeds NDIS cap'**
  String get priceExceedsCap;

  /// No description provided for @priceFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Price (e.g., 65.17)'**
  String get priceFieldLabel;

  /// No description provided for @priceHistory.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get priceHistory;

  /// No description provided for @priceHistoryClearedConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all price history data? This action cannot be undone.'**
  String get priceHistoryClearedConfirm;

  /// No description provided for @priceHistoryClearedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Price history cleared'**
  String get priceHistoryClearedSuccess;

  /// No description provided for @priceHistoryClearedTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Price History'**
  String get priceHistoryClearedTitle;

  /// No description provided for @priceHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor pricing changes over time'**
  String get priceHistoryDesc;

  /// No description provided for @priceHistoryRetention.
  ///
  /// In en, this message translates to:
  /// **'Price History Retention (days)'**
  String get priceHistoryRetention;

  /// No description provided for @priceHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor pricing changes over time'**
  String get priceHistorySubtitle;

  /// No description provided for @priceHistorySubtitleLabel.
  ///
  /// In en, this message translates to:
  /// **'View rate changes'**
  String get priceHistorySubtitleLabel;

  /// No description provided for @priceHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get priceHistoryTitle;

  /// No description provided for @priceIncreases.
  ///
  /// In en, this message translates to:
  /// **'Price Increases'**
  String get priceIncreases;

  /// No description provided for @priceOverride.
  ///
  /// In en, this message translates to:
  /// **'Price Override'**
  String get priceOverride;

  /// No description provided for @priceOverrideApplied.
  ///
  /// In en, this message translates to:
  /// **'{count} price override(s) applied'**
  String priceOverrideApplied(Object count);

  /// No description provided for @priceOverridesAppliedMessage.
  ///
  /// In en, this message translates to:
  /// **'Price overrides applied for {count} item(s)'**
  String priceOverridesAppliedMessage(int count);

  /// No description provided for @priceOverrideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review and adjust pricing for NDIS items before generating invoices.'**
  String get priceOverrideSubtitle;

  /// No description provided for @priceOverrideTitle.
  ///
  /// In en, this message translates to:
  /// **'PRICE OVERRIDE'**
  String get priceOverrideTitle;

  /// No description provided for @priceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get priceRange;

  /// No description provided for @priceSourceCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom Price'**
  String get priceSourceCustom;

  /// No description provided for @priceSourceManual.
  ///
  /// In en, this message translates to:
  /// **'Manual override'**
  String get priceSourceManual;

  /// No description provided for @priceSourceMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing pricing'**
  String get priceSourceMissing;

  /// No description provided for @priceSourceNdis.
  ///
  /// In en, this message translates to:
  /// **'NDIS Price'**
  String get priceSourceNdis;

  /// No description provided for @priceSourceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown source'**
  String get priceSourceUnknown;

  /// No description provided for @priceTrendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Trends'**
  String get priceTrendsTitle;

  /// No description provided for @priceUnusuallyHigh.
  ///
  /// In en, this message translates to:
  /// **'Price unusually high'**
  String get priceUnusuallyHigh;

  /// No description provided for @priceUpdatesCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'bulk adjustments'**
  String get priceUpdatesCardSubtitle;

  /// No description provided for @priceUpdatesCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Updates'**
  String get priceUpdatesCardTitle;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @pricingAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Pricing Analytics'**
  String get pricingAnalytics;

  /// No description provided for @pricingAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze pricing performance'**
  String get pricingAnalyticsSubtitle;

  /// No description provided for @pricingAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Analytics'**
  String get pricingAnalyticsTitle;

  /// No description provided for @pricingConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Pricing Configuration'**
  String get pricingConfiguration;

  /// No description provided for @pricingConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Configuration'**
  String get pricingConfigurationTitle;

  /// No description provided for @pricingDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your organization\'s pricing'**
  String get pricingDashboardSubtitle;

  /// No description provided for @pricingDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'PRICING DASHBOARD'**
  String get pricingDashboardTitle;

  /// No description provided for @pricingFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get pricingFilterAll;

  /// No description provided for @pricingFilterCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom Pricing'**
  String get pricingFilterCustom;

  /// No description provided for @pricingFilterHighIntensity.
  ///
  /// In en, this message translates to:
  /// **'High Intensity'**
  String get pricingFilterHighIntensity;

  /// No description provided for @pricingFilterStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard Pricing'**
  String get pricingFilterStandard;

  /// No description provided for @pricingInfoBanner.
  ///
  /// In en, this message translates to:
  /// **'Pricing shown for Standard rates in {state}. Custom pricing will override standard rates for your organization.'**
  String pricingInfoBanner(String state);

  /// No description provided for @pricingInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Pricing shown for {intensity} rates in {state}. Tap the price icon to set custom pricing.'**
  String pricingInfoMessage(Object intensity, Object state);

  /// No description provided for @pricingInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'PRICING INFO'**
  String get pricingInfoTitle;

  /// No description provided for @pricingInsightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing insights'**
  String get pricingInsightsSubtitle;

  /// No description provided for @pricingManagement.
  ///
  /// In en, this message translates to:
  /// **'Pricing Management'**
  String get pricingManagement;

  /// No description provided for @pricingManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage and optimize your service pricing across different regions and categories'**
  String get pricingManagementDesc;

  /// No description provided for @pricingManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Management'**
  String get pricingManagementTitle;

  /// No description provided for @pricingModel.
  ///
  /// In en, this message translates to:
  /// **'Pricing Model'**
  String get pricingModel;

  /// No description provided for @pricingModules.
  ///
  /// In en, this message translates to:
  /// **'Pricing Modules'**
  String get pricingModules;

  /// No description provided for @pricingModulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Modules'**
  String get pricingModulesTitle;

  /// No description provided for @pricingOverviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive pricing management and analytics dashboard'**
  String get pricingOverviewSubtitle;

  /// No description provided for @pricingOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Overview'**
  String get pricingOverviewTitle;

  /// No description provided for @pricingParameters.
  ///
  /// In en, this message translates to:
  /// **'Pricing Parameters'**
  String get pricingParameters;

  /// No description provided for @pricingRuleDeleted.
  ///
  /// In en, this message translates to:
  /// **'Pricing rule deleted'**
  String get pricingRuleDeleted;

  /// No description provided for @pricingRulesTab.
  ///
  /// In en, this message translates to:
  /// **'Pricing Rules'**
  String get pricingRulesTab;

  /// No description provided for @pricingRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Rules'**
  String get pricingRulesTitle;

  /// No description provided for @pricingScopeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pricing Scope'**
  String get pricingScopeLabel;

  /// No description provided for @pricingSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pricing Settings'**
  String get pricingSettingsTooltip;

  /// No description provided for @pricingSourceClientSpecific.
  ///
  /// In en, this message translates to:
  /// **'Client Specific'**
  String get pricingSourceClientSpecific;

  /// No description provided for @pricingSourceFallback.
  ///
  /// In en, this message translates to:
  /// **'Fallback'**
  String get pricingSourceFallback;

  /// No description provided for @pricingSourceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Pricing source for this item'**
  String get pricingSourceTooltip;

  /// No description provided for @pricingTrendsByCategory.
  ///
  /// In en, this message translates to:
  /// **'Pricing Trends by Category'**
  String get pricingTrendsByCategory;

  /// No description provided for @pricingTypeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get pricingTypeFixed;

  /// No description provided for @pricingUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'Here\'s what\'s happening with your pricing today.'**
  String get pricingUpdateMessage;

  /// No description provided for @pricingValidation.
  ///
  /// In en, this message translates to:
  /// **'Pricing Validation'**
  String get pricingValidation;

  /// No description provided for @pricingValidationTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing Validation'**
  String get pricingValidationTitle;

  /// No description provided for @primaryAccount.
  ///
  /// In en, this message translates to:
  /// **'PRIMARY ACCOUNT'**
  String get primaryAccount;

  /// No description provided for @proceedButton.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceedButton;

  /// No description provided for @processedLabel.
  ///
  /// In en, this message translates to:
  /// **'Processed'**
  String get processedLabel;

  /// No description provided for @processingAssignment.
  ///
  /// In en, this message translates to:
  /// **'Processing assignment...'**
  String get processingAssignment;

  /// No description provided for @processingEmployeeStep.
  ///
  /// In en, this message translates to:
  /// **'Processing employee: {name}'**
  String processingEmployeeStep(String name);

  /// No description provided for @processingImportMsg.
  ///
  /// In en, this message translates to:
  /// **'Processing import...'**
  String get processingImportMsg;

  /// No description provided for @profilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profilePhoto;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettings;

  /// No description provided for @profileSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your personal information'**
  String get profileSettingsSubtitle;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profitMargin.
  ///
  /// In en, this message translates to:
  /// **'Profit Margin'**
  String get profitMargin;

  /// No description provided for @projectedMonthlyStat.
  ///
  /// In en, this message translates to:
  /// **'projected monthly'**
  String get projectedMonthlyStat;

  /// No description provided for @projectedPayUpcoming.
  ///
  /// In en, this message translates to:
  /// **'PROJECTED PAY (UPCOMING)'**
  String get projectedPayUpcoming;

  /// No description provided for @providerNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Provider Name'**
  String get providerNamePlaceholder;

  /// No description provided for @publicHoliday.
  ///
  /// In en, this message translates to:
  /// **'Public Holiday'**
  String get publicHoliday;

  /// No description provided for @publicHolidayPenaltyLabel.
  ///
  /// In en, this message translates to:
  /// **'Public Holiday (250%)'**
  String get publicHolidayPenaltyLabel;

  /// No description provided for @publicHolidayRate.
  ///
  /// In en, this message translates to:
  /// **'Public Holiday Rate'**
  String get publicHolidayRate;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @quickActionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Frequently used pricing tools'**
  String get quickActionsDesc;

  /// No description provided for @quickActionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently used pricing tools'**
  String get quickActionsSubtitle;

  /// No description provided for @quickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActionsTitle;

  /// No description provided for @quickCaptureTitle.
  ///
  /// In en, this message translates to:
  /// **'QUICK CAPTURE'**
  String get quickCaptureTitle;

  /// No description provided for @quickInsights.
  ///
  /// In en, this message translates to:
  /// **'Quick Insights'**
  String get quickInsights;

  /// No description provided for @rateBelowAwardWarning.
  ///
  /// In en, this message translates to:
  /// **'Rate is below Award minimum ({minRate})'**
  String rateBelowAwardWarning(String minRate);

  /// No description provided for @rateColumn.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rateColumn;

  /// No description provided for @rateConsistency.
  ///
  /// In en, this message translates to:
  /// **'Rate Consistency'**
  String get rateConsistency;

  /// No description provided for @rateDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rate deleted successfully'**
  String get rateDeletedSuccess;

  /// No description provided for @rateHistoryContent.
  ///
  /// In en, this message translates to:
  /// **'Rate History Content'**
  String get rateHistoryContent;

  /// No description provided for @rateHistoryTab.
  ///
  /// In en, this message translates to:
  /// **'Rate History'**
  String get rateHistoryTab;

  /// No description provided for @rateLimit.
  ///
  /// In en, this message translates to:
  /// **'Rate Limit'**
  String get rateLimit;

  /// No description provided for @rateLimitedUsers.
  ///
  /// In en, this message translates to:
  /// **'Rate-limited Users (by IP)'**
  String get rateLimitedUsers;

  /// No description provided for @rateLimitResetFor.
  ///
  /// In en, this message translates to:
  /// **'Rate limit reset for {ip}'**
  String rateLimitResetFor(String ip);

  /// No description provided for @ratesTemplateDesc.
  ///
  /// In en, this message translates to:
  /// **'Pricing rates for all service categories'**
  String get ratesTemplateDesc;

  /// No description provided for @ratesTemplateTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Rates'**
  String get ratesTemplateTitle;

  /// No description provided for @ratesUnit.
  ///
  /// In en, this message translates to:
  /// **'rates'**
  String get ratesUnit;

  /// No description provided for @rateUpdatedActivity.
  ///
  /// In en, this message translates to:
  /// **'Rate updated'**
  String get rateUpdatedActivity;

  /// No description provided for @readyToGenerateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Ready to generate invoice'**
  String get readyToGenerateInvoice;

  /// No description provided for @readyToGenerateInvoiceText.
  ///
  /// In en, this message translates to:
  /// **'Ready to generate invoice'**
  String get readyToGenerateInvoiceText;

  /// No description provided for @realTimeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Real-time'**
  String get realTimeTooltip;

  /// No description provided for @reasonHint.
  ///
  /// In en, this message translates to:
  /// **'Reason for leave...'**
  String get reasonHint;

  /// No description provided for @reasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reasonLabel;

  /// No description provided for @reasonOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'REASON (OPTIONAL)'**
  String get reasonOptionalLabel;

  /// No description provided for @receiptDetected.
  ///
  /// In en, this message translates to:
  /// **'We detected: \${amount} - {category}'**
  String receiptDetected(String amount, String category);

  /// No description provided for @receiptScanned.
  ///
  /// In en, this message translates to:
  /// **'Receipt Scanned!'**
  String get receiptScanned;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @recentExpenses.
  ///
  /// In en, this message translates to:
  /// **'Recent Expenses'**
  String get recentExpenses;

  /// No description provided for @recentExpensesCaps.
  ///
  /// In en, this message translates to:
  /// **'RECENT EXPENSES'**
  String get recentExpensesCaps;

  /// No description provided for @recentFailedAttempts.
  ///
  /// In en, this message translates to:
  /// **'{count} recent failed attempts'**
  String recentFailedAttempts(String count);

  /// No description provided for @recheckRates.
  ///
  /// In en, this message translates to:
  /// **'Re-check Rates'**
  String get recheckRates;

  /// No description provided for @recordsUnit.
  ///
  /// In en, this message translates to:
  /// **'records'**
  String get recordsUnit;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @recurringExpense.
  ///
  /// In en, this message translates to:
  /// **'Recurring Expense'**
  String get recurringExpense;

  /// No description provided for @refreshAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshAction;

  /// No description provided for @refreshingPricingMessage.
  ///
  /// In en, this message translates to:
  /// **'Refreshing pricing…'**
  String get refreshingPricingMessage;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @regionalDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'pricing variations'**
  String get regionalDataSubtitle;

  /// No description provided for @regionalDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Regional Data'**
  String get regionalDataTitle;

  /// No description provided for @regionalRatesCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'pricing variations'**
  String get regionalRatesCardSubtitle;

  /// No description provided for @regionalRatesCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Regional Rates'**
  String get regionalRatesCardTitle;

  /// No description provided for @regionalTemplateDesc.
  ///
  /// In en, this message translates to:
  /// **'Location-based pricing variations'**
  String get regionalTemplateDesc;

  /// No description provided for @regionalTemplateTitle.
  ///
  /// In en, this message translates to:
  /// **'Regional Rates'**
  String get regionalTemplateTitle;

  /// No description provided for @regionalUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update rates for specific regions'**
  String get regionalUpdatesSubtitle;

  /// No description provided for @regionalUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Regional Updates'**
  String get regionalUpdatesTitle;

  /// No description provided for @regionLabel.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get regionLabel;

  /// No description provided for @regionsUnit.
  ///
  /// In en, this message translates to:
  /// **'regions'**
  String get regionsUnit;

  /// No description provided for @registeredProvider.
  ///
  /// In en, this message translates to:
  /// **'Registered Provider'**
  String get registeredProvider;

  /// No description provided for @registrationNumberEnter.
  ///
  /// In en, this message translates to:
  /// **'Enter registration number'**
  String get registrationNumberEnter;

  /// No description provided for @registrationNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'REGISTRATION NUMBER'**
  String get registrationNumberLabel;

  /// No description provided for @regularLabel.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regularLabel;

  /// No description provided for @rejectAction.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectAction;

  /// No description provided for @reloadAllTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reload All'**
  String get reloadAllTooltip;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @removeCustomPricingTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove custom pricing'**
  String get removeCustomPricingTooltip;

  /// No description provided for @reportGeneratedActivity.
  ///
  /// In en, this message translates to:
  /// **'Report generated'**
  String get reportGeneratedActivity;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @reportsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'REPORTS TAB'**
  String get reportsTabTitle;

  /// No description provided for @requestApprovalInfo.
  ///
  /// In en, this message translates to:
  /// **'All requests will be sent for a manager\'s approval'**
  String get requestApprovalInfo;

  /// No description provided for @requestedInvoiceNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested invoice could not be found.'**
  String get requestedInvoiceNotFound;

  /// No description provided for @requestError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String requestError(String error);

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get requestFailed;

  /// No description provided for @requestsDashboard.
  ///
  /// In en, this message translates to:
  /// **'Requests Dashboard'**
  String get requestsDashboard;

  /// No description provided for @requestsDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage time-off and shift requests'**
  String get requestsDashboardDesc;

  /// No description provided for @requestsDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'REQUESTS DASHBOARD'**
  String get requestsDashboardTitle;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get requestSent;

  /// No description provided for @requestSentMessage.
  ///
  /// In en, this message translates to:
  /// **'Your request has been sent for approval'**
  String get requestSentMessage;

  /// No description provided for @requestsLabel.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsLabel;

  /// No description provided for @requestsPerMinutes.
  ///
  /// In en, this message translates to:
  /// **'{max} requests per {minutes} minutes'**
  String requestsPerMinutes(String max, String minutes);

  /// No description provided for @requestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTitle;

  /// No description provided for @requestTypeShift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get requestTypeShift;

  /// No description provided for @requestTypeShiftExchange.
  ///
  /// In en, this message translates to:
  /// **'Shift Exchange'**
  String get requestTypeShiftExchange;

  /// No description provided for @requestTypeTimeOff.
  ///
  /// In en, this message translates to:
  /// **'Time Off'**
  String get requestTypeTimeOff;

  /// No description provided for @requireApproval.
  ///
  /// In en, this message translates to:
  /// **'Require Approval for Changes'**
  String get requireApproval;

  /// No description provided for @requireApprovalDesc.
  ///
  /// In en, this message translates to:
  /// **'Require manager approval for price changes'**
  String get requireApprovalDesc;

  /// No description provided for @requireClientRates.
  ///
  /// In en, this message translates to:
  /// **'Require client-specific base rates'**
  String get requireClientRates;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @requiredValidation.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredValidation;

  /// No description provided for @requiresAttention.
  ///
  /// In en, this message translates to:
  /// **'Requires Attention'**
  String get requiresAttention;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @resendVerification.
  ///
  /// In en, this message translates to:
  /// **'Resend Verification'**
  String get resendVerification;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get resetAll;

  /// No description provided for @resetConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Reset Configuration'**
  String get resetConfiguration;

  /// No description provided for @resetConfigurationConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all settings to their default values? This action cannot be undone.'**
  String get resetConfigurationConfirm;

  /// No description provided for @resetConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Configuration'**
  String get resetConfigurationTitle;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Create a new secure password for your account'**
  String get resetPasswordDesc;

  /// No description provided for @resetPriceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset Price'**
  String get resetPriceTooltip;

  /// No description provided for @resetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// No description provided for @resetToDefaultsDesc.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings to default values'**
  String get resetToDefaultsDesc;

  /// No description provided for @resetToDefaultsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaultsTooltip;

  /// No description provided for @resolutionRateStat.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% resolution rate'**
  String resolutionRateStat(String percentage);

  /// No description provided for @resolve.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get resolve;

  /// No description provided for @resolveAction.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get resolveAction;

  /// No description provided for @resolvedData.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolvedData;

  /// No description provided for @restrictedOwnerOnly.
  ///
  /// In en, this message translates to:
  /// **'Restricted: Owner access only'**
  String get restrictedOwnerOnly;

  /// No description provided for @retake.
  ///
  /// In en, this message translates to:
  /// **'RETAKE'**
  String get retake;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @revenueAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Revenue Analysis'**
  String get revenueAnalysis;

  /// No description provided for @revenueBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Revenue Breakdown'**
  String get revenueBreakdown;

  /// No description provided for @revenueByCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Revenue by Service Category'**
  String get revenueByCategoryTitle;

  /// No description provided for @revenueByPeriod.
  ///
  /// In en, this message translates to:
  /// **'Revenue by Period'**
  String get revenueByPeriod;

  /// No description provided for @revenueByPeriodChartDesc.
  ///
  /// In en, this message translates to:
  /// **'Revenue comparison over different time periods'**
  String get revenueByPeriodChartDesc;

  /// No description provided for @revenueByPeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'Revenue by Period'**
  String get revenueByPeriodTitle;

  /// No description provided for @revenueByServiceCategory.
  ///
  /// In en, this message translates to:
  /// **'Revenue by Service Category'**
  String get revenueByServiceCategory;

  /// No description provided for @revenueCaps.
  ///
  /// In en, this message translates to:
  /// **'REVENUE'**
  String get revenueCaps;

  /// No description provided for @revenueCategoryChartDesc.
  ///
  /// In en, this message translates to:
  /// **'Revenue breakdown by service category'**
  String get revenueCategoryChartDesc;

  /// No description provided for @revenueInsightLabel.
  ///
  /// In en, this message translates to:
  /// **'• Revenue increased by {percentage}% compared to last period'**
  String revenueInsightLabel(String percentage);

  /// No description provided for @revenueStat.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenueStat;

  /// No description provided for @revenueTrend.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get revenueTrend;

  /// No description provided for @revenueTrendChartDesc.
  ///
  /// In en, this message translates to:
  /// **'Displays the revenue trend over the selected period'**
  String get revenueTrendChartDesc;

  /// No description provided for @revenueTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get revenueTrendTitle;

  /// No description provided for @reviewAndOverridePrices.
  ///
  /// In en, this message translates to:
  /// **'Review and Override Prices'**
  String get reviewAndOverridePrices;

  /// No description provided for @reviewButton.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get reviewButton;

  /// No description provided for @reviewedByLabel.
  ///
  /// In en, this message translates to:
  /// **'Reviewed by'**
  String get reviewedByLabel;

  /// No description provided for @roleManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'ROLE MANAGEMENT'**
  String get roleManagementTitle;

  /// No description provided for @roundingMethod.
  ///
  /// In en, this message translates to:
  /// **'Rounding Method'**
  String get roundingMethod;

  /// No description provided for @ruleGeographicLoadingDescription.
  ///
  /// In en, this message translates to:
  /// **'Applies geographic loading based on service location'**
  String get ruleGeographicLoadingDescription;

  /// No description provided for @ruleGeographicLoadingName.
  ///
  /// In en, this message translates to:
  /// **'Geographic Loading Rules'**
  String get ruleGeographicLoadingName;

  /// No description provided for @ruleMinimumRateValidationDescription.
  ///
  /// In en, this message translates to:
  /// **'Validates minimum hourly rates for different service types'**
  String get ruleMinimumRateValidationDescription;

  /// No description provided for @ruleMinimumRateValidationName.
  ///
  /// In en, this message translates to:
  /// **'Minimum Rate Validation'**
  String get ruleMinimumRateValidationName;

  /// No description provided for @ruleNdisPriceCapValidationDescription.
  ///
  /// In en, this message translates to:
  /// **'Ensures prices do not exceed NDIS price guide limits'**
  String get ruleNdisPriceCapValidationDescription;

  /// No description provided for @ruleNdisPriceCapValidationName.
  ///
  /// In en, this message translates to:
  /// **'NDIS Price Cap Validation'**
  String get ruleNdisPriceCapValidationName;

  /// No description provided for @ruleNeverSync.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get ruleNeverSync;

  /// No description provided for @rulePerformanceReport.
  ///
  /// In en, this message translates to:
  /// **'Rule Performance Report'**
  String get rulePerformanceReport;

  /// No description provided for @rulePerformanceReportDesc.
  ///
  /// In en, this message translates to:
  /// **'Performance metrics for all validation rules'**
  String get rulePerformanceReportDesc;

  /// No description provided for @rulePriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get rulePriorityHigh;

  /// No description provided for @rulePriorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get rulePriorityLow;

  /// No description provided for @rulePriorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get rulePriorityMedium;

  /// No description provided for @ruleStatusConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get ruleStatusConnected;

  /// No description provided for @ruleStatusDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get ruleStatusDisconnected;

  /// No description provided for @runningValidationRule.
  ///
  /// In en, this message translates to:
  /// **'Running validation rule...'**
  String get runningValidationRule;

  /// No description provided for @runNow.
  ///
  /// In en, this message translates to:
  /// **'Run Now'**
  String get runNow;

  /// No description provided for @runNowAction.
  ///
  /// In en, this message translates to:
  /// **'Run Now'**
  String get runNowAction;

  /// No description provided for @salaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salaryLabel;

  /// No description provided for @saturdayPenaltyLabel.
  ///
  /// In en, this message translates to:
  /// **'Saturday (150%)'**
  String get saturdayPenaltyLabel;

  /// No description provided for @saturdayRate.
  ///
  /// In en, this message translates to:
  /// **'Saturday Rate'**
  String get saturdayRate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @saveChangesCaps.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get saveChangesCaps;

  /// No description provided for @saveCustomPriceAction.
  ///
  /// In en, this message translates to:
  /// **'Save Custom Price'**
  String get saveCustomPriceAction;

  /// No description provided for @savedCustomPrices.
  ///
  /// In en, this message translates to:
  /// **'Successfully saved {count} custom prices'**
  String savedCustomPrices(Object count);

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFailed;

  /// No description provided for @saveProgressButton.
  ///
  /// In en, this message translates to:
  /// **'Save Progress'**
  String get saveProgressButton;

  /// No description provided for @saveRatesAction.
  ///
  /// In en, this message translates to:
  /// **'Save Rates'**
  String get saveRatesAction;

  /// No description provided for @scanToJoin.
  ///
  /// In en, this message translates to:
  /// **'Scan to join {name}'**
  String scanToJoin(String name);

  /// No description provided for @scheduleAssignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule Assignment'**
  String get scheduleAssignmentTitle;

  /// No description provided for @scheduleConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Schedule Configuration'**
  String get scheduleConfiguration;

  /// No description provided for @scheduleConfigurationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set the date, time, and other details'**
  String get scheduleConfigurationSubtitle;

  /// No description provided for @scheduleDataInconsistent.
  ///
  /// In en, this message translates to:
  /// **'Schedule data is inconsistent. Please refresh and try again.'**
  String get scheduleDataInconsistent;

  /// No description provided for @scheduleDetails.
  ///
  /// In en, this message translates to:
  /// **'Schedule Details'**
  String get scheduleDetails;

  /// No description provided for @scheduledSuffix.
  ///
  /// In en, this message translates to:
  /// **'scheduled'**
  String get scheduledSuffix;

  /// No description provided for @scheduleError.
  ///
  /// In en, this message translates to:
  /// **'Schedule {number}: {error}'**
  String scheduleError(String number, String error);

  /// No description provided for @scheduleLabel.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleLabel;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchByItemNameOrCode.
  ///
  /// In en, this message translates to:
  /// **'Search by item name or code...'**
  String get searchByItemNameOrCode;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History...'**
  String get searchHistory;

  /// No description provided for @searchHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'Search price history...'**
  String get searchHistoryHint;

  /// No description provided for @searchInvoices.
  ///
  /// In en, this message translates to:
  /// **'Search Invoices'**
  String get searchInvoices;

  /// No description provided for @searchItems.
  ///
  /// In en, this message translates to:
  /// **'Search NDIS items...'**
  String get searchItems;

  /// No description provided for @searchItemsHint.
  ///
  /// In en, this message translates to:
  /// **'Enter item number or name'**
  String get searchItemsHint;

  /// No description provided for @searchNdisPlaceholderCaps.
  ///
  /// In en, this message translates to:
  /// **'SEARCH BY ITEM NUMBER OR DESCRIPTION'**
  String get searchNdisPlaceholderCaps;

  /// No description provided for @searchNdisPlaceholderNormal.
  ///
  /// In en, this message translates to:
  /// **'Search by Item Number or Description'**
  String get searchNdisPlaceholderNormal;

  /// No description provided for @searchPricingRulesHint.
  ///
  /// In en, this message translates to:
  /// **'Search pricing rules...'**
  String get searchPricingRulesHint;

  /// No description provided for @searchRequestsHint.
  ///
  /// In en, this message translates to:
  /// **'Search requests...'**
  String get searchRequestsHint;

  /// No description provided for @searchServiceRatesHint.
  ///
  /// In en, this message translates to:
  /// **'Search service rates...'**
  String get searchServiceRatesHint;

  /// No description provided for @searchValidationHint.
  ///
  /// In en, this message translates to:
  /// **'Search validation results...'**
  String get searchValidationHint;

  /// No description provided for @securedWith256Bit.
  ///
  /// In en, this message translates to:
  /// **'Secured with 256-bit SSL encryption'**
  String get securedWith256Bit;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @securityDashboard.
  ///
  /// In en, this message translates to:
  /// **'Security Dashboard'**
  String get securityDashboard;

  /// No description provided for @securityDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'API usage and security metrics'**
  String get securityDashboardSubtitle;

  /// No description provided for @securitySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securitySection;

  /// No description provided for @securityStatus.
  ///
  /// In en, this message translates to:
  /// **'Security Status'**
  String get securityStatus;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @selectBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Select which bank details to display'**
  String get selectBankDetails;

  /// No description provided for @selectClientPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select a client'**
  String get selectClientPrompt;

  /// No description provided for @selectClientsHeader.
  ///
  /// In en, this message translates to:
  /// **'SELECT CLIENTS'**
  String get selectClientsHeader;

  /// No description provided for @selectClientToViewPricing.
  ///
  /// In en, this message translates to:
  /// **'Select a client to view pricing'**
  String get selectClientToViewPricing;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get selectDateRange;

  /// No description provided for @selectDateRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get selectDateRangeLabel;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(String count);

  /// No description provided for @selectedEmployeesInfo.
  ///
  /// In en, this message translates to:
  /// **'SELECTED: {employeeCount} {employeeLabel} WITH {clientCount} {clientLabel}'**
  String selectedEmployeesInfo(
    Object clientCount,
    Object clientLabel,
    Object employeeCount,
    Object employeeLabel,
  );

  /// No description provided for @selectedItemsDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Selected items deleted successfully!'**
  String get selectedItemsDeletedSuccess;

  /// No description provided for @selectEmployee.
  ///
  /// In en, this message translates to:
  /// **'Select Employee'**
  String get selectEmployee;

  /// No description provided for @selectEmployees.
  ///
  /// In en, this message translates to:
  /// **'Select Employees'**
  String get selectEmployees;

  /// No description provided for @selectEmployeesAndClients.
  ///
  /// In en, this message translates to:
  /// **'Select Employees & Clients'**
  String get selectEmployeesAndClients;

  /// No description provided for @selectEmployeesModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Employees'**
  String get selectEmployeesModalTitle;

  /// No description provided for @selectEmployeesOption.
  ///
  /// In en, this message translates to:
  /// **'Select Employees'**
  String get selectEmployeesOption;

  /// No description provided for @selectExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Select Expiry Date'**
  String get selectExpiryDate;

  /// No description provided for @selectExpiryDateError.
  ///
  /// In en, this message translates to:
  /// **'Please select expiry date'**
  String get selectExpiryDateError;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select File (PDF, JPG, PNG)'**
  String get selectFile;

  /// No description provided for @selectFileError.
  ///
  /// In en, this message translates to:
  /// **'Please select a file'**
  String get selectFileError;

  /// No description provided for @selectJob.
  ///
  /// In en, this message translates to:
  /// **'Select Job'**
  String get selectJob;

  /// No description provided for @selectLeaveType.
  ///
  /// In en, this message translates to:
  /// **'Select Leave Type'**
  String get selectLeaveType;

  /// No description provided for @selectLeaveTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Select leave type'**
  String get selectLeaveTypeHint;

  /// No description provided for @selectLevelFirstHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a level to show pay points.'**
  String get selectLevelFirstHint;

  /// No description provided for @selectNdisItem.
  ///
  /// In en, this message translates to:
  /// **'Please select an NDIS Service Item'**
  String get selectNdisItem;

  /// No description provided for @selectNdisItemTitle.
  ///
  /// In en, this message translates to:
  /// **'SELECT NDIS ITEM'**
  String get selectNdisItemTitle;

  /// No description provided for @selectNdisItemTitleNormal.
  ///
  /// In en, this message translates to:
  /// **'Select NDIS Item'**
  String get selectNdisItemTitleNormal;

  /// No description provided for @selectNdisServiceItem.
  ///
  /// In en, this message translates to:
  /// **'Select NDIS Service Item'**
  String get selectNdisServiceItem;

  /// No description provided for @selectPeriod.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriod;

  /// No description provided for @selectPeriodButton.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriodButton;

  /// No description provided for @selectStreamFirstHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a stream to unlock levels.'**
  String get selectStreamFirstHint;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectTime;

  /// No description provided for @sendForApproval.
  ///
  /// In en, this message translates to:
  /// **'Send for approval'**
  String get sendForApproval;

  /// No description provided for @sendVerification.
  ///
  /// In en, this message translates to:
  /// **'Send Verification'**
  String get sendVerification;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @sendInvoiceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Send Invoice'**
  String get sendInvoiceTooltip;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @sepInitial.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get sepInitial;

  /// No description provided for @serviceColumn.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceColumn;

  /// No description provided for @serviceDistribution.
  ///
  /// In en, this message translates to:
  /// **'Service Distribution'**
  String get serviceDistribution;

  /// No description provided for @serviceDistributionChartDesc.
  ///
  /// In en, this message translates to:
  /// **'Breakdown of revenue by service category'**
  String get serviceDistributionChartDesc;

  /// No description provided for @serviceDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Distribution'**
  String get serviceDistributionTitle;

  /// No description provided for @serviceRateManagement.
  ///
  /// In en, this message translates to:
  /// **'Service Rate Management'**
  String get serviceRateManagement;

  /// No description provided for @serviceRateManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage and optimize your service pricing across different regions and categories'**
  String get serviceRateManagementSubtitle;

  /// No description provided for @serviceRateManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Rate Management'**
  String get serviceRateManagementTitle;

  /// No description provided for @serviceRates.
  ///
  /// In en, this message translates to:
  /// **'Service Rates'**
  String get serviceRates;

  /// No description provided for @serviceRatesCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'rate structures'**
  String get serviceRatesCardSubtitle;

  /// No description provided for @serviceRatesCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Rates'**
  String get serviceRatesCardTitle;

  /// No description provided for @serviceRatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Configure service pricing structures'**
  String get serviceRatesDesc;

  /// No description provided for @serviceRatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure service pricing structures'**
  String get serviceRatesSubtitle;

  /// No description provided for @serviceRatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Service Rates'**
  String get serviceRatesTitle;

  /// No description provided for @serviceTypesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} service types'**
  String serviceTypesCount(int count);

  /// No description provided for @serviceTypesStat.
  ///
  /// In en, this message translates to:
  /// **'{count} service types'**
  String serviceTypesStat(String count);

  /// No description provided for @setCustomPriceOrgLabel.
  ///
  /// In en, this message translates to:
  /// **'Set custom price for this organization'**
  String get setCustomPriceOrgLabel;

  /// No description provided for @setOrganizationEmail.
  ///
  /// In en, this message translates to:
  /// **'Set Organization Email'**
  String get setOrganizationEmail;

  /// No description provided for @setCustomPriceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Set custom price'**
  String get setCustomPriceTooltip;

  /// No description provided for @setFallbackRate.
  ///
  /// In en, this message translates to:
  /// **'Set Fallback Rate'**
  String get setFallbackRate;

  /// No description provided for @setPayRatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Pay Rates: {name}'**
  String setPayRatesTitle(String name);

  /// No description provided for @setPriceOverridesButton.
  ///
  /// In en, this message translates to:
  /// **'Set Price Overrides'**
  String get setPriceOverridesButton;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @severityError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get severityError;

  /// No description provided for @severityInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get severityInfo;

  /// No description provided for @severityLabel.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get severityLabel;

  /// No description provided for @severityWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get severityWarning;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shareableLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Shareable Link'**
  String get shareableLinkLabel;

  /// No description provided for @shareCodeInvite.
  ///
  /// In en, this message translates to:
  /// **'Share code to invite members.'**
  String get shareCodeInvite;

  /// No description provided for @shareInvoice.
  ///
  /// In en, this message translates to:
  /// **'Share Invoice'**
  String get shareInvoice;

  /// No description provided for @sharingInvoiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Sharing invoice {number}...'**
  String sharingInvoiceMessage(String number);

  /// No description provided for @shiftAssignedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Shift assigned successfully'**
  String get shiftAssignedSuccessfully;

  /// No description provided for @shiftAssignment.
  ///
  /// In en, this message translates to:
  /// **'Shift Assignment'**
  String get shiftAssignment;

  /// No description provided for @shiftAssignmentComplete.
  ///
  /// In en, this message translates to:
  /// **'Shift Assignment Complete!'**
  String get shiftAssignmentComplete;

  /// No description provided for @shiftDetails.
  ///
  /// In en, this message translates to:
  /// **'Shift Details'**
  String get shiftDetails;

  /// No description provided for @shiftExchange.
  ///
  /// In en, this message translates to:
  /// **'Shift Exchange'**
  String get shiftExchange;

  /// No description provided for @shiftExchangeDesc.
  ///
  /// In en, this message translates to:
  /// **'Offer swaps or claim open shifts from colleagues.'**
  String get shiftExchangeDesc;

  /// No description provided for @shiftExchangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swap or offer shifts'**
  String get shiftExchangeSubtitle;

  /// No description provided for @shiftIndex.
  ///
  /// In en, this message translates to:
  /// **'Shift {index}'**
  String shiftIndex(int index);

  /// No description provided for @shiftIndexDetails.
  ///
  /// In en, this message translates to:
  /// **'Shift {index} Details'**
  String shiftIndexDetails(int index);

  /// No description provided for @shiftRequestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'New shift request'**
  String get shiftRequestSubtitle;

  /// No description provided for @shiftsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Shifts'**
  String shiftsCount(int count);

  /// No description provided for @shortcutsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} shortcuts available'**
  String shortcutsAvailable(int count);

  /// No description provided for @shortcutsAvailableStat.
  ///
  /// In en, this message translates to:
  /// **'{count} shortcuts available'**
  String shortcutsAvailableStat(String count);

  /// No description provided for @showYourBestSide.
  ///
  /// In en, this message translates to:
  /// **'Show Your Best Side'**
  String get showYourBestSide;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @signingIn.
  ///
  /// In en, this message translates to:
  /// **'Signing you in...'**
  String get signingIn;

  /// No description provided for @signupLink.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signupLink;

  /// No description provided for @signupPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get signupPrompt;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join us and start managing your invoices efficiently'**
  String get signupSubtitle;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupTitle;

  /// No description provided for @smartAssign.
  ///
  /// In en, this message translates to:
  /// **'Smart Assign'**
  String get smartAssign;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @sourceClientSpecific.
  ///
  /// In en, this message translates to:
  /// **'Client-specific custom price'**
  String get sourceClientSpecific;

  /// No description provided for @sourceCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get sourceCustom;

  /// No description provided for @sourceFallback.
  ///
  /// In en, this message translates to:
  /// **'Fallback'**
  String get sourceFallback;

  /// No description provided for @sourceFallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Organization fallback base rate'**
  String get sourceFallbackBaseRate;

  /// No description provided for @sourceLabel.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get sourceLabel;

  /// No description provided for @sourceManualEntry.
  ///
  /// In en, this message translates to:
  /// **'Manual price entry'**
  String get sourceManualEntry;

  /// No description provided for @sourceManualOverride.
  ///
  /// In en, this message translates to:
  /// **'Manual override'**
  String get sourceManualOverride;

  /// No description provided for @sourceNdisCap.
  ///
  /// In en, this message translates to:
  /// **'NDIS Cap'**
  String get sourceNdisCap;

  /// No description provided for @sourceOrganization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get sourceOrganization;

  /// No description provided for @sourceOrganizationWide.
  ///
  /// In en, this message translates to:
  /// **'Organization-wide custom price'**
  String get sourceOrganizationWide;

  /// No description provided for @sourceStandardRate.
  ///
  /// In en, this message translates to:
  /// **'Standard price'**
  String get sourceStandardRate;

  /// No description provided for @standardCaps.
  ///
  /// In en, this message translates to:
  /// **'STANDARD'**
  String get standardCaps;

  /// No description provided for @standardHours.
  ///
  /// In en, this message translates to:
  /// **'Standard Hours'**
  String get standardHours;

  /// No description provided for @standardNdisRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Standard NDIS Rate'**
  String get standardNdisRateLabel;

  /// No description provided for @standardRateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Standard rate unavailable for selected state'**
  String get standardRateUnavailable;

  /// No description provided for @startBeforeEnd.
  ///
  /// In en, this message translates to:
  /// **'Start time must be before end time'**
  String get startBeforeEnd;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startButton;

  /// No description provided for @startChecklistButton.
  ///
  /// In en, this message translates to:
  /// **'Start Checklist'**
  String get startChecklistButton;

  /// No description provided for @startedLabel.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get startedLabel;

  /// No description provided for @startLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startLabel;

  /// No description provided for @startsLabel.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get startsLabel;

  /// No description provided for @startTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTimeLabel;

  /// No description provided for @startTracking.
  ///
  /// In en, this message translates to:
  /// **'START INSIGHTS'**
  String get startTracking;

  /// No description provided for @statActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statActive;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @stateFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All States'**
  String get stateFilterAll;

  /// No description provided for @stateRegion.
  ///
  /// In en, this message translates to:
  /// **'STATE / REGION'**
  String get stateRegion;

  /// No description provided for @stateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter state'**
  String get stateRequired;

  /// No description provided for @statFiltered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get statFiltered;

  /// No description provided for @statInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get statInactive;

  /// No description provided for @statsPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get statsPendingApproval;

  /// No description provided for @statsThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get statsThisMonth;

  /// No description provided for @statsTotalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get statsTotalExpenses;

  /// No description provided for @statTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statTotal;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get statusAll;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusApprovedShift.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApprovedShift;

  /// No description provided for @statusChangesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Activate/deactivate multiple items'**
  String get statusChangesSubtitle;

  /// No description provided for @statusChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Status Changes'**
  String get statusChangesTitle;

  /// No description provided for @statusCompletedShift.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompletedShift;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusInformation.
  ///
  /// In en, this message translates to:
  /// **'Status Information'**
  String get statusInformation;

  /// No description provided for @statusInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Status Information'**
  String get statusInformationTitle;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @statusOverdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get statusOverdue;

  /// No description provided for @statusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get statusPaid;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusPendingShift.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPendingShift;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @statusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get statusResolved;

  /// No description provided for @statusSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get statusSent;

  /// No description provided for @statusUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get statusUnderReview;

  /// No description provided for @statusUnresolved.
  ///
  /// In en, this message translates to:
  /// **'Unresolved'**
  String get statusUnresolved;

  /// No description provided for @stopCurrentTimer.
  ///
  /// In en, this message translates to:
  /// **'Please stop the current timer before starting a new one.'**
  String get stopCurrentTimer;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @streamLabel.
  ///
  /// In en, this message translates to:
  /// **'Stream'**
  String get streamLabel;

  /// No description provided for @streetAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddressHint;

  /// No description provided for @streetAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter street address'**
  String get streetAddressRequired;

  /// No description provided for @submitAssignment.
  ///
  /// In en, this message translates to:
  /// **'Submit Assignment'**
  String get submitAssignment;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @submitExpense.
  ///
  /// In en, this message translates to:
  /// **'Submit Expense'**
  String get submitExpense;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @submitRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequestButton;

  /// No description provided for @submittedByLabel.
  ///
  /// In en, this message translates to:
  /// **'Submitted by'**
  String get submittedByLabel;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @subtotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotalLabel;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @successfulLabel.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successfulLabel;

  /// No description provided for @successMessage.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get successMessage;

  /// No description provided for @successRate.
  ///
  /// In en, this message translates to:
  /// **'Success Rate'**
  String get successRate;

  /// No description provided for @successTitle.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successTitle;

  /// No description provided for @sundayPenaltyLabel.
  ///
  /// In en, this message translates to:
  /// **'Sunday (200%)'**
  String get sundayPenaltyLabel;

  /// No description provided for @sundayRate.
  ///
  /// In en, this message translates to:
  /// **'Sunday Rate'**
  String get sundayRate;

  /// No description provided for @supportCoordinationCategory.
  ///
  /// In en, this message translates to:
  /// **'Support Coordination'**
  String get supportCoordinationCategory;

  /// No description provided for @supportItemNameUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Support item name unavailable'**
  String get supportItemNameUnavailable;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @syncingIntegration.
  ///
  /// In en, this message translates to:
  /// **'Syncing {name}...'**
  String syncingIntegration(String name);

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @systemActive.
  ///
  /// In en, this message translates to:
  /// **'System Active'**
  String get systemActive;

  /// No description provided for @systemActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'System Active'**
  String get systemActiveLabel;

  /// No description provided for @systemBehavior.
  ///
  /// In en, this message translates to:
  /// **'System Behavior'**
  String get systemBehavior;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @systemIntegrations.
  ///
  /// In en, this message translates to:
  /// **'System Integrations'**
  String get systemIntegrations;

  /// No description provided for @systemMaintenance.
  ///
  /// In en, this message translates to:
  /// **'System Maintenance'**
  String get systemMaintenance;

  /// No description provided for @tabAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get tabAdvanced;

  /// No description provided for @tabAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get tabAnalytics;

  /// No description provided for @tabBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk'**
  String get tabBulk;

  /// No description provided for @tabDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get tabDataSubtitle;

  /// No description provided for @tabExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get tabExport;

  /// No description provided for @tabGeneralSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get tabGeneralSettings;

  /// No description provided for @tabHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabHistory;

  /// No description provided for @tabImport.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get tabImport;

  /// No description provided for @tabIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get tabIntegrations;

  /// No description provided for @tabPriceChanges.
  ///
  /// In en, this message translates to:
  /// **'Price Changes'**
  String get tabPriceChanges;

  /// No description provided for @tabPricingRules.
  ///
  /// In en, this message translates to:
  /// **'Pricing Rules'**
  String get tabPricingRules;

  /// No description provided for @tabReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get tabReports;

  /// No description provided for @tabTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get tabTrends;

  /// No description provided for @tabUpdatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get tabUpdatesSubtitle;

  /// No description provided for @tabValidationResults.
  ///
  /// In en, this message translates to:
  /// **'Validation Results'**
  String get tabValidationResults;

  /// No description provided for @tabValidationRules.
  ///
  /// In en, this message translates to:
  /// **'Validation Rules'**
  String get tabValidationRules;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @tapToChangeLogo.
  ///
  /// In en, this message translates to:
  /// **'Tap to change logo'**
  String get tapToChangeLogo;

  /// No description provided for @tapToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap to Select'**
  String get tapToSelect;

  /// No description provided for @tapToViewPdf.
  ///
  /// In en, this message translates to:
  /// **'Tap to view PDF'**
  String get tapToViewPdf;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @taxAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax Amount'**
  String get taxAmountLabel;

  /// No description provided for @taxCalculation.
  ///
  /// In en, this message translates to:
  /// **'Tax Calculation'**
  String get taxCalculation;

  /// No description provided for @taxEstimatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on ATO Resident Rates 2024-2025'**
  String get taxEstimatorSubtitle;

  /// No description provided for @taxEstimatorTitle.
  ///
  /// In en, this message translates to:
  /// **'TAX ESTIMATOR ({frequency})'**
  String taxEstimatorTitle(String frequency);

  /// No description provided for @taxFreqAnnually.
  ///
  /// In en, this message translates to:
  /// **'Annually'**
  String get taxFreqAnnually;

  /// No description provided for @taxFreqFortnightly.
  ///
  /// In en, this message translates to:
  /// **'Fortnightly'**
  String get taxFreqFortnightly;

  /// No description provided for @taxFreqMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get taxFreqMonthly;

  /// No description provided for @taxFrequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'TAX FREQUENCY:'**
  String get taxFrequencyLabel;

  /// No description provided for @taxFreqWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get taxFreqWeekly;

  /// No description provided for @taxIdAbn.
  ///
  /// In en, this message translates to:
  /// **'Tax ID (ABN)'**
  String get taxIdAbn;

  /// No description provided for @taxRate.
  ///
  /// In en, this message translates to:
  /// **'Tax Rate'**
  String get taxRate;

  /// No description provided for @taxRateHint.
  ///
  /// In en, this message translates to:
  /// **'10.0'**
  String get taxRateHint;

  /// No description provided for @taxRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax Rate'**
  String get taxRateLabel;

  /// No description provided for @taxRateNegativeError.
  ///
  /// In en, this message translates to:
  /// **'Tax rate cannot be negative when tax is applied'**
  String get taxRateNegativeError;

  /// No description provided for @teamDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage teams and emergency broadcasts'**
  String get teamDashboardSubtitle;

  /// No description provided for @teamDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'TEAM COORDINATION'**
  String get teamDashboardTitle;

  /// No description provided for @teamSection.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get teamSection;

  /// No description provided for @themeAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'THEME'**
  String get themeAppBarTitle;

  /// No description provided for @themeInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred appearance mode.'**
  String get themeInfoMessage;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app appearance'**
  String get themeSubtitle;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @thisMonthExpenses.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonthExpenses;

  /// No description provided for @thisMonthStat.
  ///
  /// In en, this message translates to:
  /// **'{count} this month'**
  String thisMonthStat(String count);

  /// No description provided for @thisQuarterLabel.
  ///
  /// In en, this message translates to:
  /// **'This Quarter'**
  String get thisQuarterLabel;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @thisWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeekLabel;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get thisYear;

  /// No description provided for @timeClock.
  ///
  /// In en, this message translates to:
  /// **'Time Clock'**
  String get timeClock;

  /// No description provided for @timeClockDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor your work hours. Clock in at start, out at finish.'**
  String get timeClockDesc;

  /// No description provided for @timeConflictBetween.
  ///
  /// In en, this message translates to:
  /// **'Time conflict between schedules {schedule1} and {schedule2} on {date}'**
  String timeConflictBetween(String schedule1, String schedule2, String date);

  /// No description provided for @timeConflictExisting.
  ///
  /// In en, this message translates to:
  /// **'Time conflict with existing schedule on this date'**
  String get timeConflictExisting;

  /// No description provided for @timeLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'TIME:'**
  String get timeLabelCaps;

  /// No description provided for @timeOffRequestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Request leave'**
  String get timeOffRequestSubtitle;

  /// No description provided for @timeOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Time off'**
  String get timeOffTitle;

  /// No description provided for @timerAlreadyRunning.
  ///
  /// In en, this message translates to:
  /// **'Timer Already Running'**
  String get timerAlreadyRunning;

  /// No description provided for @timeRange1Year.
  ///
  /// In en, this message translates to:
  /// **'1 year'**
  String get timeRange1Year;

  /// No description provided for @timeRange30Days.
  ///
  /// In en, this message translates to:
  /// **'30 days'**
  String get timeRange30Days;

  /// No description provided for @timeRange6Months.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get timeRange6Months;

  /// No description provided for @timeRange7Days.
  ///
  /// In en, this message translates to:
  /// **'7 days'**
  String get timeRange7Days;

  /// No description provided for @timeRange90Days.
  ///
  /// In en, this message translates to:
  /// **'90 days'**
  String get timeRange90Days;

  /// No description provided for @timeRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time Range'**
  String get timeRangeLabel;

  /// No description provided for @timeRangeLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get timeRangeLast30Days;

  /// No description provided for @timesheet.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
  String get timesheet;

  /// No description provided for @timesheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
  String get timesheetTitle;

  /// No description provided for @timestampLabel.
  ///
  /// In en, this message translates to:
  /// **'Timestamp'**
  String get timestampLabel;

  /// No description provided for @timeUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Time updated successfully'**
  String get timeUpdatedSuccessfully;

  /// No description provided for @timeValidationError.
  ///
  /// In en, this message translates to:
  /// **'Time validation error'**
  String get timeValidationError;

  /// No description provided for @timeWorked.
  ///
  /// In en, this message translates to:
  /// **'Time Worked'**
  String get timeWorked;

  /// No description provided for @tipBulkActions.
  ///
  /// In en, this message translates to:
  /// **'Tip: Use the checkboxes to select multiple items for bulk actions.'**
  String get tipBulkActions;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// No description provided for @toggleUnit.
  ///
  /// In en, this message translates to:
  /// **'Toggle'**
  String get toggleUnit;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get toLabel;

  /// No description provided for @toLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'TO:'**
  String get toLabelCaps;

  /// No description provided for @topEndpoints.
  ///
  /// In en, this message translates to:
  /// **'Top Endpoints'**
  String get topEndpoints;

  /// No description provided for @topPerformingServices.
  ///
  /// In en, this message translates to:
  /// **'Top Performing Services'**
  String get topPerformingServices;

  /// No description provided for @topServiceInsightLabel.
  ///
  /// In en, this message translates to:
  /// **'• {serviceName} is the top revenue generator'**
  String topServiceInsightLabel(String serviceName);

  /// No description provided for @topUsers.
  ///
  /// In en, this message translates to:
  /// **'Top Users'**
  String get topUsers;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @totalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmountLabel;

  /// No description provided for @totalApiCalls.
  ///
  /// In en, this message translates to:
  /// **'Total API Calls'**
  String get totalApiCalls;

  /// No description provided for @totalChanges.
  ///
  /// In en, this message translates to:
  /// **'Total Changes'**
  String get totalChanges;

  /// No description provided for @totalClients.
  ///
  /// In en, this message translates to:
  /// **'Total Clients'**
  String get totalClients;

  /// No description provided for @totalClientsStat.
  ///
  /// In en, this message translates to:
  /// **'Total Clients'**
  String get totalClientsStat;

  /// No description provided for @totalEarningsTitle.
  ///
  /// In en, this message translates to:
  /// **'TOTAL EARNINGS'**
  String get totalEarningsTitle;

  /// No description provided for @totalEmployeesStat.
  ///
  /// In en, this message translates to:
  /// **'Total Employees'**
  String get totalEmployeesStat;

  /// No description provided for @totalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// No description provided for @totalHours.
  ///
  /// In en, this message translates to:
  /// **'Total hours'**
  String get totalHours;

  /// No description provided for @totalHoursEstimatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Hours (Estimated)'**
  String get totalHoursEstimatedLabel;

  /// No description provided for @totalHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'TOTAL HOURS'**
  String get totalHoursTitle;

  /// No description provided for @totalIssues.
  ///
  /// In en, this message translates to:
  /// **'Total Issues'**
  String get totalIssues;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @totalOperations.
  ///
  /// In en, this message translates to:
  /// **'Total Operations'**
  String get totalOperations;

  /// No description provided for @totalRatesStat.
  ///
  /// In en, this message translates to:
  /// **'Total Rates'**
  String get totalRatesStat;

  /// No description provided for @totalRatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'+12 this month'**
  String get totalRatesSubtitle;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @totalServices.
  ///
  /// In en, this message translates to:
  /// **'Total Services'**
  String get totalServices;

  /// No description provided for @totalServicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Services'**
  String get totalServicesLabel;

  /// No description provided for @totalServicesStat.
  ///
  /// In en, this message translates to:
  /// **'Total Services'**
  String get totalServicesStat;

  /// No description provided for @totalShifts.
  ///
  /// In en, this message translates to:
  /// **'Total Shifts'**
  String get totalShifts;

  /// No description provided for @totalWorkHoursToday.
  ///
  /// In en, this message translates to:
  /// **'Total work hours today'**
  String get totalWorkHoursToday;

  /// No description provided for @trackExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expense Insights'**
  String get trackExpenses;

  /// No description provided for @trackExpensesDesc.
  ///
  /// In en, this message translates to:
  /// **'Monitor your daily spending and manage reimbursements.'**
  String get trackExpensesDesc;

  /// No description provided for @trackPricingChanges.
  ///
  /// In en, this message translates to:
  /// **'Monitor pricing changes over time'**
  String get trackPricingChanges;

  /// No description provided for @tradingAs.
  ///
  /// In en, this message translates to:
  /// **'Trading As'**
  String get tradingAs;

  /// No description provided for @tradingNameLabel.
  ///
  /// In en, this message translates to:
  /// **'TRADING NAME'**
  String get tradingNameLabel;

  /// No description provided for @trainingCompliance.
  ///
  /// In en, this message translates to:
  /// **'Training & Compliance'**
  String get trainingCompliance;

  /// No description provided for @trainingComplianceDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage certifications, complete training, and monitor compliance.'**
  String get trainingComplianceDesc;

  /// No description provided for @trainingComplianceTitle.
  ///
  /// In en, this message translates to:
  /// **'Training & Compliance'**
  String get trainingComplianceTitle;

  /// No description provided for @trainingModulesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete mandatory training'**
  String get trainingModulesSubtitle;

  /// No description provided for @trainingModulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Training Modules'**
  String get trainingModulesTitle;

  /// No description provided for @trendDecreasing.
  ///
  /// In en, this message translates to:
  /// **'Decreasing'**
  String get trendDecreasing;

  /// No description provided for @trendIncreasing.
  ///
  /// In en, this message translates to:
  /// **'Increasing'**
  String get trendIncreasing;

  /// No description provided for @trendStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get trendStable;

  /// No description provided for @tryAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgainButton;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @typeLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'TYPE:'**
  String get typeLabelCaps;

  /// No description provided for @typeNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Type your note here...'**
  String get typeNoteHint;

  /// No description provided for @unassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get unassigned;

  /// No description provided for @unblockThisIp.
  ///
  /// In en, this message translates to:
  /// **'Unblock this IP'**
  String get unblockThisIp;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @unitDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get unitDay;

  /// No description provided for @unitEach.
  ///
  /// In en, this message translates to:
  /// **'Each'**
  String get unitEach;

  /// No description provided for @unitHour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get unitHour;

  /// No description provided for @unitKilometer.
  ///
  /// In en, this message translates to:
  /// **'Kilometer'**
  String get unitKilometer;

  /// No description provided for @unitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitLabel;

  /// No description provided for @unitMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get unitMonth;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// No description provided for @unitPriceHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get unitPriceHint;

  /// No description provided for @unitPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit Price (\$)'**
  String get unitPriceLabel;

  /// No description provided for @unitWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get unitWeek;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unknownClient.
  ///
  /// In en, this message translates to:
  /// **'Unknown Client'**
  String get unknownClient;

  /// No description provided for @unknownEmployee.
  ///
  /// In en, this message translates to:
  /// **'Unknown Employee'**
  String get unknownEmployee;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @unknownItem.
  ///
  /// In en, this message translates to:
  /// **'Unknown Item'**
  String get unknownItem;

  /// No description provided for @unknownOrg.
  ///
  /// In en, this message translates to:
  /// **'Unknown Org'**
  String get unknownOrg;

  /// No description provided for @unknownValidationError.
  ///
  /// In en, this message translates to:
  /// **'Unknown validation error'**
  String get unknownValidationError;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @unreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String unreadCount(int count);

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @upcomingShifts.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING SHIFTS'**
  String get upcomingShifts;

  /// No description provided for @updateAction.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateAction;

  /// No description provided for @updateBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Update Bank Details'**
  String get updateBankDetails;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @updatedTodayStat.
  ///
  /// In en, this message translates to:
  /// **'{count} updated today'**
  String updatedTodayStat(String count);

  /// No description provided for @updateExpense.
  ///
  /// In en, this message translates to:
  /// **'Update Expense'**
  String get updateExpense;

  /// No description provided for @updatePriceOverridesButton.
  ///
  /// In en, this message translates to:
  /// **'Update Price Overrides'**
  String get updatePriceOverridesButton;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @updatesTemplateDesc.
  ///
  /// In en, this message translates to:
  /// **'Bulk price adjustments and modifications'**
  String get updatesTemplateDesc;

  /// No description provided for @updatesTemplateTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Updates'**
  String get updatesTemplateTitle;

  /// No description provided for @updatesUnit.
  ///
  /// In en, this message translates to:
  /// **'updates'**
  String get updatesUnit;

  /// No description provided for @uploadAndSave.
  ///
  /// In en, this message translates to:
  /// **'Upload & Save'**
  String get uploadAndSave;

  /// No description provided for @uploadButton.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get uploadButton;

  /// No description provided for @uploadButtonAction.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get uploadButtonAction;

  /// No description provided for @uploadCertificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Certification'**
  String get uploadCertificationTitle;

  /// No description provided for @uploadingFiles.
  ///
  /// In en, this message translates to:
  /// **'Uploading file(s)...'**
  String get uploadingFiles;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @uploadProfilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Profile Photo'**
  String get uploadProfilePhoto;

  /// No description provided for @urgentStat.
  ///
  /// In en, this message translates to:
  /// **'{count} urgent'**
  String urgentStat(String count);

  /// No description provided for @useClientBaseRates.
  ///
  /// In en, this message translates to:
  /// **'Use client-specific base rates'**
  String get useClientBaseRates;

  /// No description provided for @userLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'USER:'**
  String get userLabelCaps;

  /// No description provided for @utilization.
  ///
  /// In en, this message translates to:
  /// **'Utilization'**
  String get utilization;

  /// No description provided for @utilizationInsightLabel.
  ///
  /// In en, this message translates to:
  /// **'• Utilization rate improved by {percentage}% - good efficiency trend'**
  String utilizationInsightLabel(String percentage);

  /// No description provided for @validatePrices.
  ///
  /// In en, this message translates to:
  /// **'Validate Prices'**
  String get validatePrices;

  /// No description provided for @validatePricesOption.
  ///
  /// In en, this message translates to:
  /// **'Validate Prices'**
  String get validatePricesOption;

  /// No description provided for @validatePricesOptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Check prices against NDIS price caps'**
  String get validatePricesOptionDesc;

  /// No description provided for @validation.
  ///
  /// In en, this message translates to:
  /// **'Validation'**
  String get validation;

  /// No description provided for @validationCompletedActivity.
  ///
  /// In en, this message translates to:
  /// **'Validation completed'**
  String get validationCompletedActivity;

  /// No description provided for @validationDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Validation Details - {id}'**
  String validationDetailsTitle(String id);

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationError;

  /// No description provided for @validationErrors.
  ///
  /// In en, this message translates to:
  /// **'Validation Errors'**
  String get validationErrors;

  /// No description provided for @validationFailed.
  ///
  /// In en, this message translates to:
  /// **'Validation failed: {error}'**
  String validationFailed(Object error);

  /// No description provided for @validationIssueResolved.
  ///
  /// In en, this message translates to:
  /// **'Validation issue resolved successfully'**
  String get validationIssueResolved;

  /// No description provided for @validationIssues.
  ///
  /// In en, this message translates to:
  /// **'Validation Issues'**
  String get validationIssues;

  /// No description provided for @validationReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Validation Reports'**
  String get validationReportsTitle;

  /// No description provided for @validationResults.
  ///
  /// In en, this message translates to:
  /// **'Validation Results'**
  String get validationResults;

  /// No description provided for @validationResultsTabTitle.
  ///
  /// In en, this message translates to:
  /// **'VALIDATION RESULTS TAB'**
  String get validationResultsTabTitle;

  /// No description provided for @validationRules.
  ///
  /// In en, this message translates to:
  /// **'Validation Rules'**
  String get validationRules;

  /// No description provided for @validationRulesTabTitle.
  ///
  /// In en, this message translates to:
  /// **'VALIDATION RULES TAB'**
  String get validationRulesTabTitle;

  /// No description provided for @validationRuleStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Validation rule status updated'**
  String get validationRuleStatusUpdated;

  /// No description provided for @validationSourceService.
  ///
  /// In en, this message translates to:
  /// **'price_validation_service'**
  String get validationSourceService;

  /// No description provided for @validBadge.
  ///
  /// In en, this message translates to:
  /// **'VALID'**
  String get validBadge;

  /// No description provided for @validPairsStat.
  ///
  /// In en, this message translates to:
  /// **'Valid Pairs'**
  String get validPairsStat;

  /// No description provided for @validPositiveAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid positive amount.'**
  String get validPositiveAmountError;

  /// No description provided for @verificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully!'**
  String get verificationCodeSent;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @verifyOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtpTitle;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @versionFormat.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({build})'**
  String versionFormat(String version, String build);

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionLabel;

  /// No description provided for @versionWithBuild.
  ///
  /// In en, this message translates to:
  /// **'Version {version} ({build})'**
  String versionWithBuild(String version, String build);

  /// No description provided for @videoType.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get videoType;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @viewAllAssignments.
  ///
  /// In en, this message translates to:
  /// **'View All Assignments'**
  String get viewAllAssignments;

  /// No description provided for @viewAssignments.
  ///
  /// In en, this message translates to:
  /// **'View Assignments'**
  String get viewAssignments;

  /// No description provided for @viewAssignmentsDesc.
  ///
  /// In en, this message translates to:
  /// **'View all employee assignments'**
  String get viewAssignmentsDesc;

  /// No description provided for @viewButton.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get viewButton;

  /// No description provided for @viewDetailsAction.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetailsAction;

  /// No description provided for @viewDetailsButton.
  ///
  /// In en, this message translates to:
  /// **'VIEW DETAILS'**
  String get viewDetailsButton;

  /// No description provided for @viewEarnings.
  ///
  /// In en, this message translates to:
  /// **'VIEW EARNINGS'**
  String get viewEarnings;

  /// No description provided for @viewGeneratedPdfs.
  ///
  /// In en, this message translates to:
  /// **'View Generated PDFs'**
  String get viewGeneratedPdfs;

  /// No description provided for @viewHistoryTooltip.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistoryTooltip;

  /// No description provided for @viewInvoice.
  ///
  /// In en, this message translates to:
  /// **'View Invoice'**
  String get viewInvoice;

  /// No description provided for @viewInvoiceButton.
  ///
  /// In en, this message translates to:
  /// **'View Invoice'**
  String get viewInvoiceButton;

  /// No description provided for @viewMap.
  ///
  /// In en, this message translates to:
  /// **'View Map'**
  String get viewMap;

  /// No description provided for @viewMissingItems.
  ///
  /// In en, this message translates to:
  /// **'View Missing Items'**
  String get viewMissingItems;

  /// No description provided for @viewOffers.
  ///
  /// In en, this message translates to:
  /// **'VIEW OFFERS'**
  String get viewOffers;

  /// No description provided for @viewPdfTooltip.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get viewPdfTooltip;

  /// No description provided for @violationsLabel.
  ///
  /// In en, this message translates to:
  /// **'violations'**
  String get violationsLabel;

  /// No description provided for @visualChartsAndTrends.
  ///
  /// In en, this message translates to:
  /// **'Visual charts and trends analysis'**
  String get visualChartsAndTrends;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @vsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'vs last month'**
  String get vsLastMonth;

  /// No description provided for @vsLastMonthStat.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% vs last month'**
  String vsLastMonthStat(String percentage);

  /// No description provided for @vsLastMonthStatRange.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% vs last month'**
  String vsLastMonthStatRange(String percentage);

  /// No description provided for @vsLastQuarterStat.
  ///
  /// In en, this message translates to:
  /// **'vs last quarter'**
  String get vsLastQuarterStat;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @was.
  ///
  /// In en, this message translates to:
  /// **'Was'**
  String get was;

  /// No description provided for @wasPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Was: {price}'**
  String wasPriceLabel(String price);

  /// No description provided for @webEncryptionLimitationError.
  ///
  /// In en, this message translates to:
  /// **'Error generating invoices: Web platform limitation with encryption. Please use the mobile or desktop app for this feature.'**
  String get webEncryptionLimitationError;

  /// No description provided for @websiteLabel.
  ///
  /// In en, this message translates to:
  /// **'WEBSITE'**
  String get websiteLabel;

  /// No description provided for @weekendRate.
  ///
  /// In en, this message translates to:
  /// **'Weekend Rate'**
  String get weekendRate;

  /// No description provided for @weekendRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekend Rate'**
  String get weekendRateLabel;

  /// No description provided for @weeklySummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Summary'**
  String get weeklySummary;

  /// No description provided for @weeklyToggle.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY'**
  String get weeklyToggle;

  /// No description provided for @weeklyTrendsAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Weekly Trends Analysis'**
  String get weeklyTrendsAnalysis;

  /// No description provided for @weeklyTrendsAnalysisDesc.
  ///
  /// In en, this message translates to:
  /// **'Weekly analysis of validation trends and patterns'**
  String get weeklyTrendsAnalysisDesc;

  /// No description provided for @weekTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Week total {hours}'**
  String weekTotalLabel(String hours);

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! 👋'**
  String get welcomeBack;

  /// No description provided for @weSentCode.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to your email'**
  String get weSentCode;

  /// No description provided for @wideUnit.
  ///
  /// In en, this message translates to:
  /// **'Wide'**
  String get wideUnit;

  /// No description provided for @withinCapLabel.
  ///
  /// In en, this message translates to:
  /// **'Within cap'**
  String get withinCapLabel;

  /// No description provided for @workerDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Access your shifts and tasks'**
  String get workerDashboardSubtitle;

  /// No description provided for @workerDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'WORKER DASHBOARD'**
  String get workerDashboardTitle;

  /// No description provided for @workerSection.
  ///
  /// In en, this message translates to:
  /// **'Worker'**
  String get workerSection;

  /// No description provided for @workerShiftHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your past shifts and timesheets'**
  String get workerShiftHistorySubtitle;

  /// No description provided for @workerShiftHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'SHIFT HISTORY'**
  String get workerShiftHistoryTitle;

  /// No description provided for @workforceAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Workforce Analytics'**
  String get workforceAnalytics;

  /// No description provided for @workforceAnalyticsDesc.
  ///
  /// In en, this message translates to:
  /// **'View financial & operational metrics'**
  String get workforceAnalyticsDesc;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @yesOption.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yesOption;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @zipCodeHint.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get zipCodeHint;

  /// No description provided for @zipCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter ZIP code'**
  String get zipCodeRequired;

  /// AppBar title for the payment settings screen
  ///
  /// In en, this message translates to:
  /// **'PAYMENT SETTINGS'**
  String get paymentSettingsTitle;

  /// Label for the Stripe payout account status card
  ///
  /// In en, this message translates to:
  /// **'Stripe payout account'**
  String get paymentSettingsStripePayoutTitle;

  /// Description of the Stripe Connect flow
  ///
  /// In en, this message translates to:
  /// **'Link your bank account to receive payments directly from clients. We use Stripe Connect to ensure secure and compliant payouts for your NDIS business.'**
  String get paymentSettingsStripePayoutSubtitle;

  /// Badge shown when the Stripe account is fully connected
  ///
  /// In en, this message translates to:
  /// **'CONNECTED'**
  String get paymentSettingsConnected;

  /// Badge shown when the Stripe account is not fully connected
  ///
  /// In en, this message translates to:
  /// **'ACTION NEEDED'**
  String get paymentSettingsActionNeeded;

  /// Title shown when the Stripe account is fully connected
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT CONNECTED'**
  String get paymentSettingsAccountConnectedTitle;

  /// Title shown when the Stripe account is not connected
  ///
  /// In en, this message translates to:
  /// **'NOT CONNECTED'**
  String get paymentSettingsNotConnectedTitle;

  /// Description of an active Stripe account
  ///
  /// In en, this message translates to:
  /// **'Your Stripe account is active and ready to receive payouts.'**
  String get paymentSettingsActiveDesc;

  /// Call to action to connect Stripe
  ///
  /// In en, this message translates to:
  /// **'Connect your account to start accepting payments.'**
  String get paymentSettingsConnectDesc;

  /// Button label to start Stripe Connect onboarding
  ///
  /// In en, this message translates to:
  /// **'CONNECT WITH STRIPE'**
  String get paymentSettingsConnectButton;

  /// Button to open the Stripe dashboard
  ///
  /// In en, this message translates to:
  /// **'VIEW STRIPE DASHBOARD'**
  String get paymentSettingsViewDashboardButton;

  /// Error shown when the organization cannot be loaded
  ///
  /// In en, this message translates to:
  /// **'Organization data is unavailable'**
  String get paymentSettingsErrorOrgMissing;

  /// Error shown when the Stripe URL cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Could not launch Stripe'**
  String get paymentSettingsErrorLaunch;

  /// Message shown when the dashboard link is not implemented
  ///
  /// In en, this message translates to:
  /// **'Dashboard link is not available yet'**
  String get paymentSettingsDashboardNotImplemented;

  /// Section title for linking an existing Stripe account
  ///
  /// In en, this message translates to:
  /// **'Connect existing Stripe account'**
  String get paymentSettingsExistingAccountTitle;

  /// Explanation of the existing account flow
  ///
  /// In en, this message translates to:
  /// **'Link an existing Stripe account to receive invoice payments directly from your clients. This is optional and only used when your organization already has a Stripe account.'**
  String get paymentSettingsExistingAccountSubtitle;

  /// Button to start OAuth for an existing Stripe account
  ///
  /// In en, this message translates to:
  /// **'LINK EXISTING ACCOUNT'**
  String get paymentSettingsLinkExistingButton;

  /// Error when the OAuth URL could not be generated
  ///
  /// In en, this message translates to:
  /// **'Failed to start the Stripe OAuth flow'**
  String get paymentSettingsOAuthStartFailed;

  /// Title for the organization subscription screen
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIPTION'**
  String get subscriptionTitle;

  /// Description of the organization subscription
  ///
  /// In en, this message translates to:
  /// **'Unlock every CareNest feature for your organization with a monthly subscription. The subscription covers your whole organization, and one payment activates all team members.'**
  String get subscriptionDescription;

  /// Price and interval for the monthly plan
  ///
  /// In en, this message translates to:
  /// **'AUD 9.99 per month'**
  String get subscriptionPricePerMonth;

  /// First feature bullet
  ///
  /// In en, this message translates to:
  /// **'Unlimited invoice generation and client management'**
  String get subscriptionFeature1;

  /// Second feature bullet
  ///
  /// In en, this message translates to:
  /// **'Stripe payouts directly to your organization\'s bank account'**
  String get subscriptionFeature2;

  /// Third feature bullet
  ///
  /// In en, this message translates to:
  /// **'Recurring invoice consent and automatic charges'**
  String get subscriptionFeature3;

  /// Fourth feature bullet
  ///
  /// In en, this message translates to:
  /// **'Email and PDF delivery of invoices and receipts'**
  String get subscriptionFeature4;

  /// Button to start the subscription purchase
  ///
  /// In en, this message translates to:
  /// **'SUBSCRIBE NOW'**
  String get subscriptionBuyButton;

  /// Button to restore an existing subscription
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get subscriptionRestoreButton;

  /// Button to open store subscription management
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get subscriptionManageButton;

  /// Warning shown before the store products exist
  ///
  /// In en, this message translates to:
  /// **'The subscription product is not yet available. The app-store product IDs have not been created. Placeholder IDs are shown below for configuration:'**
  String get subscriptionProductPlaceholder;

  /// Placeholder for the iOS subscription product ID
  ///
  /// In en, this message translates to:
  /// **'iOS product ID: YOUR_IOS_MONTHLY_PRODUCT_ID'**
  String get subscriptionIosPlaceholder;

  /// Placeholder for the Android subscription product ID
  ///
  /// In en, this message translates to:
  /// **'Android product ID: YOUR_ANDROID_MONTHLY_PRODUCT_ID'**
  String get subscriptionAndroidPlaceholder;

  /// Shown when the organization has an active subscription
  ///
  /// In en, this message translates to:
  /// **'Your subscription is active'**
  String get subscriptionStatusActive;

  /// Shown when the subscription is in a grace period
  ///
  /// In en, this message translates to:
  /// **'Your subscription is in a grace period'**
  String get subscriptionStatusGrace;

  /// Shown when the subscription has expired
  ///
  /// In en, this message translates to:
  /// **'Your subscription has expired'**
  String get subscriptionStatusExpired;

  /// Shown when there is no subscription
  ///
  /// In en, this message translates to:
  /// **'No subscription on file'**
  String get subscriptionStatusUnknown;

  /// Generic error for subscription verification
  ///
  /// In en, this message translates to:
  /// **'Could not verify your subscription. Please try again later.'**
  String get subscriptionError;

  /// Title for the recurring payment consent dialog
  ///
  /// In en, this message translates to:
  /// **'RECURRING PAYMENT'**
  String get recurringPaymentTitle;

  /// Consent text shown before the client accepts recurring payments
  ///
  /// In en, this message translates to:
  /// **'I authorise {orgName} to charge my saved payment method on the {frequency} cadence to pay CareNest invoice {invoiceNumber} ({amount}). I can cancel at any time before the next scheduled charge.'**
  String recurringPaymentSubtitle(
    String orgName,
    String frequency,
    String invoiceNumber,
    String amount,
  );

  /// Frequency label for weekly cadence
  ///
  /// In en, this message translates to:
  /// **'weekly'**
  String get recurringPaymentFrequencyWeekly;

  /// Frequency label for fortnightly cadence
  ///
  /// In en, this message translates to:
  /// **'fortnightly'**
  String get recurringPaymentFrequencyFortnightly;

  /// Frequency label for monthly cadence
  ///
  /// In en, this message translates to:
  /// **'monthly'**
  String get recurringPaymentFrequencyMonthly;

  /// Checkbox the client must tick before accepting
  ///
  /// In en, this message translates to:
  /// **'I understand and agree to the recurring-payment terms'**
  String get recurringPaymentConsentCheckbox;

  /// Button to accept the recurring-payment consent
  ///
  /// In en, this message translates to:
  /// **'ACCEPT AND SAVE'**
  String get recurringPaymentAcceptButton;

  /// Button to cancel the consent dialog
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get recurringPaymentCancelButton;

  /// Error when the recurring agreement cannot be created
  ///
  /// In en, this message translates to:
  /// **'Could not set up recurring payments. Please try again later.'**
  String get recurringPaymentError;

  /// Confirmation shown after the agreement is created
  ///
  /// In en, this message translates to:
  /// **'Recurring-payment consent is ready. The client can open the link to save their payment method.'**
  String get recurringPaymentSetupReady;

  /// Instruction to open the Stripe setup URL
  ///
  /// In en, this message translates to:
  /// **'Open this link in your browser: {url}'**
  String recurringPaymentSetupUrlHint(String url);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
