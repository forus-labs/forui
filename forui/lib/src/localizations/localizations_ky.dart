// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kirghiz Kyrgyz (`ky`).
class FLocalizationsKy extends FLocalizations {
  FLocalizationsKy([String locale = 'ky']) : super(locale);

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
  String get barrierLabel => 'Кенеп';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName жабуу';
  }

  @override
  String get autocompleteNoResults => 'Эч кандай дал келүү табылган жок.';

  @override
  String get dateFieldHint => 'Күндү тандоо';

  @override
  String get dateFieldInvalidDateError => 'Жараксыз күн.';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Калкып чыгуучу терезе';

  @override
  String get progressSemanticsLabel => 'Жүктөлүүдө';

  @override
  String get multiSelectHint => 'Элементтерди тандоо';

  @override
  String get selectHint => 'Элементти тандаңыз';

  @override
  String get selectSearchHint => 'Издөө';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Өйдө сыдыруу';

  @override
  String get selectScrollDownSemanticsLabel => 'Ылдый сыдыруу';

  @override
  String get sheetSemanticsLabel => 'экран';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Убакытты тандаңыз';

  @override
  String get timeFieldInvalidDateError => 'Жараксыз убакыт.';
}
