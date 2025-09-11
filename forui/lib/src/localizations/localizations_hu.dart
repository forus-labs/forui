// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class FLocalizationsHu extends FLocalizations {
  FLocalizationsHu([String locale = 'hu']) : super(locale);

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
  String get barrierLabel => 'Borítás';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName bezárása';
  }

  @override
  String get autocompleteNoResults => 'Nincs találat.';

  @override
  String get dateFieldHint => 'Válasszon dátumot';

  @override
  String get dateFieldInvalidDateError => 'Érvénytelen dátum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dialogSemanticsLabel => 'Párbeszédablak';

  @override
  String get paginationPreviousSemanticsLabel => 'Előző';

  @override
  String get paginationNextSemanticsLabel => 'Következő';

  @override
  String get popoverSemanticsLabel => 'Felugró ablak';

  @override
  String get progressSemanticsLabel => 'Betöltés';

  @override
  String get multiSelectHint => 'Elemek kiválasztása';

  @override
  String get selectHint => 'Válasszon egy elemet';

  @override
  String get selectSearchHint => 'Keresés';

  @override
  String get selectNoResults => 'Nincs megfelelő találat.';

  @override
  String get selectScrollUpSemanticsLabel => 'Görgetés felfelé';

  @override
  String get selectScrollDownSemanticsLabel => 'Görgetés lefelé';

  @override
  String get sheetSemanticsLabel => 'lap';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Törlés';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Jelszó elrejtése';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Jelszó megjelenítése';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Válasszon időpontot';

  @override
  String get timeFieldInvalidDateError => 'Érvénytelen idő.';
}
