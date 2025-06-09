// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class FLocalizationsSr extends FLocalizations {
  FLocalizationsSr([String locale = 'sr']) : super(locale);

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
  String get barrierLabel => 'Скрим';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Затвори: \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Изаберите датум';

  @override
  String get dateFieldInvalidDateError => 'Неважећи датум.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dialogSemanticsLabel => 'Дијалог';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Искачући прозор';

  @override
  String get selectHint => 'Изаберите ставку';

  @override
  String get selectSearchHint => 'Претрага';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Померите нагоре';

  @override
  String get selectScrollDownSemanticsLabel => 'Померите надоле';

  @override
  String get sheetSemanticsLabel => 'табела';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Изаберите време';

  @override
  String get timeFieldInvalidDateError => 'Неважеће време.';
}

/// The translations for Serbian, using the Latin script (`sr_Latn`).
class FLocalizationsSrLatn extends FLocalizationsSr {
  FLocalizationsSrLatn(): super('sr_Latn');

  @override
  String get barrierLabel => 'Skrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Zatvori: \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Izaberite datum';

  @override
  String get dateFieldInvalidDateError => 'Nevažeći datum.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dialogSemanticsLabel => 'Dijalog';

  @override
  String get paginationPreviousSemanticsLabel => 'Prethodno';

  @override
  String get paginationNextSemanticsLabel => 'Sledeće';

  @override
  String get popoverSemanticsLabel => 'Iskačući prozor';

  @override
  String get selectHint => 'Izaberite stavku';

  @override
  String get selectSearchHint => 'Pretraga';

  @override
  String get selectNoResults => 'Nema podudarajućih rezultata.';

  @override
  String get selectScrollUpSemanticsLabel => 'Pomerite nagore';

  @override
  String get selectScrollDownSemanticsLabel => 'Pomerite nadole';

  @override
  String get sheetSemanticsLabel => 'tabela';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Obriši';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Izaberite vreme';

  @override
  String get timeFieldInvalidDateError => 'Nevažeće vreme.';
}
