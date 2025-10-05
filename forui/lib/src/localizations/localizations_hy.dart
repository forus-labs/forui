// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class FLocalizationsHy extends FLocalizations {
  FLocalizationsHy([String locale = 'hy']) : super(locale);

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
  String get barrierLabel => 'Դիմակ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return 'Փակել՝ \$modalRouteContentName';
  }

  @override
  String get autocompleteNoResults => 'Համընկնումներ չեն գտնվել.';

  @override
  String get dateFieldHint => 'Ընտրել ամսաթիվը';

  @override
  String get dateFieldInvalidDateError => 'Սխալ ամսաթիվ:';

  @override
  String get shortDateSeparator => '.';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'Երկխոսության պատուհան';

  @override
  String get paginationPreviousSemanticsLabel => 'Previous';

  @override
  String get paginationNextSemanticsLabel => 'Next';

  @override
  String get popoverSemanticsLabel => 'Ելնող պատուհան';

  @override
  String get progressSemanticsLabel => 'Բեռնում';

  @override
  String get multiSelectHint => 'Ընտրել տարրեր';

  @override
  String get selectHint => 'Ընտրեք տարր';

  @override
  String get selectSearchHint => 'Որոնել';

  @override
  String get selectNoResults => 'No matches found.';

  @override
  String get selectScrollUpSemanticsLabel => 'Ոլորել վերև';

  @override
  String get selectScrollDownSemanticsLabel => 'Ոլորել ներքև';

  @override
  String get sheetSemanticsLabel => 'էկրան';

  @override
  String get textFieldEmailLabel => 'Էլ․ փոստ';

  @override
  String get textFieldClearButtonSemanticsLabel => 'Clear';

  @override
  String get passwordFieldLabel => 'Գաղտնաբառ';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'Թաքցնել գաղտնաբառը';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'Ցույց տալ գաղտնաբառը';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => '';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'Ընտրեք ժամանակը';

  @override
  String get timeFieldInvalidDateError => 'Անվավեր ժամանակ:';
}
