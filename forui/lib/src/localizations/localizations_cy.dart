// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Welsh (`cy`).
class FLocalizationsCy extends FLocalizations {
  FLocalizationsCy([String locale = 'cy']) : super(locale);

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
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Cau \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Dim cydweddiadau wedi\'u canfod.';

  @override
  String get dateFieldHint => 'Dewiswch ddyddiad';

  @override
  String get dateFieldInvalidDateError => 'Dyddiad annilys.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Deialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Blaenorol';

  @override
  String get paginationNextSemanticsLabel => 'Nesaf';

  @override
  String get popoverSemanticsLabel => 'Ffenestr naid';

  @override
  String get progressSemanticsLabel => 'Yn llwytho';

  @override
  String get multiSelectHint => 'Dewis eitemau';

  @override
  String get selectHint => 'Dewiswch eitem';

  @override
  String get selectSearchHint => 'Chwilio';

  @override
  String get selectNoResults => 'Dim canlyniadau cyfatebol.';

  @override
  String get selectScrollUpSemanticsLabel => 'Sgrolio i fyny';

  @override
  String get selectScrollDownSemanticsLabel => 'Sgrolio i lawr';

  @override
  String get sheetSemanticsLabel => 'Taflen';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clirio';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Dewiswch amser';

  @override
  String get timeFieldInvalidDateError => 'Amser annilys.';
}
