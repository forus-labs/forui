import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class FLocalizationsDe extends FLocalizations {
  FLocalizationsDe([String locale = 'de']) : super(locale);

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
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Datum auswählen';

  @override
  String get datePickerInvalidDateError => 'Ungültiges Datum.';

  @override
  String get dialogLabel => 'Dialogfeld';

  @override
  String get sheetLabel => 'Ansicht';

  @override
  String get barrierLabel => 'Gitter';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName schließen';
  }
}

/// The translations for German, as used in Switzerland (`de_CH`).
class FLocalizationsDeCh extends FLocalizationsDe {
  FLocalizationsDeCh() : super('de_CH');

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Datum auswählen';

  @override
  String get datePickerInvalidDateError => 'Ungültiges Datum.';

  @override
  String get dialogLabel => 'Dialogfeld';
}
