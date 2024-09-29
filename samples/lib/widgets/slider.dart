import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SliderPage extends SampleScaffold {
  final String? label;
  final String? description;
  final String? error;
  final bool enabled;
  final FSliderInteraction interaction;
  final ({double min, double max}) extent;

  SliderPage({
    @queryParam super.theme,
    @queryParam this.label,
    @queryParam this.description,
    @queryParam this.error,
    @queryParam String enabled = 'true',
    @queryParam String interaction = 'tapAndSlideThumb',
    @queryParam String extent = 'false',
  })  : enabled = bool.tryParse(enabled) ?? true,
        interaction = switch (interaction) {
          'slide' => FSliderInteraction.slide,
          'slideThumb' => FSliderInteraction.slideThumb,
          'tap' => FSliderInteraction.tap,
          _ => FSliderInteraction.tapAndSlideThumb,
        },
        extent = bool.tryParse(extent) ?? false ? (min: 0.25, max: 0.75) : (min: 0, max: 1);

  @override
  Widget child(BuildContext context) => FSlider(
        label: label != null ? Text(label!) : null,
        description: description != null ? Text(description!) : null,
        forceErrorText: error,
        controller: FContinuousSliderController(
          selection: FSliderSelection(
            max: 0.6,
            extent: extent,
          ),
          allowedInteraction: interaction,
        ),
        enabled: enabled,
      );
}

@RoutePage()
class TooltipSliderPage extends SampleScaffold {
  TooltipSliderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FSlider(
        tooltipBuilder: (style, value) {
          final hex = (value * 100).round().toRadixString(16).padLeft(2, '0');
          return Text('0x$hex');
        },
        controller: FContinuousSliderController(selection: FSliderSelection(max: 0.6)),
      );
}

@RoutePage()
class MarksSliderPage extends SampleScaffold {
  MarksSliderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: FSlider(
          controller: FContinuousSliderController(selection: FSliderSelection(max: 0.35)),
          marks: const [
            FSliderMark(value: 0, label: Text('0%')),
            FSliderMark(value: 0.25, tick: false),
            FSliderMark(value: 0.5),
            FSliderMark(value: 0.75, tick: false),
            FSliderMark(value: 1, label: Text('100%')),
          ],
        ),
      );
}

@RoutePage()
class DiscreteSliderPage extends SampleScaffold {
  DiscreteSliderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FSlider(
        controller: FDiscreteSliderController(selection: FSliderSelection(max: 0.25)),
        marks: const [
          FSliderMark(value: 0, label: Text('0%')),
          FSliderMark(value: 0.25, tick: false),
          FSliderMark(value: 0.5),
          FSliderMark(value: 0.75, tick: false),
          FSliderMark(value: 1, label: Text('100%')),
        ],
      );
}

@RoutePage()
class RangeSliderPage extends SampleScaffold {
  RangeSliderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FSlider(
        controller: FContinuousSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75)),
      );
}

@RoutePage()
class VerticalSliderPage extends SampleScaffold {
  VerticalSliderPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 35),
        child: FSlider(
          label: const Text('Volume'),
          description: const Text('Adjust the volume by dragging the slider.'),
          layout: Layout.btt,
          controller: FContinuousSliderController(selection: FSliderSelection(max: 0.35)),
          trackMainAxisExtent: 350,
          marks: const [
            FSliderMark(value: 0, label: Text('0%')),
            FSliderMark(value: 0.25, tick: false),
            FSliderMark(value: 0.5, label: Text('50%')),
            FSliderMark(value: 0.75, tick: false),
            FSliderMark(value: 1, label: Text('100%')),
          ],
        ),
      );
}

@RoutePage()
class SliderFormPage extends SampleScaffold {
  SliderFormPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: const SliderForm(),
      );
}

class SliderForm extends StatefulWidget {
  const SliderForm({super.key});

  @override
  State<SliderForm> createState() => SliderFormState();
}

class SliderFormState extends State<SliderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FSlider(
              label: const Text('Brightness'),
              description: const Text('Adjust the brightness level.'),
              controller: FContinuousSliderController(
                selection: FSliderSelection(max: 0.35),
              ),
              marks: const [
                FSliderMark(value: 0, label: Text('0%')),
                FSliderMark(value: 0.25, tick: false),
                FSliderMark(value: 0.5, label: Text('50%')),
                FSliderMark(value: 0.75, tick: false),
                FSliderMark(value: 1, label: Text('100%')),
              ],
            ),
            const SizedBox(height: 20),
            FButton(
              label: const Text('Save'),
              onPress: () {
                if (!_formKey.currentState!.validate()) {
                  // Handle errors here.
                  return;
                }

                _formKey.currentState!.save();
                // Do something.
              },
            ),
          ],
        ),
      );
}
