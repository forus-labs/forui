import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FTile(
          prefixIcon: Icon(FIcons.bell),
          title: const Text('Home'),
          suffixIcon: Icon(FIcons.chevronRight),
          // onPress: () {},
        ),
      ],
    );
  }
}
