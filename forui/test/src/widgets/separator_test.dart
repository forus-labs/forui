@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../box.dart';

void main() {
  group('FSeparator', () {
    for (final (name, theme, _) in Box.themes) {
      for (final (orientation, value) in [('horizontal', false), ('vertical', true)]) {
        testWidgets('$name - $orientation', (tester) async {
          final children = [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: theme.style.borderRadius,
                border: Border.all(color: theme.colorScheme.secondary),
              ),
            ),
            FSeparator(vertical: value),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: theme.style.borderRadius,
                border: Border.all(color: theme.colorScheme.secondary),
              ),
            ),
          ];

          await tester.pumpWidget(Box(
            data: theme,
            child: value ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
          ));

          await expectLater(
            find.byType(Box),
            matchesGoldenFile('separator/$name-$orientation.png'),
          );
        });
      }
    }
  });
}
