import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TextFieldPage extends Sample {
  TextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => const FTextField(
    label: Text('Username'),
    hint: 'JaneDoe',
    description: Text('Please enter your username.'),
  );
}

@RoutePage()
class DisabledTextFieldPage extends Sample {
  DisabledTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => const FTextField(
    label: Text('Username'),
    hint: 'JaneDoe',
    description: Text('Please enter your username.'),
    // {@highlight}
    enabled: false,
    // {@endhighlight}
  );
}

@RoutePage()
class ClearableTextFieldPage extends Sample {
  ClearableTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTextField(
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
class EmailTextFieldPage extends Sample {
  EmailTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => const FTextField.email(
    control: .managed(initial: TextEditingValue(text: 'jane@doe.com')),
  );
}

@RoutePage()
class PasswordTextFieldPage extends Sample {
  PasswordTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => FTextField.password(
    control: const .managed(initial: TextEditingValue(text: 'My password')),
  );
}

@RoutePage()
class MultilineTextFieldPage extends Sample {
  MultilineTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => const FTextField.multiline(label: Text('Leave a review'), maxLines: 4);
}
