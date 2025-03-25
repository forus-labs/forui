// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class FLocalizationsFil extends FLocalizations {
  FLocalizationsFil([String locale = 'fil']) : super(locale);

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
  String get selectHint => 'Pumili ng item';

  @override
  String get selectSearchHint => 'Maghanap';

  @override
  String get selectNoResults => 'Walang mga tumutugmang resulta.';

  @override
  String get selectScrollUpSemanticsLabel => 'Mag-scroll pataas';

  @override
  String get selectScrollDownSemanticsLabel => 'Mag-scroll pababa';

  @override
  String get textFieldClearButtonSemanticsLabel => 'I-clear';

  @override
  String get paginationPreviousSemanticsLabel => 'Nakaraan';

  @override
  String get paginationNextSemanticsLabel => 'Susunod';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pumili ng petsa';

  @override
  String get dateFieldInvalidDateError => 'Hindi wastong petsa.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pumili ng oras';

  @override
  String get timeFieldInvalidDateError => 'Hindi wastong oras.';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Isara ang \$modalRouteContentName';
  }
}
