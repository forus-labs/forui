// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Assamese (`as`).
class FLocalizationsAs extends FLocalizations {
  FLocalizationsAs([String locale = 'as']) : super(locale);

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
  String get barrierLabel => 'স্ক্ৰিম';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName বন্ধ কৰক';
  }

  @override
  String get autocompleteNoResults => 'কোনো মিল পোৱা নগল.';

  @override
  String get dateFieldHint => 'তাৰিখ বাছনি কৰক';

  @override
  String get dateFieldInvalidDateError => 'অমান্য তাৰিখ।';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'পপঅভাৰ';

  @override
  String get progressSemanticsLabel => 'লোড হৈ আছে';

  @override
  String get multiSelectHint => 'বস্তুসমূহ বাছক';

  @override
  String get selectHint => 'এটা বস্তু বাছনি কৰক';

  @override
  String get selectSearchHint => 'সন্ধান কৰক';

  @override
  String get selectNoResults => 'কোনো মিল থকা ফলাফল নাই।';

  @override
  String get selectScrollUpSemanticsLabel => 'ওপৰলৈ স্ক্ৰল কৰক';

  @override
  String get selectScrollDownSemanticsLabel => 'তললৈ স্ক্ৰল কৰক';

  @override
  String get sheetSemanticsLabel => 'শ্বীট';

  @override
  String get textFieldClearButtonSemanticsLabel => 'মচক';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'সময় বাছনি কৰক';

  @override
  String get timeFieldInvalidDateError => 'অমান্য সময়।';
}
