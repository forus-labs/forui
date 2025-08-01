// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class FLocalizationsTe extends FLocalizations {
  FLocalizationsTe([String locale = 'te']) : super(locale);

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
  String get barrierLabel => 'స్క్రిమ్';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName‌ను మూసివేయండి';
  }

  @override
  String get autocompleteNoResults => 'సరిపోలినవి ఏవీ కనుగొనబడలేదు.';

  @override
  String get dateFieldHint => 'తేదీని ఎంచుకోండి';

  @override
  String get dateFieldInvalidDateError => 'చెల్లని తేదీ.';

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
  String get popoverSemanticsLabel => 'పాప్‌ఓవర్';

  @override
  String get multiSelectHint => 'అంశాలను ఎంచుకోండి';

  @override
  String get selectHint => 'ఒక అంశాన్ని ఎంచుకోండి';

  @override
  String get selectSearchHint => 'శోధించు';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'పైకి స్క్రోల్ చేయండి';

  @override
  String get selectScrollDownSemanticsLabel => 'క్రిందికి స్క్రోల్ చేయండి';

  @override
  String get sheetSemanticsLabel => 'షీట్';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'సమయాన్ని ఎంచుకోండి';

  @override
  String get timeFieldInvalidDateError => 'చెల్లని సమయం.';
}
