// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class FLocalizationsBn extends FLocalizations {
  FLocalizationsBn([String locale = 'bn']) : super(locale);

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
  String get barrierLabel => 'স্ক্রিম';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName বন্ধ করুন';
  }

  @override
  String get autocompleteNoResults => 'কোনো মিল পাওয়া যায়নি.';

  @override
  String get dateFieldHint => 'তারিখ বেছে নিন';

  @override
  String get dateFieldInvalidDateError => 'অবৈধ তারিখ।';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'পপওভার';

  @override
  String get progressSemanticsLabel => 'লোড হচ্ছে';

  @override
  String get multiSelectHint => 'আইটেম নির্বাচন করুন';

  @override
  String get selectHint => 'একটি আইটেম নির্বাচন করুন';

  @override
  String get selectSearchHint => 'অনুসন্ধান';

  @override
  String get selectNoResults => 'কোন মিলে যাওয়া ফলাফল নেই।';

  @override
  String get selectScrollUpSemanticsLabel => 'উপরে স্ক্রোল করুন';

  @override
  String get selectScrollDownSemanticsLabel => 'নিচে স্ক্রোল করুন';

  @override
  String get sheetSemanticsLabel => 'শীট';

  @override
  String get textFieldClearButtonSemanticsLabel => 'মুছুন';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'একটি সময় বেছে নিন';

  @override
  String get timeFieldInvalidDateError => 'অবৈধ সময়।';
}
