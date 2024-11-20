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
  String get dialogLabel => '对话框';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class FLocalizationsZhHk extends FLocalizationsZh {
  FLocalizationsZhHk(): super('zh_HK');

  @override
  String get dialogLabel => '對話方塊';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class FLocalizationsZhTw extends FLocalizationsZh {
  FLocalizationsZhTw(): super('zh_TW');

  @override
  String get dialogLabel => '對話方塊';
}
