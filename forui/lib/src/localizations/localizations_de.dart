// dart format off
// coverage:ignore-file


// ignore: unused_import
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
  String get barrierLabel => 'Gitter';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName schließen';
  }

  @override
  String get autocompleteNoResults => 'Keine Übereinstimmungen gefunden.';

  @override
  String get dateFieldHint => 'Datum auswählen';

  @override
  String get dateFieldInvalidDateError => 'Ungültiges Datum.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialogfeld';

  @override
  String get paginationPreviousSemanticsLabel => 'Zurück';

  @override
  String get paginationNextSemanticsLabel => 'Weiter';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get multiSelectHint => 'Elemente auswählen';

  @override
  String get selectHint => 'Wählen Sie ein Element';

  @override
  String get selectSearchHint => 'Suchen';

  @override
  String get selectNoResults => 'Keine übereinstimmenden Ergebnisse.';

  @override
  String get selectScrollUpSemanticsLabel => 'Nach oben scrollen';

  @override
  String get selectScrollDownSemanticsLabel => 'Nach unten scrollen';

  @override
  String get sheetSemanticsLabel => 'Ansicht';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Löschen';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wähle eine Uhrzeit';

  @override
  String get timeFieldInvalidDateError => 'Ungültige Uhrzeit.';
}

/// The translations for German, as used in Switzerland (`de_CH`).
class FLocalizationsDeCh extends FLocalizationsDe {
  FLocalizationsDeCh(): super('de_CH');

  @override
  String get autocompleteNoResults => 'Keine Übereinstimmungen gefunden.';

  @override
  String get dateFieldHint => 'Datum auswählen';

  @override
  String get dateFieldInvalidDateError => 'Ungültiges Datum.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialogfeld';

  @override
  String get paginationPreviousSemanticsLabel => 'Zurück';

  @override
  String get paginationNextSemanticsLabel => 'Weiter';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get multiSelectHint => 'Elemente auswählen';

  @override
  String get selectHint => 'Wählen Sie ein Element';

  @override
  String get selectSearchHint => 'Suchen';

  @override
  String get selectNoResults => 'Keine übereinstimmenden Ergebnisse.';

  @override
  String get selectScrollUpSemanticsLabel => 'Nach oben scrollen';

  @override
  String get selectScrollDownSemanticsLabel => 'Nach unten scrollen';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Löschen';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wählen Sie eine Zeit';

  @override
  String get timeFieldInvalidDateError => 'Ungültige Zeit.';
}
