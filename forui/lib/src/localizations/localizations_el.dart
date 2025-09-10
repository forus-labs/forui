// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class FLocalizationsEl extends FLocalizations {
  FLocalizationsEl([String locale = 'el']) : super(locale);

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
  String get barrierLabel => 'Επικάλυψη';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Κλείσιμο \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Δεν βρέθηκαν αντιστοιχίες.';

  @override
  String get dateFieldHint => 'Επιλέξτε ημερομηνία';

  @override
  String get dateFieldInvalidDateError => 'Μη έγκυρη ημερομηνία.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Παράθυρο διαλόγου';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Αναδυόμενο παράθυρο';

  @override
  String get progressSemanticsLabel => 'Φόρτωση';

  @override
  String get multiSelectHint => 'Επιλέξτε στοιχεία';

  @override
  String get selectHint => 'Επιλέξτε ένα στοιχείο';

  @override
  String get selectSearchHint => 'Αναζήτηση';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Κύλιση προς τα πάνω';

  @override
  String get selectScrollDownSemanticsLabel => 'Κύλιση προς τα κάτω';

  @override
  String get sheetSemanticsLabel => 'Φύλλο';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Απόκρυψη κωδικού';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Εμφάνιση κωδικού';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Επιλέξτε μια ώρα';

  @override
  String get timeFieldInvalidDateError => 'Μη έγκυρη ώρα.';
}
