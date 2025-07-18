// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class FLocalizationsKo extends FLocalizations {
  FLocalizationsKo([String locale = 'ko']) : super(locale);

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
  String get barrierLabel => '스크림';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName 닫기';
  }

  @override
  String get dateFieldHint => '날짜 선택';

  @override
  String get dateFieldInvalidDateError => '날짜가 잘못되었습니다.';

  @override
  String get shortDateSeparator => '. ';

  @override
  String get shortDateSuffix => '.';

  @override
  String get dialogSemanticsLabel => '대화상자';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => '팝오버';

  @override
  String get multiSelectHint => '항목 선택';

  @override
  String get selectHint => '항목 선택';

  @override
  String get selectSearchHint => '검색';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => '위로 스크롤';

  @override
  String get selectScrollDownSemanticsLabel => '아래로 스크롤';

  @override
  String get sheetSemanticsLabel => '시트';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '시간 선택';

  @override
  String get timeFieldInvalidDateError => '잘못된 시간입니다.';
}
