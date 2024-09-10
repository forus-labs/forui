import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;

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
            controller: FMultiSelectGroupController(min: 1, max: 2, values: {1}),
            items: [
              FSelectGroupItem.checkbox(value: 1, label: const Text('Checkbox 1'), semanticLabel: 'Checkbox 1'),
              FSelectGroupItem.checkbox(value: 2, label: const Text('Checkbox 2'), semanticLabel: 'Checkbox 2'),
              FSelectGroupItem.checkbox(value: 3, label: const Text('Checkbox 3'), semanticLabel: 'Checkbox 3'),
            ],
          ),
          const SizedBox(height: 20),
          FSwitch(
            label: const Text('Switch'),
            description: const Text('Switch Description'),
            value: value,
            onChange: (value) => setState(() => this.value = value),
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
