import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

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
  State<CheckboxPage> createState() => _CheckboxState();
}

class _CheckboxState extends StatefulSampleState<CheckboxPage> {
  bool state = false;

  @override
  void initState() {
    super.initState();
    state = widget.initialValue;
  }

  @override
  Widget sample(BuildContext context) => FCheckbox(
    label: const Text('Accept terms and conditions'),
    description: const Text('You agree to our terms and conditions.'),
    error: widget.error != null ? Text(widget.error!) : null,
    semanticLabel: 'Accept terms and conditions',
    value: state,
    onChange: (value) => setState(() => state = value),
    enabled: widget.enabled,
  );
}

@RoutePage()
class RawCheckboxPage extends StatefulSample {
  final bool enabled;

  RawCheckboxPage({
    @queryParam super.theme,
    @queryParam this.enabled = true,
  });

  @override
  State<RawCheckboxPage> createState() => _RawCheckboxState();
}

class _RawCheckboxState extends StatefulSampleState<RawCheckboxPage> {
  bool state = false;

  @override
  Widget sample(BuildContext context) => FCheckbox(
        value: state,
        onChange: (value) => setState(() => state = value),
        enabled: widget.enabled,
      );
}

@RoutePage()
class FormCheckboxPage extends StatefulSample {
  FormCheckboxPage({
    @queryParam super.theme,
  });

  @override
  State<FormCheckboxPage> createState() => _FormCheckboxState();
}

class _FormCheckboxState extends StatefulSampleState<FormCheckboxPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FTextField.email(
                hint: 'janedoe@foruslabs.com',
                validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
              ),
              const SizedBox(height: 12),
              FTextField.password(
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
                  error: state.errorText != null ? Text(state.errorText!) : null,
                  value: state.value ?? false,
                  onChange: (value) => state.didChange(value),
                ),
              ),
              const SizedBox(height: 20),
              FButton(
                label: const Text('Register'),
                onPress: () {
                  if (!_formKey.currentState!.validate()) {
                    // Handle errors here.
                    return;
                  }

                  _formKey.currentState!.save();
                  // Do something.
                },
              ),
            ],
          ),
        ),
      );
}
