import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class SliderPage extends StatefulSample {
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
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends StatefulSampleState<SliderPage> {
  late final _controller = FContinuousSliderController(
    selection: FSliderSelection(max: 0.6, extent: widget.extent),
    allowedInteraction: widget.interaction,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FSlider(
    label: widget.label == null ? null : Text(widget.label!),
    description: widget.description == null ? null : Text(widget.description!),
    forceErrorText: widget.error,
    controller: _controller,
    enabled: widget.enabled,
  );
}

@RoutePage()
class TooltipSliderPage extends StatefulSample {
  TooltipSliderPage({@queryParam super.theme});

  @override
  State<TooltipSliderPage> createState() => _TooltipSliderPageState();
}

class _TooltipSliderPageState extends StatefulSampleState<TooltipSliderPage> {
  final _controller = FContinuousSliderController(selection: FSliderSelection(max: 0.6));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FSlider(
    controller: _controller,
    tooltipBuilder: (style, value) {
      final hex = (value * 100).round().toRadixString(16).padLeft(2, '0');
      return Text('0x$hex');
    },
  );
}

@RoutePage()
class MarksSliderPage extends StatefulSample {
  MarksSliderPage({@queryParam super.theme});

  @override
  State<MarksSliderPage> createState() => _MarksSliderPageState();
}

class _MarksSliderPageState extends StatefulSampleState<MarksSliderPage> {
  final _controller = FContinuousSliderController(selection: FSliderSelection(max: 0.35));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .symmetric(vertical: 35),
    child: FSlider(
      controller: _controller,
      marks: const [
        .mark(value: 0, label: Text('0%')),
        .mark(value: 0.25, tick: false),
        .mark(value: 0.5),
        .mark(value: 0.75, tick: false),
        .mark(value: 1, label: Text('100%')),
      ],
    ),
  );
}

@RoutePage()
class DiscreteSliderPage extends StatefulSample {
  DiscreteSliderPage({@queryParam super.theme});

  @override
  State<DiscreteSliderPage> createState() => _DiscreteSliderPageState();
}

class _DiscreteSliderPageState extends StatefulSampleState<DiscreteSliderPage> {
  final _controller = FDiscreteSliderController(selection: FSliderSelection(max: 0.25));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FSlider(
    controller: _controller,
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
class RangeSliderPage extends StatefulSample {
  RangeSliderPage({@queryParam super.theme});

  @override
  State<RangeSliderPage> createState() => _RangeSliderPageState();
}

class _RangeSliderPageState extends StatefulSampleState<RangeSliderPage> {
  final _controller = FContinuousSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FSlider(controller: _controller);
}

@RoutePage()
class VerticalSliderPage extends StatefulSample {
  VerticalSliderPage({@queryParam super.theme});

  @override
  State<VerticalSliderPage> createState() => _VerticalSliderPageState();
}

class _VerticalSliderPageState extends StatefulSampleState<VerticalSliderPage> {
  final _controller = FContinuousSliderController(selection: FSliderSelection(max: 0.35));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const .symmetric(vertical: 35),
    child: FSlider(
      label: const Text('Volume'),
      description: const Text('Adjust the volume by dragging the slider.'),
      layout: .btt,
      controller: _controller,
      trackMainAxisExtent: 350,
      marks: const [
        .mark(value: 0, label: Text('0%')),
        .mark(value: 0.25, tick: false),
        .mark(value: 0.5, label: Text('50%')),
        .mark(value: 0.75, tick: false),
        .mark(value: 1, label: Text('100%')),
      ],
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
  final _controller = FContinuousSliderController(selection: FSliderSelection(max: 0.35));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Form(
    key: _key,
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .start,
      children: [
        FSlider(
          label: const Text('Brightness'),
          description: const Text('Adjust the brightness level.'),
          controller: _controller,
          marks: const [
            .mark(value: 0, label: Text('0%')),
            .mark(value: 0.25, tick: false),
            .mark(value: 0.5, label: Text('50%')),
            .mark(value: 0.75, tick: false),
            .mark(value: 1, label: Text('100%')),
          ],
        ),
        const SizedBox(height: 20),
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
