import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/slider/inherited_controller.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/widgets/slider/inherited_data.dart';

class _ShrinkIntent extends Intent {
  const _ShrinkIntent();
}

class _ExtendIntent extends Intent {
  const _ExtendIntent();
}

@internal
class Thumb extends StatefulWidget {
  final bool min;

  const Thumb({
    required this.min,
    super.key,
  });

  @override
  State<Thumb> createState() => _ThumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('min', value: min, ifTrue: 'min', ifFalse: 'max'));
  }
}

class _ThumbState extends State<Thumb> {
  MouseCursor _cursor = SystemMouseCursors.grab;

  @override
  Widget build(BuildContext context) {
    final controller = InheritedController.of(context);
    final InheritedData(
      style: FSliderStyle(:thumbStyle),
      :layout,
      :tooltipBuilder,
      :semanticValueFormatterCallback,
      :enabled,
    ) = InheritedData.of(context);

    String? increasedValue;
    if (controller.selection.step(min: widget.min, extend: !widget.min) case final selection
        when controller.selection != selection) {
      increasedValue = semanticValueFormatterCallback(offset(selection));
    }

    String? decreasedValue;
    if (controller.selection.step(min: widget.min, extend: widget.min) case final selection
    when controller.selection != selection) {
      decreasedValue = semanticValueFormatterCallback(offset(selection));
    }

    Widget thumb = Semantics(
      enabled: enabled,
      value: semanticValueFormatterCallback(offset(controller.selection)),
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      child: FocusableActionDetector(
        shortcuts: _shortcuts(layout),
        actions: {
          _ExtendIntent: CallbackAction(onInvoke: (_) => controller.step(min: widget.min, extend: true)),
          _ShrinkIntent: CallbackAction(onInvoke: (_) => controller.step(min: widget.min, extend: false)),
        },
        enabled: enabled,
        mouseCursor: enabled ? _cursor : MouseCursor.defer,
        includeFocusSemantics: false,
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
      ),
    );

    if (enabled) {
      final (horizontal, vertical) = _gestures(controller, layout);
      thumb = FTooltip(
        controller: controller.tooltip,
        tipBuilder: (context, style, _) => tooltipBuilder(style, offset(controller.selection)),
        longPress: false,
        hover: false,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() => _cursor = SystemMouseCursors.grabbing);
            controller.tooltip.show();
          },
          onTapUp: (_) {
            setState(() => _cursor = SystemMouseCursors.grab);
            controller.tooltip.hide();
          },
          onTapCancel: () => setState(() => _cursor = SystemMouseCursors.grab),
          onHorizontalDragUpdate: horizontal,
          onHorizontalDragEnd: (_) => controller.tooltip.hide(),
          onVerticalDragUpdate: vertical,
          onVerticalDragEnd: (_) => controller.tooltip.hide(),
          child: thumb,
        ),
      );
    }

    return thumb;
  }

  double offset(FSliderSelection selection) => widget.min ? selection.offset.min : selection.offset.max;

  Map<ShortcutActivator, Intent> _shortcuts(Layout layout) => switch ((layout, widget.min)) {
        (Layout.ltr, true) || (Layout.rtl, false) => const {
            SingleActivator(LogicalKeyboardKey.arrowLeft): _ExtendIntent(),
            SingleActivator(LogicalKeyboardKey.arrowRight): _ShrinkIntent(),
          },
        (Layout.ltr, false) || (Layout.rtl, true) => const {
            SingleActivator(LogicalKeyboardKey.arrowLeft): _ShrinkIntent(),
            SingleActivator(LogicalKeyboardKey.arrowRight): _ExtendIntent(),
          },
        (Layout.ttb, true) || (Layout.btt, false) => const {
            SingleActivator(LogicalKeyboardKey.arrowUp): _ExtendIntent(),
            SingleActivator(LogicalKeyboardKey.arrowDown): _ShrinkIntent(),
          },
        (Layout.ttb, false) || (Layout.btt, true) => const {
            SingleActivator(LogicalKeyboardKey.arrowUp): _ShrinkIntent(),
            SingleActivator(LogicalKeyboardKey.arrowDown): _ExtendIntent(),
          },
      };

  (GestureDragUpdateCallback?, GestureDragUpdateCallback?) _gestures(FSliderController controller, Layout layout) {
    if (controller.allowedInteraction == FSliderInteraction.tap) {
      return (null, null);
    }

    return switch (layout) {
      Layout.ltr => ((details) => controller.slide(details.delta.dx, min: widget.min), null),
      Layout.rtl => ((details) => controller.slide(-details.delta.dx, min: widget.min), null),
      Layout.ttb => (null, (details) => controller.slide(details.delta.dy, min: widget.min)),
      Layout.btt => (null, (details) => controller.slide(-details.delta.dy, min: widget.min)),
    };
  }
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
