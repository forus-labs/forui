// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Macedonian (`mk`).
class FLocalizationsMk extends FLocalizations {
  FLocalizationsMk([String locale = 'mk']) : super(locale);

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
  String get barrierLabel => 'Скрим';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Затворете ја \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Не се пронајдени совпаѓања.';

  @override
  String get dateFieldHint => 'Изберете датум';

  @override
  String get dateFieldInvalidDateError => 'Неважечки датум.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Дијалог';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Скокачки прозорец';

  @override
  String get progressSemanticsLabel => 'Се вчитува';

  @override
  String get multiSelectHint => 'Изберете елементи';

  @override
  String get selectHint => 'Изберете ставка';

  @override
  String get selectSearchHint => 'Пребарување';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Лизгај нагоре';

  @override
  String get selectScrollDownSemanticsLabel => 'Лизгај надолу';

  @override
  String get sheetSemanticsLabel => 'лист';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Изберете време';

  @override
  String get timeFieldInvalidDateError => 'Невалидно време.';
}
