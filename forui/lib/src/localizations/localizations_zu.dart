// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Zulu (`zu`).
class FLocalizationsZu extends FLocalizations {
  FLocalizationsZu([String locale = 'zu']) : super(locale);

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
  String get selectHint => 'Khetha into';

  @override
  String get selectSearchHint => 'Sesha';

  @override
  String get selectNoResults => 'Ayikho imiphumela efanayo.';

  @override
  String get selectScrollUpSemanticsLabel => 'Skrola phezulu';

  @override
  String get selectScrollDownSemanticsLabel => 'Skrola phansi';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Sula';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Khetha usuku';

  @override
  String get dateFieldInvalidDateError => 'Usuku olungalungile.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Khetha isikhathi';

  @override
  String get timeFieldInvalidDateError => 'Isikhathi esingalungile.';

  @override
  String get dialogLabel => 'Ingxoxo';

  @override
  String get sheetSemanticsLabel => 'Ishidi';

  @override
  String get barrierLabel => 'I-Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Vala i-\$modalRouteContentName';
  }
}
