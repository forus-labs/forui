import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

class Foo extends StatelessWidget {
  final FThemeData data;
  final bool vertical;

   Foo({required this.data, required this.vertical, super.key});

  @override
  Widget build(BuildContext context) {
    final children = [
      FCard(
        title: 'Notification',
        subtitle: 'You have 3 unread messages.',
      ),
      FSeparator(vertical: vertical),
      FCard(
        title: 'Notification',
        subtitle: 'You have 3 unread messages.',
      ),
    ];

    return FTheme(
      data: data,
      textDirection: TextDirection.ltr,
      child: RepaintBoundary(
        child: ColoredBox(
          color: data.colorScheme.background,
          child: vertical ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ) :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
        ),
      ),
    );
  }
}


void main() {
  group('Separator', () {
    for (final MapEntry(key: name, value: theme) in FThemes.all.entries) {
      for (final (orientation, value) in [('horizontal', false), ('vertical', true)]) {
        testWidgets('$name - $orientation', (tester) async {
          await tester.pumpWidget(Foo(
            data: theme,
            vertical: value,
          ));

          await expectLater(
            find.byType(RepaintBoundary),
            matchesGoldenFile('separator/$name-$orientation.png'),
          );
        });
      }
    }
  });
}