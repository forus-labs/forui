import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../test_scaffold.dart';

void main() {
  group('FScaffold', () {
    testWidgets('apply IconTheme from FStyle', (tester) async {
      const testIconColor = Colors.red;
      const testIconSize = 30.0;
      
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemeData(
            colors: FThemes.zinc.light.colors,
            typography: FThemes.zinc.light.typography,
            style: FThemes.zinc.light.style.copyWith(
              iconStyle: const IconThemeData(
                color: testIconColor,
                size: testIconSize,
              ),
            ),
          ),
          child: const FScaffold(
            child: Center(
              child: Icon(FIcons.star),
            ),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget);

      // Verify IconTheme properties.
      final iconTheme = IconTheme.of(tester.element(iconFinder));
      expect(iconTheme.color, testIconColor);
      expect(iconTheme.size, testIconSize);
    });
  });
}
