import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SliderPage extends Sample {
  SliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(control: .managedContinuous(initial: FSliderValue(max: 0.6)));
}

@RoutePage()
class LabelledSliderPage extends Sample {
  LabelledSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.6)),
    // {@highlight}
    label: const Text('Volume'),
    description: const Text('Adjust the volume by dragging the slider.'),
    // {@endhighlight}
  );
}

@RoutePage()
class DisabledSliderPage extends Sample {
  DisabledSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.6)),
    label: const Text('Volume'),
    description: const Text('Adjust the volume by dragging the slider.'),
    // {@highlight}
    enabled: false,
    // {@endhighlight}
  );
}

@RoutePage()
class ErrorSliderPage extends Sample {
  ErrorSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.6)),
    label: const Text('Volume'),
    description: const Text('Adjust the volume by dragging the slider.'),
    // {@highlight}
    forceErrorText: 'Volume is too high.',
    // {@endhighlight}
  );
}

@RoutePage()
class TooltipSliderPage extends Sample {
  TooltipSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.6)),
    // {@highlight}
    tooltipBuilder: (style, value) {
      final hex = (value * 100).round().toRadixString(16).padLeft(2, '0');
      return Text('0x$hex');
    },
    // {@endhighlight}
  );
}

@RoutePage()
class MarksSliderPage extends Sample {
  MarksSliderPage({@queryParam super.theme}) : super(top: 35);

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.35)),
    marks: const [
      .mark(value: 0, label: Text('0%')),
      .mark(value: 0.25, tick: false),
      .mark(value: 0.5),
      .mark(value: 0.75, tick: false),
      .mark(value: 1, label: Text('100%')),
    ],
  );
}

@RoutePage()
class DiscreteSliderPage extends Sample {
  DiscreteSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    // {@highlight}
    control: .managedDiscrete(initial: FSliderValue(max: 0.25)),
    // {@endhighlight}
    marks: const [
      .mark(value: 0, label: Text('0%')),
      .mark(value: 0.25, tick: false),
      .mark(value: 0.5),
      .mark(value: 0.75, tick: false),
      .mark(value: 1, label: Text('100%')),
    ],
  );
}

@RoutePage()
class RangeSliderPage extends Sample {
  RangeSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    // {@highlight}
    control: .managedContinuousRange(
      initial: FSliderValue(min: 0.25, max: 0.75),
      // {@endhighlight}
    ),
  );
}

@RoutePage()
class BoundariesSliderPage extends Sample {
  BoundariesSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(
      initial: FSliderValue(
        max: 0.6,
        // {@highlight}
        constraints: (min: 0.25, max: 0.75),
        // {@endhighlight}
      ),
    ),
  );
}

@RoutePage()
class VerticalSliderPage extends Sample {
  VerticalSliderPage({@queryParam super.theme, super.top = 35});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.35)),
    label: const Text('Volume'),
    description: const Text('Adjust the volume by dragging the slider.'),
    // {@highlight}
    layout: .btt,
    // {@endhighlight}
    trackMainAxisExtent: 350,
    marks: const [
      .mark(value: 0, label: Text('0%')),
      .mark(value: 0.25, tick: false),
      .mark(value: 0.5, label: Text('50%')),
      .mark(value: 0.75, tick: false),
      .mark(value: 1, label: Text('100%')),
    ],
  );
}

@RoutePage()
class SlideSliderPage extends Sample {
  SlideSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(
      initial: FSliderValue(max: 0.6),
      // {@highlight}
      interaction: .slide,
      // {@endhighlight}
    ),
  );
}

@RoutePage()
class SlideThumbSliderPage extends Sample {
  SlideThumbSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(
      initial: FSliderValue(max: 0.6),
      // {@highlight}
      interaction: .slideThumb,
      // {@endhighlight}
    ),
  );
}

@RoutePage()
class TapSliderPage extends Sample {
  TapSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(
      initial: FSliderValue(max: 0.6),
      // {@highlight}
      interaction: .tap,
      // {@endhighlight}
    ),
  );
}

@RoutePage()
class TapAndSlideThumbSliderPage extends Sample {
  TapAndSlideThumbSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(
      initial: FSliderValue(max: 0.6),
      // {@highlight}
      interaction: .tapAndSlideThumb,
      // {@endhighlight}
    ),
  );
}

@RoutePage()
class SliderFormPage extends StatefulSample {
  SliderFormPage({@queryParam super.theme});

  @override
  State<SliderFormPage> createState() => _SliderFormPageState();
}

class _SliderFormPageState extends StatefulSampleState<SliderFormPage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      spacing: 20,
      children: [
        FSlider(
          control: .managedContinuous(initial: FSliderValue(max: 0.35)),
          label: const Text('Brightness'),
          description: const Text('Adjust the brightness level.'),
          marks: const [
            .mark(value: 0, label: Text('0%')),
            .mark(value: 0.25, tick: false),
            .mark(value: 0.5, label: Text('50%')),
            .mark(value: 0.75, tick: false),
            .mark(value: 1, label: Text('100%')),
          ],
        ),
        FButton(
          child: const Text('Save'),
          onPress: () {
            if (!_key.currentState!.validate()) {
              // Handle errors here.
              return;
            }

            _key.currentState!.save();
            // Do something.
          },
        ),
      ],
    ),
  );
}
