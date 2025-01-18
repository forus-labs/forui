import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class FLocalizationsOr extends FLocalizations {
  FLocalizationsOr([String locale = 'or']) : super(locale);

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
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'ତାରିଖ ଚୟନ କରନ୍ତୁ';

  @override
  String get datePickerInvalidDateError => 'ଅବୈଧ ତାରିଖ।';

  @override
  String get dialogLabel => 'ଡାୟଲଗ୍';

  @override
  String get sheetLabel => 'ସିଟ';

  @override
  String get barrierLabel => 'ସ୍କ୍ରିମ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentNameକୁ ବନ୍ଦ କରନ୍ତୁ';
  }
}
