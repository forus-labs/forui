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
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: DefaultTextField(enabled: enabled),
          ),
        ],
      );
}

class DefaultTextField extends StatefulWidget {
  final bool enabled;

  const DefaultTextField({required this.enabled, super.key});

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FTextField(
        controller: _controller,
        enabled: widget.enabled,
        label: const Text('Username'),
        hint: 'JaneDoe',
        description: const Text('Please enter your username.'),
        maxLines: 1,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class EmailTextFieldPage extends SampleScaffold {
  EmailTextFieldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: FTextField.email(
              initialValue: 'jane@doe.com',
            ),
          ),
        ],
      );
}

@RoutePage()
class PasswordTextFieldPage extends SampleScaffold {
  PasswordTextFieldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: FTextField.password(
              initialValue: 'My password',
            ),
          ),
        ],
      );
}

@RoutePage()
class MultilineTextFieldPage extends SampleScaffold {
  MultilineTextFieldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: FTextField.multiline(
              label: Text('Leave a review'),
              maxLines: 4,
            ),
          ),
        ],
      );
}

@RoutePage()
class FormTextFieldPage extends SampleScaffold {
  FormTextFieldPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => const Padding(
        padding: EdgeInsets.all(15.0),
        child: LoginForm(),
      );
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
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
      );
}
