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
  late WidgetStatesController controller;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    controller = WidgetStatesController();
    textController = TextEditingController()..addListener(() {});
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
        children: [
          // FCard(title: 'Email'),
          FTextField(
            // enabled: false,
            labelText: 'Email',
            hintText: 'hannah@foruslabs.com',
            helpText: 'This is your public display name.',
            // errorText: 'Error',
            // statesController: controller,
            controller: textController,
          ),
          // const TextField(
          //   // enabled: false,
          //   decoration: InputDecoration(
          //     labelText: 'Material TextField',
          //     hintText: 'Email',
          //     errorText: 'Error text',
          //   ),
          // ),
        ],
      ),
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    textController.dispose();
  }
}
