// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class FLocalizationsVi extends FLocalizations {
  FLocalizationsVi([String locale = 'vi']) : super(locale);

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
    return 'Đóng \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Không tìm thấy kết quả phù hợp.';

  @override
  String get dateFieldHint => 'Chọn ngày';

  @override
  String get dateFieldInvalidDateError => 'Ngày không hợp lệ.';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Hộp thoại';

  @override
  String get paginationPreviousSemanticsLabel => 'Trước';

  @override
  String get paginationNextSemanticsLabel => 'Tiếp';

  @override
  String get popoverSemanticsLabel => 'Cửa sổ bật lên';

  @override
  String get progressSemanticsLabel => 'Đang tải';

  @override
  String get multiSelectHint => 'Chọn các mục';

  @override
  String get selectHint => 'Chọn một mục';

  @override
  String get selectSearchHint => 'Tìm kiếm';

  @override
  String get selectNoResults => 'Không có kết quả phù hợp.';

  @override
  String get selectScrollUpSemanticsLabel => 'Cuộn lên';

  @override
  String get selectScrollDownSemanticsLabel => 'Cuộn xuống';

  @override
  String get sheetSemanticsLabel => 'Bảng';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Xóa';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Ẩn mật khẩu';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Hiển thị mật khẩu';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Chọn thời gian';

  @override
  String get timeFieldInvalidDateError => 'Thời gian không hợp lệ.';
}
