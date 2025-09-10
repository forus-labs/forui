// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class FLocalizationsSk extends FLocalizations {
  FLocalizationsSk([String locale = 'sk']) : super(locale);

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
    return 'Zavrieť \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Nenašli sa žiadne zhody.';

  @override
  String get dateFieldHint => 'Vyberte dátum';

  @override
  String get dateFieldInvalidDateError => 'Neplatný dátum.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialógové okno';

  @override
  String get paginationPreviousSemanticsLabel => 'Predchádzajúce';

  @override
  String get paginationNextSemanticsLabel => 'Ďalej';

  @override
  String get popoverSemanticsLabel => 'Vyskakovacie okno';

  @override
  String get progressSemanticsLabel => 'Načítava sa';

  @override
  String get multiSelectHint => 'Vybrať položky';

  @override
  String get selectHint => 'Vyberte položku';

  @override
  String get selectSearchHint => 'Hľadať';

  @override
  String get selectNoResults => 'Žiadne zodpovedajúce výsledky.';

  @override
  String get selectScrollUpSemanticsLabel => 'Posunúť nahor';

  @override
  String get selectScrollDownSemanticsLabel => 'Posunúť nadol';

  @override
  String get sheetSemanticsLabel => 'hárok';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Vymazať';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Skryť heslo';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Zobraziť heslo';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Vyberte čas';

  @override
  String get timeFieldInvalidDateError => 'Neplatný čas.';
}
