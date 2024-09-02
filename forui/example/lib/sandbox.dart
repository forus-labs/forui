import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/accordion.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FSelectGroupController selectGroupController = FRadioSelectGroupController(value: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAccordion(
            title: 'Is it Accessible?',
            childHeight: 100,
            initiallyExpanded: false,
            onExpanded: () {},
            child: const Text('Yes. It adheres to the WAI-ARIA design pattern', textAlign: TextAlign.left,),
          ),
          FAccordion(
            title: 'Is it Accessible?',
            childHeight: 100,
            initiallyExpanded: false,
            onExpanded: () {},
            child: const Text('Yes. It adheres to the WAI-ARIA design pattern', textAlign: TextAlign.left,),
          ),
          FAccordion(
            title: 'Is it Accessible?',
            childHeight: 100,
            initiallyExpanded: false,
            onExpanded: () {},
            child: const Text('Yes. It adheres to the WAI-ARIA design pattern', textAlign: TextAlign.left,),
          ),
          FAccordion(
            title: 'Is it Accessible?',
            childHeight: 100,
            initiallyExpanded: false,
            onExpanded: () {},
            child: const Text('Yes. It adheres to the WAI-ARIA design pattern', textAlign: TextAlign.left,),
          ),
          FAccordion(
            title: 'Is it Accessible?',
            childHeight: 100,
            initiallyExpanded: false,
            onExpanded: () {},
            child: const Text('Yes. It adheres to the WAI-ARIA design pattern', textAlign: TextAlign.left,),
          ),
          SizedBox(height: 20),
          FTooltip(
            longPressExitDuration: const Duration(seconds: 5000),
            tipBuilder: (context, style, _) => const Text('Add to library'),
            child: FButton(
              style: FButtonStyle.outline,
              onPress: () {},
              label: const Text('Hover'),
            ),
          ),
          const SizedBox(height: 20),
          const FTextField.password(),
        ],
      );
}
