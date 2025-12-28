import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class CheckboxPage extends StatefulSample {
  CheckboxPage({@queryParam super.theme}) : super(maxHeight: 320);

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends StatefulSampleState<CheckboxPage> {
  bool _state = false;

  @override
  Widget sample(BuildContext _) => FCheckbox(
    label: const Text('Accept terms and conditions'),
    description: const Text('You agree to our terms and conditions.'),
    semanticsLabel: 'Accept terms and conditions',
    value: _state,
    onChange: (value) => setState(() => _state = value),
  );
}

@RoutePage()
class DisabledCheckboxPage extends StatefulSample {
  DisabledCheckboxPage({@queryParam super.theme}) : super(maxHeight: 320);

  @override
  State<DisabledCheckboxPage> createState() => _DisabledCheckboxPageState();
}

class _DisabledCheckboxPageState extends StatefulSampleState<DisabledCheckboxPage> {
  bool _state = true;

  @override
  Widget sample(BuildContext _) => FCheckbox(
    label: const Text('Accept terms and conditions'),
    description: const Text('You agree to our terms and conditions.'),
    semanticsLabel: 'Accept terms and conditions',
    value: _state,
    onChange: (value) => setState(() => _state = value),
    // {@highlight}
    enabled: false,
    // {@endhighlight}
  );
}

@RoutePage()
class ErrorCheckboxPage extends StatefulSample {
  ErrorCheckboxPage({@queryParam super.theme}) : super(maxHeight: 320);

  @override
  State<ErrorCheckboxPage> createState() => _ErrorCheckboxPageState();
}

class _ErrorCheckboxPageState extends StatefulSampleState<ErrorCheckboxPage> {
  bool _state = false;

  @override
  Widget sample(BuildContext _) => FCheckbox(
    label: const Text('Accept terms and conditions'),
    description: const Text('You agree to our terms and conditions.'),
    // {@highlight}
    error: const Text('Please accept the terms and conditions.'),
    // {@endhighlight}
    semanticsLabel: 'Accept terms and conditions',
    value: _state,
    onChange: (value) => setState(() => _state = value),
  );
}

@RoutePage()
class RawCheckboxPage extends StatefulSample {
  RawCheckboxPage({@queryParam super.theme});

  @override
  State<RawCheckboxPage> createState() => _RawCheckboxPageState();
}

class _RawCheckboxPageState extends StatefulSampleState<RawCheckboxPage> {
  bool _state = false;

  @override
  Widget sample(BuildContext _) => FCheckbox(value: _state, onChange: (value) => setState(() => _state = value));
}

@RoutePage()
class FormCheckboxPage extends StatefulSample {
  FormCheckboxPage({@queryParam super.theme, super.top = 20});

  @override
  State<FormCheckboxPage> createState() => _FormCheckboxPageState();
}

class _FormCheckboxPageState extends StatefulSampleState<FormCheckboxPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext _) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        FTextFormField.email(
          hint: 'janedoe@foruslabs.com',
          validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
        ),
        const SizedBox(height: 12),
        FTextFormField.password(
          validator: (value) => 8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
        ),
        const SizedBox(height: 15),
        FormField(
          initialValue: false,
          onSaved: (value) {
            // Save values somewhere.
          },
          validator: (value) => (value ?? false) ? null : 'Please accept the terms and conditions.',
          builder: (state) => FCheckbox(
            label: const Text('Accept terms and conditions'),
            description: const Text('You agree to our terms and conditions.'),
            error: state.errorText == null ? null : Text(state.errorText!),
            value: state.value ?? false,
            onChange: (value) => state.didChange(value),
          ),
        ),
        const SizedBox(height: 20),
        FButton(
          child: const Text('Register'),
          onPress: () {
            if (!_key.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _key.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );
}
