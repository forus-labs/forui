// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class FLocalizationsBg extends FLocalizations {
  FLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String fullDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String year(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.y(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String yearMonth(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMM(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String abbreviatedMonth(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMM(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String day(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.d(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String shortDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String get selectHint => 'Изберете елемент';

  @override
  String get selectSearchHint => 'Търсене';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Превъртане нагоре';

  @override
  String get selectScrollDownSemanticsLabel => 'Превъртане надолу';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => ' г.';

  @override
  String get dateFieldHint => 'Изберете дата';

  @override
  String get dateFieldInvalidDateError => 'Невалидна дата.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => ' ч.';

  @override
  String get timeFieldHint => 'Изберете време';

  @override
  String get timeFieldInvalidDateError => 'Невалидно време.';

  @override
  String get dialogLabel => 'Диалогов прозорец';

  @override
  String get sheetSemanticsLabel => 'лист';

  @override
  String get barrierLabel => 'Скрим';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Затваряне на \$modalRouteContentName';
  }
}
