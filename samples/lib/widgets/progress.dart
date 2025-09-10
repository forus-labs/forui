import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ProgressPage extends Sample {
  ProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const FProgress();
}

@RoutePage()
class DeterminateProgressPage extends StatefulSample {
  DeterminateProgressPage({@queryParam super.theme});

  @override
  State<DeterminateProgressPage> createState() => _DeterminateProgressPageState();
}

class _DeterminateProgressPageState extends StatefulSampleState<DeterminateProgressPage> {
  late Timer timer;
  double value = 0.2;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 1), () => setState(() => value = 0.7));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 20,
    children: [
      FDeterminateProgress(value: value),
      FButton(
        child: const Text('Reset'),
        onPress: () => setState(() {
          value = 0.2;
          timer.cancel();
          timer = Timer(const Duration(seconds: 1), () => setState(() => value = 0.7));
        }),
      ),
    ],
  );
}

@RoutePage()
class CircularProgressPage extends Sample {
  CircularProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 25,
    children: [FCircularProgress(), FCircularProgress.loader(), FCircularProgress.pinwheel()],
  );
}
