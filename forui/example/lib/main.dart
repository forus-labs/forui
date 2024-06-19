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
            body: const ExampleWidget(),
          ),
        ),
      );
}





class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final font = context.theme.typography;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeArea(
          child: FHeader(
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
          style: TextStyle(fontSize: font.xs).scale(font),
        ),
        Text(
          'text-sm',
          style: TextStyle(fontSize: font.sm).scale(font),
        ),
        Text(
          'text-base',
          style: TextStyle(fontSize: font.base).scale(font),
        ),
        Text(
          'text-lg',
          style: TextStyle(fontSize: font.lg).scale(font),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FTabs(
            tabs: [
              FTabEntry(
                label: 'Account',
                content: FCard(
                  title: 'Account',
                  subtitle: 'Make changes to your account here. Click save when you are done.',
                  child: Column(
                    children: [
                      Container(
                        color: Colors.red,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
              FTabEntry(
                label: 'Password',
                content: FCard(
                  title: 'Password',
                  subtitle: 'Change your password here. After saving, you will be logged out.',
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 100,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
