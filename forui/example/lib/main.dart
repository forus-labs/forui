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
            body: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExampleWidget(),
              ],
            ),
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

class _ExampleWidgetState extends State<ExampleWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FButton(
            design: FButtonVariant.destructive,
            labelText: 'Delete?',
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                alignment: FDialogAlignment.horizontal,
                title: 'Are you absolutely sure?',
                body: 'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                actions: [
                  FButton(design: FButtonVariant.outlined, labelText: 'Cancel', onPress: () {
                    Navigator.of(context).pop();
                  }),
                  FButton(labelText: 'Continue', onPress: () {}),
                ],
              ),
            ),
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
        FTabs(
          tabs: [
            MapEntry(
              'Account',
              FTabContent(
                title: 'Account',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.red,
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
            MapEntry(
              'Password',
              FTabContent(
                title: 'Password',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
        )
      ],
    );
}
