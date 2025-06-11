import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';

@internal
class TileRenderObject extends MultiChildRenderObjectWidget {
  final FTileContentStyle style;
  final FTileDivider divider;

  const TileRenderObject({required this.style, required this.divider, super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderTile(style, divider, Directionality.maybeOf(context) ?? TextDirection.ltr);

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, covariant _RenderTile tile) {
    tile
      ..style = style
      ..divider = divider
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider));
  }
}

class _Data extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

class _RenderTile extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _Data>, RenderBoxContainerDefaultsMixin<RenderBox, _Data> {
  FTileContentStyle _style;
  FTileDivider _divider;
  TextDirection _textDirection;

  _RenderTile(this._style, this._divider, this._textDirection);

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = _Data();

  @override
  void performLayout() {
    final EdgeInsets(:left, :top, :right, :bottom) = _style.padding.resolve(_textDirection);
    final prefix = firstChild!;
    final column = childAfter(prefix)!;
    final details = childAfter(column)!;
    final suffix = childAfter(details)!;
    final divider = childAfter(suffix)!;

    // Layout children.
    var contentConstraints = constraints.loosen().copyWith(maxWidth: constraints.maxWidth - left - right);

    prefix.layout(contentConstraints, parentUsesSize: true);
    contentConstraints = contentConstraints.copyWith(maxWidth: contentConstraints.maxWidth - prefix.size.width);

    suffix.layout(contentConstraints, parentUsesSize: true);
    contentConstraints = contentConstraints.copyWith(maxWidth: contentConstraints.maxWidth - suffix.size.width);

    // Column takes priority if details is text, and vice-versa.
    final (first, last) = details is RenderParagraph ? (column, details) : (details, column);

    first.layout(contentConstraints, parentUsesSize: true);
    contentConstraints = contentConstraints.copyWith(maxWidth: contentConstraints.maxWidth - first.size.width);
    last.layout(contentConstraints, parentUsesSize: true);

    // Layout divider based on the type.
    switch (_divider) {
      case FTileDivider.none || FTileDivider.full:
        divider.layout(constraints.loosen(), parentUsesSize: true);

      case FTileDivider.indented:
        final spacing = _textDirection == TextDirection.ltr ? left : right;
        final width = constraints.maxWidth - spacing - prefix.size.width;
        divider.layout(constraints.loosen().copyWith(maxWidth: width), parentUsesSize: true);
    }

    final height = [prefix.size.height, suffix.size.height, column.size.height, details.size.height].max;
    size = Size(constraints.maxWidth, height + top + bottom);

    // Position all children.
    final (l, ml, mr, r) = _textDirection == TextDirection.ltr
        ? (prefix, column, details, suffix)
        : (suffix, details, column, prefix);

    l.data.offset = Offset(left, top + (height - l.size.height) / 2);
    ml.data.offset = Offset(left + l.size.width, top + (height - ml.size.height) / 2);
    mr.data.offset = Offset(
      constraints.maxWidth - right - r.size.width - mr.size.width,
      top + (height - mr.size.height) / 2,
    );
    r.data.offset = Offset(constraints.maxWidth - right - r.size.width, top + (height - r.size.height) / 2);

    divider.data.offset = Offset(
      textDirection == TextDirection.ltr && _divider == FTileDivider.indented ? left + prefix.size.width : 0,
      top + height + bottom - divider.size.height
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(EnumProperty('textDirection', textDirection));
  }

  FTileContentStyle get style => _style;

  set style(FTileContentStyle value) {
    if (_style != value) {
      _style = value;
      markNeedsLayout();
    }
  }

  FTileDivider get divider => _divider;

  set divider(FTileDivider value) {
    if (_divider != value) {
      _divider = value;
      markNeedsLayout();
    }
  }

  TextDirection get textDirection => _textDirection;

  set textDirection(TextDirection value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsLayout();
    }
  }
}
