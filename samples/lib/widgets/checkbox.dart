import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class CheckboxPage extends SampleScaffold {
  final bool enabled;
  final String? forceErrorText;

  CheckboxPage({
    @queryParam super.theme,
    @queryParam this.enabled = true,
    @queryParam this.forceErrorText,
  });

  @override
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 290),
            child: FCheckbox(
              label: const Text('Accept terms and conditions'),
              description: const Text('You agree to our terms and conditions.'),
              semanticLabel: 'Accept terms and conditions',
              onChange: (value) {}, // Do something.
              forceErrorText: forceErrorText,
              enabled: enabled,
            ),
          ),
        ],
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
        child: FCheckbox(
          onChange: (value) {}, // Do something.
          enabled: enabled,
        ),
      ),
    ],
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
            FCheckbox(
              label: const Text('Accept terms and conditions'),
              description: const Text('You agree to our terms and conditions.'),
              validator: (value) => (value ?? false) ? null : 'Please accept the terms and conditions.',
            ),
            const SizedBox(height: 20),
            FButton(
              label: const Text('Register'),
              onPress: () {
                if (!_formKey.currentState!.validate()) {
                  // Handle errors here.
                  return;
                }
                // Do something.
              },
            ),
          ],
        ),
      );
}
