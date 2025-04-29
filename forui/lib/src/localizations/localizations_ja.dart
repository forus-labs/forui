// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class FLocalizationsJa extends FLocalizations {
  FLocalizationsJa([String locale = 'ja']) : super(locale);

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
  String get selectHint => 'アイテムを選択';

  @override
  String get selectSearchHint => '検索';

  @override
  String get selectNoResults => '一致する結果がありません。';

  @override
  String get selectScrollUpSemanticsLabel => '上にスクロール';

  @override
  String get selectScrollDownSemanticsLabel => '下にスクロール';

  @override
  String get textFieldClearButtonSemanticsLabel => 'クリア';

  @override
  String get paginationPreviousSemanticsLabel => '前へ';

  @override
  String get paginationNextSemanticsLabel => '次へ';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => '日付を選択';

  @override
  String get dateFieldInvalidDateError => '日付が無効です。';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '時間を選択';

  @override
  String get timeFieldInvalidDateError => '無効な時間です。';

  @override
  String get dialogLabel => 'ダイアログ';

  @override
  String get sheetSemanticsLabel => 'シート';

  @override
  String get barrierLabel => 'スクリム';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName を閉じる';
  }
}
