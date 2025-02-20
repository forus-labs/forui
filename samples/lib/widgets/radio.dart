import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class RadioPage extends Sample {
  RadioPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 290),
    child: FRadio(
      label: const Text('Default'),
      description: const Text('The description of the default option.'),
      value: true,
      onChange: (value) {},
    ),
  );
}
