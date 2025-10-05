// dart format off
// coverage:ignore-file


// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class FLocalizationsOr extends FLocalizations {
  FLocalizationsOr([String locale = 'or']) : super(locale);

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
  String get barrierLabel => 'ସ୍କ୍ରିମ';

  @override
  String barrierOnTapHint(String modalRouteContentName) {
    return '\$modalRouteContentNameକୁ ବନ୍ଦ କରନ୍ତୁ';
  }

  @override
  String get autocompleteNoResults => 'କୌଣସି ମେଳ ମିଳିଲା ନାହିଁ.';

  @override
  String get dateFieldHint => 'ତାରିଖ ଚୟନ କରନ୍ତୁ';

  @override
  String get dateFieldInvalidDateError => 'ଅବୈଧ ତାରିଖ।';

  @override
  String get shortDateSeparator => '/';

  @override
  String get shortDateSuffix => '';

  @override
  String get dialogSemanticsLabel => 'ଡାୟଲଗ୍';

  @override
  String get paginationPreviousSemanticsLabel => 'ପୂର୍ବବର୍ତ୍ତୀ';

  @override
  String get paginationNextSemanticsLabel => 'ପରବର୍ତ୍ତୀ';

  @override
  String get popoverSemanticsLabel => 'ପପଓଭର';

  @override
  String get progressSemanticsLabel => 'ଲୋଡ଼ ହେଉଛି';

  @override
  String get multiSelectHint => 'ଆଇଟମ୍ ବାଛନ୍ତୁ';

  @override
  String get selectHint => 'ଏକ ଆଇଟମ୍ ଚୟନ କରନ୍ତୁ';

  @override
  String get selectSearchHint => 'ସନ୍ଧାନ କରନ୍ତୁ';

  @override
  String get selectNoResults => 'କୌଣସି ମେଳଖାଉଥିବା ଫଳାଫଳ ନାହିଁ।';

  @override
  String get selectScrollUpSemanticsLabel => 'ଉପରକୁ ସ୍କ୍ରୋଲ କରନ୍ତୁ';

  @override
  String get selectScrollDownSemanticsLabel => 'ତଳକୁ ସ୍କ୍ରୋଲ କରନ୍ତୁ';

  @override
  String get sheetSemanticsLabel => 'ସିଟ';

  @override
  String get textFieldEmailLabel => 'ଇମେଲ୍';

  @override
  String get textFieldClearButtonSemanticsLabel => 'ସଫା କରନ୍ତୁ';

  @override
  String get passwordFieldLabel => 'ପାସୱାର୍ଡ';

  @override
  String get passwordFieldObscureTextButtonSemanticsLabel => 'ପାସୱାର୍ଡ ଲୁଚାନ୍ତୁ';

  @override
  String get passwordFieldUnobscureTextButtonSemanticsLabel => 'ପାସୱାର୍ଡ ଦେଖାନ୍ତୁ';

  @override
  String get timeFieldTimeSeparator => ':';

  @override
  String get timeFieldPeriodSeparator => ' ';

  @override
  String get timeFieldSuffix => '';

  @override
  String get timeFieldHint => 'ସମୟ ଚୟନ କରନ୍ତୁ';

  @override
  String get timeFieldInvalidDateError => 'ଅବୈଧ ସମୟ।';
}
