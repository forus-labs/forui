import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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

/// The default localization for when no localization is provided.
class FDefaultLocalizations extends FLocalizations {
  static final _localizations = FDefaultLocalizations._();

  /// Creates a [FDefaultLocalizations].
  factory FDefaultLocalizations() => _localizations;

  FDefaultLocalizations._() : super('en_US');

  @override
  String fullDate(DateTime date) => DateFormat.yMMMMd().format(date);

  @override
  String year(DateTime date) => DateFormat.y().format(date);

  @override
  String yearMonth(DateTime date) => DateFormat.yMMMM().format(date);

  @override
  String abbreviatedMonth(DateTime date) => DateFormat.MMM().format(date);

  @override
  String day(DateTime date) => DateFormat.d().format(date);

  @override
  String shortDate(DateTime date) => DateFormat.yMd().format(date);

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get sheetLabel => 'Sheet';

  @override
  String get barrierLabel => 'Barrier';

  @override
  String barrierOnTapHint(String modalRouteContentName) => 'Close $modalRouteContentName';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';
}

