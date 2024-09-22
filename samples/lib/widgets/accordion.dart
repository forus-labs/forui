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
            items: const [
              FAccordionItem(
                title:  Text('Is it accessible?'),
                child:  Text('Yes. It adheres to the WAI-ARIA design pattern.'),
              ),
              FAccordionItem(
                title:  Text('Is it Styled?'),
                initiallyExpanded: true,
                child:  Text(
                  "Yes. It comes with default styles that matches the other components' aesthetics",
                ),
              ),
              FAccordionItem(
                title:  Text('Is it Animated?'),
                child:  Text(
                  'Yes. It is animated by default, but you can disable it if you prefer',
                ),
              ),
            ],
          ),
        ],
      );
}
