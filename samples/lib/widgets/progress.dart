import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class ProgressPage extends Sample {
  ProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => const FProgress();
}

@RoutePage()
class DeterminateProgressPage extends StatefulSample {
  DeterminateProgressPage({@queryParam super.theme});

  @override
  State<DeterminateProgressPage> createState() => _DeterminateProgressPageState();
}

class _DeterminateProgressPageState extends StatefulSampleState<DeterminateProgressPage> {
  late Timer _timer = Timer(const Duration(seconds: 1), () => setState(() => _value = 0.7));
  double _value = 0.2;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget sample(BuildContext _) => Column(
    mainAxisAlignment: .center,
    spacing: 20,
    children: [
      FDeterminateProgress(value: _value),
      FButton(
        child: const Text('Reset'),
        onPress: () => setState(() {
          _value = 0.2;
          _timer.cancel();
          _timer = Timer(const Duration(seconds: 1), () => setState(() => _value = 0.7));
        }),
      ),
    ],
  );
}

@RoutePage()
class CircularProgressPage extends Sample {
  CircularProgressPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext _) => const Row(
    mainAxisAlignment: .center,
    spacing: 25,
    children: [FCircularProgress(), FCircularProgress.loader(), FCircularProgress.pinwheel()],
  );
}
