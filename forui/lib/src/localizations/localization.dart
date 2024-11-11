import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// Localizations for date and time formatting.
extension FDateTimeLocalizations on FLocalizations {
  /// The first day of the week, in ISO 8601 style, where the first day of the week, i. e. index 1, is Monday.
  int get firstDayOfWeek => localeName == '' ? 7 : DateFormat.yMMMMd(localeName).dateSymbols.FIRSTDAYOFWEEK + 1;

  /// Very short names for days of the week, starting with Sunday, e.g. 'Su'.
  List<String> get narrowWeekDays => (localeName == '' || localeName.startsWith('en'))
      ? const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
      : DateFormat.yMMMMd(localeName).dateSymbols.STANDALONENARROWWEEKDAYS;
}

@internal
class DefaultLocalizations extends FLocalizations {
  DefaultLocalizations() : super('');

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
}
