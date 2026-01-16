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

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'CareNest'**
  String get appName;

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

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

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

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @signupPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get signupPrompt;

  /// No description provided for @signupLink.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signupLink;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @securedWith256Bit.
  ///
  /// In en, this message translates to:
  /// **'Secured with 256-bit SSL encryption'**
  String get securedWith256Bit;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 CareNest. All rights reserved.'**
  String get copyright;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join us and start managing your invoices efficiently'**
  String get signupSubtitle;

  /// No description provided for @personalInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfoSection;

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

  /// No description provided for @accountTypeSection.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountTypeSection;

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

  /// No description provided for @organizationSetupSection.
  ///
  /// In en, this message translates to:
  /// **'Organization Setup'**
  String get organizationSetupSection;

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

  /// No description provided for @joinOrgSection.
  ///
  /// In en, this message translates to:
  /// **'Join Organization'**
  String get joinOrgSection;

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

  /// No description provided for @organizationCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Organization Code'**
  String get organizationCodeHint;

  /// No description provided for @organizationCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter organization code'**
  String get organizationCodeRequired;

  /// No description provided for @securitySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securitySection;

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

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

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

  /// No description provided for @emailAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddressLabel;

  /// No description provided for @enterEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmailHint;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberPassword;

  /// No description provided for @verificationCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully!'**
  String get verificationCodeSent;

  /// No description provided for @failedToSendCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification code. Please try again.'**
  String get failedToSendCode;

  /// No description provided for @verifyOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtpTitle;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @weSentCode.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to your email'**
  String get weSentCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

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

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordHint;

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

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

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

  /// No description provided for @organizationSection.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organizationSection;

  /// No description provided for @organizationDetails.
  ///
  /// In en, this message translates to:
  /// **'Organization Details'**
  String get organizationDetails;

  /// No description provided for @appSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettingsSection;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage notification preferences'**
  String get notificationsSubtitle;

  /// No description provided for @dateFormatTitle.
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormatTitle;

  /// No description provided for @dateFormatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Control parsing of ambiguous dates'**
  String get dateFormatSubtitle;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app appearance'**
  String get themeSubtitle;

  /// No description provided for @ownerToolsSection.
  ///
  /// In en, this message translates to:
  /// **'Owner Tools'**
  String get ownerToolsSection;

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

  /// No description provided for @dangerZoneSection.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZoneSection;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @logoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your account'**
  String get logoutSubtitle;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmMessage;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and cannot be undone. Are you sure?'**
  String get deleteAccountConfirmMessage;

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

  /// No description provided for @restrictedOwnerOnly.
  ///
  /// In en, this message translates to:
  /// **'Restricted: Owner access only'**
  String get restrictedOwnerOnly;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @errorNetworkTitle.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION ERROR'**
  String get errorNetworkTitle;

  /// No description provided for @errorNetworkMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to the server. Please check your internet connection and try again.'**
  String get errorNetworkMessage;

  /// No description provided for @errorGenericTitle.
  ///
  /// In en, this message translates to:
  /// **'SOMETHING WENT WRONG'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericMessage.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get errorGenericMessage;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'TRY AGAIN'**
  String get retryButton;

  /// No description provided for @noResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'NO RESULTS'**
  String get noResultsTitle;

  /// No description provided for @noResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'No items found matching your criteria.'**
  String get noResultsMessage;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingMessage;

  /// No description provided for @loadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Loading Dashboard...'**
  String get loadingDashboard;

  /// No description provided for @successMessage.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get successMessage;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @adminTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminTitle;

  /// No description provided for @invoicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesTitle;

  /// No description provided for @invoiceCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No invoices} =1{1 invoice} other{{count} invoices}}'**
  String invoiceCount(int count);

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @offlineBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Changes will sync when connected.'**
  String get offlineBannerMessage;

  /// No description provided for @naLabel.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get naLabel;

  /// No description provided for @bankDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetailsTitle;

  /// No description provided for @primaryAccount.
  ///
  /// In en, this message translates to:
  /// **'PRIMARY ACCOUNT'**
  String get primaryAccount;

  /// No description provided for @noBankDetails.
  ///
  /// In en, this message translates to:
  /// **'No bank details saved yet.'**
  String get noBankDetails;

  /// No description provided for @addBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Your Bank Details'**
  String get addBankDetails;

  /// No description provided for @updateBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Update Bank Details'**
  String get updateBankDetails;

  /// No description provided for @selectBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Select which bank details to display'**
  String get selectBankDetails;

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

  /// No description provided for @trackExpenses.
  ///
  /// In en, this message translates to:
  /// **'Track Expenses'**
  String get trackExpenses;

  /// No description provided for @trackExpensesDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep track of your daily spending and manage reimbursements.'**
  String get trackExpensesDesc;

  /// No description provided for @openDashboard.
  ///
  /// In en, this message translates to:
  /// **'Open Dashboard'**
  String get openDashboard;

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

  /// No description provided for @activeBusinesses.
  ///
  /// In en, this message translates to:
  /// **'Active Businesses'**
  String get activeBusinesses;

  /// No description provided for @totalClients.
  ///
  /// In en, this message translates to:
  /// **'Total Clients'**
  String get totalClients;

  /// No description provided for @invoicesGenerated.
  ///
  /// In en, this message translates to:
  /// **'Invoices Generated'**
  String get invoicesGenerated;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @businessOverview.
  ///
  /// In en, this message translates to:
  /// **'Business Overview'**
  String get businessOverview;

  /// No description provided for @businessOverviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Track your business performance at a glance'**
  String get businessOverviewDesc;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @adminActive.
  ///
  /// In en, this message translates to:
  /// **'Admin Active'**
  String get adminActive;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @addClient.
  ///
  /// In en, this message translates to:
  /// **'Add Client'**
  String get addClient;

  /// No description provided for @editClient.
  ///
  /// In en, this message translates to:
  /// **'Edit Client'**
  String get editClient;

  /// No description provided for @clientDetails.
  ///
  /// In en, this message translates to:
  /// **'Client Details'**
  String get clientDetails;

  /// No description provided for @clientName.
  ///
  /// In en, this message translates to:
  /// **'Client Name'**
  String get clientName;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments'**
  String get noAppointments;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @createInvoice.
  ///
  /// In en, this message translates to:
  /// **'Create Invoice'**
  String get createInvoice;

  /// No description provided for @generateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Generate Invoice'**
  String get generateInvoice;

  /// No description provided for @invoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetails;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get invoiceNumber;

  /// No description provided for @invoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice Date'**
  String get invoiceDate;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @employees.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get employees;

  /// No description provided for @selectEmployee.
  ///
  /// In en, this message translates to:
  /// **'Select Employee'**
  String get selectEmployee;

  /// No description provided for @employeeTracking.
  ///
  /// In en, this message translates to:
  /// **'Employee Tracking'**
  String get employeeTracking;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @expenseDetails.
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetails;

  /// No description provided for @expenseCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get expenseCategory;

  /// No description provided for @expenseAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get expenseAmount;

  /// No description provided for @expenseDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get expenseDate;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @holidays.
  ///
  /// In en, this message translates to:
  /// **'Holidays'**
  String get holidays;

  /// No description provided for @addHoliday.
  ///
  /// In en, this message translates to:
  /// **'Add Holiday'**
  String get addHoliday;

  /// No description provided for @holidayList.
  ///
  /// In en, this message translates to:
  /// **'Holiday List'**
  String get holidayList;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @addNotes.
  ///
  /// In en, this message translates to:
  /// **'Add Notes'**
  String get addNotes;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @pricingManagement.
  ///
  /// In en, this message translates to:
  /// **'Pricing Management'**
  String get pricingManagement;

  /// No description provided for @priceHistory.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get priceHistory;

  /// No description provided for @bulkOperations.
  ///
  /// In en, this message translates to:
  /// **'Bulk Operations'**
  String get bulkOperations;

  /// No description provided for @ndisItems.
  ///
  /// In en, this message translates to:
  /// **'NDIS Items'**
  String get ndisItems;

  /// No description provided for @configuration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// No description provided for @validation.
  ///
  /// In en, this message translates to:
  /// **'Validation'**
  String get validation;

  /// No description provided for @assignment.
  ///
  /// In en, this message translates to:
  /// **'Assignment'**
  String get assignment;

  /// No description provided for @assignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get assignments;

  /// No description provided for @assignmentList.
  ///
  /// In en, this message translates to:
  /// **'Assignment List'**
  String get assignmentList;

  /// No description provided for @editAssignment.
  ///
  /// In en, this message translates to:
  /// **'Edit Assignment'**
  String get editAssignment;

  /// No description provided for @shiftAssignment.
  ///
  /// In en, this message translates to:
  /// **'Shift Assignment'**
  String get shiftAssignment;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @addBusiness.
  ///
  /// In en, this message translates to:
  /// **'Add Business'**
  String get addBusiness;

  /// No description provided for @businessDetails.
  ///
  /// In en, this message translates to:
  /// **'Business Details'**
  String get businessDetails;

  /// No description provided for @businessList.
  ///
  /// In en, this message translates to:
  /// **'Business List'**
  String get businessList;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @editOrganization.
  ///
  /// In en, this message translates to:
  /// **'Edit Organization'**
  String get editOrganization;

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

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark All Read'**
  String get markAllRead;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @apiUsage.
  ///
  /// In en, this message translates to:
  /// **'API Usage'**
  String get apiUsage;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

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

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @deselectAll.
  ///
  /// In en, this message translates to:
  /// **'Deselect All'**
  String get deselectAll;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// No description provided for @thisYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get thisYear;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'PERMISSION REQUIRED'**
  String get permissionRequired;

  /// No description provided for @permissionCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera access is required to take photos.'**
  String get permissionCamera;

  /// No description provided for @permissionStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage access is required to save files.'**
  String get permissionStorage;

  /// No description provided for @grantPermission.
  ///
  /// In en, this message translates to:
  /// **'GRANT PERMISSION'**
  String get grantPermission;

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

  /// No description provided for @serviceRates.
  ///
  /// In en, this message translates to:
  /// **'Service Rates'**
  String get serviceRates;

  /// No description provided for @serviceRatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Configure service pricing structures'**
  String get serviceRatesDesc;

  /// No description provided for @bulkOperationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk Operations'**
  String get bulkOperationsTitle;

  /// No description provided for @bulkOperationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Import/export and batch updates'**
  String get bulkOperationsDesc;

  /// No description provided for @priceHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get priceHistoryTitle;

  /// No description provided for @priceHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Track pricing changes over time'**
  String get priceHistoryDesc;

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

  /// No description provided for @pricingModules.
  ///
  /// In en, this message translates to:
  /// **'Pricing Modules'**
  String get pricingModules;

  /// No description provided for @chooseModule.
  ///
  /// In en, this message translates to:
  /// **'Choose a module to manage your pricing'**
  String get chooseModule;

  /// No description provided for @totalServices.
  ///
  /// In en, this message translates to:
  /// **'Total Services'**
  String get totalServices;

  /// No description provided for @activeRates.
  ///
  /// In en, this message translates to:
  /// **'Active Rates'**
  String get activeRates;

  /// No description provided for @pendingUpdates.
  ///
  /// In en, this message translates to:
  /// **'Pending Updates'**
  String get pendingUpdates;

  /// No description provided for @avgRate.
  ///
  /// In en, this message translates to:
  /// **'Avg Rate'**
  String get avgRate;

  /// No description provided for @systemActive.
  ///
  /// In en, this message translates to:
  /// **'System Active'**
  String get systemActive;

  /// No description provided for @shortcutsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} shortcuts available'**
  String shortcutsAvailable(int count);

  /// No description provided for @ndisItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} NDIS items'**
  String ndisItemsCount(int count);

  /// No description provided for @serviceTypesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} service types'**
  String serviceTypesCount(int count);

  /// No description provided for @pendingOperations.
  ///
  /// In en, this message translates to:
  /// **'{count} pending operations'**
  String pendingOperations(int count);

  /// No description provided for @historicalRecords.
  ///
  /// In en, this message translates to:
  /// **'{count} historical records'**
  String historicalRecords(int count);

  /// No description provided for @activeMetrics.
  ///
  /// In en, this message translates to:
  /// **'{count} active metrics'**
  String activeMetrics(int count);

  /// No description provided for @expenseManagement.
  ///
  /// In en, this message translates to:
  /// **'EXPENSE MANAGEMENT'**
  String get expenseManagement;

  /// No description provided for @expenseManagementWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome! Use the tabs to manage expenses, approvals, and reports. Tap any stat card for details.'**
  String get expenseManagementWelcome;

  /// No description provided for @totalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// No description provided for @pendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get pendingApproval;

  /// No description provided for @thisMonthExpenses.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonthExpenses;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @expenseList.
  ///
  /// In en, this message translates to:
  /// **'Expense List'**
  String get expenseList;

  /// No description provided for @approvals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get approvals;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @noExpenseData.
  ///
  /// In en, this message translates to:
  /// **'No Expense Data'**
  String get noExpenseData;

  /// No description provided for @addExpenseToView.
  ///
  /// In en, this message translates to:
  /// **'Add expenses to view dashboard statistics'**
  String get addExpenseToView;

  /// No description provided for @recentExpenses.
  ///
  /// In en, this message translates to:
  /// **'Recent Expenses'**
  String get recentExpenses;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @invoiceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetailsTitle;

  /// No description provided for @clientInformation.
  ///
  /// In en, this message translates to:
  /// **'Client Information'**
  String get clientInformation;

  /// No description provided for @financialSummary.
  ///
  /// In en, this message translates to:
  /// **'Financial Summary'**
  String get financialSummary;

  /// No description provided for @statusInformation.
  ///
  /// In en, this message translates to:
  /// **'Status Information'**
  String get statusInformation;

  /// No description provided for @shareInvoice.
  ///
  /// In en, this message translates to:
  /// **'Share Invoice'**
  String get shareInvoice;

  /// No description provided for @deleteInvoice.
  ///
  /// In en, this message translates to:
  /// **'Delete Invoice'**
  String get deleteInvoice;

  /// No description provided for @viewInvoice.
  ///
  /// In en, this message translates to:
  /// **'View Invoice'**
  String get viewInvoice;

  /// No description provided for @loadingInvoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Loading invoice details...'**
  String get loadingInvoiceDetails;

  /// No description provided for @invoiceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Invoice not found'**
  String get invoiceNotFound;

  /// No description provided for @errorLoadingInvoice.
  ///
  /// In en, this message translates to:
  /// **'Error loading invoice'**
  String get errorLoadingInvoice;

  /// No description provided for @unreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String unreadCount(int count);

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up! New notifications will appear here.'**
  String get allCaughtUp;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsRead;

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

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @clientInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Client Information'**
  String get clientInformationTitle;

  /// No description provided for @personalDetailsAndContact.
  ///
  /// In en, this message translates to:
  /// **'Personal details and contact information'**
  String get personalDetailsAndContact;

  /// No description provided for @scheduleDetails.
  ///
  /// In en, this message translates to:
  /// **'Schedule Details'**
  String get scheduleDetails;

  /// No description provided for @appointmentSchedules.
  ///
  /// In en, this message translates to:
  /// **'Appointment schedules'**
  String get appointmentSchedules;

  /// No description provided for @loadingAppointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Loading appointment details...'**
  String get loadingAppointmentDetails;

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

  /// No description provided for @timerAlreadyRunning.
  ///
  /// In en, this message translates to:
  /// **'Timer Already Running'**
  String get timerAlreadyRunning;

  /// No description provided for @stopCurrentTimer.
  ///
  /// In en, this message translates to:
  /// **'Please stop the current timer before starting a new one.'**
  String get stopCurrentTimer;

  /// No description provided for @timeUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Time updated successfully'**
  String get timeUpdatedSuccessfully;

  /// No description provided for @automaticInvoiceGeneration.
  ///
  /// In en, this message translates to:
  /// **'Automatic Invoice Generation'**
  String get automaticInvoiceGeneration;

  /// No description provided for @oneClickInvoiceGeneration.
  ///
  /// In en, this message translates to:
  /// **'One-Click Invoice Generation'**
  String get oneClickInvoiceGeneration;

  /// No description provided for @invoiceConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Invoice Configuration'**
  String get invoiceConfiguration;

  /// No description provided for @includeExpenses.
  ///
  /// In en, this message translates to:
  /// **'Include Expenses'**
  String get includeExpenses;

  /// No description provided for @addExpenseItemsToInvoices.
  ///
  /// In en, this message translates to:
  /// **'Add expense items to invoices'**
  String get addExpenseItemsToInvoices;

  /// No description provided for @applyTax.
  ///
  /// In en, this message translates to:
  /// **'Apply Tax'**
  String get applyTax;

  /// No description provided for @includeTaxCalculations.
  ///
  /// In en, this message translates to:
  /// **'Include tax calculations'**
  String get includeTaxCalculations;

  /// No description provided for @validatePrices.
  ///
  /// In en, this message translates to:
  /// **'Validate Prices'**
  String get validatePrices;

  /// No description provided for @checkPricesAgainstNDIS.
  ///
  /// In en, this message translates to:
  /// **'Check prices against NDIS price caps'**
  String get checkPricesAgainstNDIS;

  /// No description provided for @allowPriceCapOverride.
  ///
  /// In en, this message translates to:
  /// **'Allow Price Cap Override'**
  String get allowPriceCapOverride;

  /// No description provided for @allowPricesAboveNDIS.
  ///
  /// In en, this message translates to:
  /// **'Allow prices above NDIS caps'**
  String get allowPricesAboveNDIS;

  /// No description provided for @detailedPricingInfo.
  ///
  /// In en, this message translates to:
  /// **'Detailed Pricing Info'**
  String get detailedPricingInfo;

  /// No description provided for @includeComprehensivePricing.
  ///
  /// In en, this message translates to:
  /// **'Include comprehensive pricing details'**
  String get includeComprehensivePricing;

  /// No description provided for @invoicePeriod.
  ///
  /// In en, this message translates to:
  /// **'Invoice Period'**
  String get invoicePeriod;

  /// No description provided for @selectPeriod.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriod;

  /// No description provided for @noPeriodSelected.
  ///
  /// In en, this message translates to:
  /// **'No period selected (using default)'**
  String get noPeriodSelected;

  /// No description provided for @allEmployees.
  ///
  /// In en, this message translates to:
  /// **'All Employees'**
  String get allEmployees;

  /// No description provided for @selectEmployees.
  ///
  /// In en, this message translates to:
  /// **'Select Employees'**
  String get selectEmployees;

  /// No description provided for @noEmployeesSelected.
  ///
  /// In en, this message translates to:
  /// **'No employees selected'**
  String get noEmployeesSelected;

  /// No description provided for @chooseEmployees.
  ///
  /// In en, this message translates to:
  /// **'Choose Employees'**
  String get chooseEmployees;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetails;

  /// No description provided for @taxRate.
  ///
  /// In en, this message translates to:
  /// **'Tax Rate'**
  String get taxRate;

  /// No description provided for @generatingInvoices.
  ///
  /// In en, this message translates to:
  /// **'Generating Invoices...'**
  String get generatingInvoices;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @viewGeneratedPdfs.
  ///
  /// In en, this message translates to:
  /// **'View Generated PDFs'**
  String get viewGeneratedPdfs;

  /// No description provided for @pricingConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Pricing Configuration'**
  String get pricingConfiguration;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @pricingRulesTab.
  ///
  /// In en, this message translates to:
  /// **'Pricing Rules'**
  String get pricingRulesTab;

  /// No description provided for @integrationsTab.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get integrationsTab;

  /// No description provided for @advancedTab.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advancedTab;

  /// No description provided for @generalPricingSettings.
  ///
  /// In en, this message translates to:
  /// **'General Pricing Settings'**
  String get generalPricingSettings;

  /// No description provided for @basicConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Basic Configuration'**
  String get basicConfiguration;

  /// No description provided for @defaultCurrency.
  ///
  /// In en, this message translates to:
  /// **'Default Currency'**
  String get defaultCurrency;

  /// No description provided for @pricingModel.
  ///
  /// In en, this message translates to:
  /// **'Pricing Model'**
  String get pricingModel;

  /// No description provided for @roundingMethod.
  ///
  /// In en, this message translates to:
  /// **'Rounding Method'**
  String get roundingMethod;

  /// No description provided for @taxCalculation.
  ///
  /// In en, this message translates to:
  /// **'Tax Calculation'**
  String get taxCalculation;

  /// No description provided for @pricingParameters.
  ///
  /// In en, this message translates to:
  /// **'Pricing Parameters'**
  String get pricingParameters;

  /// No description provided for @defaultMarkup.
  ///
  /// In en, this message translates to:
  /// **'Default Markup (%)'**
  String get defaultMarkup;

  /// No description provided for @maxPriceVariation.
  ///
  /// In en, this message translates to:
  /// **'Max Price Variation (%)'**
  String get maxPriceVariation;

  /// No description provided for @fallbackBaseRate.
  ///
  /// In en, this message translates to:
  /// **'Fallback Base Rate'**
  String get fallbackBaseRate;

  /// No description provided for @systemBehavior.
  ///
  /// In en, this message translates to:
  /// **'System Behavior'**
  String get systemBehavior;

  /// No description provided for @addRule.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRule;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @resetConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Reset Configuration'**
  String get resetConfiguration;

  /// No description provided for @clearPriceHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear Price History'**
  String get clearPriceHistory;

  /// No description provided for @monitorPricingPerformance.
  ///
  /// In en, this message translates to:
  /// **'Monitor pricing performance and analyze trends across your services'**
  String get monitorPricingPerformance;

  /// No description provided for @liveData.
  ///
  /// In en, this message translates to:
  /// **'Live Data'**
  String get liveData;

  /// No description provided for @avgRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg Rate'**
  String get avgRateLabel;

  /// No description provided for @utilization.
  ///
  /// In en, this message translates to:
  /// **'Utilization'**
  String get utilization;

  /// No description provided for @profitMargin.
  ///
  /// In en, this message translates to:
  /// **'Profit Margin'**
  String get profitMargin;

  /// No description provided for @analyticsOverview.
  ///
  /// In en, this message translates to:
  /// **'Analytics Overview'**
  String get analyticsOverview;

  /// No description provided for @revenueTrend.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get revenueTrend;

  /// No description provided for @serviceDistribution.
  ///
  /// In en, this message translates to:
  /// **'Service Distribution'**
  String get serviceDistribution;

  /// No description provided for @revenueAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Revenue Analysis'**
  String get revenueAnalysis;

  /// No description provided for @revenueByPeriod.
  ///
  /// In en, this message translates to:
  /// **'Revenue by Period'**
  String get revenueByPeriod;

  /// No description provided for @revenueByServiceCategory.
  ///
  /// In en, this message translates to:
  /// **'Revenue by Service Category'**
  String get revenueByServiceCategory;

  /// No description provided for @topPerformingServices.
  ///
  /// In en, this message translates to:
  /// **'Top Performing Services'**
  String get topPerformingServices;

  /// No description provided for @pricingTrendsByCategory.
  ///
  /// In en, this message translates to:
  /// **'Pricing Trends by Category'**
  String get pricingTrendsByCategory;

  /// No description provided for @averageRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Average Rate'**
  String get averageRateLabel;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @pricingValidation.
  ///
  /// In en, this message translates to:
  /// **'Pricing Validation'**
  String get pricingValidation;

  /// No description provided for @validationResults.
  ///
  /// In en, this message translates to:
  /// **'Validation Results'**
  String get validationResults;

  /// No description provided for @validationRules.
  ///
  /// In en, this message translates to:
  /// **'Validation Rules'**
  String get validationRules;

  /// No description provided for @resolve.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get resolve;

  /// No description provided for @runNow.
  ///
  /// In en, this message translates to:
  /// **'Run Now'**
  String get runNow;

  /// No description provided for @configure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get configure;

  /// No description provided for @ndisItemManagement.
  ///
  /// In en, this message translates to:
  /// **'NDIS Item Management'**
  String get ndisItemManagement;

  /// No description provided for @noNdisItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found.'**
  String get noNdisItemsFound;

  /// No description provided for @searchByItemNameOrCode.
  ///
  /// In en, this message translates to:
  /// **'Search by item name or code...'**
  String get searchByItemNameOrCode;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @filtered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get filtered;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @editNdisItem.
  ///
  /// In en, this message translates to:
  /// **'Edit NDIS Item'**
  String get editNdisItem;

  /// No description provided for @addNewNdisItem.
  ///
  /// In en, this message translates to:
  /// **'Add New NDIS Item'**
  String get addNewNdisItem;

  /// No description provided for @itemCode.
  ///
  /// In en, this message translates to:
  /// **'Item Code'**
  String get itemCode;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @unitPrice.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unitPrice;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInformation;

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact Details'**
  String get contactDetails;

  /// No description provided for @banking.
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get banking;

  /// No description provided for @ndisRegistration.
  ///
  /// In en, this message translates to:
  /// **'NDIS Registration'**
  String get ndisRegistration;

  /// No description provided for @legalName.
  ///
  /// In en, this message translates to:
  /// **'Legal Name'**
  String get legalName;

  /// No description provided for @tradingAs.
  ///
  /// In en, this message translates to:
  /// **'Trading As'**
  String get tradingAs;

  /// No description provided for @taxIdAbn.
  ///
  /// In en, this message translates to:
  /// **'Tax ID (ABN)'**
  String get taxIdAbn;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @headquarters.
  ///
  /// In en, this message translates to:
  /// **'Headquarters'**
  String get headquarters;

  /// No description provided for @viewMap.
  ///
  /// In en, this message translates to:
  /// **'View Map'**
  String get viewMap;

  /// No description provided for @joinOrganization.
  ///
  /// In en, this message translates to:
  /// **'Join Organization'**
  String get joinOrganization;

  /// No description provided for @organizationCode.
  ///
  /// In en, this message translates to:
  /// **'Organization Code'**
  String get organizationCode;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// No description provided for @clientPricingReview.
  ///
  /// In en, this message translates to:
  /// **'Client Pricing Review'**
  String get clientPricingReview;

  /// No description provided for @selectClientToViewPricing.
  ///
  /// In en, this message translates to:
  /// **'Select a client to view pricing'**
  String get selectClientToViewPricing;

  /// No description provided for @noClientsWithAssignmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No clients with assignments found'**
  String get noClientsWithAssignmentsFound;

  /// No description provided for @noSupportItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No support items found'**
  String get noSupportItemsFound;

  /// No description provided for @editPrices.
  ///
  /// In en, this message translates to:
  /// **'Edit Prices'**
  String get editPrices;

  /// No description provided for @exceedsCap.
  ///
  /// In en, this message translates to:
  /// **'Exceeds Cap'**
  String get exceedsCap;

  /// No description provided for @priceOverride.
  ///
  /// In en, this message translates to:
  /// **'Price Override'**
  String get priceOverride;

  /// No description provided for @noNdisItemsForOverride.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found'**
  String get noNdisItemsForOverride;

  /// No description provided for @noClientAssignmentsForOverride.
  ///
  /// In en, this message translates to:
  /// **'No client assignments with NDIS items available for price override.'**
  String get noClientAssignmentsForOverride;

  /// No description provided for @applyOverrides.
  ///
  /// In en, this message translates to:
  /// **'Apply Overrides'**
  String get applyOverrides;

  /// No description provided for @clientSpecificPricing.
  ///
  /// In en, this message translates to:
  /// **'Client-Specific Pricing'**
  String get clientSpecificPricing;

  /// No description provided for @organizationWidePricing.
  ///
  /// In en, this message translates to:
  /// **'Organization-Wide Pricing'**
  String get organizationWidePricing;

  /// No description provided for @currentPrice.
  ///
  /// In en, this message translates to:
  /// **'Current Price'**
  String get currentPrice;

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get maxPrice;

  /// No description provided for @priceExceedsCap.
  ///
  /// In en, this message translates to:
  /// **'Price exceeds NDIS cap'**
  String get priceExceedsCap;

  /// No description provided for @newBusiness.
  ///
  /// In en, this message translates to:
  /// **'New Business'**
  String get newBusiness;

  /// No description provided for @businessInformation.
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get businessInformation;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @addressInformation.
  ///
  /// In en, this message translates to:
  /// **'Address Information'**
  String get addressInformation;

  /// No description provided for @addingBusiness.
  ///
  /// In en, this message translates to:
  /// **'Adding business...'**
  String get addingBusiness;

  /// No description provided for @businessDetailsAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Business details added successfully'**
  String get businessDetailsAddedSuccessfully;

  /// No description provided for @areYouSureAddBusiness.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to add this business?'**
  String get areYouSureAddBusiness;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessName;

  /// No description provided for @businessEmail.
  ///
  /// In en, this message translates to:
  /// **'Business Email'**
  String get businessEmail;

  /// No description provided for @businessPhone.
  ///
  /// In en, this message translates to:
  /// **'Business Phone'**
  String get businessPhone;

  /// No description provided for @businessAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Address'**
  String get businessAddress;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @addNewExpense.
  ///
  /// In en, this message translates to:
  /// **'Add New Expense'**
  String get addNewExpense;

  /// No description provided for @editExpense.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// No description provided for @expenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get expenseTitle;

  /// No description provided for @recurringExpense.
  ///
  /// In en, this message translates to:
  /// **'Recurring Expense'**
  String get recurringExpense;

  /// No description provided for @enableForRegularlyOccurring.
  ///
  /// In en, this message translates to:
  /// **'Enable for regularly occurring expenses'**
  String get enableForRegularlyOccurring;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @submitExpense.
  ///
  /// In en, this message translates to:
  /// **'Submit Expense'**
  String get submitExpense;

  /// No description provided for @updateExpense.
  ///
  /// In en, this message translates to:
  /// **'Update Expense'**
  String get updateExpense;

  /// No description provided for @expenseSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Expense submitted successfully'**
  String get expenseSubmittedSuccessfully;

  /// No description provided for @expenseUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Expense updated successfully'**
  String get expenseUpdatedSuccessfully;

  /// No description provided for @uploadingFiles.
  ///
  /// In en, this message translates to:
  /// **'Uploading file(s)...'**
  String get uploadingFiles;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @profilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profilePhoto;

  /// No description provided for @showYourBestSide.
  ///
  /// In en, this message translates to:
  /// **'Show Your Best Side'**
  String get showYourBestSide;

  /// No description provided for @photoTipsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A great photo builds trust and makes your profile stand out.'**
  String get photoTipsSubtitle;

  /// No description provided for @tapToSelect.
  ///
  /// In en, this message translates to:
  /// **'Tap to Select'**
  String get tapToSelect;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @uploadAndSave.
  ///
  /// In en, this message translates to:
  /// **'Upload & Save'**
  String get uploadAndSave;

  /// No description provided for @photoUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Photo uploaded successfully'**
  String get photoUploadedSuccessfully;

  /// No description provided for @addNewHoliday.
  ///
  /// In en, this message translates to:
  /// **'Add New Holiday'**
  String get addNewHoliday;

  /// No description provided for @holidayDetails.
  ///
  /// In en, this message translates to:
  /// **'Holiday Details'**
  String get holidayDetails;

  /// No description provided for @holidayName.
  ///
  /// In en, this message translates to:
  /// **'Holiday Name'**
  String get holidayName;

  /// No description provided for @dayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Day of Week'**
  String get dayOfWeek;

  /// No description provided for @creatingHoliday.
  ///
  /// In en, this message translates to:
  /// **'Creating Holiday...'**
  String get creatingHoliday;

  /// No description provided for @holidayCreated.
  ///
  /// In en, this message translates to:
  /// **'Holiday Created!'**
  String get holidayCreated;

  /// No description provided for @holidayAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your holiday has been added successfully'**
  String get holidayAddedSuccessfully;

  /// No description provided for @serviceRateManagement.
  ///
  /// In en, this message translates to:
  /// **'Service Rate Management'**
  String get serviceRateManagement;

  /// No description provided for @baseRate.
  ///
  /// In en, this message translates to:
  /// **'Base Rate'**
  String get baseRate;

  /// No description provided for @weekendRate.
  ///
  /// In en, this message translates to:
  /// **'Weekend Rate'**
  String get weekendRate;

  /// No description provided for @publicHolidayRate.
  ///
  /// In en, this message translates to:
  /// **'Public Holiday Rate'**
  String get publicHolidayRate;

  /// No description provided for @effectiveDate.
  ///
  /// In en, this message translates to:
  /// **'Effective Date'**
  String get effectiveDate;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @liveTracking.
  ///
  /// In en, this message translates to:
  /// **'Live Tracking'**
  String get liveTracking;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @increases.
  ///
  /// In en, this message translates to:
  /// **'Increases'**
  String get increases;

  /// No description provided for @decreases.
  ///
  /// In en, this message translates to:
  /// **'Decreases'**
  String get decreases;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History...'**
  String get searchHistory;

  /// No description provided for @was.
  ///
  /// In en, this message translates to:
  /// **'Was'**
  String get was;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @selectEmployeesAndClients.
  ///
  /// In en, this message translates to:
  /// **'Select Employees & Clients'**
  String get selectEmployeesAndClients;

  /// No description provided for @loadingEmployeesAndClients.
  ///
  /// In en, this message translates to:
  /// **'Loading employees and clients...'**
  String get loadingEmployeesAndClients;

  /// No description provided for @shiftDetails.
  ///
  /// In en, this message translates to:
  /// **'Shift Details'**
  String get shiftDetails;

  /// No description provided for @errorLoadingEmployees.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Employees'**
  String get errorLoadingEmployees;

  /// No description provided for @noEmployeesFound.
  ///
  /// In en, this message translates to:
  /// **'No Employees Found'**
  String get noEmployeesFound;

  /// No description provided for @noEmployeesAvailable.
  ///
  /// In en, this message translates to:
  /// **'There are no employees available to select for invoice generation.'**
  String get noEmployeesAvailable;

  /// No description provided for @loadingClients.
  ///
  /// In en, this message translates to:
  /// **'Loading clients...'**
  String get loadingClients;

  /// No description provided for @noClientsAssigned.
  ///
  /// In en, this message translates to:
  /// **'No clients assigned to this employee'**
  String get noClientsAssigned;

  /// No description provided for @employeesSelected.
  ///
  /// In en, this message translates to:
  /// **'employees selected'**
  String get employeesSelected;

  /// No description provided for @readyToGenerateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Ready to generate invoice'**
  String get readyToGenerateInvoice;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @errorLoadingAssignments.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Assignments'**
  String get errorLoadingAssignments;

  /// No description provided for @noAssignmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No Assignments Found'**
  String get noAssignmentsFound;

  /// No description provided for @noAssignmentsMessage.
  ///
  /// In en, this message translates to:
  /// **'Assignments for this organization will appear here.'**
  String get noAssignmentsMessage;

  /// No description provided for @totalWorkHoursToday.
  ///
  /// In en, this message translates to:
  /// **'Total work hours today'**
  String get totalWorkHoursToday;

  /// No description provided for @nothingScheduledToday.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled today'**
  String get nothingScheduledToday;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get myRequests;

  /// No description provided for @timesheet.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
  String get timesheet;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @addShiftRequest.
  ///
  /// In en, this message translates to:
  /// **'Add a shift request'**
  String get addShiftRequest;

  /// No description provided for @addTimeOffRequest.
  ///
  /// In en, this message translates to:
  /// **'Add a time off request'**
  String get addTimeOffRequest;

  /// No description provided for @noRequestsToDisplay.
  ///
  /// In en, this message translates to:
  /// **'No requests to display'**
  String get noRequestsToDisplay;

  /// No description provided for @addNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Add a new request'**
  String get addNewRequest;

  /// No description provided for @declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

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

  /// No description provided for @imDone.
  ///
  /// In en, this message translates to:
  /// **'I\'m done'**
  String get imDone;

  /// No description provided for @pleaseSelectJob.
  ///
  /// In en, this message translates to:
  /// **'Please select a job'**
  String get pleaseSelectJob;

  /// No description provided for @endTimeError.
  ///
  /// In en, this message translates to:
  /// **'End time cannot be before start time'**
  String get endTimeError;

  /// No description provided for @failedToCreateRequest.
  ///
  /// In en, this message translates to:
  /// **'Failed to create request'**
  String get failedToCreateRequest;

  /// No description provided for @addShiftTitle.
  ///
  /// In en, this message translates to:
  /// **'Add shift'**
  String get addShiftTitle;

  /// No description provided for @jobLabel.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get jobLabel;

  /// No description provided for @selectJob.
  ///
  /// In en, this message translates to:
  /// **'Select Job'**
  String get selectJob;

  /// No description provided for @startsLabel.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get startsLabel;

  /// No description provided for @endsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get endsLabel;

  /// No description provided for @totalHours.
  ///
  /// In en, this message translates to:
  /// **'Total hours'**
  String get totalHours;

  /// No description provided for @invalidDuration.
  ///
  /// In en, this message translates to:
  /// **'Invalid duration'**
  String get invalidDuration;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get addNote;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Type your note here...'**
  String get noteHint;

  /// No description provided for @managerApprovalMessage.
  ///
  /// In en, this message translates to:
  /// **'All requests will be sent for a manager\'s approval'**
  String get managerApprovalMessage;

  /// No description provided for @sendForApproval.
  ///
  /// In en, this message translates to:
  /// **'Send for approval'**
  String get sendForApproval;

  /// No description provided for @timeOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Time off'**
  String get timeOffTitle;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @selectLeaveType.
  ///
  /// In en, this message translates to:
  /// **'Select Leave Type'**
  String get selectLeaveType;

  /// No description provided for @fromLabel.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get fromLabel;

  /// No description provided for @toLabel.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get toLabel;

  /// No description provided for @fromLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'FROM:'**
  String get fromLabelCaps;

  /// No description provided for @toLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'TO:'**
  String get toLabelCaps;

  /// No description provided for @pleaseSelectLeaveType.
  ///
  /// In en, this message translates to:
  /// **'Please select a leave type'**
  String get pleaseSelectLeaveType;

  /// No description provided for @endDateError.
  ///
  /// In en, this message translates to:
  /// **'End date cannot be before start date'**
  String get endDateError;

  /// No description provided for @requestsDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'REQUESTS DASHBOARD'**
  String get requestsDashboardTitle;

  /// No description provided for @pendingTab.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pendingTab;

  /// No description provided for @approvedTab.
  ///
  /// In en, this message translates to:
  /// **'APPROVED'**
  String get approvedTab;

  /// No description provided for @declinedTab.
  ///
  /// In en, this message translates to:
  /// **'DECLINED'**
  String get declinedTab;

  /// No description provided for @noRequestsFoundCaps.
  ///
  /// In en, this message translates to:
  /// **'NO REQUESTS FOUND'**
  String get noRequestsFoundCaps;

  /// No description provided for @userLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'USER:'**
  String get userLabelCaps;

  /// No description provided for @declineButton.
  ///
  /// In en, this message translates to:
  /// **'DECLINE'**
  String get declineButton;

  /// No description provided for @approveButton.
  ///
  /// In en, this message translates to:
  /// **'APPROVE'**
  String get approveButton;

  /// No description provided for @declineRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'DECLINE REQUEST'**
  String get declineRequestTitle;

  /// No description provided for @reasonOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'REASON (OPTIONAL)'**
  String get reasonOptionalLabel;

  /// No description provided for @enterReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter reason for declining'**
  String get enterReasonHint;

  /// No description provided for @cancelButtonCaps.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancelButtonCaps;

  /// No description provided for @typeLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'TYPE:'**
  String get typeLabelCaps;

  /// No description provided for @jobLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'JOB:'**
  String get jobLabelCaps;

  /// No description provided for @dateLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'DATE:'**
  String get dateLabelCaps;

  /// No description provided for @timeLabelCaps.
  ///
  /// In en, this message translates to:
  /// **'TIME:'**
  String get timeLabelCaps;

  /// No description provided for @regularLabel.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get regularLabel;

  /// No description provided for @otLabel.
  ///
  /// In en, this message translates to:
  /// **'OT'**
  String get otLabel;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @absenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Absence'**
  String get absenceLabel;

  /// No description provided for @weekTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Week total'**
  String get weekTotalLabel;

  /// No description provided for @requestsLabel.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsLabel;

  /// No description provided for @moreButton.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreButton;

  /// No description provided for @enhancedInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'ENHANCED INVOICE GENERATION'**
  String get enhancedInvoiceTitle;

  /// No description provided for @enhancedInvoiceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate professional invoices with enhanced pricing validation'**
  String get enhancedInvoiceSubtitle;

  /// No description provided for @noEmployeesSelectedCaps.
  ///
  /// In en, this message translates to:
  /// **'NO EMPLOYEES SELECTED'**
  String get noEmployeesSelectedCaps;

  /// No description provided for @selectedEmployeesInfo.
  ///
  /// In en, this message translates to:
  /// **'SELECTED: {employeeCount} {employeeLabel} WITH {clientCount} {clientLabel}'**
  String selectedEmployeesInfo(Object clientCount, Object clientLabel,
      Object employeeCount, Object employeeLabel);

  /// No description provided for @employeeLabel.
  ///
  /// In en, this message translates to:
  /// **'EMPLOYEE'**
  String get employeeLabel;

  /// No description provided for @employeesLabel.
  ///
  /// In en, this message translates to:
  /// **'EMPLOYEES'**
  String get employeesLabel;

  /// No description provided for @clientLabel.
  ///
  /// In en, this message translates to:
  /// **'CLIENT'**
  String get clientLabel;

  /// No description provided for @clientsLabel.
  ///
  /// In en, this message translates to:
  /// **'CLIENTS'**
  String get clientsLabel;

  /// No description provided for @invoiceConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Configuration'**
  String get invoiceConfigurationTitle;

  /// No description provided for @invoiceTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Type'**
  String get invoiceTypeTitle;

  /// No description provided for @invoiceTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose who will be billed on the invoice'**
  String get invoiceTypeSubtitle;

  /// No description provided for @clientOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get clientOptionTitle;

  /// No description provided for @clientOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bill the client'**
  String get clientOptionSubtitle;

  /// No description provided for @employeeOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employeeOptionTitle;

  /// No description provided for @employeeOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bill the employee'**
  String get employeeOptionSubtitle;

  /// No description provided for @adminOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminOptionTitle;

  /// No description provided for @adminOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get adminOptionSubtitle;

  /// No description provided for @invoiceTypeWarning.
  ///
  /// In en, this message translates to:
  /// **'Select an invoice type before generating'**
  String get invoiceTypeWarning;

  /// No description provided for @includeTaxTitle.
  ///
  /// In en, this message translates to:
  /// **'Include Tax (GST)'**
  String get includeTaxTitle;

  /// No description provided for @includeTaxSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add tax calculations to the invoice'**
  String get includeTaxSubtitle;

  /// No description provided for @taxRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Tax Rate'**
  String get taxRateLabel;

  /// No description provided for @bankDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select which bank details to use on the invoice'**
  String get bankDetailsSubtitle;

  /// No description provided for @includeExpensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Include Expenses'**
  String get includeExpensesTitle;

  /// No description provided for @includeExpensesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add expense items to the invoice'**
  String get includeExpensesSubtitle;

  /// No description provided for @allowPriceOverrideTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Price Cap Override'**
  String get allowPriceOverrideTitle;

  /// No description provided for @allowPriceOverrideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable price adjustments beyond standard caps'**
  String get allowPriceOverrideSubtitle;

  /// No description provided for @attachmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachmentsTitle;

  /// No description provided for @additionalFilesTitle.
  ///
  /// In en, this message translates to:
  /// **'ADDITIONAL FILES'**
  String get additionalFilesTitle;

  /// No description provided for @additionalFilesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Attach documents, receipts, or other files'**
  String get additionalFilesSubtitle;

  /// No description provided for @addFilesTitle.
  ///
  /// In en, this message translates to:
  /// **'ADD FILES'**
  String get addFilesTitle;

  /// No description provided for @addFilesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to select files or drag and drop'**
  String get addFilesSubtitle;

  /// No description provided for @attachedFilesLabel.
  ///
  /// In en, this message translates to:
  /// **'Attached Files'**
  String get attachedFilesLabel;

  /// No description provided for @priceOverrideTitle.
  ///
  /// In en, this message translates to:
  /// **'PRICE OVERRIDE'**
  String get priceOverrideTitle;

  /// No description provided for @priceOverrideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review and adjust pricing for NDIS items before generating invoices.'**
  String get priceOverrideSubtitle;

  /// No description provided for @refreshingPricingMessage.
  ///
  /// In en, this message translates to:
  /// **'Refreshing pricing…'**
  String get refreshingPricingMessage;

  /// No description provided for @noNdisItemsFoundInAssignments.
  ///
  /// In en, this message translates to:
  /// **'No NDIS items found in selected assignments.'**
  String get noNdisItemsFoundInAssignments;

  /// No description provided for @allRatesConfiguredMessage.
  ///
  /// In en, this message translates to:
  /// **'All selected NDIS items have configured base service rates.'**
  String get allRatesConfiguredMessage;

  /// No description provided for @missingBaseRatesMessage.
  ///
  /// In en, this message translates to:
  /// **'Base service rates are missing or using fallback for {count} NDIS item(s): {items}. Please add custom pricing or set price overrides.'**
  String missingBaseRatesMessage(Object count, Object items);

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

  /// No description provided for @pricingInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'PRICING INFO'**
  String get pricingInfoTitle;

  /// No description provided for @pricingInfoMessage.
  ///
  /// In en, this message translates to:
  /// **'Pricing shown for {intensity} rates in {state}. Tap the price icon to set custom pricing.'**
  String pricingInfoMessage(Object intensity, Object state);

  /// No description provided for @highIntensityCaps.
  ///
  /// In en, this message translates to:
  /// **'HIGH INTENSITY'**
  String get highIntensityCaps;

  /// No description provided for @standardCaps.
  ///
  /// In en, this message translates to:
  /// **'STANDARD'**
  String get standardCaps;

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

  /// No description provided for @failedToLoadNdisItems.
  ///
  /// In en, this message translates to:
  /// **'Failed to load NDIS items. Please try again.'**
  String get failedToLoadNdisItems;
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
      'that was used.');
}
