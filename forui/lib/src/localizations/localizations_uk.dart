// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class FLocalizationsUk extends FLocalizations {
  FLocalizationsUk([String locale = 'uk']) : super(locale);

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
  String get selectHint => 'Виберіть елемент';

  @override
  String get selectSearchHint => 'Пошук';

  @override
  String get selectNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Очистити';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Виберіть дату';

  @override
  String get dateFieldInvalidDateError => 'Недійсна дата.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Виберіть час';

  @override
  String get timeFieldInvalidDateError => 'Недійсний час.';

  @override
  String get dialogLabel => 'Вікно';

  @override
  String get sheetSemanticsLabel => 'екран';

  @override
  String get barrierLabel => 'Маскувальний фон';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Закрити: \$modalRouteContentName';
  }
}
