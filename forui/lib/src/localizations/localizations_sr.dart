import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class FLocalizationsSr extends FLocalizations {
  FLocalizationsSr([String locale = 'sr']) : super(locale);

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
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get datePickerHint => 'Изаберите датум';

  @override
  String get datePickerInvalidDateError => 'Неважећи датум.';

  @override
  String get dialogLabel => 'Дијалог';

  @override
  String get sheetLabel => 'табела';

  @override
  String get barrierLabel => 'Скрим';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Затвори: \$modalRouteContentName';
  }
}

/// The translations for Serbian, using the Latin script (`sr_Latn`).
class FLocalizationsSrLatn extends FLocalizationsSr {
  FLocalizationsSrLatn() : super('sr_Latn');

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get datePickerHint => 'Izaberite datum';

  @override
  String get datePickerInvalidDateError => 'Nevažeći datum.';

  @override
  String get dialogLabel => 'Dijalog';

  @override
  String get sheetLabel => 'tabela';

  @override
  String get barrierLabel => 'Skrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zatvori: \$modalRouteContentName';
  }
}
