import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class LinearProgressPage extends StatefulSample {
  LinearProgressPage({@queryParam super.theme});

  @override
  State<LinearProgressPage> createState() => _LinearProgressPageState();
}

class _LinearProgressPageState extends StatefulSampleState<LinearProgressPage> {
  @override
  Widget sample(BuildContext context) => const FProgress();
}

@RoutePage()
class DeterminateLinearProgressPage extends StatefulSample {
  DeterminateLinearProgressPage({@queryParam super.theme});

  @override
  State<DeterminateLinearProgressPage> createState() => _DeterminateLinearProgressPageState();
}

class _DeterminateLinearProgressPageState extends StatefulSampleState<DeterminateLinearProgressPage> {
  late Timer timer;
  double value = 0.2;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 800), () => setState(() => value = 0.7));
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 20,
    children: [
      FProgress(value: value),
      FButton(
        child: const Text('Reset'),
        onPress:
            () => setState(() {
              value = 0.2;
              timer.cancel();
              timer = Timer(const Duration(milliseconds: 800), () => setState(() => value = 0.7));
            }),
      ),
    ],
  );

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

@RoutePage()
class CircularProgressPage extends StatefulSample {
  CircularProgressPage({@queryParam super.theme});

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends StatefulSampleState<CircularProgressPage> {
  @override
  Widget sample(BuildContext context) =>
      FProgress.circularIcon(style: widget.theme.progressStyles.circularIconProgressStyle);
}
