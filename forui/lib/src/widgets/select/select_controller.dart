import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

@internal
class FSelectControllerData<T> extends InheritedWidget {
  final bool Function(T) contains;
  final ValueChanged<T> onPress;

  const FSelectControllerData({required this.contains, required this.onPress, required super.child, super.key});

  static FSelectControllerData<T> of<T>(BuildContext context) {
    final FSelectControllerData<T>? result = context.dependOnInheritedWidgetOfExactType<FSelectControllerData<T>>();
    assert(result != null, 'No FSelectData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FSelectControllerData<T> old) => contains != old.contains || onPress != old.onPress;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty.has('contains', contains))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

/// The [FSelect]'s controller.
class FSelectController<T> extends FValueNotifier<T?> {
  static String? _defaultValidator(Object? _) => null;

  /// The controller for the popover. Does nothing if the time field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FSelectController] instead.
  final FPopoverController popover;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a time in a picker is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<T> validator;

  /// Creates a [FSelectController].
  FSelectController({
    required TickerProvider vsync,
    this.validator = _defaultValidator,
    T? value,
    Duration popoverAnimationDuration = const Duration(milliseconds: 50),
  }) : popover = FPopoverController(vsync: vsync, animationDuration: popoverAnimationDuration),
       super(value);

  @override
  set value(T? value) {
    super.value = super.value == value ? null : value;
    notifyListeners();
  }

  @override
  void dispose() {
    popover.dispose();
    super.dispose();
  }
}
