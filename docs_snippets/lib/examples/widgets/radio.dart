import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class RadioPage extends StatefulExample {
  RadioPage({@queryParam super.theme});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends StatefulExampleState<RadioPage> {
  bool _value = true;

  @override
  Widget example(BuildContext _) => FRadio(
    label: const Text('Default'),
    description: const Text('The description of the default option.'),
    value: _value,
    onChange: (value) => setState(() => _value = value),
  );
}
