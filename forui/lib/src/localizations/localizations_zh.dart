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
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => '选择日期';

  @override
  String get datePickerInvalidDateError => '日期无效。';

  @override
  String get dialogLabel => '对话框';

  @override
  String get sheetLabel => '动作条';

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
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => '選擇日期';

  @override
  String get datePickerInvalidDateError => '日期無效。';

  @override
  String get dialogLabel => '對話方塊';

  @override
  String get sheetLabel => '面板';

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
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get datePickerHint => '選擇日期';

  @override
  String get datePickerInvalidDateError => '日期無效。';

  @override
  String get dialogLabel => '對話方塊';

  @override
  String get sheetLabel => '功能表';

  @override
  String get barrierLabel => '紗罩';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '關閉「\$modalRouteContentName」';
  }
}
