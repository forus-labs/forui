// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class FLocalizationsSw extends FLocalizations {
  FLocalizationsSw([String locale = 'sw']) : super(locale);

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
    return 'Funga \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Hakuna mechi zilizopatikana.';

  @override
  String get dateFieldHint => 'Chagua tarehe';

  @override
  String get dateFieldInvalidDateError => 'Tarehe si sahihi.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Kidirisha';

  @override
  String get paginationPreviousSemanticsLabel => 'Iliyotangulia';

  @override
  String get paginationNextSemanticsLabel => 'Inayofuata';

  @override
  String get popoverSemanticsLabel => 'Dirisha la haraka';

  @override
  String get multiSelectHint => 'Chagua vipengee';

  @override
  String get selectHint => 'Chagua kipengee';

  @override
  String get selectSearchHint => 'Tafuta';

  @override
  String get selectNoResults => 'Hakuna matokeo yanayolingana.';

  @override
  String get selectScrollUpSemanticsLabel => 'Sogeza juu';

  @override
  String get selectScrollDownSemanticsLabel => 'Sogeza chini';

  @override
  String get sheetSemanticsLabel => 'Safu';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Futa';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Chagua wakati';

  @override
  String get timeFieldInvalidDateError => 'Wakati batili.';
}
