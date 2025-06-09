// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class FLocalizationsAr extends FLocalizations {
  FLocalizationsAr([String locale = 'ar']) : super(locale);

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
  String get barrierLabel => 'تمويه';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'إغلاق \"\$modalRouteContentName\"';
  }

  @override
  String get dateFieldHint => 'اختر تاريخًا';

  @override
  String get dateFieldInvalidDateError => 'تاريخ غير صالح.';

  @override
  String get shortDateSeparator => '‏/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'مربع حوار';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'منبثقة';

  @override
  String get selectHint => 'حدد عنصرا';

  @override
  String get selectSearchHint => 'بحث';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'التمرير لأعلى';

  @override
  String get selectScrollDownSemanticsLabel => 'التمرير لأسفل';

  @override
  String get sheetSemanticsLabel => 'بطاق ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'اختر وقتًا';

  @override
  String get timeFieldInvalidDateError => 'وقت غير صالح.';
}
