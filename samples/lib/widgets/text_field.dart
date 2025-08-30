import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TextFieldPage extends Sample {
  final bool enabled;

  TextFieldPage({@queryParam super.theme, @queryParam this.enabled = false});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField(
      enabled: enabled,
      label: const Text('Username'),
      hint: 'JaneDoe',
      description: const Text('Please enter your username.'),
    ),
  );
}

@RoutePage()
class ClearableTextFieldPage extends StatefulSample {
  ClearableTextFieldPage({@queryParam super.theme});

  @override
  State<ClearableTextFieldPage> createState() => ClearableTextFieldState();
}

class ClearableTextFieldState extends StatefulSampleState<ClearableTextFieldPage> {
  late final TextEditingController _controller = TextEditingController(text: 'MyUsername');

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField(
      controller: _controller,
      label: const Text('Username'),
      hint: 'JaneDoe',
      description: const Text('Please enter your username.'),
      clearable: (value) => value.text.isNotEmpty,
    ),
  );
}

@RoutePage()
class EmailTextFieldPage extends Sample {
  EmailTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField.email(initialText: 'jane@doe.com'),
  );
}

@RoutePage()
class PasswordTextFieldPage extends Sample {
  PasswordTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField.password(initialText: 'My password', obscuringCharacter: '*'),
  );
}

@RoutePage()
class MultilineTextFieldPage extends Sample {
  MultilineTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField.multiline(label: Text('Leave a review'), maxLines: 4),
  );
}
