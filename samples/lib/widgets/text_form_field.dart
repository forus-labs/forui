import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TextFormFieldPage extends StatefulSample {
  TextFormFieldPage({@queryParam super.theme});

  @override
  State<TextFormFieldPage> createState() => _FormFieldState();
}

class _FormFieldState extends StatefulSampleState<TextFormFieldPage> {
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
          FTextFormField.email(
            controller: _emailController,
            hint: 'janedoe@foruslabs.com',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
          ),
          const SizedBox(height: 10),
          FTextFormField.password(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => 8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
          ),
          const SizedBox(height: 20),
          FButton(
            child: const Text('Login'),
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
