import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/date_field/field/date_field_controller.dart';
import '../../../test_scaffold.dart';

final _date = DateTime(2024, 12, 25);

// We use a widget to load the locales since Flutter and default intl might have different mappings.
void main() {
  for (final locale in FLocalizations.supportedLocales.where((locale) => !scriptNumerals.contains(locale.toString()))) {
    testWidgets('split parts - $locale', (tester) async {
      late List<String> parts;
      late String joined;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: Builder(
            builder: (context) {
              final selector = DateSelector(FLocalizations.of(context)!);

              parts = selector.split(DateFormat.yMd(locale.toString()).format(_date));
              joined = selector.join(parts);

              return const Text('');
            },
          ),
        ),
      );

      expect(parts, unorderedEquals(['2024', '12', '25']));
      expect(joined, DateFormat.yMd(locale.toString()).format(_date));
    });
  }
}
