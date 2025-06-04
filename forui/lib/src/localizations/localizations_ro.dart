// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class FLocalizationsRo extends FLocalizations {
  FLocalizationsRo([String locale = 'ro']) : super(locale);

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
  String get barrierLabel => 'Material';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Închideți \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Selectați data';

  @override
  String get dateFieldInvalidDateError => 'Dată nevalidă.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get paginationPreviousSemanticsLabel => 'Anterior';

  @override
  String get paginationNextSemanticsLabel => 'Înainte';

  @override
  String get popoverSemanticsLabel => 'Fereastră contextuală';

  @override
  String get selectHint => 'Selectați un element';

  @override
  String get selectSearchHint => 'Căutare';

  @override
  String get selectNoResults => 'Niciun rezultat care să se potrivească.';

  @override
  String get selectScrollUpSemanticsLabel => 'Derulează în sus';

  @override
  String get selectScrollDownSemanticsLabel => 'Derulează în jos';

  @override
  String get sheetSemanticsLabel => 'Foaie';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Ștergeți';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Alegeți o oră';

  @override
  String get timeFieldInvalidDateError => 'Oră invalidă.';

  @override
  String get dialogLabel => 'Casetă de dialog';
}
