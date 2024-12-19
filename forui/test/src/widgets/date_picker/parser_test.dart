import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  initializeDateFormatting();

  (String?, bool) _dd(NumberFormat number, String old, String current) {
    final full = old == 'DD' ? current : '$old$current';
    if (number.tryParse(full) case final day? when 1 <= day && day <= 31) {
      return (number.format(day), 4 <= day);
    }

    return (null, false);
  }


  for (final locale in FLocalizations.supportedLocales) {
    print(DateFormat.yMd(locale.toString()).pattern);
  }

}
