import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class CheckboxPage extends SampleScaffold {
  final bool initialValue;
  final bool enabled;
  final String? error;

  CheckboxPage({
    @queryParam super.theme,
    @queryParam this.initialValue = false,
    @queryParam this.enabled = true,
    @queryParam this.error,
  });

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 290),
            child: _Checkbox(
              initialValue: initialValue,
              enabled: enabled,
              error: error,
            ),
          ),
        ],
      );
}

class _Checkbox extends StatefulWidget {
  final bool initialValue;
  final bool enabled;
  final String? error;

  const _Checkbox({
    required this.initialValue,
    required this.enabled,
    this.error,
  });

  @override
  State<_Checkbox> createState() => _CheckboxState();
}

class _CheckboxState extends State<_Checkbox> {
  bool state = false;

  @override
  void initState() {
    super.initState();
    state = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => FCheckbox(
        label: const Text('Accept terms and conditions'),
        description: const Text('You agree to our terms and conditions.'),
        error: widget.error != null ? Text(widget.error!) : null,
        semanticLabel: 'Accept terms and conditions',
        value: state,
        onChange: (value) {
          setState(() => state = value);
        },
        enabled: widget.enabled,
      );
}

@RoutePage()
class RawCheckboxPage extends SampleScaffold {
  final bool enabled;

  RawCheckboxPage({
    @queryParam super.theme,
    @queryParam this.enabled = true,
  });

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: _RawCheckbox(enabled: enabled),
          ),
        ],
      );
}

class _RawCheckbox extends StatefulWidget {
  final bool enabled;

  const _RawCheckbox({required this.enabled});

  @override
  State<_RawCheckbox> createState() => _RawCheckboxState();
}

class _RawCheckboxState extends State<_RawCheckbox> {
  bool state = false;

  @override
  Widget build(BuildContext context) => FCheckbox(
        value: state,
        onChange: (value) {
          setState(() => state = value);
        },
        enabled: widget.enabled,
      );
}

@RoutePage()
class FormCheckboxPage extends SampleScaffold {
  FormCheckboxPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
        padding: EdgeInsets.all(15.0),
        child: RegisterForm(),
      );
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
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
                onChange: (value) {
                  state.didChange(value);
                },
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
      );
}
