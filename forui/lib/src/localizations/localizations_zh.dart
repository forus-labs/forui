// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class FLocalizationsZh extends FLocalizations {
  FLocalizationsZh([String locale = 'zh']) : super(locale);

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
  String get selectHint => '选择项目';

  @override
  String get selectSearchHint => '搜索';

  @override
  String get selectNoResults => '没有匹配结果。';

  @override
  String get selectScrollUpSemanticsLabel => '向上滚动';

  @override
  String get selectScrollDownSemanticsLabel => '向下滚动';

  @override
  String get textFieldClearButtonSemanticsLabel => '清除';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => '选择日期';

  @override
  String get dateFieldInvalidDateError => '日期无效。';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '选择时间';

  @override
  String get timeFieldInvalidDateError => '无效的时间。';

  @override
  String get dialogLabel => '对话框';

  @override
  String get sheetSemanticsLabel => '动作条';

  @override
  String get barrierLabel => '纱罩';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '关闭 \$modalRouteContentName';
  }
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class FLocalizationsZhHk extends FLocalizationsZh {
  FLocalizationsZhHk() : super('zh_HK');

  @override
  String get selectHint => '選擇項目';

  @override
  String get selectSearchHint => '搜尋';

  @override
  String get selectNoResults => '沒有匹配結果。';

  @override
  String get selectScrollUpSemanticsLabel => '向上捲動';

  @override
  String get selectScrollDownSemanticsLabel => '向下捲動';

  @override
  String get textFieldClearButtonSemanticsLabel => '清除';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => '選擇日期';

  @override
  String get dateFieldInvalidDateError => '日期無效。';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '選擇時間';

  @override
  String get timeFieldInvalidDateError => '無效的時間。';

  @override
  String get dialogLabel => '對話方塊';

  @override
  String get sheetSemanticsLabel => '面板';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '關閉 \$modalRouteContentName';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class FLocalizationsZhTw extends FLocalizationsZh {
  FLocalizationsZhTw() : super('zh_TW');

  @override
  String get selectHint => '選擇項目';

  @override
  String get selectSearchHint => '搜尋';

  @override
  String get selectNoResults => '沒有匹配結果。';

  @override
  String get selectScrollUpSemanticsLabel => '向上捲動';

  @override
  String get selectScrollDownSemanticsLabel => '向下捲動';

  @override
  String get textFieldClearButtonSemanticsLabel => '清除';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => '選擇日期';

  @override
  String get dateFieldInvalidDateError => '日期無效。';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => '選擇時間';

  @override
  String get timeFieldInvalidDateError => '無效的時間。';

  @override
  String get dialogLabel => '對話方塊';

  @override
  String get sheetSemanticsLabel => '功能表';

  @override
  String get barrierLabel => '紗罩';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '關閉「\$modalRouteContentName」';
  }
}
