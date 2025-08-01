// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class FLocalizationsPl extends FLocalizations {
  FLocalizationsPl([String locale = 'pl']) : super(locale);

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
  String get barrierLabel => 'Siatka';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zamknij: \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nie znaleziono dopasowań.';

  @override
  String get dateFieldHint => 'Wybierz datę';

  @override
  String get dateFieldInvalidDateError => 'Nieprawidłowa data.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Okno dialogowe';

  @override
  String get paginationPreviousSemanticsLabel => 'Poprzedni';

  @override
  String get paginationNextSemanticsLabel => 'Dalej';

  @override
  String get popoverSemanticsLabel => 'Okno wyskakujące';

  @override
  String get multiSelectHint => 'Wybierz elementy';

  @override
  String get selectHint => 'Wybierz element';

  @override
  String get selectSearchHint => 'Szukaj';

  @override
  String get selectNoResults => 'Brak pasujących wyników.';

  @override
  String get selectScrollUpSemanticsLabel => 'Przewiń w górę';

  @override
  String get selectScrollDownSemanticsLabel => 'Przewiń w dół';

  @override
  String get sheetSemanticsLabel => 'Plansza';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Wyczyść';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wybierz godzinę';

  @override
  String get timeFieldInvalidDateError => 'Nieprawidłowa godzina.';
}
