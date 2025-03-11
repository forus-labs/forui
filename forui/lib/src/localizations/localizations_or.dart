// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class FLocalizationsOr extends FLocalizations {
  FLocalizationsOr([String locale = 'or']) : super(locale);

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
  String get selectHint => 'ଏକ ଆଇଟମ୍ ଚୟନ କରନ୍ତୁ';

  @override
  String get selectSearchHint => 'ସନ୍ଧାନ କରନ୍ତୁ';

  @override
  String get textFieldClearButtonSemanticLabel => 'ସଫା କରନ୍ତୁ';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'ତାରିଖ ଚୟନ କରନ୍ତୁ';

  @override
  String get dateFieldInvalidDateError => 'ଅବୈଧ ତାରିଖ।';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ସମୟ ଚୟନ କରନ୍ତୁ';

  @override
  String get timeFieldInvalidDateError => 'ଅବୈଧ ସମୟ।';

  @override
  String get dialogLabel => 'ଡାୟଲଗ୍';

  @override
  String get sheetSemanticsLabel => 'ସିଟ';

  @override
  String get barrierLabel => 'ସ୍କ୍ରିମ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentNameକୁ ବନ୍ଦ କରନ୍ତୁ';
  }
}
