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
/// import 'localization/app_localizations.dart';
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

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Our Service'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get email_hint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Create a secure password'**
  String get password_hint;

  /// No description provided for @forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot?'**
  String get forgot;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @join_our.
  ///
  /// In en, this message translates to:
  /// **'Join our'**
  String get join_our;

  /// No description provided for @sanctuary.
  ///
  /// In en, this message translates to:
  /// **'Sanctuary'**
  String get sanctuary;

  /// No description provided for @experience_text.
  ///
  /// In en, this message translates to:
  /// **'Experience a new standard of luxury cleaning for your home and office.'**
  String get experience_text;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @full_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get full_name_hint;

  /// No description provided for @we_will_send_otp.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a verification code to this number'**
  String get we_will_send_otp;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address associated with your account and we\'ll send you a link to reset your password.'**
  String get enter_email;

  /// No description provided for @send_link.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get send_link;

  /// No description provided for @my_addresses.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get my_addresses;

  /// No description provided for @add_address.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get add_address;

  /// No description provided for @no_addresses.
  ///
  /// In en, this message translates to:
  /// **'No Addresses Found'**
  String get no_addresses;

  /// No description provided for @primary_address.
  ///
  /// In en, this message translates to:
  /// **'Primary Address'**
  String get primary_address;

  /// No description provided for @saved_service.
  ///
  /// In en, this message translates to:
  /// **'Saved Service Locations'**
  String get saved_service;

  /// No description provided for @select_for_request.
  ///
  /// In en, this message translates to:
  /// **'Select for Request'**
  String get select_for_request;

  /// No description provided for @address_label.
  ///
  /// In en, this message translates to:
  /// **'Address Label'**
  String get address_label;

  /// No description provided for @address_label_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter address label'**
  String get address_label_hint;

  /// No description provided for @street_address.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get street_address;

  /// No description provided for @street_address_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter street address'**
  String get street_address_hint;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @city_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter city'**
  String get city_hint;

  /// No description provided for @zip_code.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zip_code;

  /// No description provided for @zip_code_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter zip code'**
  String get zip_code_hint;

  /// No description provided for @save_address.
  ///
  /// In en, this message translates to:
  /// **'Save Address'**
  String get save_address;

  /// No description provided for @access_note.
  ///
  /// In en, this message translates to:
  /// **'Access Note'**
  String get access_note;

  /// No description provided for @please_provide.
  ///
  /// In en, this message translates to:
  /// **'Please provide any gate codes or specific entry instructions to ensure our cleaning professionals can access your sanctuary promptly.'**
  String get please_provide;

  /// No description provided for @save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get save_changes;
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
