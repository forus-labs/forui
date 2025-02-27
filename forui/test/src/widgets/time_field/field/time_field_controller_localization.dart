import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localization.dart';
import 'package:forui/src/widgets/time_field/field/time_field_controller.dart';
import 'package:intl/intl.dart';

import '../../../test_scaffold.dart';

final _date = DateTime(2024, 12, 25, 15, 30);

// We use a widget to load the locales since Flutter and default intl might have different mappings.
void main() {
  testWidgets('remove quotes from special character', (tester) async {
    late String placeholder;
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('fr', 'CA'),
        child: Builder(
          builder: (context) {
            placeholder =
                TimeFieldController(
                  FLocalizations.of(context)!,
                  FTimeFieldController(),
                  DateFormat.jm('fr_CA'),
                  context.theme.textFieldStyle,
                  const FTime(12, 15),
                ).placeholder;

            return const Text('');
          },
        ),
      ),
    );

    expect(placeholder, 'HH h MM');
  });

  testWidgets('remove quotes', (tester) async {
    late String placeholder;
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('bg'),
        child: Builder(
          builder: (context) {
            placeholder =
                TimeFieldController(
                  FLocalizations.of(context)!,
                  FTimeFieldController(),
                  DateFormat.jm('bg'),
                  context.theme.textFieldStyle,
                  const FTime(12, 15),
                ).placeholder;

            return const Text('');
          },
        ),
      ),
    );

    expect(placeholder, 'HH:MM ч.');
  });

  testWidgets('no separator between time and period', (tester) async {
    late String placeholder;
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('zh', 'HK'),
        child: Builder(
          builder: (context) {
            placeholder =
                TimeFieldController(
                  FLocalizations.of(context)!,
                  FTimeFieldController(),
                  DateFormat.jm('zh_HK'),
                  context.theme.textFieldStyle,
                  const FTime(12, 15),
                ).placeholder;

            return const Text('');
          },
        ),
      ),
    );

    expect(placeholder, '--HH:MM');
  });

  group('split parts', () {
    for (final locale in FLocalizations.supportedLocales.where(
      (locale) => !scriptNumerals.contains(locale.toString()),
    )) {
      testWidgets('jm - $locale', (tester) async {
        late List<String> parts;
        late String joined;

        await tester.pumpWidget(
          TestScaffold.app(
            locale: locale,
            child: Builder(
              builder: (context) {
                final controller = TimeFieldController(
                  FLocalizations.of(context)!,
                  FTimeFieldController(),
                  DateFormat.jm(locale.toString()),
                  context.theme.textFieldStyle,
                  const FTime(12, 15),
                );

                parts = controller.selector.split(DateFormat.jm(locale.toString()).format(_date));
                joined = controller.selector.join(parts);

                return const Text('');
              },
            ),
          ),
        );

        expect(parts, anyOf(unorderedEquals(['3', '30', anything]), unorderedEquals(['15', '30'])));
        expect(joined, DateFormat.jm(locale.toString()).format(_date));
      });

      testWidgets('Hm - $locale', (tester) async {
        late List<String> parts;
        late String joined;

        await tester.pumpWidget(
          TestScaffold.app(
            locale: locale,
            child: Builder(
              builder: (context) {
                final controller = TimeFieldController(
                  FLocalizations.of(context)!,
                  FTimeFieldController(),
                  DateFormat.Hm(locale.toString()),
                  context.theme.textFieldStyle,
                  const FTime(12, 15),
                );

                parts = controller.selector.split(DateFormat.Hm(locale.toString()).format(_date));
                joined = controller.selector.join(parts);
                return const Text('');
              },
            ),
          ),
        );

        expect(parts, unorderedEquals(['15', '30']));
        expect(joined, DateFormat.Hm(locale.toString()).format(_date));
      });
    }
  });
}
