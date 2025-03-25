// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class FLocalizationsFa extends FLocalizations {
  FLocalizationsFa([String locale = 'fa']) : super(locale);

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
  String get selectHint => 'یک مورد را انتخاب کنید';

  @override
  String get selectSearchHint => 'جستجو';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'پیمایش به بالا';

  @override
  String get selectScrollDownSemanticsLabel => 'پیمایش به پایین';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'انتخاب تاریخ';

  @override
  String get dateFieldInvalidDateError => 'تاریخ نامعتبر.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'یک زمان انتخاب کنید';

  @override
  String get timeFieldInvalidDateError => 'زمان نامعتبر است.';

  @override
  String get dialogLabel => 'کادر گفتگو';

  @override
  String get sheetSemanticsLabel => 'برگ';

  @override
  String get barrierLabel => 'رویه';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'بستن \$modalRouteContentName';
  }
}
