import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FSelectGroupController selectGroupController = FRadioSelectGroupController(value: 1);
  FAccordionController controller = FAccordionController(min: 1, max: 3);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FAccordion(
      items: [
        FAccordionItem(
          initiallyExpanded: true,
          title: const Text('Title'),
          child: const ColoredBox(
            color: Colors.yellow,
            child: SizedBox.square(
              dimension: 50,
            ),
          ),
        ),
      ],
    );

    final actions = [
      FButton(style: FButtonStyle.outline, label: const Text('Cancel'), onPress: () => Navigator.of(context).pop()),
      FButton(label: const Text('Continue'), onPress: () => Navigator.of(context).pop()),
    ];

    final style = context.theme.dialogStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntrinsicWidth(
          child: FButton(
            label: const Text('Show Dialog'),
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) {
                final direction = MediaQuery.sizeOf(context).width < 600 ? Axis.vertical : Axis.horizontal;
                return FDialog(
                  style: style,
                  direction: direction,
                  title: const Text('Are you absolutely sure?'),
                  body: const Text(
                    'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                  ),
                  actions: actions,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
