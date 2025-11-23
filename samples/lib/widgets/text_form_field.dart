import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TextFormFieldPage extends StatefulSample {
  TextFormFieldPage({String? theme}) : super(theme: theme ?? 'zinc-light');

  @override
  State<TextFormFieldPage> createState() => _TextFormFieldPageState();
}

class _TextFormFieldPageState extends StatefulSampleState<TextFormFieldPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .all(15.0),
    child: Form(
      key: _key,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          FTextFormField.email(
            controller: _emailController,
            hint: 'janedoe@foruslabs.com',
            autovalidateMode: .onUserInteraction,
            validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
          ),
          const SizedBox(height: 10),
          FTextFormField.password(
            controller: _passwordController,
            autovalidateMode: .onUserInteraction,
            validator: (value) => 8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
          ),
          const SizedBox(height: 20),
          FButton(
            child: const Text('Login'),
            onPress: () {
              if (!_key.currentState!.validate()) {
                return; // Form is invalid.
              }

              // Form is valid, do something.
            },
          ),
        ],
      ),
    ),
  );
}
