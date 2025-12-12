/// {@category Widgets}
///
/// A tooltip displays information related to an widget when focused, hovered over on desktop, and long pressed on
/// Android and iOS.
///
/// See https://forui.dev/docs/overlay/tooltip for working examples.
library forui.widgets.tooltip;

export '../src/widgets/tooltip/tooltip.dart';
export '../src/widgets/tooltip/tooltip_controller.dart'
    hide FTooltipManagedControl, InternalFTooltipControl, InternalTooltipController, Lifted;
