import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class CircularProgressPage extends Example {
  CircularProgressPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const Row(
    mainAxisAlignment: .center,
    spacing: 25,
    children: [FCircularProgress(), FCircularProgress.loader(), FCircularProgress.pinwheel()],
  );
}

@RoutePage()
class DeterminateProgressPage extends StatefulExample {
  DeterminateProgressPage({@queryParam super.theme});

  @override
  State<DeterminateProgressPage> createState() => _DeterminateProgressPageState();
}

class _DeterminateProgressPageState extends StatefulExampleState<DeterminateProgressPage> {
  late Timer _timer = Timer(const Duration(seconds: 1), () => setState(() => _value = 0.7));
  double _value = 0.2;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget example(BuildContext _) => Column(
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
class ProgressPage extends Example {
  ProgressPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => const FProgress();
}
