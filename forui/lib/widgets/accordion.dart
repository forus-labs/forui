/// {@category Widgets}
///
/// A vertically stacked set of interactive headings that each reveal a section of content.
///
/// See https://forui.dev/docs/data/accordion for working examples.
library forui.widgets.accordion;

export '../src/widgets/accordion/accordion.dart' hide InheritedAccordionData;
export '../src/widgets/accordion/accordion_control.dart' show FAccordionControl;
export '../src/widgets/accordion/accordion_controller.dart' hide InternalAccordionController, LiftedController;
export '../src/widgets/accordion/accordion_item.dart';
