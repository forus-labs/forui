import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class FLocalizationsFr extends FLocalizations {
  FLocalizationsFr([String locale = 'fr']) : super(locale);

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
  String get datePickerHint => 'Sélectionner une date';

  @override
  String get datePickerInvalidDateError => 'Date non valide.';

  @override
  String get dialogLabel => 'Boîte de dialogue';

  @override
  String get sheetLabel => 'sheet';

  @override
  String get barrierLabel => 'Fond';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fermer \$modalRouteContentName';
  }
}

/// The translations for French, as used in Canada (`fr_CA`).
class FLocalizationsFrCa extends FLocalizationsFr {
  FLocalizationsFrCa() : super('fr_CA');

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Sélectionner une date';

  @override
  String get datePickerInvalidDateError => 'Date non valide.';

  @override
  String get dialogLabel => 'Boîte de dialogue';

  @override
  String get sheetLabel => 'Zone de contenu';

  @override
  String get barrierLabel => 'Grille';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fermer \$modalRouteContentName';
  }
}
