import 'package:flutter/cupertino.dart';
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
          data: FThemes.zinc.dark,
          child: Scaffold(
            backgroundColor: FThemes.zinc.dark.colorScheme.background,
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
        TextField(
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 5),
        FTextField(
          label: 'Email',
          hint: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
      ]
    );
  }
}
