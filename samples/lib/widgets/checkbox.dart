import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class CheckboxPage extends StatefulSample {
  final bool initialValue;
  final bool enabled;
  final String? error;

  CheckboxPage({
    @queryParam super.theme,
    @queryParam this.initialValue = false,
    @queryParam this.enabled = true,
    @queryParam this.error,
    super.maxWidth = 320,
  });

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends StatefulSampleState<CheckboxPage> {
  late bool _state = widget.initialValue;

  @override
  Widget sample(BuildContext context) => FCheckbox(
    label: const Text('Accept terms and conditions'),
    description: const Text('You agree to our terms and conditions.'),
    error: widget.error == null ? null : Text(widget.error!),
    semanticsLabel: 'Accept terms and conditions',
    value: _state,
    onChange: (value) => setState(() => _state = value),
    enabled: widget.enabled,
  );
}

@RoutePage()
class RawCheckboxPage extends StatefulSample {
  final bool enabled;

  RawCheckboxPage({@queryParam super.theme, @queryParam this.enabled = true});

  @override
  State<RawCheckboxPage> createState() => _RawCheckboxPageState();
}

class _RawCheckboxPageState extends StatefulSampleState<RawCheckboxPage> {
  bool _state = false;

  @override
  Widget sample(BuildContext context) =>
      FCheckbox(value: _state, onChange: (value) => setState(() => _state = value), enabled: widget.enabled);
}

@RoutePage()
class FormCheckboxPage extends StatefulSample {
  FormCheckboxPage({@queryParam super.theme});

  @override
  State<FormCheckboxPage> createState() => _FormCheckboxPageState();
}

class _FormCheckboxPageState extends StatefulSampleState<FormCheckboxPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .all(15.0),
    child: Form(
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
    ),
  );
}
