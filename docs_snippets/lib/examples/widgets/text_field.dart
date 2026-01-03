import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TextFieldPage extends Example {
  TextFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) =>
      const FTextField(label: Text('Username'), hint: 'JaneDoe', description: Text('Please enter your username.'));
}

@RoutePage()
class DisabledTextFieldPage extends Example {
  DisabledTextFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FTextField(
    label: Text('Username'),
    hint: 'JaneDoe',
    description: Text('Please enter your username.'),
    // {@highlight}
    enabled: false,
    // {@endhighlight}
  );
}

@RoutePage()
class ClearableTextFieldPage extends Example {
  ClearableTextFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTextField(
    control: const .managed(initial: TextEditingValue(text: 'MyUsername')),
    label: const Text('Username'),
    hint: 'JaneDoe',
    description: const Text('Please enter your username.'),
    // {@highlight}
    clearable: (value) => value.text.isNotEmpty,
    // {@endhighlight}
  );
}

@RoutePage()
class EmailTextFieldPage extends Example {
  EmailTextFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FTextField.email(
    control: .managed(initial: TextEditingValue(text: 'jane@doe.com')),
  );
}

@RoutePage()
class PasswordTextFieldPage extends Example {
  PasswordTextFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FTextField.password(
    control: const .managed(initial: TextEditingValue(text: 'My password')),
  );
}

@RoutePage()
class MultilineTextFieldPage extends Example {
  MultilineTextFieldPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FTextField.multiline(label: Text('Leave a review'), maxLines: 4);
}
