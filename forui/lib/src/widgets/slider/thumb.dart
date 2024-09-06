import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/slider.dart';
import 'package:meta/meta.dart';

class _ShrinkIntent extends Intent {
  const _ShrinkIntent();
}

class _GrowIntent extends Intent {
  const _GrowIntent();
}

@internal
class Thumb extends StatefulWidget {
  final double hitRegionExtent;
  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;
  final double adjustment;
  final bool min;

  const Thumb({
    required this.hitRegionExtent,
    required this.focusNode,
    required this.autofocus,
    required this.onFocusChange,
    required this.adjustment,
    required this.min,
    super.key,
  });

  @override
  State<Thumb> createState() => _ThumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('hitRegionExtent', hitRegionExtent))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(ObjectFlagProperty('onFocusChange', onFocusChange, ifPresent: 'onFocusChange'))
      ..add(DoubleProperty('adjustment', adjustment))
      ..add(FlagProperty('min', value: min, ifTrue: 'min', ifFalse: 'max'));
  }
}

class _ThumbState extends State<Thumb> {
  MouseCursor _cursor = SystemMouseCursors.grab;

  @override
  Widget build(BuildContext context) {
    final InheritedData(:controller, style: FSliderStyle(:thumbStyle), :layout, :enabled) = InheritedData.of(context);

    Widget thumb = FocusableActionDetector(
      shortcuts: _shortcuts(layout),
      actions: {
        _GrowIntent: CallbackAction(onInvoke: (_) => controller.traverse(min: widget.min, grow: true)),
        _ShrinkIntent: CallbackAction(onInvoke: (_) => controller.traverse(min: widget.min, grow: false)),
      },
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onFocusChange: widget.onFocusChange,
      enabled: enabled,
      mouseCursor: enabled ? _cursor : MouseCursor.defer,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: thumbStyle.color,
          border: Border.all(
            color: thumbStyle.borderColor,
            width: thumbStyle.borderWidth,
          ),
        ),
        child: SizedBox.square(
          dimension: thumbStyle.dimension,
        ),
      ),
    );

    if (enabled) {
      // TODO: tooltip
      final (horizontal, vertical) = _gestures(controller, layout);
      thumb = GestureDetector(
        onTapDown: (_) => setState(() => _cursor = SystemMouseCursors.grabbing),
        onTapUp: (_) => setState(() => _cursor = SystemMouseCursors.grab),
        onTapCancel: () => setState(() => _cursor = SystemMouseCursors.grab),
        onHorizontalDragUpdate: horizontal,
        onVerticalDragUpdate: vertical,
        child: widget.hitRegionExtent == 0
            ? thumb
            : SizedBox.square(
                dimension: thumbStyle.dimension + widget.hitRegionExtent,
                child: Align(
                  child: thumb,
                ),
              ),
      );
    }

    return thumb;
  }

  Map<ShortcutActivator, Intent> _shortcuts(Layout layout) => switch ((layout, widget.min)) {
        (Layout.ltr, true) || (Layout.rtl, false) => const {
            SingleActivator(LogicalKeyboardKey.arrowLeft): _GrowIntent(),
            SingleActivator(LogicalKeyboardKey.arrowRight): _ShrinkIntent(),
          },
        (Layout.ltr, false) || (Layout.rtl, true) => const {
            SingleActivator(LogicalKeyboardKey.arrowLeft): _ShrinkIntent(),
            SingleActivator(LogicalKeyboardKey.arrowRight): _GrowIntent(),
          },
        (Layout.ttb, true) || (Layout.btt, false) => const {
            SingleActivator(LogicalKeyboardKey.arrowUp): _GrowIntent(),
            SingleActivator(LogicalKeyboardKey.arrowDown): _ShrinkIntent(),
          },
        (Layout.ttb, false) || (Layout.btt, true) => const {
            SingleActivator(LogicalKeyboardKey.arrowUp): _ShrinkIntent(),
            SingleActivator(LogicalKeyboardKey.arrowDown): _GrowIntent(),
          },
      };

  (GestureDragUpdateCallback?, GestureDragUpdateCallback?) _gestures(FSliderController controller, Layout layout) =>
      switch (layout) {
        Layout.ltr => ((details) => controller.slide(details.delta.dx, min: widget.min), null),
        Layout.rtl => ((details) => controller.slide(-details.delta.dx, min: widget.min), null),
        Layout.ttb => (null, (details) => controller.slide(details.delta.dy, min: widget.min)),
        Layout.btt => (null, (details) => controller.slide(-details.delta.dy, min: widget.min)),
      };
}

/// A slider thumb's style.
final class FSliderThumbStyle with Diagnosticable {
  /// The thumb's color.
  final Color color;

  /// The thumb's dimension, inclusive of [borderWidth]. Defaults to `20`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [dimension] is not positive.
  final double dimension;

  /// The border's color.
  final Color borderColor;

  /// The border's width. Defaults to `2`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [borderWidth] is not positive.
  final double borderWidth;

  /// Creates a [FSliderThumbStyle].
  FSliderThumbStyle({
    required this.color,
    required this.borderColor,
    this.dimension = 20,
    this.borderWidth = 2,
  })  : assert(0 < dimension, 'The diameter must be positive'),
        assert(0 < borderWidth, 'The border width must be positive');

  /// Returns a copy of this [FSliderThumbStyle] but with the given fields replaced with the new values.
  @useResult
  FSliderThumbStyle copyWith({
    Color? color,
    double? dimension,
    Color? borderColor,
    double? borderWidth,
  }) =>
      FSliderThumbStyle(
        color: color ?? this.color,
        dimension: dimension ?? this.dimension,
        borderColor: borderColor ?? this.borderColor,
        borderWidth: borderWidth ?? this.borderWidth,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('dimension', dimension))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(DoubleProperty('borderWidth', borderWidth));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderThumbStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          dimension == other.dimension &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth;

  @override
  int get hashCode => color.hashCode ^ dimension.hashCode ^ borderColor.hashCode ^ borderWidth.hashCode;
}
