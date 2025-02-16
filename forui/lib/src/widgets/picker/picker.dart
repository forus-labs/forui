import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A picker's controller.
///
/// The [value] contains the index of the selected item in each wheel. The indexes are ordered:
/// * from left to right if the current text direction is LTR
/// * from right to left if the current text direction is RTL
class FPickerController extends FValueNotifier<List<int>> {
  /// The picker wheels' initial indexes.
  final List<int> initialIndexes;

  /// The controllers for the individual picker wheels.
  ///
  /// The controllers are ordered:
  /// * from left to right if the current text direction is LTR
  /// * from right to left if the current text direction is RTL
  ///
  /// ## Contract
  /// Reading the controllers before this FPickerController is attached to a [FPicker] is undefined behavior.
  ///
  /// Modifying [wheels] is undefined behavior.
  final List<FixedExtentScrollController> wheels = [];

  /// Creates a [FPickerController].
  FPickerController({required this.initialIndexes}) : super([...initialIndexes]);

  @override
  List<int> get value => [...super.value];

  @override
  set value(List<int> value) {
    assert(
      wheels.isEmpty || value.length == wheels.length,
      'The value must have the same length as the number of wheels.',
    );

    if (wheels.isNotEmpty) {
      for (final (i, index) in value.indexed) {
        wheels[i].jumpToItem(index);
      }
    }
    super.value = value;
  }

  @override
  void dispose() {
    for (final wheel in wheels) {
      wheel.dispose();
    }
    super.dispose();
  }

  // ignore: avoid_setters_without_getters
  set _value(List<int> value) => super.value = value;
}

/// A generic picker that allows an item to be selected. It is composed of one or more [FPickerWheel]s, optionally,
/// with separators between those wheels.
///
/// Recommended for touch devices.
///
/// The picker supports arrow key navigation:
/// * Up/Down arrows: Increment/decrement selected value
/// * Left/Right arrows: Move between wheels
///
/// See:
/// * https://forui.dev/docs/form/picker for working examples.
/// * [FPickerController] for controlling a picker.
/// * [FPickerWheel] for customizing a picker's individual wheel.
/// * [FPickerStyle] for customizing a picker's appearance.
class FPicker extends StatefulWidget {
  /// The controller.
  final FPickerController? controller;

  /// The style.
  final FPickerStyle? style;

  /// The individual wheels and separators.
  ///
  /// ## Contract
  /// A wheel cannot be wrapped in a widget other than a custom [FPickerWheel]. Doing so will result in this picker
  /// treating it as a separator and causing an error.
  final List<Widget> children;

  /// Creates a [FPicker] with several wheels, and optionally, separators.
  const FPicker({required this.children, this.controller, this.style, super.key});

  @override
  State<FPicker> createState() => _FPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style));
  }
}

class _FPickerState extends State<FPicker> {
  late FPickerController _controller;

  @override
  void initState() {
    super.initState();
    _createController();
  }

  @override
  void didUpdateWidget(covariant FPicker old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    if (old.controller == null) {
      _controller.dispose();
    }

    _createController();
  }

  void _createController() {
    _controller =
        widget.controller ??
        FPickerController(initialIndexes: List.filled(widget.children.whereType<FPickerWheel>().length, 0));

    for (final wheel in _controller.wheels) {
      wheel.dispose();
    }
    _controller.wheels.clear();

    for (final (index, item) in _controller.value.indexed) {
      _controller.wheels.add(
        FixedExtentScrollController(
          initialItem: item,
          onAttach: (position) {
            if (position.hasContentDimensions) {
              final copy = _controller.value;
              // This is evil but it's the only way to get the item index as it's hidden in a private class.
              copy[index] = (position as dynamic).itemIndex;
              _controller._value = copy;
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.pickerStyle;
    final selectionExtent = FPickerWheel.estimateExtent(style, context) * style.magnification;

    var wheelIndex = 0;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: selectionExtent,
          decoration: BoxDecoration(color: style.selectionColor, borderRadius: style.selectionBorderRadius),
        ),
        // Syncs the controller's value with the wheel's scroll controller when the widget is updated.
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            _controller._value = [for (final wheel in _controller.wheels) wheel.selectedItem];
            return false;
          },
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              _controller._value = [for (final wheel in _controller.wheels) wheel.selectedItem];
              return false;
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: style.spacing,
              children: [
                for (final child in widget.children)
                  if (child is FPickerWheelMixin)
                    PickerData(controller: _controller.wheels[wheelIndex++], style: style, child: child)
                  else
                    Center(
                      child: DefaultTextStyle.merge(
                        textHeightBehavior: style.textHeightBehavior,
                        style: style.textStyle,
                        child: child,
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

@internal
class PickerData extends InheritedWidget {
  static PickerData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PickerData>();
    assert(result != null, 'No parent FPicker found in context');
    return result!;
  }

  final FixedExtentScrollController controller;
  final FPickerStyle style;

  const PickerData({required this.controller, required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(PickerData old) => controller != old.controller || style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style));
  }
}
