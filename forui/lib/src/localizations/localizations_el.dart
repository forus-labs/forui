// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class FLocalizationsEl extends FLocalizations {
  FLocalizationsEl([String locale = 'el']) : super(locale);

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
  String get textFieldClearButtonSemanticLabel => 'Εκκαθάριση';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Επιλέξτε ημερομηνία';

  @override
  String get dateFieldInvalidDateError => 'Μη έγκυρη ημερομηνία.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Επιλέξτε μια ώρα';

  @override
  String get timeFieldInvalidDateError => 'Μη έγκυρη ώρα.';

  @override
  String get dialogLabel => 'Παράθυρο διαλόγου';

  @override
  String get sheetSemanticsLabel => 'Φύλλο';

  @override
  String get barrierLabel => 'Επικάλυψη';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Κλείσιμο \$modalRouteContentName';
  }
}
