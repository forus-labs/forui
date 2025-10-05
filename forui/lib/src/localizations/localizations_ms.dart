// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class FLocalizationsMs extends FLocalizations {
  FLocalizationsMs([String locale = 'ms']) : super(locale);

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
  String get barrierLabel => 'Scrim';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Tutup \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Tiada padanan ditemui.';

  @override
  String get dateFieldHint => 'Pilih tarikh';

  @override
  String get dateFieldInvalidDateError => 'Tarikh tidak sah.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Sebelumnya';

  @override
  String get paginationNextSemanticsLabel => 'Seterusnya';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get progressSemanticsLabel => 'Memuatkan';

  @override
  String get multiSelectHint => 'Pilih item';

  @override
  String get selectHint => 'Pilih item';

  @override
  String get selectSearchHint => 'Cari';

  @override
  String get selectNoResults => 'Tiada hasil yang sepadan.';

  @override
  String get selectScrollUpSemanticsLabel => 'Tatal ke atas';

  @override
  String get selectScrollDownSemanticsLabel => 'Tatal ke bawah';

  @override
  String get sheetSemanticsLabel => 'Helaian';

  @override
  String get textFieldEmailLabel => 'E-mel';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Kosongkan';

  @override
  String get passwordFieldLabel => 'Kata laluan';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Sembunyikan kata laluan';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Tunjukkan kata laluan';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pilih masa';

  @override
  String get timeFieldInvalidDateError => 'Masa tidak sah.';
}
