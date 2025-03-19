// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class FLocalizationsCa extends FLocalizations {
  FLocalizationsCa([String locale = 'ca']) : super(locale);

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
  String get selectHint => 'Selecciona un element';

  @override
  String get selectSearchHint => 'Cerca';

  @override
  String get selectNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Esborrar';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Selecciona una data';

  @override
  String get dateFieldInvalidDateError => 'Data no vàlida.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Trieu una hora';

  @override
  String get timeFieldInvalidDateError => 'Hora no vàlida.';

  @override
  String get dialogLabel => 'Diàleg';

  @override
  String get sheetSemanticsLabel => 'Full';

  @override
  String get barrierLabel => 'Fons atenuat';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Tanca \$modalRouteContentName';
  }
}
