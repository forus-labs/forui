import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class RadioPage extends StatefulSample {
  RadioPage({@queryParam super.theme});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends StatefulSampleState<RadioPage> {
  bool _value = true;

  @override
  Widget sample(BuildContext _) => FRadio(
    label: const Text('Default'),
    description: const Text('The description of the default option.'),
    value: _value,
    onChange: (value) => setState(() => _value = value),
  );
}
