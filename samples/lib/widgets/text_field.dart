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
            child: FTextField(
              enabled: enabled,
              label: const Text('Email'),
              hint: 'john@doe.com',
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
  Widget child(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: FTextField.password(
              controller: TextEditingController(text: 'My password'),
              label: const Text('Password'),
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
  Widget child(BuildContext context) => const LoginForm();
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      children: [
        FTextField.email(
          label: const Text('Email'),
          hint: 'janedoe@foruslabs.com',
          help: const Text(''),
          validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
        ),
        const SizedBox(height: 4),
        FTextField.password(
          label: const Text('Password'),
          hint: '',
          help: const Text(''),
          validator: (value) => (value?.length ?? 0) >= 8 ? null : 'Password must be at least 8 characters long.',
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
          child: FButton(
            rawLabel: const Text('Login'),
            onPress: () => _formKey.currentState!.validate(),
          ),
        )
      ],
    ),
  );
}
