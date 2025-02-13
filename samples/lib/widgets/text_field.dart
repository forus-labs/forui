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
      maxLines: 1,
    ),
  );
}

@RoutePage()
class EmailTextFieldPage extends Sample {
  EmailTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField.email(initialValue: 'jane@doe.com'),
  );
}

@RoutePage()
class PasswordTextFieldPage extends Sample {
  PasswordTextFieldPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: FTextField.password(initialValue: 'My password'),
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

@RoutePage()
class FormTextFieldPage extends StatefulSample {
  FormTextFieldPage({@queryParam super.theme});

  @override
  State<FormTextFieldPage> createState() => _FormFieldState();
}

class _FormFieldState extends StatefulSampleState<FormTextFieldPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FTextField.email(
            controller: _emailController,
            hint: 'janedoe@foruslabs.com',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
          ),
          const SizedBox(height: 10),
          FTextField.password(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
          ),
          const SizedBox(height: 20),
          FButton(
            label: const Text('Login'),
            onPress: () {
              if (!_formKey.currentState!.validate()) {
                return; // Form is invalid.
              }

              // Form is valid, do something.
            },
          ),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
