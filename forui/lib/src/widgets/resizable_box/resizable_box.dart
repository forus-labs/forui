import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable_box/resizable_box_controller.dart';
import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

export '/src/widgets/resizable_box/resizable.dart';
export '/src/widgets/resizable_box/resizable_box_controller.dart' hide ResizableBoxController, Resize, SelectAndResize;
export '/src/widgets/resizable_box/resizable_data.dart' hide UpdatableResizableData;

/// A box which children can all be resized either horizontally or vertically.
///
/// Each child is a [FResizable].
///
/// ## Contract
/// Each child has a minimum size determined by its slider size multiplied by 2. Setting an initial size smaller than
/// the required minimum size will result in undefined behaviour.
///
/// A [FResizableBox] should contain at least two children. Passing it less than 2 children will result in undefined
/// behaviour.
class FResizableBox extends StatefulWidget {
  /// The axis that the [children] can be resized along.
  final Axis axis;

  /// The allowed way for the user to interact with this resizable box.
  final FResizableInteraction interaction;

  /// The number of pixels in the non-resizable axis.
  final double? crossAxisExtent;

  /// The minimum velocity, inclusive, of a drag gesture for haptic feedback to be performed
  /// on collision between two regions, defaults to 6.5.
  ///
  /// Setting it to `null` disables haptic feedback while setting it to 0 will cause
  /// haptic feedback to always be performed.
  ///
  /// ## Contract
  /// [_hapticFeedbackVelocity] should be a positive, finite number. It will otherwise
  /// result in undefined behaviour.
  final double _hapticFeedbackVelocity = 6.5; // TODO: haptic feedback

  /// The children which may be resized.
  final List<FResizable> children;

  /// A function that is called when a resizable is selected.
  final void Function(int index)? onPress;

  /// A function that is called when a resizable and its neighbour are being resized.
  ///
  /// This function is called *while* the regions are being resized. Most users should prefer [onResizeEnd], which is
  /// called only when the regions have finished resizing.
  final void Function(FResizableData selected, FResizableData neighbour)? onResizeUpdate;

  /// A function that is called when a resizable and its neighbour have been resized.
  final void Function(FResizableData selected, FResizableData neighbour)? onResizeEnd;

  /// Creates a [FResizableBox].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [interaction] is a [FResizableInteraction.selectAndResize] and index is index < 0 or `children.length` <= index.
  /// * less than two [children] are given.
  FResizableBox({
    required this.axis,
    required this.interaction,
    required this.children,
    this.crossAxisExtent,
    this.onPress,
    this.onResizeUpdate,
    this.onResizeEnd,
    super.key,
  }) : assert(2 <= children.length, 'FResizableBox should have at least 2 FResizables.') {
    if (interaction case SelectAndResize(:final index)) {
      assert(
        0 <= index && index < children.length,
        'The initial index should be in 0 <= initialIndex < ${children.length}, but it is $index.',
      );
    }
  }

  @override
  State<StatefulWidget> createState() => _FResizableBoxState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('axis', axis))
      ..add(DiagnosticsProperty('interaction', interaction))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('_hapticFeedbackVelocity', _hapticFeedbackVelocity))
      ..add(IterableProperty('children', children))
      ..add(ObjectFlagProperty('onPress', onPress))
      ..add(ObjectFlagProperty('onResizeUpdate', onResizeUpdate))
      ..add(ObjectFlagProperty('onResizeEnd', onResizeEnd));
  }
}

class _FResizableBoxState extends State<FResizableBox> {
  late ResizableBoxController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update(widget.interaction);
  }

  @override
  void didUpdateWidget(FResizableBox old) {
    super.didUpdateWidget(old);
    if (widget.axis != old.axis ||
        widget.interaction != old.interaction ||
        widget.crossAxisExtent != old.crossAxisExtent ||
        widget._hapticFeedbackVelocity != old._hapticFeedbackVelocity ||
        widget.onPress != widget.onPress ||
        widget.onResizeUpdate != widget.onResizeUpdate ||
        widget.onResizeEnd != widget.onResizeEnd ||
        !widget.children.equals(old.children)) {
      _update(controller.interaction);
    }
  }

  void _update(FResizableInteraction interaction) {
    final selected = switch (interaction) {
      SelectAndResize(:final index) => index,
      Resize _ => null,
    };

    var min = 0.0;
    final max = widget.children.sum((child) => child.initialSize, initial: 0.0);
    final resizables = [
      for (final (index, resizable) in widget.children.indexed)
        FResizableData(
          index: index,
          selected: selected == index,
          constraints: (min: resizable.minSize, max: max),
          offsets: (min: min, max: min += resizable.initialSize),
        ),
    ];

    controller = ResizableBoxController(
      resizables: resizables,
      axis: widget.axis,
      hapticFeedbackVelocity: widget._hapticFeedbackVelocity,
      onPress: widget.onPress,
      onResizeUpdate: widget.onResizeUpdate,
      onResizeEnd: widget.onResizeEnd,
      interaction: interaction,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(
      controller.resizables.length == widget.children.length,
      'The number of FResizableData should be equal to the number of children.',
    );

    if (widget.axis == Axis.horizontal) {
      return SizedBox(
        height: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.children.length; i++)
                InheritedData(
                  controller: controller,
                  data: controller.resizables[i],
                  child: widget.children[i],
                ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.children.length; i++)
                InheritedData(
                  controller: controller,
                  data: controller.resizables[i],
                  child: widget.children[i],
                ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

@internal
class InheritedData extends InheritedWidget {
  final ResizableBoxController controller;
  final FResizableData data;

  const InheritedData({
    required this.controller,
    required this.data,
    required super.child,
    super.key,
  });

  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedController found in context. Is there an ancestor ResizableBox?');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedData old) => controller != old.controller || data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('data', data));
  }
}
