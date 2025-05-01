import 'package:flutter/material.dart';

import 'package:forui_example/portal/visualizer.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return const Visualizer();
  }
}
