import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: const [
          FCheckbox(
            label: Text('Remember me'),
            description: Text('Remember me on this device.'),
            forceErrorText: 'Please check the box to continue.',
            initialValue: true,
            enabled: false,
          ),
          SizedBox(height: 20),
          FLabel(
            axis: Axis.vertical,
            label: Text('Email'),
            description: Text('Enter your email address.'),
            error: Text('Please enter a valid email address.'),
            state: FLabelState.error,
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.grey),
              child: SizedBox(width: 200, height: 30),
            ),
          ),
          SizedBox(height: 20),
          FLabel(
            axis: Axis.horizontal,
            label: Text('Accept terms and conditions'),
            description: Text('You agree to our terms and conditions.'),
            error: Text('Please accept the terms and conditions.'),
            state: FLabelState.error,
            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.grey),
              child: SizedBox(width: 16, height: 16),
            ),
          ),
        ],
      );
}
