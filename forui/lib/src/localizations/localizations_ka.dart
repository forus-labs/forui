// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class FLocalizationsKa extends FLocalizations {
  FLocalizationsKa([String locale = 'ka']) : super(locale);

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
  String get selectHint => 'აირჩიეთ ელემენტი';

  @override
  String get selectSearchHint => 'ძიება';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ზემოთ გადაადგილება';

  @override
  String get selectScrollDownSemanticsLabel => 'ქვემოთ გადაადგილება';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'აირჩიეთ თარიღი';

  @override
  String get dateFieldInvalidDateError => 'არასწორი თარიღი.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'აირჩიეთ დრო';

  @override
  String get timeFieldInvalidDateError => 'არასწორი დრო.';

  @override
  String get dialogLabel => 'დიალოგი';

  @override
  String get sheetSemanticsLabel => 'ფურცელი';

  @override
  String get barrierLabel => 'სკრიმი';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName-ის დახურვა';
  }
}
