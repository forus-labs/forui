// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class FLocalizationsGu extends FLocalizations {
  FLocalizationsGu([String locale = 'gu']) : super(locale);

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
  String get selectHint => 'આઇટમ પસંદ કરો';

  @override
  String get selectSearchHint => 'શોધો';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ઉપર સ્ક્રોલ કરો';

  @override
  String get selectScrollDownSemanticsLabel => 'નીચે સ્ક્રોલ કરો';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'તારીખ પસંદ કરો';

  @override
  String get dateFieldInvalidDateError => 'અમાન્ય તારીખ.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'સમય પસંદ કરો';

  @override
  String get timeFieldInvalidDateError => 'અમાન્ય સમય.';

  @override
  String get dialogLabel => 'સંવાદ';

  @override
  String get sheetSemanticsLabel => 'શીટ';

  @override
  String get barrierLabel => 'સ્ક્રિમ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentNameને બંધ કરો';
  }
}
