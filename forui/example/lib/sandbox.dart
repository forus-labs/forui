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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAccordion(
            items: [
              const FAccordionItem(
                title:  Text('Title 1'),
                initiallyExpanded: true,
                child:  Text(
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
              const FAccordionItem(
                title:  Text('Title 3'),
                child:  Text(
                  'Yes. It adheres to the WAI-ARIA design pattern',
                  textAlign: TextAlign.left,
                ),
              ),
              const FAccordionItem(
                title:  Text('Title 4'),
                child:  Text(
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
