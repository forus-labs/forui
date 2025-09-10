// dart format off
// coverage:ignore-file


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
  String get barrierLabel => 'Маска';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Закрыть \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Совпадений не найдено.';

  @override
  String get dateFieldHint => 'Выберите дату';

  @override
  String get dateFieldInvalidDateError => 'Недействительная дата.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Диалоговое окно';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Всплывающее окно';

  @override
  String get progressSemanticsLabel => 'Загрузка';

  @override
  String get multiSelectHint => 'Выберите элементы';

  @override
  String get selectHint => 'Выберите элемент';

  @override
  String get selectSearchHint => 'Поиск';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Прокрутить вверх';

  @override
  String get selectScrollDownSemanticsLabel => 'Прокрутить вниз';

  @override
  String get sheetSemanticsLabel => 'экран';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Скрыть пароль';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Показать пароль';

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
}
