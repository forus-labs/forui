import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_af.dart';
import 'localizations_am.dart';
import 'localizations_ar.dart';
import 'localizations_as.dart';
import 'localizations_az.dart';
import 'localizations_be.dart';
import 'localizations_bg.dart';
import 'localizations_bn.dart';
import 'localizations_bs.dart';
import 'localizations_ca.dart';
import 'localizations_cs.dart';
import 'localizations_cy.dart';
import 'localizations_da.dart';
import 'localizations_de.dart';
import 'localizations_el.dart';
import 'localizations_en.dart';
import 'localizations_es.dart';
import 'localizations_et.dart';
import 'localizations_eu.dart';
import 'localizations_fa.dart';
import 'localizations_fi.dart';
import 'localizations_fil.dart';
import 'localizations_fr.dart';
import 'localizations_gl.dart';
import 'localizations_gsw.dart';
import 'localizations_gu.dart';
import 'localizations_he.dart';
import 'localizations_hi.dart';
import 'localizations_hr.dart';
import 'localizations_hu.dart';
import 'localizations_hy.dart';
import 'localizations_id.dart';
import 'localizations_is.dart';
import 'localizations_it.dart';
import 'localizations_ja.dart';
import 'localizations_ka.dart';
import 'localizations_kk.dart';
import 'localizations_km.dart';
import 'localizations_kn.dart';
import 'localizations_ko.dart';
import 'localizations_ky.dart';
import 'localizations_lo.dart';
import 'localizations_lt.dart';
import 'localizations_lv.dart';
import 'localizations_mk.dart';
import 'localizations_ml.dart';
import 'localizations_mn.dart';
import 'localizations_mr.dart';
import 'localizations_ms.dart';
import 'localizations_my.dart';
import 'localizations_nb.dart';
import 'localizations_ne.dart';
import 'localizations_nl.dart';
import 'localizations_no.dart';
import 'localizations_or.dart';
import 'localizations_pa.dart';
import 'localizations_pl.dart';
import 'localizations_ps.dart';
import 'localizations_pt.dart';
import 'localizations_ro.dart';
import 'localizations_ru.dart';
import 'localizations_si.dart';
import 'localizations_sk.dart';
import 'localizations_sl.dart';
import 'localizations_sq.dart';
import 'localizations_sr.dart';
import 'localizations_sv.dart';
import 'localizations_sw.dart';
import 'localizations_ta.dart';
import 'localizations_te.dart';
import 'localizations_th.dart';
import 'localizations_tl.dart';
import 'localizations_tr.dart';
import 'localizations_uk.dart';
import 'localizations_ur.dart';
import 'localizations_uz.dart';
import 'localizations_vi.dart';
import 'localizations_zh.dart';
import 'localizations_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FLocalizations
/// returned by `FLocalizations.of(context)`.
///
/// Applications need to include `FLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FLocalizations.localizationsDelegates,
///   supportedLocales: FLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the FLocalizations.supportedLocales
/// property.
abstract class FLocalizations {
  FLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FLocalizations? of(BuildContext context) {
    return Localizations.of<FLocalizations>(context, FLocalizations);
  }

