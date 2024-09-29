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
  Widget build(BuildContext context) {
    final sliderStyle = FThemes.zinc.light.sliderStyles.verticalStyle.enabledStyle;
    // final positive = sliderStyle.markStyle.copyWith(labelOffset: 1, labelAnchor: Alignment.topCenter);
    // final negative = sliderStyle.markStyle.copyWith(labelOffset: -1, labelAnchor: Alignment.bottomCenter);
    // final layout = Layout.ltr;
    final positive = sliderStyle.markStyle.copyWith(labelOffset: 1, labelAnchor: Alignment.centerLeft);
    final negative = sliderStyle.markStyle.copyWith(labelOffset: -1, labelAnchor: Alignment.centerRight);
    final layout = Layout.ttb;
    return FSlider(
      controller: FContinuousSliderController.range(selection: FSliderSelection(min: 0.30, max: 0.35)),
      layout: layout,
      enabled: false,
      marks: [
        FSliderMark(value: 0.0, label: Text('0'), style: positive),
        // FSliderMark(value: 0.25, label: Text('25'), tick: false),
        FSliderMark(value: 0.5, label: Text('50'), style: negative),
        // FSliderMark(value: 0.75, label: Text('75'), tick: false),
        // FSliderMark(value: 1.0, label: Text('100')),
      ],
    );
  }
}
