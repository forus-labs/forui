import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SliderPage extends Sample {
  final String? label;
  final String? description;
  final String? error;
  final bool enabled;
  final FSliderInteraction interaction;
  final ({double min, double max}) extent;

  SliderPage({
    @queryParam this.label,
    @queryParam this.description,
    @queryParam this.error,
    @queryParam this.enabled = true,
    @queryParam String interaction = 'tapAndSlideThumb',
    @queryParam bool extent = false,
    @queryParam super.theme,
  }) : interaction = switch (interaction) {
         'slide' => .slide,
         'slideThumb' => .slideThumb,
         'tap' => .tap,
         _ => .tapAndSlideThumb,
       },
       extent = extent ? (min: 0.25, max: 0.75) : (min: 0, max: 1);

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(
      initial: FSliderValue(max: 0.6, constraints: extent),
      interaction: interaction,
    ),
    label: label == null ? null : Text(label!),
    description: description == null ? null : Text(description!),
    forceErrorText: error,
    enabled: enabled,
  );
}

@RoutePage()
class TooltipSliderPage extends Sample {
  TooltipSliderPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.6)),
    tooltipBuilder: (style, value) {
      final hex = (value * 100).round().toRadixString(16).padLeft(2, '0');
      return Text('0x$hex');
    },
  );
}

@RoutePage()
class MarksSliderPage extends Sample {
  MarksSliderPage({@queryParam super.theme, super.top = 35});

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
    control: .managedDiscrete(initial: FSliderValue(max: 0.25)),
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
  Widget sample(BuildContext context) =>
      FSlider(control: .managedContinuousRange(initial: FSliderValue(min: 0.25, max: 0.75)));
}

@RoutePage()
class VerticalSliderPage extends Sample {
  VerticalSliderPage({@queryParam super.theme, super.top = 35});

  @override
  Widget sample(BuildContext context) => FSlider(
    control: .managedContinuous(initial: FSliderValue(max: 0.35)),
    label: const Text('Volume'),
    description: const Text('Adjust the volume by dragging the slider.'),
    layout: .btt,
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
