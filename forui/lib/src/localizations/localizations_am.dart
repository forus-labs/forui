// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class FLocalizationsAm extends FLocalizations {
  FLocalizationsAm([String locale = 'am']) : super(locale);

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
  String get barrierLabel => 'ገዳቢ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentNameን ዝጋ';
  }

  @override
  String get autocompleteNoResults => 'ማንኛውም ውጤት አልተገኘም.';

  @override
  String get dateFieldHint => 'ቀን ይምረጡ';

  @override
  String get dateFieldInvalidDateError => 'ልክ ያልሆነ ቀን።';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'መገናኛ';

  @override
  String get paginationPreviousSemanticsLabel => 'ቀዳሚ';

  @override
  String get paginationNextSemanticsLabel => 'ቀጣይ';

  @override
  String get popoverSemanticsLabel => 'ፖፖቨር';

  @override
  String get progressSemanticsLabel => 'በመጫን ላይ';

  @override
  String get multiSelectHint => 'ንጥሎች ይምረጡ';

  @override
  String get selectHint => 'አንድ ንጥል ይምረጡ';

  @override
  String get selectSearchHint => 'ፍለጋ';

  @override
  String get selectNoResults => 'ምንም ተዛማጅ ውጤቶች የሉም።';

  @override
  String get selectScrollUpSemanticsLabel => 'ወደ ላይ ሸብልል';

  @override
  String get selectScrollDownSemanticsLabel => 'ወደ ታች ሸብልል';

  @override
  String get sheetSemanticsLabel => 'ሉህ';

  @override
  String get textFieldEmailLabel => 'ኢሜይል';

  @override
  String get textFieldClearButtonSemanticsLabel => 'አጽዳ';

  @override
  String get passwordFieldLabel => 'የይለፍ ቃል';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'ይለፍ ቃል ደብቅ';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'ይለፍ ቃል አሳይ';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ሰዓት ይምረጡ';

  @override
  String get timeFieldInvalidDateError => 'ልክ ያልሆነ ሰዓት።';
}
