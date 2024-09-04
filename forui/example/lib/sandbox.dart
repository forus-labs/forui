import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FSelectGroup(
            label: const Text('Select Group'),
            description: const Text('Select Group Description'),
            controller: FRadioSelectGroupController(value: 1),
            items: [
              FCheckbox.item(value: 1, label: const Text('Checkbox 1'), semanticLabel: 'Checkbox 1'),
              FCheckbox.item(value: 2, label: const Text('Checkbox 2'), semanticLabel: 'Checkbox 2'),
              FCheckbox.item(value: 3, label: const Text('Checkbox 3'), semanticLabel: 'Checkbox 3'),
            ],
          ),
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
          )
        ],
      );
}
