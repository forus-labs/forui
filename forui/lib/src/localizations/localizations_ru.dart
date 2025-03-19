// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class FLocalizationsRu extends FLocalizations {
  FLocalizationsRu([String locale = 'ru']) : super(locale);

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
  String get selectHint => 'Выберите элемент';

  @override
  String get selectSearchHint => 'Поиск';

  @override
  String get selectNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Очистить';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Выберите дату';

  @override
  String get dateFieldInvalidDateError => 'Недействительная дата.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Выберите время';

  @override
  String get timeFieldInvalidDateError => 'Недействительное время.';

  @override
  String get dialogLabel => 'Диалоговое окно';

  @override
  String get sheetSemanticsLabel => 'экран';

  @override
  String get barrierLabel => 'Маска';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Закрыть \$modalRouteContentName';
  }
}
