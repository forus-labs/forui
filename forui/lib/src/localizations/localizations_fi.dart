// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class FLocalizationsFi extends FLocalizations {
  FLocalizationsFi([String locale = 'fi']) : super(locale);

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
  String get barrierLabel => 'Sermi';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Sulje \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Valitse päivämäärä';

  @override
  String get dateFieldInvalidDateError => 'Virheellinen päivämäärä.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Valintaikkuna';

  @override
  String get paginationPreviousSemanticsLabel => 'Edellinen';

  @override
  String get paginationNextSemanticsLabel => 'Seuraava';

  @override
  String get popoverSemanticsLabel => 'Ponnahdusikkuna';

  @override
  String get multiSelectHint => 'Valitse kohteet';

  @override
  String get selectHint => 'Valitse kohde';

  @override
  String get selectSearchHint => 'Haku';

  @override
  String get selectNoResults => 'Ei vastaavia tuloksia.';

  @override
  String get selectScrollUpSemanticsLabel => 'Vieritä ylös';

  @override
  String get selectScrollDownSemanticsLabel => 'Vieritä alas';

  @override
  String get sheetSemanticsLabel => 'arkki';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Tyhjennä';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Valitse aika';

  @override
  String get timeFieldInvalidDateError => 'Virheellinen aika.';
}
