// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class FLocalizationsNo extends FLocalizations {
  FLocalizationsNo([String locale = 'no']) : super(locale);

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
  String get selectHint => 'Velg et element';

  @override
  String get selectSearchHint => 'Søk';

  @override
  String get selectNoResults => 'Ingen samsvarende resultater.';

  @override
  String get textFieldClearButtonSemanticLabel => 'Tøm';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Velg dato';

  @override
  String get dateFieldInvalidDateError => 'Ugyldig dato.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Velg et tidspunkt';

  @override
  String get timeFieldInvalidDateError => 'Ugyldig tidspunkt.';

  @override
  String get dialogLabel => 'Dialogboks';

  @override
  String get sheetSemanticsLabel => 'Felt';

  @override
  String get barrierLabel => 'Vev';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Lukk \$modalRouteContentName';
  }
}
