import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/rendering.dart';

part 'item_content.style.dart';

@internal
class FItemContent extends StatelessWidget {
  final FItemContentStyle style;
  final FWidgetStateMap<FDividerStyle>? dividerStyle;
  final FItemDivider dividerType;
  final Set<WidgetState> states;
  final Widget? prefix;
  final Widget title;
  final Widget? subtitle;
  final Widget? details;
  final Widget? suffix;

  const FItemContent({
    required this.style,
    required this.dividerStyle,
    required this.dividerType,
    required this.states,
    required this.title,
    required this.prefix,
    required this.subtitle,
    required this.details,
    required this.suffix,
    super.key,
  }) : assert(
         dividerStyle != null || dividerType == FItemDivider.none,
         "dividerStyle must be provided if dividerType is not FItemDivider.none. This is a bug unless you're creating your "
         'own custom item container.',
       );

  @override
  Widget build(BuildContext context) => _ItemContent(
    style: style,
    dividerType: dividerType,
    children: [
      if (prefix case final prefix?)
        Padding(
          padding: EdgeInsetsDirectional.only(end: style.prefixIconSpacing),
          child: IconTheme(data: style.prefixIconStyle.resolve(states), child: prefix),
        )
      else
        const SizedBox(),
      Padding(
        padding: EdgeInsetsDirectional.only(end: style.middleSpacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: style.titleSpacing,
          children: [
            DefaultTextStyle.merge(
              style: style.titleTextStyle.resolve(states),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              overflow: TextOverflow.ellipsis,
              child: title,
            ),
            if (subtitle case final subtitle?)
              DefaultTextStyle.merge(
                style: style.subtitleTextStyle.resolve(states),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                overflow: TextOverflow.ellipsis,
                child: subtitle,
              ),
          ],
        ),
      ),
      if (details case final details?)
        DefaultTextStyle.merge(
          style: style.detailsTextStyle.resolve(states),
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          overflow: TextOverflow.ellipsis,
          child: details,
        )
      else
        const SizedBox(),
      if (suffix case final suffixIcon?)
        Padding(
          padding: EdgeInsetsDirectional.only(start: style.suffixIconSpacing),
          child: IconTheme(data: style.suffixIconStyle.resolve(states), child: suffixIcon),
        )
      else
        const SizedBox(),
      if (dividerType == FItemDivider.none) const SizedBox() else FDivider(style: dividerStyle!.resolve(states)),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('dividerType', dividerType))
      ..add(IterableProperty('states', states));
  }
}

class _ItemContent extends MultiChildRenderObjectWidget {
  final FItemContentStyle style;
  final FItemDivider dividerType;

  const _ItemContent({required this.style, required this.dividerType, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderItemContent(style, dividerType, Directionality.maybeOf(context) ?? TextDirection.ltr);

  @override
  void updateRenderObject(BuildContext context, covariant _RenderItemContent content) {
    content
      ..style = style
      ..dividerType = dividerType
      ..textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('dividerType', dividerType));
  }
}

class _RenderItemContent extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, DefaultData>, RenderBoxContainerDefaultsMixin<RenderBox, DefaultData> {
  FItemContentStyle _style;
  FItemDivider _dividerType;
  TextDirection _textDirection;

  _RenderItemContent(this._style, this._dividerType, this._textDirection);

  @override
  void setupParentData(covariant RenderObject child) => child.parentData = DefaultData();

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
    switch (_dividerType) {
      case FItemDivider.none || FItemDivider.full:
        divider.layout(constraints.loosen(), parentUsesSize: true);

      case FItemDivider.indented:
        final spacing = _textDirection == TextDirection.ltr ? left : right;
        final width = constraints.maxWidth - spacing - prefix.size.width;
        divider.layout(constraints.loosen().copyWith(maxWidth: width), parentUsesSize: true);
    }

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

    divider.data.offset = Offset(
      textDirection == TextDirection.ltr && _dividerType == FItemDivider.indented ? left + prefix.size.width : 0,
      top + height + bottom - divider.size.height,
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
      ..add(EnumProperty('dividerType', dividerType))
      ..add(EnumProperty('textDirection', textDirection));
  }

  FItemContentStyle get style => _style;

  set style(FItemContentStyle value) {
    if (_style != value) {
      _style = value;
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

/// An [FItem] content's style.
class FItemContentStyle with Diagnosticable, _$FItemContentStyleFunctions {
  /// The content's padding. Defaults to `EdgeInsetsDirectional.only(15, 13, 10, 13)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The prefix icon style.
  @override
  final FWidgetStateMap<IconThemeData> prefixIconStyle;

  /// The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override
  final double prefixIconSpacing;

  /// The title's text style.
  @override
  final FWidgetStateMap<TextStyle> titleTextStyle;

  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [titleSpacing] is negative.
  @override
  final double titleSpacing;

  /// The subtitle's text style.
  @override
  final FWidgetStateMap<TextStyle> subtitleTextStyle;

  /// The minimum horizontal spacing between the title, subtitle, combined, and the details. Defaults to 4.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [middleSpacing] is negative.
  @override
  final double middleSpacing;

  /// The details text style.
  @override
  final FWidgetStateMap<TextStyle> detailsTextStyle;

  /// The suffix icon style.
  @override
  final FWidgetStateMap<IconThemeData> suffixIconStyle;

  /// The horizontal spacing between the details and suffix icon. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [suffixIconSpacing] is negative.
  @override
  final double suffixIconSpacing;

  /// Creates a [FItemContentStyle].
  FItemContentStyle({
    required this.prefixIconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.detailsTextStyle,
    required this.suffixIconStyle,
    this.padding = const EdgeInsetsDirectional.fromSTEB(15, 13, 10, 13),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 3,
    this.middleSpacing = 4,
    this.suffixIconSpacing = 5,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing must be non-negative.'),
       assert(0 <= titleSpacing, 'titleSpacing must be non-negative.'),
       assert(0 <= middleSpacing, 'middleSpacing must be non-negative.'),
       assert(0 <= suffixIconSpacing, 'suffixIconSpacing must be non-negative.');

  /// Creates a [FItemContentStyle] that inherits its properties.
  FItemContentStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        prefixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 18),
          WidgetState.any: IconThemeData(color: colors.primary, size: 18),
        }),
        titleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.base,
        }),
        subtitleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
        }),
        detailsTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.base.copyWith(color: colors.mutedForeground),
        }),
        suffixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 18),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 18),
        }),
      );
}
