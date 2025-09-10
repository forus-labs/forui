// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class FLocalizationsPa extends FLocalizations {
  FLocalizationsPa([String locale = 'pa']) : super(locale);

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
  String get barrierLabel => 'ਸਕ੍ਰਿਮ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName ਨੂੰ ਬੰਦ ਕਰੋ';
  }

  @override
  String get autocompleteNoResults => 'ਕੋਈ ਮੇਲ ਨਹੀਂ ਮਿਲਿਆ.';

  @override
  String get dateFieldHint => 'ਤਾਰੀਖ ਚੁਣੋ';

  @override
  String get dateFieldInvalidDateError => 'ਅਵੈਧ ਤਾਰੀਖ।';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'ਵਿੰਡੋ';

  @override
  String get paginationPreviousSemanticsLabel => 'ਪਿਛਲਾ';

  @override
  String get paginationNextSemanticsLabel => 'ਅੱਗੇ';

  @override
  String get popoverSemanticsLabel => 'ਪੌਪਓਵਰ';

  @override
  String get progressSemanticsLabel => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ';

  @override
  String get multiSelectHint => 'ਆਈਟਮਾਂ ਚੁਣੋ';

  @override
  String get selectHint => 'ਇੱਕ ਆਈਟਮ ਚੁਣੋ';

  @override
  String get selectSearchHint => 'ਖੋਜ';

  @override
  String get selectNoResults => 'ਕੋਈ ਮੇਲ ਖਾਂਦੇ ਨਤੀਜੇ ਨਹੀਂ ਹਨ।';

  @override
  String get selectScrollUpSemanticsLabel => 'ਉੱਪਰ ਸਕ੍ਰੋਲ ਕਰੋ';

  @override
  String get selectScrollDownSemanticsLabel => 'ਹੇਠਾਂ ਸਕ੍ਰੋਲ ਕਰੋ';

  @override
  String get sheetSemanticsLabel => 'ਸ਼ੀਟ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'ਕਲੀਅਰ ਕਰੋ';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ਇੱਕ ਸਮਾਂ ਚੁਣੋ';

  @override
  String get timeFieldInvalidDateError => 'ਅਵੈਧ ਸਮਾਂ।';
}
