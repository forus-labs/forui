import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';
import 'package:forui/src/widgets/picker/picker_controller.dart';

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
  /// The control that manages the picker's value.
  ///
  /// Defaults to [FPickerControl.managed].
  final FPickerControl control;

  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create picker
  /// ```
  final FPickerStyle Function(FPickerStyle style)? style;

  /// The individual wheels and separators.
  ///
  /// ## Contract
  /// A picker wheel must mix-in [FAccordionItemMixin]. Not doing so will result in the wheel being treated as a
  /// separator and cause undefined behavior.
  final List<Widget> children;

  /// The label used in debug messages. Defaults to `FPicker`.
  ///
  /// This is typically only ever used when creating a custom picker that composes [FPicker]. Most users will never
  /// need to change this.
  final String debugLabel;

  /// Creates a [FPicker] with several wheels, and optionally, separators.
  const FPicker({
    required this.children,
    this.control = const .managed(),
    this.style,
    this.debugLabel = 'FPicker',
    super.key,
  });

  @override
  State<FPicker> createState() => _FPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('debugType', debugLabel));
  }
}

class _FPickerState extends State<FPicker> {
  late FPickerController _controller;

  /// Prevents the controller's value from being updated when the wheels are scrolling.
  int _scrolling = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.control.create(_handleChange, widget.children.whereType<FPickerWheel>().length);
  }

  @override
  void didUpdateWidget(covariant FPicker old) {
    super.didUpdateWidget(old);
    _controller = widget.control
        .update(old.control, _controller, _handleChange, widget.children.whereType<FPickerWheel>().length)
        .$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleChange);
    super.dispose();
  }

  void _handleChange() {
    if (widget.control case FPickerManagedControl(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style?.call(context.theme.pickerStyle) ?? context.theme.pickerStyle;
    final selectionExtent =
        FPickerWheel.estimateExtent(style, context) * style.magnification + style.selectionHeightAdjustment;

    var wheelIndex = 0;
    Widget picker = Stack(
      alignment: .center,
      children: [
        Container(
          height: selectionExtent,
          decoration: BoxDecoration(color: style.selectionColor, borderRadius: style.selectionBorderRadius),
        ),
        // Syncs the controller's value with the wheel's scroll controller when the widget is updated.
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (_) {
            if (_scrolling == 0) {
              _controller.replace([for (final wheel in _controller.wheels) wheel.selectedItem]);
            }

            return false;
          },
          child: NotificationListener<ScrollStartNotification>(
            onNotification: (_) {
              _scrolling++;
              return false;
            },
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (_) {
                _scrolling = max(_scrolling - 1, 0);
                if (_scrolling == 0) {
                  _controller.replace([for (final wheel in _controller.wheels) wheel.selectedItem]);
                }

                return false;
              },
              child: Row(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
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
        ),
      ],
    );

    if (kDebugMode) {
      picker = FiniteConstraintsValidator(type: widget.debugLabel, child: picker);
    }

    return picker;
  }
}

@internal
class PickerData extends InheritedWidget {
  static PickerData of(BuildContext context) {
    assert(debugCheckHasAncestor<PickerData>('$FPicker', context));
    return context.dependOnInheritedWidgetOfExactType<PickerData>()!;
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
