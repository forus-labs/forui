// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class FLocalizationsDa extends FLocalizations {
  FLocalizationsDa([String locale = 'da']) : super(locale);

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
  String get selectHint => 'Vælg et element';

  @override
  String get selectSearchHint => 'Søg';

  @override
  String get selectNoResults => 'Ingen matchende resultater.';

  @override
  String get selectScrollUpSemanticsLabel => 'Rul op';

  @override
  String get selectScrollDownSemanticsLabel => 'Rul ned';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Ryd';

  @override
  String get paginationPreviousSemanticsLabel => 'Forrige';

  @override
  String get paginationNextSemanticsLabel => 'Næste';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Vælg en dato';

  @override
  String get dateFieldInvalidDateError => 'Ugyldig dato.';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vælg et tidspunkt';

  @override
  String get timeFieldInvalidDateError => 'Ugyldigt tidspunkt.';

  @override
  String get dialogLabel => 'Dialogboks';

  @override
  String get sheetSemanticsLabel => 'Felt';

  @override
  String get barrierLabel => 'Dæmpeskærm';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Luk \$modalRouteContentName';
  }
}
