import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

/// The application widget.
class Application extends StatelessWidget {
  /// Creates an application widget.
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: FTheme(
          data: FThemes.zinc.light,
          child: Scaffold(
            backgroundColor: FThemes.zinc.light.colorScheme.background,
            body: const Padding(
              padding: EdgeInsets.all(16),
              child: ExampleWidget(),
            ),
          ),
        ),
      );
}

/// The example widget.
class ExampleWidget extends StatelessWidget {
  /// Creates an example widget.
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final font = context.theme.font;

    return ListView(
      children: [
        FHeader(
          title: 'Notification - A very long message',
          actions: [
            FHeaderAction(
              icon: FAssets.icons.alarmClock,
              onPress: null,
            ),
            FHeaderAction(
              icon: FAssets.icons.plus,
              onPress: () {},
            ),
          ],
        ),
        const SizedBox(height: 40),
        FCard(
          title: 'Notification',
          subtitle: 'You have 3 unread messages.',
          child: const Text(
            'Material default font size of 14. (text-sm)',
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: FBadge(label: 'New'),
        ),
        Text(
          'text-xs',
          style: TextStyle(fontSize: font.xs).withFont(font),
        ),
        Text(
          'text-sm',
          style: TextStyle(fontSize: font.sm).withFont(font),
        ),
        Text(
          'text-base',
          style: TextStyle(fontSize: font.base).withFont(font),
        ),
        Text(
          'text-lg',
          style: TextStyle(fontSize: font.lg).withFont(font),
        ),
      ],
    );
  }
}
