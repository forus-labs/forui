// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class FLocalizationsSv extends FLocalizations {
  FLocalizationsSv([String locale = 'sv']) : super(locale);

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
  String get selectHint => 'Välj ett objekt';

  @override
  String get selectSearchHint => 'Sök';

  @override
  String get selectNoResults => 'Inga matchande resultat.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rulla uppåt';

  @override
  String get selectScrollDownSemanticsLabel => 'Rulla nedåt';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Rensa';

  @override
  String get paginationPreviousSemanticsLabel => 'Föregående';

  @override
  String get paginationNextSemanticsLabel => 'Nästa';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Välj datum';

  @override
  String get dateFieldInvalidDateError => 'Ogiltigt datum.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Välj en tid';

  @override
  String get timeFieldInvalidDateError => 'Ogiltig tid.';

  @override
  String get dialogLabel => 'Dialogruta';

  @override
  String get sheetSemanticsLabel => 'Ark';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Stäng \$modalRouteContentName';
  }
}
