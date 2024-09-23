import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FSelectGroupController selectGroupController = FRadioSelectGroupController(value: 1);

  final selected = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FTextField.email(
            autovalidateMode: AutovalidateMode.always,
            description: const Text('Description'),
            validator: (value) => value?.length == 5 ? 'Error message' : null,
          ),
          const SizedBox(height: 20),
          const FTextField.password(),
          FLineCalendar(selected: selected),
          const SizedBox(height: 20),
          FTooltip(
            longPressExitDuration: const Duration(seconds: 5000),
            tipBuilder: (context, style, _) => const Text('Add to library'),
            child: FButton(
              style: FButtonStyle.outline,
              onPress: () {},
              label: const Text('Hover'),
            ),
          ),
          Tooltip(
            message: 'Add to library 2',
            showDuration: const Duration(seconds: 5000),
            child: FButton(
              style: FButtonStyle.outline,
              onPress: () {},
              label: const Text('Hover 2'),
            ),
          ),
        ],
      );
}
