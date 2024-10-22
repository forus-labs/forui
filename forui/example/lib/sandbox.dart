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
  Widget build(BuildContext context) => FAccordion(
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
}
