// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class FLocalizationsIt extends FLocalizations {
  FLocalizationsIt([String locale = 'it']) : super(locale);

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
  String get barrierLabel => 'Rete';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Chiudi \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'Seleziona data';

  @override
  String get dateFieldInvalidDateError => 'Data non valida.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get paginationPreviousSemanticsLabel => 'Precedente';

  @override
  String get paginationNextSemanticsLabel => 'Avanti';

  @override
  String get popoverSemanticsLabel => 'Finestra di sovrapposizione';

  @override
  String get selectHint => 'Seleziona un elemento';

  @override
  String get selectSearchHint => 'Cerca';

  @override
  String get selectNoResults => 'Nessun risultato corrispondente.';

  @override
  String get selectScrollUpSemanticsLabel => 'Scorri verso l\'alto';

  @override
  String get selectScrollDownSemanticsLabel => 'Scorri verso il basso';

  @override
  String get sheetSemanticsLabel => 'Riquadro';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Cancella';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Scegli un orario';

  @override
  String get timeFieldInvalidDateError => 'Orario non valido.';

  @override
  String get dialogLabel => 'Finestra di dialogo';
}
