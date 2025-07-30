// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class FLocalizationsId extends FLocalizations {
  FLocalizationsId([String locale = 'id']) : super(locale);

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
  String get autocompleteNoResults => 'Tidak ada hasil yang cocok';

  @override
  String get dateFieldHint => 'Pilih tanggal';

  @override
  String get dateFieldInvalidDateError => 'Tanggal tidak valid.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Dialog';

  @override
  String get paginationPreviousSemanticsLabel => 'Sebelumnya';

  @override
  String get paginationNextSemanticsLabel => 'Berikutnya';

  @override
  String get popoverSemanticsLabel => 'Popover';

  @override
  String get multiSelectHint => 'Pilih item';

  @override
  String get selectHint => 'Pilih item';

  @override
  String get selectSearchHint => 'Cari';

  @override
  String get selectNoResults => 'Tidak ada hasil yang cocok.';

  @override
  String get selectScrollUpSemanticsLabel => 'Gulir ke atas';

  @override
  String get selectScrollDownSemanticsLabel => 'Gulir ke bawah';

  @override
  String get sheetSemanticsLabel => 'Sheet';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Hapus';

  @override
  String get timeFieldTimeSeparator => '.';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Pilih waktu';

  @override
  String get timeFieldInvalidDateError => 'Waktu tidak valid.';
}
