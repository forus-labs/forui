// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class FLocalizationsHi extends FLocalizations {
  FLocalizationsHi([String locale = 'hi']) : super(locale);

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
  String get barrierLabel => 'स्क्रिम';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName को बंद करें';
  }

  @override
  String get autocompleteNoResults => 'कोई मिलान नहीं मिला.';

  @override
  String get dateFieldHint => 'तारीख़ चुनें';

  @override
  String get dateFieldInvalidDateError => 'अमान्य तारीख़.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'डायलॉग';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'पॉपओवर';

  @override
  String get progressSemanticsLabel => 'लोड हो रहा है';

  @override
  String get multiSelectHint => 'आइटम चुनें';

  @override
  String get selectHint => 'एक आइटम चुनें';

  @override
  String get selectSearchHint => 'खोजें';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ऊपर स्क्रॉल करें';

  @override
  String get selectScrollDownSemanticsLabel => 'नीचे स्क्रॉल करें';

  @override
  String get sheetSemanticsLabel => 'शीट';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'समय चुनें';

  @override
  String get timeFieldInvalidDateError => 'अमान्य समय.';
}
