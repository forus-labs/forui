import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:meta/meta.dart';

@internal
class ItemContentLayout extends MultiChildRenderObjectWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final FDividerStyle? dividerStyle;
  final FItemDivider dividerType;

  const ItemContentLayout({
    required this.margin,
    required this.padding,
    required this.dividerStyle,
    required this.dividerType,
    super.children,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    return _RenderItemContent(
      margin.resolve(direction),
      padding.resolve(direction),
      dividerStyle,
      dividerType,
      direction,
    );
  }

  @override
  // ignore: library_private_types_in_public_api
  void updateRenderObject(BuildContext context, covariant _RenderItemContent content) {
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    content
      ..margin = margin.resolve(direction)
      ..padding = padding.resolve(direction)
      ..dividerStyle = dividerStyle
      ..dividerType = dividerType
      ..textDirection = direction;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(EnumProperty('dividerType', dividerType));
  }
}

class _RenderItemContent extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  EdgeInsets _margin;
  EdgeInsets _padding;
  FDividerStyle? _dividerStyle;
  FItemDivider _dividerType;
  TextDirection _textDirection;

  _RenderItemContent(this._margin, this._padding, this._dividerStyle, this._dividerType, this._textDirection);

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = DefaultData();

  @override
  void performLayout() {
    final EdgeInsets(:left, :top, :right, :bottom) = _padding;
    final prefix = firstChild!;
    final column = childAfter(prefix)!;
    final details = childAfter(column)!;
    final suffix = childAfter(details)!;

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

    final height = [prefix.size.height, suffix.size.height, column.size.height, details.size.height].max;
    size = Size(constraints.maxWidth, height + top + bottom);

    // Position children.
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
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
    if (dividerType == FItemDivider.none) {
      return;
    }

    final EdgeInsets(:left, :top, :right, :bottom) = _padding;
    // We offset the divider by 0.5 to avoid a gap between the line and the tile below.
    final y = offset.dy + size.height + _margin.vertical - _dividerStyle!.width + 0.5;
    final paint = Paint()
      ..isAntiAlias = false
      ..color = _dividerStyle!.color
      ..strokeWidth = _dividerStyle!.width;

    if (_dividerType == FItemDivider.indented) {
      final prefix = firstChild!;
      final spacing = _textDirection == TextDirection.ltr ? left : right;

      if (_textDirection == TextDirection.ltr) {
        context.canvas.drawLine(
          Offset(offset.dx + spacing + prefix.size.width, y),
          Offset(offset.dx + size.width + _margin.right, y),
          paint,
        );
      } else {
        context.canvas.drawLine(
          Offset(offset.dx - _margin.left, y),
          Offset(offset.dx + size.width - spacing - prefix.size.width, y),
          paint,
        );
      }
    } else {
      context.canvas.drawLine(
        Offset(offset.dx - _margin.left, y),
        Offset(offset.dx + size.width + _margin.right, y),
        paint,
      );
    }
  }

  @override
  Rect get paintBounds =>
      Offset(_margin.left, _margin.top) & Size(size.width + _margin.horizontal, size.height + _margin.vertical);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(EnumProperty('dividerType', dividerType))
      ..add(EnumProperty('textDirection', textDirection));
  }

  EdgeInsets get padding => _padding;

  set padding(EdgeInsets value) {
    if (_padding != value) {
      _padding = value;
      markNeedsLayout();
    }
  }

  EdgeInsets get margin => _margin;

  set margin(EdgeInsets value) {
    if (_margin != value) {
      _margin = value;
      markNeedsLayout();
    }
  }

  FDividerStyle? get dividerStyle => _dividerStyle;

  set dividerStyle(FDividerStyle? value) {
    if (_dividerStyle != value) {
      _dividerStyle = value;
      markNeedsLayout();
    }
  }

  FItemDivider get dividerType => _dividerType;

  set dividerType(FItemDivider value) {
    if (_dividerType != value) {
      _dividerType = value;
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
