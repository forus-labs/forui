import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/item/render_item_content.dart';
import 'package:meta/meta.dart';

part 'raw_item_content.style.dart';

@internal
class RawItemContent extends StatelessWidget {
  final FRawItemContentStyle style;
  final FWidgetStateMap<FDividerStyle>? dividerStyle;
  final FItemDivider dividerType;
  final EdgeInsetsGeometry padding;
  final Set<WidgetState> states;
  final Widget? prefix;
  final Widget child;

  const RawItemContent({
    required this.style,
    required this.dividerStyle,
    required this.dividerType,
    required this.padding,
    required this.states,
    required this.prefix,
    required this.child,
    super.key,
  }) : assert(
         dividerStyle != null || dividerType == FItemDivider.none,
         "dividerStyle must be provided if dividerType is not FItemDivider.none. This is a bug unless you're creating your "
         'own custom item container.',
       );

  @override
  Widget build(BuildContext context) => ItemContentLayout(
    padding: padding,
    margin: style.padding,
    dividerStyle: dividerStyle?.resolve(states),
    dividerType: dividerType,
    children: [
      if (prefix case final prefix?)
        Padding(
          padding: EdgeInsetsDirectional.only(end: style.prefixIconSpacing),
          child: IconTheme(data: style.prefixIconStyle.resolve(states), child: prefix),
        )
      else
        const SizedBox(),
      DefaultTextStyle.merge(
        style: style.childTextStyle.resolve(states),
        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
        overflow: TextOverflow.ellipsis,
        child: child,
      ),
      const SizedBox(),
      const SizedBox(),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('dividerType', dividerType))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(IterableProperty('states', states));
  }
}

/// An [FItem] raw content's style.
class FRawItemContentStyle with Diagnosticable, _$FRawItemContentStyleFunctions {
  /// The content's padding. Defaults to `EdgeInsetsDirectional.only(15, 13, 10, 13)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The prefix icon style.
  @override
  final FWidgetStateMap<IconThemeData> prefixIconStyle;

  /// The horizontal spacing between the prefix icon and child. Defaults to 10.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [prefixIconSpacing] is negative.
  @override
  final double prefixIconSpacing;

  /// The child's text style.
  @override
  final FWidgetStateMap<TextStyle> childTextStyle;

  /// Creates a [FRawItemContentStyle].
  FRawItemContentStyle({
    required this.prefixIconStyle,
    required this.childTextStyle,
    this.padding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
    this.prefixIconSpacing = 10,
  }) : assert(0 <= prefixIconSpacing, 'prefixIconSpacing must be non-negative.');

  /// Creates a [FRawItemContentStyle] that inherits its properties.
  FRawItemContentStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        prefixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
          WidgetState.any: IconThemeData(color: colors.primary, size: 15),
        }),
        childTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.sm,
        }),
      );
}
