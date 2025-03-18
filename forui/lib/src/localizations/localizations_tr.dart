// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class FLocalizationsTr extends FLocalizations {
  FLocalizationsTr([String locale = 'tr']) : super(locale);

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
  String get selectHint => 'Bir öğe seçin';

  @override
  String get selectSearchHint => 'Ara';

  @override
  String get selectSearchNoResults => 'Eşleşen sonuç yok.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Temizle';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Tarih seçin';

  @override
  String get dateFieldInvalidDateError => 'Geçersiz tarih.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Bir zaman seçin';

  @override
  String get timeFieldInvalidDateError => 'Geçersiz zaman.';

  @override
  String get dialogLabel => 'İletişim kutusu';

  @override
  String get sheetSemanticsLabel => 'sayfa';

  @override
  String get barrierLabel => 'opaklık katmanı';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName içeriğini kapat';
  }
}
