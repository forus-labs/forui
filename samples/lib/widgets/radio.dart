import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class RadioPage extends SampleScaffold {
  RadioPage({@queryParam super.theme});

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 290),
            child: FRadio(
              label: const Text('Default'),
              description: const Text('The description of the default option.'),
              value: true,
              onChange: (value) {},
            ),
          ),
        ],
      );
}
