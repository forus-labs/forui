import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class FLocalizationsPt extends FLocalizations {
  FLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Selecionar data';

  @override
  String get datePickerInvalidDateError => 'Data inválida.';

  @override
  String get dialogLabel => 'Caixa de diálogo';

  @override
  String get sheetLabel => 'inferior';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fechar \$modalRouteContentName';
  }
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class FLocalizationsPtPt extends FLocalizationsPt {
  FLocalizationsPtPt() : super('pt_PT');

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => 'Selecionar data';

  @override
  String get datePickerInvalidDateError => 'Data inválida.';

  @override
  String get dialogLabel => 'Caixa de diálogo';

  @override
  String get sheetLabel => 'Secção';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Fechar \$modalRouteContentName';
  }
}
