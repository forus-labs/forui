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
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FTextField(
            rawHelp: Text('Some error text'),
          ),
          const SizedBox(height: 10),
          FTextField(rawHelp: Text('Some error text', style: context.theme.textFieldStyle.enabled.footer,)),
          const SizedBox(height: 10),
          Text('Some error text', style: context.theme.textFieldStyle.enabled.footer,),
          FTextField(help: 'Some error text', textAlign: TextAlign.start,),
          const SizedBox(height: 10),
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
        ],
      ),
    );
}
