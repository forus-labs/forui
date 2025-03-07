import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:forui/src/widgets/time_field/input/time_parser.dart';
import '../../../test_scaffold.dart';

// This needs to be a separate test suite as Flutter modifies the period. It is AM/PM in intl, and 오전/오후 in Flutter.
void main() {
  for (final (i, (old, current, expected))
      in [
        ('--', '오', ('오-', false)),
        ('오', '전', ('오전', true)),
        ('오', '후', ('오후', true)),
        ('오-', 'A', ('오-', false)),
        ('오-', 'A', ('오-', false)),
        // Replace rather than append
        ('A', '오전', ('오전', true)),
        ('A', '오후', ('오후', true)),
        ('오전', '오', ('오-', false)),
        ('오후', '오', ('오-', false)),
      ].indexed) {
    testWidgets('ko locale - $i', (tester) async {
      await tester.pumpWidget(TestScaffold.app(child: const Text('stub')));
      final ko = Time12Parser(DateFormat.jm('ko')); // a h:mm (오전/오후)

      expect(ko.updatePeriod(old, current), expected);
    });
  }
}
