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

  const TileRenderObject({required this.style, required this.divider, super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderTile(style, divider);

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, covariant _RenderTile renderObject) {
    renderObject
      ..style = style
      ..divider = divider;
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

  _RenderTile(this._style, this._divider);

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = _Data();

  @override
  void performLayout() {
    final EdgeInsets(:left, :top, :right, :bottom) = _style.padding;
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

    size = Size(this.constraints.maxWidth, height + top + bottom);
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
      ..add(EnumProperty('divider', divider));
  }

  FTileContentStyle get style => _style;

  set style(FTileContentStyle value) {
    if (_style == value) {
      return;
    }

    _style = value;
    markNeedsLayout();
  }

  FTileDivider get divider => _divider;

  set divider(FTileDivider value) {
    if (_divider == value) {
      return;
    }

    _divider = value;
    markNeedsLayout();
  }
}
