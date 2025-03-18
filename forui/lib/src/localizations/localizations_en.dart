// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class FLocalizationsEn extends FLocalizations {
  FLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get barrierLabel => 'Barrier';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close $modalRouteContentName';
  }
}

/// The translations for English, as used in Australia (`en_AU`).
class FLocalizationsEnAu extends FLocalizationsEn {
  FLocalizationsEnAu() : super('en_AU');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in Canada (`en_CA`).
class FLocalizationsEnCa extends FLocalizationsEn {
  FLocalizationsEnCa() : super('en_CA');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '-';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in the United Kingdom (`en_GB`).
class FLocalizationsEnGb extends FLocalizationsEn {
  FLocalizationsEnGb() : super('en_GB');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in Ireland (`en_IE`).
class FLocalizationsEnIe extends FLocalizationsEn {
  FLocalizationsEnIe() : super('en_IE');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in India (`en_IN`).
class FLocalizationsEnIn extends FLocalizationsEn {
  FLocalizationsEnIn() : super('en_IN');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in New Zealand (`en_NZ`).
class FLocalizationsEnNz extends FLocalizationsEn {
  FLocalizationsEnNz() : super('en_NZ');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in Singapore (`en_SG`).
class FLocalizationsEnSg extends FLocalizationsEn {
  FLocalizationsEnSg() : super('en_SG');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}

/// The translations for English, as used in South Africa (`en_ZA`).
class FLocalizationsEnZa extends FLocalizationsEn {
  FLocalizationsEnZa() : super('en_ZA');

  @override
  String get selectHint => 'Select an item';

  @override
  String get selectSearchHint => 'Search';

  @override
  String get selectSearchNoResults => 'No matching results.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Clear';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Pick a date';

  @override
  String get dateFieldInvalidDateError => 'Invalid date.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pick a time';

  @override
  String get timeFieldInvalidDateError => 'Invalid time.';

  @override
  String get dialogLabel => 'Dialogue';

  @override
  String get sheetSemanticsLabel => 'sheet';

  @override
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Close \$modalRouteContentName';
  }
}
