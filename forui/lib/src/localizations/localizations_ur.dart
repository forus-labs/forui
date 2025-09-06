// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class FLocalizationsUr extends FLocalizations {
  FLocalizationsUr([String locale = 'ur']) : super(locale);

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
  String get barrierLabel => 'اسکریم';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName بند کریں';
  }

  @override
  String get autocompleteNoResults => 'کوئی میچ نہیں ملا.';

  @override
  String get dateFieldHint => 'تاریخ منتخب کریں';

  @override
  String get dateFieldInvalidDateError => 'غلط تاریخ۔';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'ڈائلاگ';

  @override
  String get paginationPreviousSemanticsLabel => 'پچھلا';

  @override
  String get paginationNextSemanticsLabel => 'اگلا';

  @override
  String get popoverSemanticsLabel => 'پاپ اوور';

  @override
  String get progressSemanticsLabel => 'لوڈ ہو رہا ہے';

  @override
  String get multiSelectHint => 'آئٹمز منتخب کریں';

  @override
  String get selectHint => 'آئٹم منتخب کریں';

  @override
  String get selectSearchHint => 'تلاش کریں';

  @override
  String get selectNoResults => 'کوئی مماثل نتائج نہیں۔';

  @override
  String get selectScrollUpSemanticsLabel => 'اوپر سکرول کریں';

  @override
  String get selectScrollDownSemanticsLabel => 'نیچے سکرول کریں';

  @override
  String get sheetSemanticsLabel => 'شیٹ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'صاف کریں';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'وقت منتخب کریں';

  @override
  String get timeFieldInvalidDateError => 'غلط وقت۔';
}
