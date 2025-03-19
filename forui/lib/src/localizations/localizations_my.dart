// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class FLocalizationsMy extends FLocalizations {
  FLocalizationsMy([String locale = 'my']) : super(locale);

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
  String get selectHint => 'ပစ္စည်းတစ်ခုရွေးပါ';

  @override
  String get selectSearchHint => 'ရှာဖွေရန်';

  @override
  String get selectNoResults => 'တူညီသည့်ရလဒ်များမရှိပါ။';

  @override
  String get textFieldClearButtonSemanticLabel => 'ရှင်းရန်';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'ရက်စွဲ ရွေးပါ';

  @override
  String get dateFieldInvalidDateError => 'ရက်စွဲ မမှန်ကန်ပါ။';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'အချိန်ရွေးပါ';

  @override
  String get timeFieldInvalidDateError => 'အချိန်မမှန်ပါ။';

  @override
  String get dialogLabel => 'ဒိုင်ယာလော့';

  @override
  String get sheetSemanticsLabel => 'ပိုဆောင်း စာမျက်နှာ';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName ပိတ်ရန်';
  }
}
