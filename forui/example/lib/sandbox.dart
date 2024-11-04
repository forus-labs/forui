import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  bool value = false;
  FRadioSelectGroupController<String> selectGroupController = FRadioSelectGroupController();
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => const Column();

  @override
  void dispose() {
    controller.dispose();
    selectGroupController.dispose();
    super.dispose();
  }
}