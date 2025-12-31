import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class TimePickerPage extends Example {
  TimePickerPage({@queryParam super.theme}) : super(maxWidth: 200);

  @override
  Widget example(BuildContext context) => FTimePicker(control: .managed(initial: .now()));
}

@RoutePage()
class Hour24TimePickerPage extends Example {
  Hour24TimePickerPage({@queryParam super.theme}) : super(maxWidth: 200);

  @override
  Widget example(BuildContext context) => FTimePicker(
    control: .managed(initial: .now()),
    // {@highlight}
    hour24: true,
    // {@endhighlight}
  );
}

@RoutePage()
class IntervalTimePickerPage extends Example {
  IntervalTimePickerPage({@queryParam super.theme}) : super(maxWidth: 200);

  @override
  Widget example(BuildContext context) => FTimePicker(
    control: .managed(initial: .now()),
    // {@highlight}
    hourInterval: 2,
    minuteInterval: 5,
    // {@endhighlight}
  );
}

@RoutePage()
class AnimatedTimePickerPage extends StatefulExample {
  AnimatedTimePickerPage({@queryParam super.theme}) : super(maxWidth: 200);

  @override
  State<AnimatedTimePickerPage> createState() => _AnimatedTimePickerPageState();
}

class _AnimatedTimePickerPageState extends StatefulExampleState<AnimatedTimePickerPage> {
  static final _random = Random();
  final _controller = FTimePickerController(time: .now());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget example(BuildContext context) => Column(
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
