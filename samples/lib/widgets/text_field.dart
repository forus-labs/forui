import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class TextFieldPage extends SampleScaffold {
  final bool enabled;

  TextFieldPage({
    @queryParam super.theme,
    @queryParam this.enabled = false,
  });

  @override
  Widget child(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical:30),
    child: FTextField(
      enabled: enabled,
      label: 'Email',
      hint: 'john@doe.com',
    ),
  );
}

@RoutePage()
class PasswordTextFieldPage extends SampleScaffold {

  PasswordTextFieldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical:30),
    child: FTextField.password(
      controller: TextEditingController(text: 'My password'),
      label: 'Password',
    ),
  );
}

@RoutePage()
class MultilineTextFieldPage extends SampleScaffold {

  MultilineTextFieldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical:30),
    child: FTextField.multiline(
      label: 'Leave a review',
    ),
  );
}
