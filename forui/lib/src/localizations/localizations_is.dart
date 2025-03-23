// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class FLocalizationsIs extends FLocalizations {
  FLocalizationsIs([String locale = 'is']) : super(locale);

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
  String get selectHint => 'Veldu atriði';

  @override
  String get selectSearchHint => 'Leita';

  @override
  String get selectNoResults => 'Engar samsvarandi niðurstöður.';

  @override
  String get selectScrollUpSemanticsLabel => 'Fletta upp';

  @override
  String get selectScrollDownSemanticsLabel => 'Fletta niður';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Hreinsa';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dateFieldHint => 'Veldu dagsetningu';

  @override
  String get dateFieldInvalidDateError => 'Ógild dagsetning.';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Veldu tíma';

  @override
  String get timeFieldInvalidDateError => 'Ógildur tími.';

  @override
  String get dialogLabel => 'Gluggi';

  @override
  String get sheetSemanticsLabel => 'Blað';

  @override
  String get barrierLabel => 'Möskvi';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Loka \$modalRouteContentName';
  }
}
