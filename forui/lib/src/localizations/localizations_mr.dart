// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class FLocalizationsMr extends FLocalizations {
  FLocalizationsMr([String locale = 'mr']) : super(locale);

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
    return '\$modalRouteContentName बंद करा';
  }

  @override
  String get autocompleteNoResults => 'कोणतेही जुळणारे आढळले नाही.';

  @override
  String get dateFieldHint => 'तारीख निवडा';

  @override
  String get dateFieldInvalidDateError => 'अवैध तारीख.';

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
  String get popoverSemanticsLabel => 'पॉपओव्हर';

  @override
  String get progressSemanticsLabel => 'लोड होत आहे';

  @override
  String get multiSelectHint => 'आयटम निवडा';

  @override
  String get selectHint => 'आयटम निवडा';

  @override
  String get selectSearchHint => 'शोधा';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'वर स्क्रोल करा';

  @override
  String get selectScrollDownSemanticsLabel => 'खाली स्क्रोल करा';

  @override
  String get sheetSemanticsLabel => 'शीट';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'पासवर्ड लपवा';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'पासवर्ड दाखवा';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'वेळ निवडा';

  @override
  String get timeFieldInvalidDateError => 'अवैध वेळ.';
}
