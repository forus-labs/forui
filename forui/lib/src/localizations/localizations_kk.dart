// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class FLocalizationsKk extends FLocalizations {
  FLocalizationsKk([String locale = 'kk']) : super(locale);

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
    return '\$modalRouteContentName жабу';
  }

  @override
  String get autocompleteNoResults => 'Ешқандай сәйкестік табылмады';

  @override
  String get dateFieldHint => 'Күнді таңдаңыз';

  @override
  String get dateFieldInvalidDateError => 'Жарамсыз күн.';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Диалогтық терезе';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Қалқымалы терезе';

  @override
  String get multiSelectHint => 'Элементтерді таңдаңыз';

  @override
  String get selectHint => 'Элементті таңдаңыз';

  @override
  String get selectSearchHint => 'Іздеу';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Жоғары айналдыру';

  @override
  String get selectScrollDownSemanticsLabel => 'Төмен айналдыру';

  @override
  String get sheetSemanticsLabel => 'парақша';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Уақытты таңдаңыз';

  @override
  String get timeFieldInvalidDateError => 'Жарамсыз уақыт.';
}
