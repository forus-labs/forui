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
  Widget build(BuildContext context) => FSlider(
      controller: FContinuousSliderController.range(selection: FSliderSelection(min: 0.30, max: 0.35)),
    );
}
