import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// The select's controller.
class FSelectController<T> extends FValueNotifier<Set<T>> {
  static String? _defaultValidator(Set<Object?>? _) => null;

  /// The controller for the popover. Does nothing if the time field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FSelectController] instead.
  final FPopoverController popover;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a time in a picker is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<Set<T>> validator;

  /// Creates a [FSelectController].
  FSelectController({
    required TickerProvider vsync,
    this.validator = _defaultValidator,
    Set<T>? initialSelections,
    Duration popoverAnimationDuration = const Duration(milliseconds: 100),
  }) : popover = FPopoverController(vsync: vsync, animationDuration: popoverAnimationDuration),
       super(initialSelections ?? const {});

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}
