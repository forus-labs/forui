import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ProgressPage extends StatefulSample {
  ProgressPage({
    @queryParam super.theme,
  });

  @override
  State<ProgressPage> createState() => _State();
}

class _State extends StatefulSampleState<ProgressPage> {
  late Timer timer;
  double value = 0.2;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 800), () => setState(() => value = 0.7));
  }

  @override
  Widget sample(BuildContext context) => FProgress(value: value);

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
