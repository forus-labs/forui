import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_content.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_controller.dart';

part 'autocomplete_item.design.dart';

/// A marker interface which denotes that mixed-in widgets can be used in a [FAutocomplete].
mixin FAutocompleteItemMixin on Widget {
  /// {@macro forui.widgets.FAutocompleteSection.new}
  ///
  /// For more control over the appearance of individual items, use [richSection].
  ///
  /// This function is a shorthand for [FAutocompleteSection.new].
  static FAutocompleteSection section({
    required Widget label,
    required List<String> items,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? style,
    bool? enabled,
    FItemDivider divider = .none,
    Key? key,
  }) => .new(label: label, items: items, style: style, enabled: enabled, divider: divider, key: key);

  /// {@macro forui.widgets.FAutocompleteSection.rich}
  ///
  /// This function is a shorthand for [FAutocompleteSection.rich].
  static FAutocompleteSection richSection({
    required Widget label,
    required List<FAutocompleteItem> children,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? style,
    bool? enabled,
    FItemDivider divider = .none,
    Key? key,
  }) => .rich(label: label, style: style, enabled: enabled, divider: divider, key: key, children: children);

  /// {@macro forui.widgets.FAutocompleteItem.new}
  ///
  /// For even more control over the item's appearance, use [rawItem].
  ///
  /// This function is a shorthand for [FAutocompleteItem.new].
  static FAutocompleteItem item({
    required String value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Widget? title,
    Widget? subtitle,
    Widget? suffix,
    Key? key,
  }) => .item(
    value: value,
    style: style,
    enabled: enabled,
    prefix: prefix,
    title: title,
    subtitle: subtitle,
    suffix: suffix,
    key: key,
  );

  /// {@macro forui.widgets.FAutocompleteItem.raw}
  ///
  /// This function is a shorthand for [FAutocompleteItem.raw].
  static FAutocompleteItem rawItem({
    required Widget child,
    required String value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Key? key,
  }) => .raw(value: value, style: style, enabled: enabled, prefix: prefix, key: key, child: child);
}

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
  final FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? style;

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

  /// {@template forui.widgets.FAutocompleteSection.new}
  /// Creates a [FAutocompleteSection] from the given items.
  /// {@endtemplate}
  ///
  /// For more control over the appearance of individual items, use [FAutocompleteSection.rich].
  FAutocompleteSection({
    required Widget label,
    required List<String> items,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? style,
    bool? enabled,
    FItemDivider divider = .none,
    Key? key,
  }) : this.rich(
         label: label,
         children: [for (final item in items) FAutocompleteItem.item(value: item)],
         style: style,
         enabled: enabled,
         divider: divider,
         key: key,
       );

  /// {@template forui.widgets.FAutocompleteSection.rich}
  /// Creates a [FAutocompleteSection] with the given [children].
  /// {@endtemplate}
  const FAutocompleteSection.rich({
    required this.label,
    required this.children,
    this.style,
    this.enabled,
    this.divider = .none,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final content = ContentData.of(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style) ?? content.style;
    final itemStyle = style.itemStyle;

    return ContentData(
      style: style,
      enabled: enabled,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          DefaultTextStyle.merge(
            style: style.labelTextStyle.resolve({if (!enabled) .disabled}),
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
  final FItemStyle itemStyle;

  /// Creates a [FAutocompleteSectionStyle].
  FAutocompleteSectionStyle({
    required this.labelTextStyle,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.labelPadding = const .directional(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FAutocompleteSectionStyle] that inherits its properties.
  factory FAutocompleteSectionStyle.inherit({
    required FColors colors,
    required FStyle style,
    required FTypography typography,
  }) {
    const padding = EdgeInsetsDirectional.only(start: 11, top: 7.5, bottom: 7.5, end: 6);
    final iconStyle = FWidgetStateMap({
      WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
      WidgetState.any: IconThemeData(color: colors.primary, size: 15),
    });
    final textStyle = FWidgetStateMap({
      WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary)),
      WidgetState.any: typography.sm.copyWith(color: colors.primary),
    });

    return .new(
      labelTextStyle: FWidgetStateMap({
        WidgetState.disabled: typography.sm.copyWith(
          color: colors.disable(colors.primary),
          fontWeight: FontWeight.w600,
        ),
        WidgetState.any: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
      }),
      dividerColor: .all(colors.border),
      dividerWidth: style.borderWidth,
      itemStyle: FItemStyle(
        backgroundColor: .all(null),
        decoration: FWidgetStateMap({
          ~WidgetState.disabled & (WidgetState.focused | WidgetState.hovered | WidgetState.pressed): BoxDecoration(
            color: colors.secondary,
            borderRadius: style.borderRadius,
          ),
        }),
        contentStyle: .inherit(colors: colors, typography: typography).copyWith(
          padding: padding,
          prefixIconStyle: iconStyle,
          prefixIconSpacing: 10,
          titleTextStyle: textStyle,
          titleSpacing: 4,
          subtitleTextStyle: FWidgetStateMap({
            WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
            WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
          }),
          suffixIconStyle: FWidgetStateMap({
            WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
            WidgetState.any: IconThemeData(color: colors.primary, size: 15),
          }),
        ),
        rawItemContentStyle: FRawItemContentStyle(
          padding: padding,
          prefixIconStyle: iconStyle,
          childTextStyle: textStyle,
        ),
        tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
        focusedOutlineStyle: null,
      ),
    );
  }
}

/// A suggestion in a [FAutocomplete] that can optionally be nested in a [FAutocompleteSection].
abstract class FAutocompleteItem extends StatelessWidget with FAutocompleteItemMixin {
  /// The style. Defaults to the [FItemStyle] inherited from the parent [FAutocompleteSection] or [FAutocomplete].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create autocomplete-section
  /// ```
  final FItemStyle Function(FItemStyle style)? style;

  /// The value.
  final String value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to the value inherited from the parent [FAutocompleteSection] or [FAutocomplete].
  final bool? enabled;

  /// A prefix.
  final Widget? prefix;

  /// {@template forui.widgets.FAutocompleteItem.new}
  /// Creates a [FAutocompleteItem] with a custom [title] and value.
  ///
  /// For even more control over the item's appearance, use [FAutocompleteItem.raw].
  /// {@endtemplate}
  factory FAutocompleteItem({
    required String value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Widget? title,
    Widget? subtitle,
    Widget? suffix,
    Key? key,
  }) = _AutocompleteItem;

  /// Creates a [FAutocompleteItem] with a custom [title] and value.
  ///
  /// This is identical to [FAutocompleteItem.new]. It provides consistency with other [FAutocompleteItemMixin]
  /// members when using dot-shorthands.
  ///
  /// For even more control over the item's appearance, use [FAutocompleteItem.raw].
  factory FAutocompleteItem.item({
    required String value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Widget? title,
    Widget? subtitle,
    Widget? suffix,
    Key? key,
  }) = FAutocompleteItem;

  /// {@template forui.widgets.FAutocompleteItem.raw}
  /// Creates a [FAutocompleteItem] with raw layout that delegates to [FItem.raw].
  ///
  /// This provides full control over the item's layout without the structured
  /// title/subtitle/prefix/suffix layout of the default constructor.
  /// {@endtemplate}
  factory FAutocompleteItem.raw({
    required Widget child,
    required String value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Key? key,
  }) = _RawAutocompleteItem;

  const FAutocompleteItem._({required this.value, this.style, this.enabled, this.prefix, super.key});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

class _AutocompleteItem extends FAutocompleteItem {
  final Widget? subtitle;
  final Widget title;
  final Widget? suffix;

  _AutocompleteItem({
    required super.value,
    super.style,
    super.enabled,
    super.prefix,
    this.subtitle,
    this.suffix,
    Widget? title,
    super.key,
  }) : title = title ?? Text(value),
       super._();

  @override
  Widget build(BuildContext context) {
    final InheritedAutocompleteController(:popover, :onPress, :onFocus) = .of(context);
    final content = ContentData.of(context);

    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style.itemStyle);

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
}

class _RawAutocompleteItem extends FAutocompleteItem {
  final Widget child;

  const _RawAutocompleteItem({
    required this.child,
    required super.value,
    super.style,
    super.enabled,
    super.prefix,
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    final InheritedAutocompleteController(:popover, :onPress, :onFocus) = .of(context);
    final content = ContentData.of(context);

    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style.itemStyle);

    return FItem.raw(
      style: style?.call,
      enabled: enabled,
      onPress: () => onPress(value),
      onFocusChange: (focused) {
        if (focused) {
          onFocus(value);
        }
      },
      prefix: prefix,
      child: child,
    );
  }
}
