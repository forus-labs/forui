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
          child: const FScaffold(
            header: FHeader(title: 'Example'),
            content: ExampleWidget(),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FTextField.email(
              hint: 'janedoe@foruslabs.com',
              help: const Text(''),
              validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
            ),
            const SizedBox(height: 4),
            FTextField.password(
              hint: '',
              help: const Text(''),
              validator: (value) => (value?.length ?? 0) >= 8 ? null : 'Password must be at least 8 characters long.',
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: FButton(
                rawLabel: const Text('Login'),
                onPress: () => _formKey.currentState!.validate(),
              ),
            )
          ],
        ),
      ));
}
