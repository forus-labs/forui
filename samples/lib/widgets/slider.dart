import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class SliderPage extends SampleScaffold {
  final bool enabled;
  final FSliderInteraction interaction;

  SliderPage({
    @queryParam super.theme,
    @queryParam String enabled = 'true',
    @queryParam String interaction = 'tapAndSlideThumb',
  })  : enabled = bool.tryParse(enabled) ?? true,
        interaction = switch (interaction) {
          'slide' => FSliderInteraction.slide,
          'slideThumb' => FSliderInteraction.slideThumb,
          'tap' => FSliderInteraction.tap,
          _ => FSliderInteraction.tapAndSlideThumb,
        };

  @override
  Widget child(BuildContext context) => FSlider(
        controller: FContinuousSliderController(
          selection: FSliderSelection(max: 0.6),
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
  final Layout layout;

  MarksSliderPage({
    @queryParam super.theme,
    @queryParam String layout = 'ltr',
  }) : layout = switch (layout) {
          'rtl' => Layout.rtl,
          'ttb' => Layout.ttb,
          'btt' => Layout.btt,
          _ => Layout.ltr,
        };

  @override
  Widget child(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 35),
    child: FSlider(
          layout: layout,
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
