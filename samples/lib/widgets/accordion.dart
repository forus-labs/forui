import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

final controllers = {
  'default': FAccordionController(),
  'radio': FRadioAccordionController(),
};

@RoutePage()
class AccordionPage extends SampleScaffold {
  final FAccordionController controller;

  AccordionPage({
    @queryParam super.theme,
    @queryParam String controller = 'default',
  }) : controller = controllers[controller] ?? FRadioAccordionController();

  @override
  Widget child(BuildContext context) => Column(
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
                title: const Text('Is it Styled?'),
                initiallyExpanded: true,
                child: const Text(
                  "Yes. It comes with default styles that matches the other components' aesthetics",
                ),
              ),
              FAccordionItem(
                title: const Text('Is it Animated?'),
                child: const Text(
                  'Yes. It is animated by default, but you can disable it if you prefer',
                ),
              ),
            ],
          ),
        ],
      );
}
