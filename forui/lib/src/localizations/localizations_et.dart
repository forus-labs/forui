// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class FLocalizationsEt extends FLocalizations {
  FLocalizationsEt([String locale = 'et']) : super(locale);

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
  String get selectHint => 'Valige üksus';

  @override
  String get selectSearchHint => 'Otsi';

  @override
  String get selectNoResults => 'Sobivaid tulemusi pole.';

  @override
  String get selectScrollUpSemanticsLabel => 'Keri üles';

  @override
  String get selectScrollDownSemanticsLabel => 'Keri alla';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Kustuta';

  @override
  String get paginationPreviousSemanticsLabel => 'Eelmine';

  @override
  String get paginationNextSemanticsLabel => 'Järgmine';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Valige kuupäev';

  @override
  String get dateFieldInvalidDateError => 'Sobimatu kuupäev.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vali aeg';

  @override
  String get timeFieldInvalidDateError => 'Vigane aeg.';

  @override
  String get dialogLabel => 'Dialoog';

  @override
  String get sheetSemanticsLabel => 'leht';

  @override
  String get barrierLabel => 'Sirm';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Sule \$modalRouteContentName';
  }
}
