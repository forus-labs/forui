import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class ProgressPage extends SampleScaffold {
  ProgressPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Progress();
}

class Progress extends StatefulWidget {
  @override
  State<Progress> createState() => ProgressState();
}

class ProgressState extends State<Progress> {
  double value = 0.2;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 800), () => setState(() => value = 0.7));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [FProgress(value: value)],
      );
}
