// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class FLocalizationsSq extends FLocalizations {
  FLocalizationsSq([String locale = 'sq']) : super(locale);

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
  String get barrierLabel => 'Kanavacë';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Mbyll \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Zgjidh datën';

  @override
  String get dateFieldInvalidDateError => 'Datë e pavlefshme.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialogu';

  @override
  String get paginationPreviousSemanticsLabel => 'E mëparshme';

  @override
  String get paginationNextSemanticsLabel => 'Tjetër';

  @override
  String get popoverSemanticsLabel => 'Dritare kërcyese';

  @override
  String get multiSelectHint => 'Zgjidh elementet';

  @override
  String get selectHint => 'Zgjidhni një artikull';

  @override
  String get selectSearchHint => 'Kërko';

  @override
  String get selectNoResults => 'Nuk ka rezultate përputhëse.';

  @override
  String get selectScrollUpSemanticsLabel => 'Lëviz lart';

  @override
  String get selectScrollDownSemanticsLabel => 'Lëviz poshtë';

  @override
  String get sheetSemanticsLabel => 'Fleta';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Pastro';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Zgjidh një orë';

  @override
  String get timeFieldInvalidDateError => 'Orë e pavlefshme.';
}
