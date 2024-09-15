import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class AccordionPage extends SampleScaffold {
  AccordionPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FAccordion(
            title: 'Is it Styled?',
            child: Text(
              "Yes. It comes with default styles that matches the other components' aesthetics",
              textAlign: TextAlign.left,
            ),
          ),
          FAccordion(
            title: 'Is it Animated?',
            initiallyExpanded: false,
            child: Text(
              'Yes. It is animated by default, but you can disable it if you prefer',
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
}
