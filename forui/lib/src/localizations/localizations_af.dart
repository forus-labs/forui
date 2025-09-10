// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class FLocalizationsAf extends FLocalizations {
  FLocalizationsAf([String locale = 'af']) : super(locale);

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
  String get barrierLabel => 'Skerm';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Maak \$modalRouteContentName toe';
  }

  @override
  String get autocompleteNoResults => 'Geen resultate gevind nie.';

  @override
  String get dateFieldHint => 'Kies \'n datum';

  @override
  String get dateFieldInvalidDateError => 'Ongeldige datum.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialoog';

  @override
  String get paginationPreviousSemanticsLabel => 'Vorige';

  @override
  String get paginationNextSemanticsLabel => 'Volgende';

  @override
  String get popoverSemanticsLabel => 'Opspringer';

  @override
  String get progressSemanticsLabel => 'Besig om te laai';

  @override
  String get multiSelectHint => 'Kies items';

  @override
  String get selectHint => 'Kies \'n item';

  @override
  String get selectSearchHint => 'Soek';

  @override
  String get selectNoResults => 'Geen passende resultate nie.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rol op';

  @override
  String get selectScrollDownSemanticsLabel => 'Rol af';

  @override
  String get sheetSemanticsLabel => 'blad';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Vee uit';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Kies \'n tyd';

  @override
  String get timeFieldInvalidDateError => 'Ongeldige tyd.';
}
