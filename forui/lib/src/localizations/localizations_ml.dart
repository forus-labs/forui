// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class FLocalizationsMl extends FLocalizations {
  FLocalizationsMl([String locale = 'ml']) : super(locale);

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
  String get barrierLabel => 'സ്ക്രിം';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentName അടയ്ക്കുക';
  }

  @override
  String get autocompleteNoResults => 'പൊരുത്തങ്ങളൊന്നും കണ്ടെത്തിയില്ല.';

  @override
  String get dateFieldHint => 'തീയതി തിരഞ്ഞെടുക്കുക';

  @override
  String get dateFieldInvalidDateError => 'അസാധുവായ തീയതി.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'ഡയലോഗ്';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'പോപ്പോവർ';

  @override
  String get progressSemanticsLabel => 'ലോഡ് ചെയ്യുന്നു';

  @override
  String get multiSelectHint => 'ഇനങ്ങൾ തിരഞ്ഞെടുക്കുക';

  @override
  String get selectHint => 'ഒരു ഇനം തിരഞ്ഞെടുക്കുക';

  @override
  String get selectSearchHint => 'തിരയുക';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'മുകളിലേക്ക് സ്ക്രോൾ ചെയ്യുക';

  @override
  String get selectScrollDownSemanticsLabel => 'താഴേക്ക് സ്ക്രോൾ ചെയ്യുക';

  @override
  String get sheetSemanticsLabel => 'ഷീറ്റ്';

  @override
  String get textFieldEmailLabel => 'ഇമെയിൽ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'പാസ്‌വേഡ്';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'പാസ്‌വേഡ് മറയ്ക്കുക';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'പാസ്‌വേഡ് കാണിക്കുക';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ഒരു സമയം തിരഞ്ഞെടുക്കുക';

  @override
  String get timeFieldInvalidDateError => 'അസാധുവായ സമയം.';
}
