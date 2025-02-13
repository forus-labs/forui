import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

final controllers = {
  'default': FAccordionController(),
  'default-max': FAccordionController(max: 2),
  'radio': FAccordionController.radio(),
};

@RoutePage()
class AccordionPage extends Sample {
  final FAccordionController controller;

  AccordionPage({@queryParam super.theme, @queryParam String controller = 'default'})
    : controller = controllers[controller] ?? FAccordionController();

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FAccordion(
        controller: controller,
        items: [
          FAccordionItem(
            title: const Text('Is it accessible?'),
            child: const Text('Yes. It adheres to the WAI-ARIA design pattern.'),
          ),
          FAccordionItem(
            initiallyExpanded: true,
            title: const Text('Is it Styled?'),
            child: const Text("Yes. It comes with default styles that matches the other components' aesthetics"),
          ),
          FAccordionItem(
            title: const Text('Is it Animated?'),
            child: const Text('Yes. It is animated by default, but you can disable it if you prefer'),
          ),
        ],
      ),
    ],
  );
}
