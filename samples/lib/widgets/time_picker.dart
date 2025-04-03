import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:auto_route/annotations.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class TimePickerPage extends StatefulSample {
  final bool hour24;

  TimePickerPage({@queryParam String hour24 = 'false', @queryParam super.theme, super.maxWidth = 200})
    : hour24 = bool.tryParse(hour24) ?? false;

  @override
  State<TimePickerPage> createState() => _TimePickerPageState();
}

class _TimePickerPageState extends StatefulSampleState<TimePickerPage> {
  late final FTimePickerController _controller = FTimePickerController(initial: FTime.now());

  @override
  Widget sample(BuildContext context) => FTimePicker(controller: _controller, hour24: widget.hour24);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class IntervalTimePickerPage extends StatefulSample {
  IntervalTimePickerPage({@queryParam super.theme, super.maxWidth = 200});

  @override
  State<IntervalTimePickerPage> createState() => _IntervalTimePickerPageState();
}

class _IntervalTimePickerPageState extends StatefulSampleState<IntervalTimePickerPage> {
  late final FTimePickerController _controller = FTimePickerController(initial: FTime.now());

  @override
  Widget sample(BuildContext context) => FTimePicker(controller: _controller, hourInterval: 2, minuteInterval: 5);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class AnimatedTimePickerPage extends StatefulSample {
  AnimatedTimePickerPage({@queryParam super.theme, super.maxWidth = 200});

  @override
  State<AnimatedTimePickerPage> createState() => _AnimatedTimePickerPageState();
}

class _AnimatedTimePickerPageState extends StatefulSampleState<AnimatedTimePickerPage> {
  static final _random = Random();
  late final FTimePickerController _controller = FTimePickerController(initial: FTime.now());

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 300, child: FTimePicker(controller: _controller)),
      FButton(
        child: const Text('Funny button'),
        onPress: () => _controller.animateTo(FTime(_random.nextInt(24), _random.nextInt(60))),
      ),
    ],
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
