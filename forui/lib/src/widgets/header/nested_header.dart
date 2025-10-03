part of 'header.dart';

/// A nested header.
///
/// A nested header contains the page's title and actions (including pop navigation).
/// It is typically used on pages that are not at the root of the navigation stack.
///
/// See:
/// * https://forui.dev/docs/navigation/header for working examples.
/// * [FHeaderStyle] for customizing a header's appearance.
class _FNestedHeader extends FHeader {
  /// The style.
  final FHeaderStyle Function(FHeaderStyle style)? style;

  /// The actions, aligned to the left in LTR locales. Defaults to an empty list.
  ///
  /// They are aligned to the right in RTL locales.
  final List<Widget> prefixes;

  /// The actions, aligned to the right. Defaults to an empty list.
  ///
  /// They are aligned to the left in RTL locales.
  final List<Widget> suffixes;

  /// The title's alignment.
  final AlignmentGeometry titleAlignment;

  /// Creates a [_FNestedHeader].
  const _FNestedHeader({
    this.style,
    this.prefixes = const [],
    this.suffixes = const [],
    this.titleAlignment = Alignment.center,
    super.title = const SizedBox(),
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.headerStyles.nestedStyle) ?? context.theme.headerStyles.nestedStyle;
    final alignment = titleAlignment.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    Widget header = SafeArea(
      bottom: false,
      child: Semantics(
        header: true,
        child: DecoratedBox(
          decoration: style.decoration,
          child: Padding(
            padding: style.padding,
            child: FHeaderData(
              actionStyle: style.actionStyle,
              child: _NestedHeader(
                alignment: alignment,
                prefixes: Row(mainAxisSize: MainAxisSize.min, spacing: style.actionSpacing, children: prefixes),
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DefaultTextStyle.merge(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: style.titleTextStyle,
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                    child: title,
                  ),
                ),
                suffixes: Row(mainAxisSize: MainAxisSize.min, spacing: style.actionSpacing, children: suffixes),
              ),
            ),
          ),
        ),
      ),
    );

    if (style.backgroundFilter case final filter?) {
      header = Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(filter: filter, child: Container()),
            ),
          ),
          header,
        ],
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(value: style.systemOverlayStyle, child: header);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('titleAlignment', titleAlignment));
  }
}

class _NestedHeader extends MultiChildRenderObjectWidget {
  final Alignment alignment;

  _NestedHeader({required this.alignment, required Widget prefixes, required Widget title, required Widget suffixes})
    : super(children: [prefixes, title, suffixes]);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderNestedHeader(alignment: alignment, textDirection: Directionality.of(context));

  @override
  void updateRenderObject(BuildContext context, covariant _RenderNestedHeader renderObject) => renderObject
    ..alignment = alignment
    ..direction = Directionality.of(context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('alignment', alignment));
  }
}

class _RenderNestedHeader extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  Alignment _alignment;
  TextDirection _direction;

  _RenderNestedHeader({required Alignment alignment, required TextDirection textDirection})
    : _alignment = alignment,
      _direction = textDirection;

  @override
  void setupParentData(RenderBox child) => child.parentData = DefaultData();

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    final prefixes = firstChild!;
    final title = childAfter(prefixes)!;
    final suffixes = childAfter(title)!;

    // We prioritize the prefixes and suffixes since they are interactive.
    prefixes.layout(constraints, parentUsesSize: true);
    suffixes.layout(constraints, parentUsesSize: true);
    title.layout(
      constraints.copyWith(maxWidth: constraints.maxWidth - prefixes.size.width - suffixes.size.width),
      parentUsesSize: true,
    );

    final height = [title.size.height, prefixes.size.height, suffixes.size.height].reduce(max);
    size = constraints.constrain(Size(constraints.maxWidth, height));

    final (left, right) = _direction == TextDirection.ltr ? (prefixes, suffixes) : (suffixes, prefixes);
    left.data.offset = Offset(0, (size.height - left.size.height) / 2);
    right.data.offset = Offset(size.width - right.size.width, (size.height - right.size.height) / 2);

    // Position title based on Alignment (-1 to 1) on each axis where 0 is center.
    // Title x-axis is relative to the center of the NestedHeader container
    final titleX = (size.width - title.size.width) / 2 * (alignment.x + 1);
    final titleY = (size.height - title.size.height) * (alignment.y + 1) / 2;
    title.data.offset = Offset(titleX.clamp(left.size.width, size.width - right.size.width - title.size.width), titleY);
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  Alignment get alignment => _alignment;

  set alignment(Alignment value) {
    if (_alignment == value) {
      return;
    }
    _alignment = value;
    markNeedsLayout();
  }

  TextDirection get direction => _direction;

  set direction(TextDirection value) {
    if (_direction == value) {
      return;
    }
    _direction = value;
    markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('alignment', alignment))
      ..add(EnumProperty('direction', direction));
  }
}
