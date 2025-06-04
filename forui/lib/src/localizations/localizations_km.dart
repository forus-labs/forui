// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class FLocalizationsKm extends FLocalizations {
  FLocalizationsKm([String locale = 'km']) : super(locale);

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
  String get barrierLabel => 'ផ្ទាំងស្រអាប់';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'បិទ \$modalRouteContentName';
  }

  @override
  String get dateFieldHint => 'ជ្រើសរើស​កាលបរិច្ឆេទ';

  @override
  String get dateFieldInvalidDateError => 'កាលបរិច្ឆេទ​មិន​ត្រឹមត្រូវ។';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'បង្អួចលេចឡើង';

  @override
  String get selectHint => 'ជ្រើសរើសធាតុមួយ';

  @override
  String get selectSearchHint => 'ស្វែងរក';

  @override
  String get selectNoResults => 'គ្មានលទ្ធផលដែលត្រូវគ្នាទេ។';

  @override
  String get selectScrollUpSemanticsLabel => 'រមូរឡើងលើ';

  @override
  String get selectScrollDownSemanticsLabel => 'រមូរចុះក្រោម';

  @override
  String get sheetSemanticsLabel => 'សន្លឹក';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ជ្រើសរើសពេលវេលា';

  @override
  String get timeFieldInvalidDateError => 'ពេលវេលាមិនត្រឹមត្រូវ។';

  @override
  String get dialogLabel => 'ប្រអប់';
}
