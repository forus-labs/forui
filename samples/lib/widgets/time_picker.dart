import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TimePickerPage extends Sample {
  final bool hour24;

  TimePickerPage({@queryParam this.hour24 = false, @queryParam super.theme, super.maxWidth = 200});

  @override
  Widget sample(BuildContext context) => FTimePicker(
    control: .managed(initial: .now()),
    hour24: hour24,
  );
}

@RoutePage()
class IntervalTimePickerPage extends Sample {
  IntervalTimePickerPage({@queryParam super.theme, super.maxWidth = 200});

  @override
  Widget sample(BuildContext context) =>
      FTimePicker(control: .managed(initial: .now()), hourInterval: 2, minuteInterval: 5);
}

@RoutePage()
class AnimatedTimePickerPage extends StatefulSample {
  AnimatedTimePickerPage({@queryParam super.theme, super.maxWidth = 200});

  @override
  State<AnimatedTimePickerPage> createState() => _AnimatedTimePickerPageState();
}

class _AnimatedTimePickerPageState extends StatefulSampleState<AnimatedTimePickerPage> {
  static final _random = Random();
  final _controller = FTimePickerController(initial: .now());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisSize: .min,
    children: [
      SizedBox(
        height: 300,
        child: FTimePicker(control: .managed(controller: _controller)),
      ),
      FButton(
        child: const Text('Funny button'),
        onPress: () => _controller.animateTo(FTime(_random.nextInt(24), _random.nextInt(60))),
      ),
    ],
  );
}
