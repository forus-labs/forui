// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class FLocalizationsLt extends FLocalizations {
  FLocalizationsLt([String locale = 'lt']) : super(locale);

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
  String get selectHint => 'Pasirinkite elementą';

  @override
  String get selectSearchHint => 'Ieškoti';

  @override
  String get selectNoResults => 'Jokių atitinkančių rezultatų.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Išvalyti';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pasirinkti datą';

  @override
  String get dateFieldInvalidDateError => 'Netinkama data.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pasirinkite laiką';

  @override
  String get timeFieldInvalidDateError => 'Neteisingas laikas.';

  @override
  String get dialogLabel => 'Dialogo langas';

  @override
  String get sheetSemanticsLabel => 'lapas';

  @override
  String get barrierLabel => 'Užsklanda';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Uždaryti „\$modalRouteContentName“';
  }
}
