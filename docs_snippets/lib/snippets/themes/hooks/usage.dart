import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';

class Example extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useFAccordionController();
    return Column(
      mainAxisAlignment: .center,
      children: [
        FAccordion(
          control: .managed(controller: controller),
          children: const [
            FAccordionItem(
              title: Text('Is it accessible?'),
              child: Text('Yes. It adheres to the WAI-ARIA design pattern.'),
            ),
            FAccordionItem(
              initiallyExpanded: true,
              title: Text('Is it Styled?'),
              child: Text("Yes. It comes with default styles that matches the other components' aesthetics"),
            ),
            FAccordionItem(
              title: Text('Is it Animated?'),
              child: Text('Yes. It is animated by default, but you can disable it if you prefer'),
            ),
          ],
        ),
      ],
    );
  }
}
