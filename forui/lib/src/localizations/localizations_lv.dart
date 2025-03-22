// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class FLocalizationsLv extends FLocalizations {
  FLocalizationsLv([String locale = 'lv']) : super(locale);

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
  String get selectHint => 'Atlasiet vienumu';

  @override
  String get selectSearchHint => 'Meklēt';

  @override
  String get selectNoResults => 'Nav atbilstošu rezultātu.';

  @override
  String get selectScrollUpSemanticsLabel => 'Ritināt uz augšu';

  @override
  String get selectScrollDownSemanticsLabel => 'Ritināt uz leju';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Notīrīt';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dateFieldHint => 'Atlasīt datumu';

  @override
  String get dateFieldInvalidDateError => 'Nederīgs datums.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Izvēlieties laiku';

  @override
  String get timeFieldInvalidDateError => 'Nederīgs laiks.';

  @override
  String get dialogLabel => 'Dialoglodziņš';

  @override
  String get sheetSemanticsLabel => 'lapa';

  @override
  String get barrierLabel => 'Pārklājums';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Aizvērt \$modalRouteContentName';
  }
}
