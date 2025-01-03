/// {@category Widgets}
///
/// A sheet is a panel that slides in from the edge of a screen.
///
/// See:
/// * https://forui.dev/docs/overlay/sheet for working examples of a modal sheet.
/// * https://forui.dev/docs/overlay/persistent-sheet for working examples of a persistent sheet.
library forui.widgets.sheet;

export '../src/widgets/sheet/modal_sheet.dart';
export '../src/widgets/sheet/persistent_sheet.dart' hide FSheetsState;
export '../src/widgets/sheet/sheet.dart' show FSheetStyle;
