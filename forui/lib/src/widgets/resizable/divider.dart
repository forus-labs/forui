import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'divider.design.dart';

class _Up extends Intent {
  const _Up();
}

class _Down extends Intent {
  const _Down();
}

@internal
sealed class Divider extends StatefulWidget {
  final FResizableController controller;
  final FResizableDividerStyle style;
  final FResizableDivider type;
  final int left;
  final int right;
  final double? crossAxisExtent;
  final double hitRegionExtent;
  final double resizePercentage;
  final MouseCursor cursor;
  final String Function(FResizableRegionData first, FResizableRegionData second) semanticFormatterCallback;

  const Divider({
    required this.controller,
    required this.style,
    required this.type,
    required this.left,
    required this.right,
    required this.crossAxisExtent,
    required this.hitRegionExtent,
    required this.resizePercentage,
    required this.cursor,
    required this.semanticFormatterCallback,
    super.key,
  }) : assert(0 <= left, 'left ($left) must be >= 0'),
       assert(left + 1 == right, 'Left and right should be next to each other.');

  Widget focusableActionDetector({
    required Map<ShortcutActivator, Intent> shortcuts,
    required List<Widget> children,
    required bool focused,
    required ValueChanged<bool> onFocusChange,
  }) => Semantics(
    value: semanticFormatterCallback(controller.regions[left], controller.regions[right]),
    child: FocusableActionDetector(
      mouseCursor: cursor,
      shortcuts: shortcuts,
      onFocusChange: onFocusChange,
      actions: {
        _Up: CallbackAction(
          onInvoke: (_) => controller.update(left, right, -resizePercentage * (controller.regions[left].extent.total)),
        ),
        _Down: CallbackAction(
          onInvoke: (_) => controller.update(left, right, resizePercentage * (controller.regions[left].extent.total)),
        ),
      },
      child: FFocusedOutline(
        focused: focused,
        child: Stack(alignment: AlignmentDirectional.center, children: children),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('type', type))
      ..add(IntProperty('left', left))
      ..add(IntProperty('right', right))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('hitRegionExtent', hitRegionExtent))
      ..add(PercentProperty('resizePercentage', resizePercentage))
      ..add(DiagnosticsProperty('cursor', cursor))
      ..add(ObjectFlagProperty.has('semanticFormatterCallback', semanticFormatterCallback));
  }
}

@internal
class HorizontalDivider extends Divider {
  const HorizontalDivider({
    required super.controller,
    required super.style,
    required super.type,
    required super.left,
    required super.right,
    required super.crossAxisExtent,
    required super.hitRegionExtent,
    required super.resizePercentage,
    required super.cursor,
    required super.semanticFormatterCallback,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _HorizontalDividerState();
}

class _HorizontalDividerState extends State<HorizontalDivider> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) => Positioned(
    left: widget.controller.regions[widget.left].offset.max - (widget.hitRegionExtent / 2),
    child: widget.focusableActionDetector(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowLeft): _Up(),
        SingleActivator(LogicalKeyboardKey.arrowRight): _Down(),
      },
      onFocusChange: (focused) => setState(() => _focused = focused),
      focused: _focused,
      children: [
        if (widget.type == FResizableDivider.divider || widget.type == FResizableDivider.dividerWithThumb)
          ColoredBox(
            color: widget.style.color,
            child: SizedBox(height: widget.crossAxisExtent, width: widget.style.width),
          ),
        if (widget.type == FResizableDivider.dividerWithThumb)
          _Thumb(style: widget.style.thumbStyle, icon: FIcons.gripVertical),
        SizedBox(
          height: widget.crossAxisExtent,
          width: widget.hitRegionExtent,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx == 0.0) {
                return;
              }

              widget.controller.update(widget.left, widget.right, details.delta.dx);
              // TODO: haptic feedback
            },
            onHorizontalDragEnd: (_) => widget.controller.end(widget.left, widget.right),
          ),
        ),
      ],
    ),
  );
}

@internal
class VerticalDivider extends Divider {
  const VerticalDivider({
    required super.controller,
    required super.style,
    required super.type,
    required super.left,
    required super.right,
    required super.crossAxisExtent,
    required super.hitRegionExtent,
    required super.resizePercentage,
    required super.cursor,
    required super.semanticFormatterCallback,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _VerticalDividerState();
}

class _VerticalDividerState extends State<VerticalDivider> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) => Positioned(
    top: widget.controller.regions[widget.left].offset.max - (widget.hitRegionExtent / 2),
    child: widget.focusableActionDetector(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowUp): _Up(),
        SingleActivator(LogicalKeyboardKey.arrowDown): _Down(),
      },
      onFocusChange: (focused) => setState(() => _focused = focused),
      focused: _focused,
      children: [
        if (widget.type == FResizableDivider.divider || widget.type == FResizableDivider.dividerWithThumb)
          ColoredBox(
            color: widget.style.color,
            child: SizedBox(height: widget.style.width, width: widget.crossAxisExtent),
          ),
        if (widget.type == FResizableDivider.dividerWithThumb)
          _Thumb(style: widget.style.thumbStyle, icon: FIcons.gripHorizontal),
        SizedBox(
          height: widget.hitRegionExtent,
          width: widget.crossAxisExtent,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.delta.dy == 0.0) {
                return;
              }

              widget.controller.update(widget.left, widget.right, details.delta.dy);
              // TODO: haptic feedback
            },
            onVerticalDragEnd: (_) => widget.controller.end(widget.left, widget.right),
          ),
        ),
      ],
    ),
  );
}

class _Thumb extends StatelessWidget {
  final FResizableDividerThumbStyle style;
  final IconData icon;

  const _Thumb({required this.style, required this.icon});

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    decoration: style.decoration,
    height: style.height,
    width: style.width,
    child: Icon(icon, color: style.foregroundColor, size: min(style.height, style.width)),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

/// The appearance of dividers between [FResizableRegion]s.
enum FResizableDivider {
  /// No divider.
  none,

  /// Divider without thumb.
  divider,

  /// Divider with thumb.
  dividerWithThumb,
}

/// The style of the dividers between [FResizableRegion]s.
class FResizableDividerStyle with Diagnosticable, _$FResizableDividerStyleFunctions {
  /// The divider's color.
  @override
  final Color color;

  /// The divider's width (thickness). Defaults to `0.5`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [width] <= 0.
  @override
  final double width;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The divider thumb's style.
  @override
  final FResizableDividerThumbStyle thumbStyle;

  /// Creates a [FResizableDividerStyle].
  FResizableDividerStyle({
    required this.color,
    required this.focusedOutlineStyle,
    required this.thumbStyle,
    this.width = 0.5,
  }) : assert(0 < width, 'width ($width) must be > 0');
}

/// The style of the dividers' thumbs between [FResizableRegion]s.
class FResizableDividerThumbStyle with Diagnosticable, _$FResizableDividerThumbStyleFunctions {
  /// The background color.
  @override
  final BoxDecoration decoration;

  /// The foreground color.
  @override
  final Color foregroundColor;

  /// The height.
  ///
  /// ## Contract
  /// Throws [AssertionError] if height] <= 0.
  @override
  final double height;

  /// The width.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [width] <= 0.
  @override
  final double width;

  /// Creates a [FResizableDividerThumbStyle].
  FResizableDividerThumbStyle({
    required this.decoration,
    required this.foregroundColor,
    required this.height,
    required this.width,
  }) : assert(0 < height, 'height ($height) must be > 0'),
       assert(0 < width, 'width ($width) must be > 0');
}
