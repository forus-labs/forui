import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/date_field/field/date_field_controller.dart';
import 'package:intl/intl.dart';

import '../../../test_scaffold.dart';

final _date = DateTime(2024, 12, 25);

void main() {
  testWidgets('remove quotes', (tester) async {
    late String placeholder;

    // We use a widget to load the locales since Flutter and default intl might have different mappings.
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('bg'),
        child: Builder(
          builder: (context) {
            placeholder = DateFieldController(
              FCalendarController.date(),
              FLocalizations.of(context)!,
              context.theme.textFieldStyle,
              2025,
            ).placeholder;

            return const Text('');
          },
        ),
      ),
    );

    expect(placeholder, 'DD.MM.YYYY г.');
  });

  for (final locale in FLocalizations.supportedLocales.where((locale) => !scriptNumerals.contains(locale.toString()))) {
    testWidgets('split parts - $locale', (tester) async {
      late List<String> parts;

      // We use a widget to load the locales since Flutter and default intl might have different mappings.
      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: Builder(
            builder: (context) {
              parts = DateFieldController(
                FCalendarController.date(),
                FLocalizations.of(context)!,
                context.theme.textFieldStyle,
                2025,
              ).split(DateFormat.yMd(locale.toString()).format(_date));

              return const Text('');
            },
          ),
        ),
      );

      expect(parts, unorderedEquals(['2024', '12', '25']));
    });
  }
}
