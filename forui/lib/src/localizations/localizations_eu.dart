// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class FLocalizationsEu extends FLocalizations {
  FLocalizationsEu([String locale = 'eu']) : super(locale);

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
  String get barrierLabel => 'Barrera';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Itxi \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Ez da bat-etortzerik aurkitu';

  @override
  String get dateFieldHint => 'Hautatu data';

  @override
  String get dateFieldInvalidDateError => 'Data baliogabea.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Leihoa';

  @override
  String get paginationPreviousSemanticsLabel => 'Aurrekoa';

  @override
  String get paginationNextSemanticsLabel => 'Hurrengoa';

  @override
  String get popoverSemanticsLabel => 'Leiho emergentea';

  @override
  String get multiSelectHint => 'Hautatu elementuak';

  @override
  String get selectHint => 'Hautatu elementu bat';

  @override
  String get selectSearchHint => 'Bilatu';

  @override
  String get selectNoResults => 'Ez dago bat datorren emaitzarik.';

  @override
  String get selectScrollUpSemanticsLabel => 'Egin gora';

  @override
  String get selectScrollDownSemanticsLabel => 'Egin behera';

  @override
  String get sheetSemanticsLabel => 'orria';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Garbitu';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Aukeratu ordua';

  @override
  String get timeFieldInvalidDateError => 'Ordu baliogabea.';
}
