/// {@category Widgets}
///
/// An input where the user selects a value from within a given range.
///
/// See https://forui.dev/docs/form/slider for working examples.
library forui.widgets.slider;

export '../src/widgets/slider/slider.dart';
export '../src/widgets/slider/slider_controller.dart'
    hide ProxyContinuousSliderController, ProxyDiscreteSliderController;
export '../src/widgets/slider/slider_mark.dart';
export '../src/widgets/slider/slider_value.dart' hide ContinuousValue, DiscreteValue, SplayTreeMaps;
export '../src/widgets/slider/slider_styles.dart';
export '../src/widgets/slider/slider_control.dart' hide InternalFSliderControl;
export '../src/widgets/slider/thumb.dart' hide Layouts, Thumb;
