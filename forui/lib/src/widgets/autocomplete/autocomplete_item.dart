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

  /// Creates a [FAutocompleteSection].
  const FAutocompleteSection({
    required this.label,
    required this.children,
    this.style,
    this.enabled,
    this.divider = FItemDivider.none,
    super.key,
  });

  /// Creates a [FAutocompleteSection] from the given items.
  FAutocompleteSection.fromMap({
    required Widget label,
    required Map<String, String> items,
    FAutocompleteSectionStyle Function(FAutocompleteSectionStyle)? style,
    bool? enabled,
    FItemDivider divider = FItemDivider.none,
    Key? key,
  }) : this(
    label: label,
    children: [for (final e in items.entries) FAutocompleteItem(e.key, value: e.value)],
    style: style,
    enabled: enabled,
    divider: divider,
    key: key,
  );

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
    itemStyle: FItemStyle.inherit(colors: colors, style: style, typography: typography),
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
  final FItemStyle Function(FItemStyle)? style;

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
  FAutocompleteItem(String text, {String? value, bool? enabled, Key? key})
      : this.from(key: key, value: value ?? text, enabled: enabled, title: Text(text));

  /// Creates a [FAutocompleteItem] with a custom child widget.
  FAutocompleteItem.from({
    required this.value,
    required this.title,
    this.style,
    this.enabled,
    this.prefix,
    this.subtitle,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final InheritedAutocompleteController(:popover, :onPress) = InheritedAutocompleteController.of(context);
    final content = ContentData.of(context);

    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style.itemStyle);

    return FItem(
      style: style?.call,
      enabled: enabled,
      onPress: () => onPress(value),
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

