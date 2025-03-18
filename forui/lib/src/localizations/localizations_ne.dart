// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class FLocalizationsNe extends FLocalizations {
  FLocalizationsNe([String locale = 'ne']) : super(locale);

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
  String get selectHint => 'वस्तु चयन गर्नुहोस्';

  @override
  String get selectSearchHint => 'खोज्नुहोस्';

  @override
  String get selectSearchNoResults => 'कुनै मिल्दो परिणामहरू छैनन्।';

  @override
  String get textFieldClearButtonSemanticLabel => 'खाली गर्नुहोस्';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'मिति चयन गर्नुहोस्';

  @override
  String get dateFieldInvalidDateError => 'अमान्य मिति।';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'समय चयन गर्नुहोस्';

  @override
  String get timeFieldInvalidDateError => 'अमान्य समय।';

  @override
  String get dialogLabel => 'संवाद';

  @override
  String get sheetSemanticsLabel => 'पाना';

  @override
  String get barrierLabel => 'स्क्रिम';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName बन्द गर्नुहोस्';
  }
}
