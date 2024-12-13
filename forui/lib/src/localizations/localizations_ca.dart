import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class FLocalizationsCa extends FLocalizations {
  FLocalizationsCa([String locale = 'ca']) : super(locale);

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
  String get dialogLabel => 'Diàleg';

  @override
  String get sheetLabel => 'Full';

  @override
  String get barrierLabel => 'Fons atenuat';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Tanca \$modalRouteContentName';
  }
}
