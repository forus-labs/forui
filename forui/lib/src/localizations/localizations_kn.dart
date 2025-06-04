// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class FLocalizationsKn extends FLocalizations {
  FLocalizationsKn([String locale = 'kn']) : super(locale);

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
  String get barrierLabel => 'ಸ್ಕ್ರಿಮ್';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName ಅನ್ನು ಮುಚ್ಚಿರಿ';
  }

  @override
  String get dateFieldHint => 'ದಿನಾಂಕವನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get dateFieldInvalidDateError => 'ಅಮಾನ್ಯವಾದ ದಿನಾಂಕ.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'ಪಾಪ್‌ಓವರ್';

  @override
  String get selectHint => 'ಐಟಂ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get selectSearchHint => 'ಹುಡುಕಿ';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ಮೇಲಕ್ಕೆ ಸ್ಕ್ರಾಲ್ ಮಾಡಿ';

  @override
  String get selectScrollDownSemanticsLabel => 'ಕೆಳಗೆ ಸ್ಕ್ರಾಲ್ ಮಾಡಿ';

  @override
  String get sheetSemanticsLabel => 'ಶೀಟ್';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ಸಮಯವನ್ನು ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get timeFieldInvalidDateError => 'ಅಮಾನ್ಯ ಸಮಯ.';

  @override
  String get dialogLabel => 'ಡೈಲಾಗ್';
}
