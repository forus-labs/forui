import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_content.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_controller.dart';
import 'package:meta/meta.dart';

part 'autocomplete_item.style.dart';

/// A marker interface which denotes that mixed-in widgets can be used in a [FAutocomplete].
mixin FAutocompleteItemMixin on Widget {}

/// A section in a [FAutocomplete] that can contain multiple [FAutocompleteItem]s.
class FAutocompleteSection extends StatelessWidget with FAutocompleteItemMixin {
  /// The style. Defaults to the [FAutocompleteSectionStyle] inherited from the parent [FAutocomplete].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create autocomplete-section
  /// ```
  final FAutocompleteSectionStyle Function(FAutocompleteSectionStyle)? style;

  /// True if the section is enabled. Disabled sections cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to inheriting from the [FAutocomplete].
  final bool? enabled;

  /// The divider style. Defaults to the [FItemDivider] inherited from the parent [FAutocomplete]. Defaults to
  /// [FItemDivider.none].
  final FItemDivider divider;

  /// The label.
  final Widget label;

  /// The nested [FAutocompleteItem]s.
  final List<FAutocompleteItem> children;

  /// Creates a [FAutocompleteSection] from the given items.
  ///
  /// For more control over the appearance of individual items, use [FAutocompleteSection.custom].
  FAutocompleteSection({
    required Widget label,
    required List<String> items,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle)? style,
    bool? enabled,
    FItemDivider divider = FItemDivider.none,
    Key? key,
  }) : this.custom(
         label: label,
         children: [for (final item in items) FAutocompleteItem(item)],
         style: style,
         enabled: enabled,
         divider: divider,
         key: key,
       );

  /// Creates a [FAutocompleteSection].
  ///
  /// For a convenient way to create a section with a list of items, use [FAutocompleteSection.new].
  const FAutocompleteSection.custom({
    required this.label,
    required this.children,
    this.style,
    this.enabled,
    this.divider = FItemDivider.none,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final content = ContentData.of(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style) ?? content.style;
    final itemStyle = style.itemStyle.toFItemStyle(context);

    return ContentData(
      style: style,
      enabled: enabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle.merge(
            style: style.labelTextStyle.resolve({if (!enabled) WidgetState.disabled}),
            child: Padding(padding: style.labelPadding, child: label),
          ),
          if (children.firstOrNull case final first?)
            ContentData(
              style: style,
              enabled: enabled,
              child: FInheritedItemData.merge(
                style: itemStyle,
                divider: divider,
                index: 0,
                last: children.length == 1,
                child: first,
              ),
            ),
          for (final (i, child) in children.indexed.skip(1))
            FInheritedItemData.merge(
              style: itemStyle,
              divider: divider,
              index: i,
              last: i == children.length - 1,
              child: child,
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(EnumProperty('divider', divider));
  }
}

/// A [FAutocompleteSection]'s style.
class FAutocompleteSectionStyle with Diagnosticable, _$FAutocompleteSectionStyleFunctions {
  /// The enabled label's text style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<TextStyle> labelTextStyle;

  /// The padding around the label. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  @override
  final EdgeInsetsGeometry labelPadding;

  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<Color> dividerColor;

  /// The divider's width.
  @override
  final double dividerWidth;

  /// The section's items' style.
  @override
  final FAutocompleteItemStyle itemStyle;

  /// Creates a [FAutocompleteSectionStyle].
  FAutocompleteSectionStyle({
    required this.labelTextStyle,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.labelPadding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FAutocompleteSectionStyle] that inherits its properties.
  FAutocompleteSectionStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
    : this(
        labelTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(
            color: colors.disable(colors.primary),
            fontWeight: FontWeight.w600,
          ),
          WidgetState.any: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
        }),
        dividerColor: FWidgetStateMap.all(colors.border),
        dividerWidth: style.borderWidth,
        itemStyle: FAutocompleteItemStyle.inherit(colors: colors, style: style, typography: typography),
      );
}

/// A suggestion in a [FAutocomplete] that can optionally be nested in a [FAutocompleteSection].
class FAutocompleteItem extends StatelessWidget with FAutocompleteItemMixin {
  /// The style. Defaults to the [FItemStyle] inherited from the parent [FAutocompleteSection] or [FAutocomplete].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item
  /// ```
  final FAutocompleteItemStyle Function(FAutocompleteItemStyle)? style;

  /// The value.
  final String value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to the value inherited from the parent [FAutocompleteSection] or [FAutocomplete].
  final bool? enabled;

  /// A prefix.
  final Widget? prefix;

  /// The subtitle.
  final Widget? subtitle;

  /// The child.
  final Widget title;

  /// The suffix.
  final Widget? suffix;

  /// Creates a [FAutocompleteItem].
  ///
  /// To customize the text shown, provide a [title]. Default to [value].
  FAutocompleteItem(this.value, {
    this.style,
    this.enabled,
    this.prefix,
    this.subtitle,
    this.suffix,
    Widget? title,
    super.key,
  }): title = title ?? Text(value);

  @override
  Widget build(BuildContext context) {
    final InheritedAutocompleteController(:popover, :onPress, :onFocus) = InheritedAutocompleteController.of(context);
    final content = ContentData.of(context);

    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style.itemStyle).toFItemStyle(context);

    return FItem(
      style: style?.call,
      enabled: enabled,
      onPress: () => onPress(value),
      onFocusChange: (focused) {
        if (focused) {
          onFocus(value);
        }
      },
      prefix: prefix,
      title: title,
      subtitle: subtitle,
      suffix: suffix,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

/// A [FAutocompleteItem]'s style.
class FAutocompleteItemStyle with Diagnosticable, _$FAutocompleteItemStyleFunctions {
  /// The margin around the item. Defaults to `EdgeInsets.symmetric(horizontal: 4, vertical: 2)`.
  @override
  final EdgeInsetsGeometry margin;

  /// The padding around the item. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<BoxDecoration?> decoration;

  /// The icon style for an item's prefix.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> prefixIconStyle;

  // The horizontal spacing between the prefix icon and title and the subtitle. Defaults to 10.
  @override
  final double prefixIconSpacing;

  /// The default text style for the title.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> titleTextStyle;

  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  @override
  final double titleSpacing;

  /// The default text style for the subtitle.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> subtitleTextStyle;

  /// The icon style for an item's suffix.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> suffixIconStyle;

  /// The tappable style for the item.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FAutocompleteItemStyle].
  FAutocompleteItemStyle({
    required this.decoration,
    required this.prefixIconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.suffixIconStyle,
    required this.tappableStyle,
    this.margin = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    this.padding = const EdgeInsetsDirectional.only(start: 11, top: 7.5, bottom: 7.5, end: 6),
    this.prefixIconSpacing = 10,
    this.titleSpacing = 4,
  });

  /// Creates a [FAutocompleteItemStyle] that inherits its properties.
  FAutocompleteItemStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
    : this(
        decoration: FWidgetStateMap({
          ~WidgetState.disabled & (WidgetState.focused | WidgetState.hovered | WidgetState.pressed): BoxDecoration(
            color: colors.secondary,
            borderRadius: style.borderRadius,
          ),
        }),
        prefixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
          WidgetState.any: IconThemeData(color: colors.primary, size: 15),
        }),
        titleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.sm.copyWith(color: colors.primary),
        }),
        subtitleTextStyle: FWidgetStateMap({
          WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
          WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
        }),
        suffixIconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
          WidgetState.any: IconThemeData(color: colors.primary, size: 15),
        }),
        tappableStyle: style.tappableStyle.copyWith(bounceTween: FTappableStyle.noBounceTween),
      );
}

@internal
extension InternalFAutocompleteItemStyletyle on FAutocompleteItemStyle {
  FItemStyle toFItemStyle(BuildContext context) => FItemStyle(
    backgroundColor: FWidgetStateMap.all(null),
    decoration: decoration,
    margin: margin,
    contentStyle: FItemContentStyle.inherit(colors: context.theme.colors, typography: context.theme.typography)
        .copyWith(
          padding: padding,
          prefixIconStyle: prefixIconStyle,
          prefixIconSpacing: prefixIconSpacing,
          titleTextStyle: titleTextStyle,
          titleSpacing: titleSpacing,
          subtitleTextStyle: subtitleTextStyle,
          suffixIconStyle: suffixIconStyle,
        ),
    rawItemContentStyle: context.theme.itemStyle.rawItemContentStyle,
    // This isn't ever used.
    tappableStyle: tappableStyle,
    focusedOutlineStyle: null,
  );
}
