import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'focused_outline.style.dart';

/// An outline around a focused widget that does not affect its layout.
///
/// See:
/// * https://forui.dev/docs/foundation/focused-outline for working examples.
/// * [FFocusedOutlineStyle] for customizing an outline.
class FFocusedOutline extends SingleChildRenderObjectWidget {
  /// The style.
  final FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? style;

  /// True if the [child] should be outlined.
  final bool focused;

  /// Creates a [FFocusedOutline].
  const FFocusedOutline({required this.focused, required super.child, this.style, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) => _Outline(
    style?.call(context.theme.style.focusedOutlineStyle) ?? context.theme.style.focusedOutlineStyle,
    Directionality.maybeOf(context) ?? TextDirection.ltr,
    focused: focused,
  );

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, _Outline outline) {
    outline
      ..style = style?.call(context.theme.style.focusedOutlineStyle) ?? context.theme.style.focusedOutlineStyle
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr
      ..focused = focused;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

class _Outline extends RenderProxyBox {
  FFocusedOutlineStyle _style;
  TextDirection _textDirection;
  bool _focused;

  _Outline(this._style, this._textDirection, {required bool focused}) : _focused = focused;

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    if (focused) {
      final radius = _style.borderRadius.resolve(_textDirection);
      context.canvas.drawPath(
        Path()..addRRect(
          RRect.fromRectAndCorners(
            (offset & child!.size).inflate(_style.spacing),
            topLeft: radius.topLeft,
            topRight: radius.topRight,
            bottomLeft: radius.bottomLeft,
            bottomRight: radius.bottomRight,
          ),
        ),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = _style.color
          ..strokeWidth = _style.width,
      );
    }
  }

  @override
  Rect get paintBounds => _focused ? child!.paintBounds.inflate(_style.spacing) : super.paintBounds;

  FFocusedOutlineStyle get style => _style;

  set style(FFocusedOutlineStyle value) {
    if (style != value) {
      _style = value;
      markNeedsPaint();
    }
  }

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    if (textDirection != value) {
      _textDirection = value;
      markNeedsPaint();
    }
  }

  bool get focused => _focused;

  set focused(bool value) {
    if (focused != value) {
      _focused = value;
      markNeedsPaint();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('textDirection', textDirection))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'));
  }
}

/// The [FFocusedOutline]'s style.
class FFocusedOutlineStyle with Diagnosticable, _$FFocusedOutlineStyleFunctions {
  /// The outline's color.
  @override
  final Color color;

  /// The border radius.
  @override
  final BorderRadiusGeometry borderRadius;

  /// The outline's width. Defaults to 1.
  ///
  /// ## Contract
  /// Must be > 0.
  @override
  final double width;

  /// The spacing between the outline and the outlined widget. Defaults to 3.
  @override
  final double spacing;

  /// Creates a [FFocusedOutlineStyle].
  const FFocusedOutlineStyle({required this.color, required this.borderRadius, this.width = 1, this.spacing = 3})
    : assert(0 < width, 'width ($width) must be > 0.');
}
