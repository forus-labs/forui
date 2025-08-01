// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class FLocalizationsCs extends FLocalizations {
  FLocalizationsCs([String locale = 'cs']) : super(locale);

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
    return 'Zavřít \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nebyly nalezeny žádné shody.';

  @override
  String get dateFieldHint => 'Vyberte datum';

  @override
  String get dateFieldInvalidDateError => 'Neplatné datum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialogové okno';

  @override
  String get paginationPreviousSemanticsLabel => 'Předchozí';

  @override
  String get paginationNextSemanticsLabel => 'Další';

  @override
  String get popoverSemanticsLabel => 'Vyskakovací okno';

  @override
  String get multiSelectHint => 'Vyberte položky';

  @override
  String get selectHint => 'Vyberte položku';

  @override
  String get selectSearchHint => 'Hledat';

  @override
  String get selectNoResults => 'Žádné odpovídající výsledky.';

  @override
  String get selectScrollUpSemanticsLabel => 'Posunout nahoru';

  @override
  String get selectScrollDownSemanticsLabel => 'Posunout dolů';

  @override
  String get sheetSemanticsLabel => 'tabulka';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Vymazat';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vyberte čas';

  @override
  String get timeFieldInvalidDateError => 'Neplatný čas.';
}
