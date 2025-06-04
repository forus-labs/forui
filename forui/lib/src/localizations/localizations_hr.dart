// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class FLocalizationsHr extends FLocalizations {
  FLocalizationsHr([String locale = 'hr']) : super(locale);

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
  String get barrierLabel => 'Rubno';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zatvori \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Odaberite datum';

  @override
  String get dateFieldInvalidDateError => 'Nevažeći datum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dialogSemanticsLabel => 'Dijalog';

  @override
  String get paginationPreviousSemanticsLabel => 'Prethodno';

  @override
  String get paginationNextSemanticsLabel => 'Sljedeće';

  @override
  String get popoverSemanticsLabel => 'Skočni prozor';

  @override
  String get selectHint => 'Odaberite stavku';

  @override
  String get selectSearchHint => 'Pretraži';

  @override
  String get selectNoResults => 'Nema podudarajućih rezultata.';

  @override
  String get selectScrollUpSemanticsLabel => 'Pomakni prema gore';

  @override
  String get selectScrollDownSemanticsLabel => 'Pomakni prema dolje';

  @override
  String get sheetSemanticsLabel => 'tablica';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Očisti';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Odaberite vrijeme';

  @override
  String get timeFieldInvalidDateError => 'Nevažeće vrijeme.';
}