  static const LocalizationsDelegate<FLocalizations> delegate = _FLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('am'),
    Locale('ar'),
    Locale('as'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('bs'),
    Locale('ca'),
    Locale('cs'),
    Locale('cy'),
    Locale('da'),
    Locale('de'),
    Locale('de', 'CH'),
    Locale('el'),
    Locale('en'),
    Locale('en', 'AU'),
    Locale('en', 'CA'),
    Locale('en', 'GB'),
    Locale('en', 'IE'),
    Locale('en', 'IN'),
    Locale('en', 'NZ'),
    Locale('en', 'SG'),
    Locale('en', 'ZA'),
    Locale('es'),
    Locale('es', '419'),
    Locale('es', 'AR'),
    Locale('es', 'BO'),
    Locale('es', 'CL'),
    Locale('es', 'CO'),
    Locale('es', 'CR'),
    Locale('es', 'DO'),
    Locale('es', 'EC'),
    Locale('es', 'GT'),
    Locale('es', 'HN'),
    Locale('es', 'MX'),
    Locale('es', 'NI'),
    Locale('es', 'PA'),
    Locale('es', 'PE'),
    Locale('es', 'PR'),
    Locale('es', 'PY'),
    Locale('es', 'SV'),
    Locale('es', 'US'),
    Locale('es', 'UY'),
    Locale('es', 'VE'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fil'),
    Locale('fr'),
    Locale('fr', 'CA'),
    Locale('gl'),
    Locale('gsw'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('ky'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('ml'),
    Locale('mn'),
    Locale('mr'),
    Locale('ms'),
    Locale('my'),
    Locale('nb'),
    Locale('ne'),
    Locale('nl'),
    Locale('no'),
    Locale('or'),
    Locale('pa'),
    Locale('pl'),
    Locale('ps'),
    Locale('pt'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW'),
    Locale('zu')
  ];

  /// The full date.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String fullDate(DateTime date);

  /// The year.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String year(DateTime date);

  /// The year and month.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String yearMonth(DateTime date);

  /// The abbreviated month.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String abbreviatedMonth(DateTime date);

  /// The day of the month.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String day(DateTime date);

  /// The short date.
  ///
  /// In en, this message translates to:
  /// **'{date}'**
  String shortDate(DateTime date);

  /// The short date's separator, typically /.
  ///
  /// In en, this message translates to:
  /// **''**
  String get shortDateSeparator;

  /// The short date's suffix, typically empty.
  ///
  /// In en, this message translates to:
  /// **''**
  String get shortDateSuffix;

  /// The hint text for the calendar-only date picker.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get datePickerHint;

  /// Error message displayed to the user when they have entered a text string in an input field of the date picker that is not in a valid date format.
  ///
  /// In en, this message translates to:
  /// **'Invalid date.'**
  String get datePickerInvalidDateError;

  /// The sheet's label.
  ///
  /// In en, this message translates to:
  /// **'Dialog'**
  String get dialogLabel;

  /// No description provided for @sheetLabel.
  ///
  /// In en, this message translates to:
  /// **'Sheet'**
  String get sheetLabel;

  /// The label for the barrier rendered underneath the content of a bottom sheet (used as the 'modalRouteContentName' of the 'barrierOnTapHint' message).
  ///
  /// In en, this message translates to:
  /// **'Barrier'**
  String get barrierLabel;

  /// The onTapHint for the barrier rendered underneath the content of a modal route (especially a sheet) which users can tap to dismiss the content.
  ///
  /// In en, this message translates to:
  /// **'Close {modalRouteContentName}'**
  String barrierOnTapHint(String modalRouteContentName);
}

class _FLocalizationsDelegate extends LocalizationsDelegate<FLocalizations> {
  const _FLocalizationsDelegate();

  @override
  Future<FLocalizations> load(Locale locale) {
    return SynchronousFuture<FLocalizations>(lookupFLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'am',
        'ar',
        'as',
        'az',
        'be',
        'bg',
        'bn',
        'bs',
        'ca',
        'cs',
        'cy',
        'da',
        'de',
        'el',
        'en',
        'es',
        'et',
        'eu',
        'fa',
        'fi',
        'fil',
        'fr',
        'gl',
        'gsw',
        'gu',
        'he',
        'hi',
        'hr',
        'hu',
        'hy',
        'id',
        'is',
        'it',
        'ja',
        'ka',
        'kk',
        'km',
        'kn',
        'ko',
        'ky',
        'lo',
        'lt',
        'lv',
        'mk',
        'ml',
        'mn',
        'mr',
        'ms',
        'my',
        'nb',
        'ne',
        'nl',
        'no',
        'or',
        'pa',
        'pl',
        'ps',
        'pt',
        'ro',
        'ru',
        'si',
        'sk',
        'sl',
        'sq',
        'sr',
        'sv',
        'sw',
        'ta',
        'te',
        'th',
        'tl',
        'tr',
        'uk',
        'ur',
        'uz',
        'vi',
        'zh',
        'zu'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_FLocalizationsDelegate old) => false;
}

FLocalizations lookupFLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'sr':
      {
        switch (locale.scriptCode) {
          case 'Latn':
            return FLocalizationsSrLatn();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'de':
      {
        switch (locale.countryCode) {
          case 'CH':
            return FLocalizationsDeCh();
        }
        break;
      }
    case 'en':
      {
        switch (locale.countryCode) {
          case 'AU':
            return FLocalizationsEnAu();
          case 'CA':
            return FLocalizationsEnCa();
          case 'GB':
            return FLocalizationsEnGb();
          case 'IE':
            return FLocalizationsEnIe();
          case 'IN':
            return FLocalizationsEnIn();
          case 'NZ':
            return FLocalizationsEnNz();
          case 'SG':
            return FLocalizationsEnSg();
          case 'ZA':
            return FLocalizationsEnZa();
        }
        break;
      }
    case 'es':
      {
        switch (locale.countryCode) {
          case '419':
            return FLocalizationsEs419();
          case 'AR':
            return FLocalizationsEsAr();
          case 'BO':
            return FLocalizationsEsBo();
          case 'CL':
            return FLocalizationsEsCl();
          case 'CO':
            return FLocalizationsEsCo();
          case 'CR':
            return FLocalizationsEsCr();
          case 'DO':
            return FLocalizationsEsDo();
          case 'EC':
            return FLocalizationsEsEc();
          case 'GT':
            return FLocalizationsEsGt();
          case 'HN':
            return FLocalizationsEsHn();
          case 'MX':
            return FLocalizationsEsMx();
          case 'NI':
            return FLocalizationsEsNi();
          case 'PA':
            return FLocalizationsEsPa();
          case 'PE':
            return FLocalizationsEsPe();
          case 'PR':
            return FLocalizationsEsPr();
          case 'PY':
            return FLocalizationsEsPy();
          case 'SV':
            return FLocalizationsEsSv();
          case 'US':
            return FLocalizationsEsUs();
          case 'UY':
            return FLocalizationsEsUy();
          case 'VE':
            return FLocalizationsEsVe();
        }
        break;
      }
    case 'fr':
      {
        switch (locale.countryCode) {
          case 'CA':
            return FLocalizationsFrCa();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'PT':
            return FLocalizationsPtPt();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'HK':
            return FLocalizationsZhHk();
          case 'TW':
            return FLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return FLocalizationsAf();
    case 'am':
      return FLocalizationsAm();
    case 'ar':
      return FLocalizationsAr();
    case 'as':
      return FLocalizationsAs();
    case 'az':
      return FLocalizationsAz();
    case 'be':
      return FLocalizationsBe();
    case 'bg':
      return FLocalizationsBg();
    case 'bn':
      return FLocalizationsBn();
    case 'bs':
      return FLocalizationsBs();
    case 'ca':
      return FLocalizationsCa();
    case 'cs':
      return FLocalizationsCs();
    case 'cy':
      return FLocalizationsCy();
    case 'da':
      return FLocalizationsDa();
    case 'de':
      return FLocalizationsDe();
    case 'el':
      return FLocalizationsEl();
    case 'en':
      return FLocalizationsEn();
    case 'es':
      return FLocalizationsEs();
    case 'et':
      return FLocalizationsEt();
    case 'eu':
      return FLocalizationsEu();
    case 'fa':
      return FLocalizationsFa();
    case 'fi':
      return FLocalizationsFi();
    case 'fil':
      return FLocalizationsFil();
    case 'fr':
      return FLocalizationsFr();
    case 'gl':
      return FLocalizationsGl();
    case 'gsw':
      return FLocalizationsGsw();
    case 'gu':
      return FLocalizationsGu();
    case 'he':
      return FLocalizationsHe();
    case 'hi':
      return FLocalizationsHi();
    case 'hr':
      return FLocalizationsHr();
    case 'hu':
      return FLocalizationsHu();
    case 'hy':
      return FLocalizationsHy();
    case 'id':
      return FLocalizationsId();
    case 'is':
      return FLocalizationsIs();
    case 'it':
      return FLocalizationsIt();
    case 'ja':
      return FLocalizationsJa();
    case 'ka':
      return FLocalizationsKa();
    case 'kk':
      return FLocalizationsKk();
    case 'km':
      return FLocalizationsKm();
    case 'kn':
      return FLocalizationsKn();
    case 'ko':
      return FLocalizationsKo();
    case 'ky':
      return FLocalizationsKy();
    case 'lo':
      return FLocalizationsLo();
    case 'lt':
      return FLocalizationsLt();
    case 'lv':
      return FLocalizationsLv();
    case 'mk':
      return FLocalizationsMk();
    case 'ml':
      return FLocalizationsMl();
    case 'mn':
      return FLocalizationsMn();
    case 'mr':
      return FLocalizationsMr();
    case 'ms':
      return FLocalizationsMs();
    case 'my':
      return FLocalizationsMy();
    case 'nb':
      return FLocalizationsNb();
    case 'ne':
      return FLocalizationsNe();
    case 'nl':
      return FLocalizationsNl();
    case 'no':
      return FLocalizationsNo();
    case 'or':
      return FLocalizationsOr();
    case 'pa':
      return FLocalizationsPa();
    case 'pl':
      return FLocalizationsPl();
    case 'ps':
      return FLocalizationsPs();
    case 'pt':
      return FLocalizationsPt();
    case 'ro':
      return FLocalizationsRo();
    case 'ru':
      return FLocalizationsRu();
    case 'si':
      return FLocalizationsSi();
    case 'sk':
      return FLocalizationsSk();
    case 'sl':
      return FLocalizationsSl();
    case 'sq':
      return FLocalizationsSq();
    case 'sr':
      return FLocalizationsSr();
    case 'sv':
      return FLocalizationsSv();
    case 'sw':
      return FLocalizationsSw();
    case 'ta':
      return FLocalizationsTa();
    case 'te':
      return FLocalizationsTe();
    case 'th':
      return FLocalizationsTh();
    case 'tl':
      return FLocalizationsTl();
    case 'tr':
      return FLocalizationsTr();
    case 'uk':
      return FLocalizationsUk();
    case 'ur':
      return FLocalizationsUr();
    case 'uz':
      return FLocalizationsUz();
    case 'vi':
      return FLocalizationsVi();
    case 'zh':
      return FLocalizationsZh();
    case 'zu':
      return FLocalizationsZu();
  }

  throw FlutterError('FLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
