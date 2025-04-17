// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';

@internal
class TileRenderObject extends MultiChildRenderObjectWidget {
  final FTileContentStyle style;
  final FTileDivider divider;
  final bool first;
  final bool last;
  final BorderSide? side;

  const TileRenderObject({
    required this.style,
    required this.divider,
    required this.first,
    required this.last,
    required this.side,
    super.key,
    super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderTile(style, divider, first, last, side, Directionality.maybeOf(context) ?? TextDirection.ltr);

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, covariant _RenderTile tile) {
    tile
      ..style = style
      ..divider = divider
      ..side = side
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('first', value: first, ifTrue: 'first'))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'))
      ..add(DiagnosticsProperty('side', side));
  }
}

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

class _RenderTile extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  FTileContentStyle _style;
  FTileDivider _divider;
  bool _first;
  bool _last;
  BorderSide? _side;
  TextDirection _textDirection;

  _RenderTile(this._style, this._divider, this._first, this._last, this._side, this._textDirection);

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = _Data();

  @override
  void performLayout() {
    final EdgeInsets(:left, :top, :right, :bottom) = _style.padding.resolve(_textDirection);
    var constraints = this.constraints.loosen().copyWith(maxWidth: this.constraints.maxWidth - left - right);
    var height = 0.0;

    final prefix = firstChild!;
    final column = childAfter(prefix)!;
    final details = childAfter(column)!;
    final suffix = childAfter(details)!;
    final divider = childAfter(suffix)!;

    // Layout all children
    prefix.layout(constraints, parentUsesSize: true);
    constraints = constraints.copyWith(maxWidth: constraints.maxWidth - prefix.size.width);
    height = prefix.size.height;

    suffix.layout(constraints, parentUsesSize: true);
    constraints = constraints.copyWith(maxWidth: constraints.maxWidth - suffix.size.width);
    height = max(height, suffix.size.height);

    // Details take priority if it is not text, i.e. a checkbox/switch. Otherwise, if details is text, we always try to
    // shrink it first.
    if (details is RenderParagraph) {
      column.layout(constraints, parentUsesSize: true);
      constraints = constraints.copyWith(maxWidth: constraints.maxWidth - column.size.width);
      details.layout(constraints, parentUsesSize: true);
    } else {
      details.layout(constraints, parentUsesSize: true);
      constraints = constraints.copyWith(maxWidth: constraints.maxWidth - details.size.width);
      column.layout(constraints, parentUsesSize: true);
    }

    switch (_divider) {
      case FTileDivider.none || FTileDivider.full:
        divider.layout(this.constraints.loosen(), parentUsesSize: true);

      case FTileDivider.indented:
        final constraints = this.constraints.loosen();
        final width = constraints.maxWidth - left - prefix.size.width;
        divider.layout(constraints.copyWith(maxWidth: width), parentUsesSize: true);
    }

    height = max(height, column.size.height);
    height = max(height, details.size.height);

    // Position all children
    if (textDirection == TextDirection.ltr) {
      prefix.data.offset = Offset(left, top + (height - prefix.size.height) / 2);
      column.data.offset = Offset(left + prefix.size.width, top + (height - column.size.height) / 2);

      details.data.offset = Offset(
        this.constraints.maxWidth - right - suffix.size.width - details.size.width,
        top + (height - details.size.height) / 2,
      );
      suffix.data.offset = Offset(
        this.constraints.maxWidth - right - suffix.size.width,
        top + (height - suffix.size.height) / 2,
      );

      divider.data.offset = Offset(
        _divider == FTileDivider.indented ? left + prefix.size.width : 0,
        top + height + bottom - divider.size.height,
      );
    } else {
      suffix.data.offset = Offset(left, top + (height - suffix.size.height) / 2);
      details.data.offset = Offset(left + suffix.size.width, top + (height - details.size.height) / 2);

      column.data.offset = Offset(
        this.constraints.maxWidth - right - prefix.size.width - column.size.width,
        top + (height - column.size.height) / 2,
      );
      prefix.data.offset = Offset(
        this.constraints.maxWidth - right - prefix.size.width,
        top + (height - prefix.size.height) / 2,
      );

      divider.data.offset = Offset(0, top + height + bottom - divider.size.height);
    }

    size = Size(this.constraints.maxWidth, height + top + bottom);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
    if (side case final side?) {
      final canvas = context.canvas;
      final focusedOutline =
          Paint()
            ..color = side.color
            ..style = PaintingStyle.stroke
            ..isAntiAlias = false
            ..blendMode = BlendMode.src
            ..strokeWidth = 1;

      if (!first) {
        canvas.drawLine(Offset(offset.dx, offset.dy), Offset(offset.dx + size.width, offset.dy), focusedOutline);
      }

      if (!last) {
        canvas.drawLine(
          Offset(offset.dx, offset.dy + size.height),
          Offset(offset.dx + size.width, offset.dy + size.height),
          focusedOutline,
        );
      }
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('first', value: first, ifTrue: 'first'))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'))
      ..add(DiagnosticsProperty('side', side))
      ..add(EnumProperty('textDirection', textDirection));
  }

  FTileContentStyle get style => _style;

  set style(FTileContentStyle value) {
    if (_style == value) {
      return;
    }

    _style = value;
    markNeedsPaint();
  }

  FTileDivider get divider => _divider;

  set divider(FTileDivider value) {
    if (_divider == value) {
      return;
    }

    _divider = value;
    markNeedsLayout();
  }

  bool get first => _first;

  set first(bool value) {
    if (_first == value) {
      return;
    }

    _first = value;
    markNeedsPaint();
  }

  bool get last => _last;

  set last(bool value) {
    if (_last == value) {
      return;
    }

    _last = value;
    markNeedsPaint();
  }

  BorderSide? get side => _side;

  set side(BorderSide? value) {
    if (_side == value) {
      return;
    }

    _side = value;
    markNeedsPaint();
  }

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection == value) {
      return;
    }

    _textDirection = value;
    markNeedsLayout();
  }
}
