// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lao (`lo`).
class FLocalizationsLo extends FLocalizations {
  FLocalizationsLo([String locale = 'lo']) : super(locale);

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
    return 'ປິດ \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'ບໍ່ພົບການຈັບຄູ່.';

  @override
  String get dateFieldHint => 'ເລືອກວັນທີ';

  @override
  String get dateFieldInvalidDateError => 'ວັນທີບໍ່ຖືກຕ້ອງ.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'ຂໍ້ຄວາມ';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'ປ໊ອບໂອເວີ';

  @override
  String get progressSemanticsLabel => 'ກຳລັງໂຫລດ';

  @override
  String get multiSelectHint => 'ເລືອກລາຍການ';

  @override
  String get selectHint => 'ເລືອກລາຍການ';

  @override
  String get selectSearchHint => 'ຊອກຫາ';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'ເລື່ອນຂຶ້ນ';

  @override
  String get selectScrollDownSemanticsLabel => 'ເລື່ອນລົງ';

  @override
  String get sheetSemanticsLabel => 'ແຜ່ນ';

  @override
  String get textFieldEmailLabel => 'ອີເມວ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'ລະຫັດຜ່ານ';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'ເຊື່ອງລະຫັດຜ່ານ';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'ສະແດງລະຫັດຜ່ານ';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ເລືອກເວລາ';

  @override
  String get timeFieldInvalidDateError => 'ເວລາບໍ່ຖືກຕ້ອງ.';
}
