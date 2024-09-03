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
          const FSwitch(
            label: Text('Accept terms and conditions'),
            description: Text('You agree to our terms and conditions.'),
            semanticLabel: 'Accept terms and conditions',
            enabled: true,
          ),
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
