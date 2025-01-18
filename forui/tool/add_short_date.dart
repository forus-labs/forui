// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

final _pattern = RegExp(r'f_([\w_]+)\.arb');
final _separator = RegExp('[A-z]+([^A-z]+)[A-z]+');
final _suffix = RegExp('[A-z]+[^A-z]+[A-z]+[^A-z]+[A-z]+(.*)');

void main() {
  initializeDateFormatting();
  for (final source in Directory('lib/l10n').listSync().whereType<File>().toList()
    ..sort((a, b) => a.path.compareTo(b.path))) {
    final locale = _pattern.firstMatch(source.path)?.group(1);
    if (locale == 'en') {
      continue;
    }

    final arb = json.decode(source.readAsStringSync());

    final pattern = DateFormat.yMd(locale).pattern!.replaceAll("'", '');
    final separator = _separator.firstMatch(pattern)!.group(1); // assume that all separators are the same.
    final suffix = _suffix.firstMatch(pattern)!.group(1);

    arb['shortDateSeparator'] = separator;
    arb['shortDateSuffix'] = suffix;

    source.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(arb));
  }
}
