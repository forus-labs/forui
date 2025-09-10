// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class FLocalizationsHe extends FLocalizations {
  FLocalizationsHe([String locale = 'he']) : super(locale);

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
  String get barrierLabel => 'מיסוך';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'סגירת \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'לא נמצאו התאמות.';

  @override
  String get dateFieldHint => 'בחירת תאריך';

  @override
  String get dateFieldInvalidDateError => 'תאריך לא חוקי.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'תיבת דו-שיח';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'חלון קופץ';

  @override
  String get progressSemanticsLabel => 'טוען';

  @override
  String get multiSelectHint => 'בחר פריטים';

  @override
  String get selectHint => 'בחר פריט';

  @override
  String get selectSearchHint => 'חיפוש';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'גלול למעלה';

  @override
  String get selectScrollDownSemanticsLabel => 'גלול למטה';

  @override
  String get sheetSemanticsLabel => 'גיליו ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'בחר שעה';

  @override
  String get timeFieldInvalidDateError => 'שעה לא חוקית.';
}
