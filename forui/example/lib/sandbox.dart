import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FTabController c;
  final controller = ValueNotifier<bool>(false);
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    c = FTabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  void dispose() {
    c.dispose();
    controller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        FButton(style: FButtonStyle.primary(), onPress: () {}, child: Text('Primary')),
        FButton(style: FButtonStyle.secondary(), onPress: () {}, child: Text('Secondary')),
        FButton(style: FButtonStyle.ghost(), onPress: () {}, child: Text('Ghost')),
        FButton(style: FButtonStyle.destructive(), onPress: () {}, child: Text('Destructive')),
        FTextField.password(label: Text('FTextField Password'), hint: 'Enter password'),
        SizedBox(height: 20),

        // Test FTextFormField.password
        FTextFormField.password(label: Text('FTextFormField Password'), hint: 'Enter password'),

        SizedBox(height: 20),

        // Test with custom obscureText notifier
        FTextField.password(
          label: Text('FTextField Password (starts visible)'),
          hint: 'Enter password',
          obscureTextController: controller,
        ),
        SizedBox(height: 20),
        FTextFormField.password(
          label: Text('FTextFormField Password (starts visible)'),
          hint: 'Enter password',
          obscureTextController: controller,
        ),
      ],
    );
  }
}
