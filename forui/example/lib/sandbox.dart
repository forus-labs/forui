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
        children: [
          FCheckbox(
            label: Text('Remember me'),
            description: Text('Remember me on this device.'),
            initialValue: true,
          ),
        ],
      );
}
