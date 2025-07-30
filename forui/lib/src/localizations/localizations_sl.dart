// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class FLocalizationsSl extends FLocalizations {
  FLocalizationsSl([String locale = 'sl']) : super(locale);

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
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zapiranje »\$modalRouteContentName«';
  }

  @override
  String get autocompleteNoResults => 'Ni ujemanj';

  @override
  String get dateFieldHint => 'Izberite datum';

  @override
  String get dateFieldInvalidDateError => 'Neveljaven datum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Pogovorno okno';

  @override
  String get paginationPreviousSemanticsLabel => 'Prejšnji';

  @override
  String get paginationNextSemanticsLabel => 'Naprej';

  @override
  String get popoverSemanticsLabel => 'Pojavno okno';

  @override
  String get multiSelectHint => 'Izberi elemente';

  @override
  String get selectHint => 'Izberite element';

  @override
  String get selectSearchHint => 'Iskanje';

  @override
  String get selectNoResults => 'Ni ujemajočih se rezultatov.';

  @override
  String get selectScrollUpSemanticsLabel => 'Pomik navzgor';

  @override
  String get selectScrollDownSemanticsLabel => 'Pomik navzdol';

  @override
  String get sheetSemanticsLabel => 'Razdelek';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Počisti';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Izberite čas';

  @override
  String get timeFieldInvalidDateError => 'Neveljaven čas.';
}
