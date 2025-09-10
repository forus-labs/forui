import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_content.dart';
import 'package:forui/src/widgets/autocomplete/autocomplete_controller.dart';

part 'autocomplete_item.design.dart';

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

  /// Creates a [FAutocompleteSection] from the given items.
  ///
  /// For more control over the appearance of individual items, use [FAutocompleteSection.rich].
  FAutocompleteSection({
    required Widget label,
    required List<String> items,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle style)? style,
    bool? enabled,
    FItemDivider divider = FItemDivider.none,
    Key? key,
  }) : this.rich(
         label: label,
         children: [for (final item in items) FAutocompleteItem(value: item)],
         style: style,
         enabled: enabled,
         divider: divider,
         key: key,
       );

  /// Creates a [FAutocompleteSection] with the given [children].
  const FAutocompleteSection.rich({
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
    final itemStyle = style.itemStyle;

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
  final FItemStyle itemStyle;

  /// Creates a [FAutocompleteSectionStyle].
  FAutocompleteSectionStyle({
    required this.labelTextStyle,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.labelPadding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
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

    return FAutocompleteSectionStyle(
      labelTextStyle: FWidgetStateMap({
        WidgetState.disabled: typography.sm.copyWith(
          color: colors.disable(colors.primary),
          fontWeight: FontWeight.w600,
        ),
        WidgetState.any: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
      }),
      dividerColor: FWidgetStateMap.all(colors.border),
      dividerWidth: style.borderWidth,
      itemStyle: FItemStyle(
        backgroundColor: FWidgetStateMap.all(null),
        decoration: FWidgetStateMap({
          ~WidgetState.disabled & (WidgetState.focused | WidgetState.hovered | WidgetState.pressed): BoxDecoration(
            color: colors.secondary,
            borderRadius: style.borderRadius,
          ),
        }),
        contentStyle: FItemContentStyle.inherit(colors: colors, typography: typography).copyWith(
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

  /// Creates a [FAutocompleteItem] with a custom [title] and value.
  ///
  /// For even more control over the item's appearance, use [FAutocompleteItem.raw].
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

  /// Creates a [FAutocompleteItem] with raw layout that delegates to [FItem.raw].
  ///
  /// This provides full control over the item's layout without the structured
  /// title/subtitle/prefix/suffix layout of the default constructor.
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
    final InheritedAutocompleteController(:popover, :onPress, :onFocus) = InheritedAutocompleteController.of(context);
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
    final InheritedAutocompleteController(:popover, :onPress, :onFocus) = InheritedAutocompleteController.of(context);
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
