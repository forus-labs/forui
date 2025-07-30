// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swiss German Alemannic Alsatian (`gsw`).
class FLocalizationsGsw extends FLocalizations {
  FLocalizationsGsw([String locale = 'gsw']) : super(locale);

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
  String get autocompleteNoResults => 'Kei Überiistimmige gfunde';

  @override
  String get dateFieldHint => 'Datum uswähle';

  @override
  String get dateFieldInvalidDateError => 'Ungültigs Datum.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialogfeld';

  @override
  String get paginationPreviousSemanticsLabel => 'Vorig';

  @override
  String get paginationNextSemanticsLabel => 'Witer';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get multiSelectHint => 'Elemente uswähle';

  @override
  String get selectHint => 'Wähle e Element';

  @override
  String get selectSearchHint => 'Sueche';

  @override
  String get selectNoResults => 'Kei passendi Ergebnis.';

  @override
  String get selectScrollUpSemanticsLabel => 'Nach obe scrolle';

  @override
  String get selectScrollDownSemanticsLabel => 'Nach unde scrolle';

  @override
  String get sheetSemanticsLabel => 'Ansicht';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Lösche';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Wähle e Zyt';

  @override
  String get timeFieldInvalidDateError => 'Ungültigi Zyt.';
}
