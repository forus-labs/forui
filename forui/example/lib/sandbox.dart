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
  Widget build(BuildContext context) => Column(
        children: [
          FAccordion(
            controller: FAccordionController(max: 2),
            items: [
              FAccordionItem(
                title: const Text('Title 1'),
                initiallyExpanded: true,
                child: const Text(
                  'Yes. It adheres to the WAI-ARIA design pattern, wfihwe fdhfiwf dfhwiodf dfwhoif',
                ),
              ),
              FAccordionItem(
                title: const Text('Title 2'),
                child: Container(
                  width: 100,
                  color: Colors.yellow,
                  child: const Text(
                    'Yes. It adheres to the WAI-ARIA design pattern geg wjfiweo dfjiowjf dfjio',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              FAccordionItem(
                title: const Text('Title 3'),
                child: const Text(
                  'Yes. It adheres to the WAI-ARIA design pattern',
                  textAlign: TextAlign.left,
                ),
              ),
              FAccordionItem(
                title: const Text('Title 4'),
                child: const Text(
                  'Yes. It adheres to the WAI-ARIA design pattern',
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
          FButton(onPress: () {}, label: const Text('hi')),
        ],
      );
}
