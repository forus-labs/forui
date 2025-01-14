import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../test_scaffold.dart';

void main() {
  const key = Key('picker');

  setUpAll(initializeDateFormatting);

  for (final (index, (locale, placeholder)) in const [
    (null, 'Pick a date'), // M/d/y
    (Locale('en', 'SG'), 'Pick a date'), // dd/MM/y
    (Locale('hr'), 'Odaberite datum'),
  ].indexed) {
    testWidgets('placeholder - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: const FDatePicker.calendar(),
        ),
      );

      expect(find.text(placeholder), findsOneWidget);
    });
  }
}
