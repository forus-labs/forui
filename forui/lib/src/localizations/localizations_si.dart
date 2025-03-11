// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class FLocalizationsSi extends FLocalizations {
  FLocalizationsSi([String locale = 'si']) : super(locale);

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
  String get selectHint => 'අයිතමයක් තෝරන්න';

  @override
  String get selectSearchHint => 'සොයන්න';

  @override
  String get textFieldClearButtonSemanticLabel => 'හිස් කරන්න';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'දිනය තෝරන්න';

  @override
  String get dateFieldInvalidDateError => 'අවලංගු දිනයකි.';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'වේලාවක් තෝරන්න';

  @override
  String get timeFieldInvalidDateError => 'අවලංගු වේලාවකි.';

  @override
  String get dialogLabel => 'සංවාදය';

  @override
  String get sheetSemanticsLabel => 'පත්‍රය';

  @override
  String get barrierLabel => 'ස්ක්‍රිම්';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName වසන්න';
  }
}
