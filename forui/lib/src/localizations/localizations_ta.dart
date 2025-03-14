// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class FLocalizationsTa extends FLocalizations {
  FLocalizationsTa([String locale = 'ta']) : super(locale);

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
  String get textFieldClearButtonSemanticLabel => 'அழி';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'தேதியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get dateFieldInvalidDateError => 'தவறான தேதி.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'நேரத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get timeFieldInvalidDateError => 'தவறான நேரம்.';

  @override
  String get dialogLabel => 'உரையாடல்';

  @override
  String get sheetSemanticsLabel => 'திரை';

  @override
  String get barrierLabel => 'ஸ்க்ரிம்';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName ஐ மூடுக';
  }
}
