import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  bool value = false;
  FSelectGroupController selectGroupController = FRadioSelectGroupController(value: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FTextField.email(
            autovalidateMode: AutovalidateMode.always,
            description: const Text('Description'),
            validator: (value) => value?.length == 5 ? 'Error message' : null,
          ),
          const SizedBox(height: 20),
          const FTextField.password(),
        ],
      );
}
