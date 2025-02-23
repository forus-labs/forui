import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localizations_en.dart';

/// The locales that use non-western digits in their date and time formatting:
/// {@template forui.localizations.fScriptNumerals}
///  * Arabic (العربية)
///  * Assamese (অসমীয়া)
///  * Bengali (বাংলা)
///  * Persian/Farsi (فارسی)
///  * Marathi (मराठी)
///  * Burmese (မြန်မာ)
///  * Nepali (नेपाली)
///  * Pashto (پښتو)
///  * Tamil (தமிழ்)
/// {@endtemplate}
@internal
const scriptNumerals = ['ar', 'as', 'bn', 'fa', 'mr', 'my', 'ne', 'ps', 'ta'];

/// The default localization for when no localization is provided.
typedef FDefaultLocalizations = FLocalizationsEn;

/// Localizations for date and time formatting.
extension FDateTimeLocalizations on FLocalizations {
  /// The first day of the week, in ISO 8601 style, where the first day of the week, i. e. index 1, is Monday.
  int get firstDayOfWeek => localeName == '' ? 7 : DateFormat.yMMMMd(localeName).dateSymbols.FIRSTDAYOFWEEK + 1;

  /// Short names for days of the week, starting with Sunday, e.g. 'Sun'.
  List<String> get shortWeekDays =>
      localeName == ''
          ? const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
          : DateFormat.yMMMMd(localeName).dateSymbols.SHORTWEEKDAYS;

  /// Very short names for days of the week, starting with Sunday, e.g. 'Su'.
  List<String> get narrowWeekDays =>
      (localeName == '' || localeName.startsWith('en'))
          ? const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
          : DateFormat.yMMMMd(localeName).dateSymbols.STANDALONENARROWWEEKDAYS;
}
