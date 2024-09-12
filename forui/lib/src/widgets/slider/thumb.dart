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

class _ThumbState extends State<Thumb> with SingleTickerProviderStateMixin {
  late FSliderController _controller;
  late final FTooltipController _tooltip;
  MouseCursor _cursor = SystemMouseCursors.grab;
  ({double min, double max})? _origin;

  @override
  void initState() {
    super.initState();
    _tooltip = FTooltipController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = InheritedController.of(context)..tooltips.add(_tooltip);
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(
      :style,
      :layout,
      :tooltipBuilder,
      :semanticValueFormatterCallback,
      :enabled,
    ) = InheritedData.of(context);

    String? increasedValue;
    if (_controller.selection.step(min: widget.min, extend: !widget.min) case final selection
        when _controller.selection != selection) {
      increasedValue = semanticValueFormatterCallback(offset(selection));
    }

    String? decreasedValue;
    if (_controller.selection.step(min: widget.min, extend: widget.min) case final selection
        when _controller.selection != selection) {
      decreasedValue = semanticValueFormatterCallback(offset(selection));
      print(offset(_controller.selection));
      print(offset(selection));
    }

    Widget thumb = Semantics(
      enabled: enabled,
      value: semanticValueFormatterCallback(offset(_controller.selection)),
      increasedValue: increasedValue,
      decreasedValue: decreasedValue,
      child: FocusableActionDetector(
        shortcuts: _shortcuts(layout),
        actions: {
          _ExtendIntent: CallbackAction(onInvoke: (_) => _controller.step(min: widget.min, extend: true)),
          _ShrinkIntent: CallbackAction(onInvoke: (_) => _controller.step(min: widget.min, extend: false)),
        },
        enabled: enabled,
        mouseCursor: enabled ? _cursor : MouseCursor.defer,
        includeFocusSemantics: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: style.thumbStyle.color,
            border: Border.all(
              color: style.thumbStyle.borderColor,
              width: style.thumbStyle.borderWidth,
            ),
          ),
          child: SizedBox.square(
            dimension: style.thumbStyle.dimension,
          ),
        ),
      ),
    );

    if (enabled) {
      final (horizontal, vertical) = _gestures(_controller, style, layout);
      thumb = GestureDetector(
        onTapDown: (_) {
          setState(() => _cursor = SystemMouseCursors.grabbing);
          _controller.tooltips.show();
        },
        onTapUp: (_) {
          setState(() => _cursor = SystemMouseCursors.grab);
          _controller.tooltips.show();
        },
        onHorizontalDragStart: (_) => _origin = _controller.selection.rawOffset,
        onHorizontalDragUpdate: horizontal,
        onHorizontalDragEnd: (_) {
          setState(() => _cursor = SystemMouseCursors.grab);
          _origin = null;
          _controller.tooltips.hide();
        },
        onVerticalDragStart: (_) => _origin = _controller.selection.rawOffset,
        onVerticalDragUpdate: vertical,
        onVerticalDragEnd: (_) {
          setState(() => _cursor = SystemMouseCursors.grab);
          _origin = null;
          _controller.tooltips.hide();
        },
        child: thumb,
      );
    }

    if (_controller.tooltips.enabled) {
      thumb = FTooltip(
        controller: _tooltip,
        tipBuilder: (context, style, _) => tooltipBuilder(style, offset(_controller.selection)),
        longPress: false,
        hover: false,
        child: thumb,
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

  (GestureDragUpdateCallback?, GestureDragUpdateCallback?) _gestures(
    FSliderController controller,
    FSliderStyle style,
    Layout layout,
  ) {
    if (controller.allowedInteraction == FSliderInteraction.tap) {
      return (null, null);
    }

    final translate = layout.translate(style);
    void drag(DragUpdateDetails details) {
      final origin = widget.min ? _origin!.min : _origin!.max;
      controller.slide(origin + translate(details.localPosition), min: widget.min);
    }

    return layout.vertical ? (null, drag) : (drag, null);
  }

  @override
  void dispose() {
    _controller.tooltips.remove(_tooltip);
    _tooltip.dispose();
    super.dispose();
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

@internal
extension Layouts on Layout {
  double Function(Offset) translate(FSliderStyle style) => switch (this) {
        Layout.ltr => (offset) => offset.dx - style.thumbStyle.dimension / 2,
        Layout.rtl => (offset) => -offset.dx + style.thumbStyle.dimension / 2,
        Layout.ttb => (offset) => offset.dy - style.thumbStyle.dimension / 2,
        Layout.btt => (offset) => -offset.dy + style.thumbStyle.dimension / 2,
      };
}
