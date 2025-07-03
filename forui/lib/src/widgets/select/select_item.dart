import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/select_controller.dart';

part 'select_item.style.dart';

/// A marker interface which denotes that mixed-in widgets can be used in a [FSelect].
mixin FSelectItemMixin on Widget {}

/// A section in a [FSelect] that can contain multiple [FSelectItem]s.
class FSelectSection<T> extends StatelessWidget with FSelectItemMixin {
  /// The style. Defaults to the [FSelectSectionStyle] inherited from the parent [FSelect].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-section
  /// ```
  final FSelectSectionStyle Function(FSelectSectionStyle)? style;

  /// True if the section is enabled. Disabled sections cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to inheriting from the [FSelect].
  final bool? enabled;

  /// The divider style. Defaults to the [FItemDivider] inherited from the parent [FSelect]. Defaults to
  /// [FItemDivider.none].
  final FItemDivider divider;

  /// The label.
  final Widget label;

  /// The nested [FSelectItem]s.
  final List<FSelectItem<T>> children;

  /// Creates a [FSelectSection].
  const FSelectSection({
    required this.label,
    required this.children,
    this.style,
    this.enabled,
    this.divider = FItemDivider.none,
    super.key,
  });

  /// Creates a [FSelectSection] from the given items.
  FSelectSection.fromMap({
    required Widget label,
    required Map<String, T> items,
    FSelectSectionStyle Function(FSelectSectionStyle)? style,
    bool? enabled,
    FItemDivider divider = FItemDivider.none,
    Key? key,
  }) : this(
         label: label,
         children: [for (final e in items.entries) FSelectItem<T>(e.key, e.value)],
         style: style,
         enabled: enabled,
         divider: divider,
         key: key,
       );

  @override
  Widget build(BuildContext context) {
    final content = SelectContentData.of<T>(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style) ?? content.style;
    final itemStyle = style.itemStyle.toFItemStyle(context);

    return SelectContentData<T>(
      style: style,
      enabled: enabled,
      first: false,
      ensureVisible: content.ensureVisible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle.merge(
            style: style.labelTextStyle.resolve({if (!enabled) WidgetState.disabled}),
            child: Padding(padding: style.labelPadding, child: label),
          ),
          // There is an edge case where a non-first, enabled child of a disabled section will not be auto-focused.
          // No feasible solution that doesn't involve a lot of complexity exists.
          if (children.firstOrNull case final first?)
            SelectContentData<T>(
              style: style,
              first: content.first,
              enabled: enabled,
              ensureVisible: content.ensureVisible,
              child: FItemData.merge(
                style: itemStyle,
                divider: divider,
                index: 0,
                last: children.length == 1,
                child: first,
              ),
            ),
          for (final (i, child) in children.indexed.skip(1))
            FItemData.merge(
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

/// A [FSelectSection]'s style.
class FSelectSectionStyle with Diagnosticable, _$FSelectSectionStyleFunctions {
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
  final FSelectItemStyle itemStyle;

  /// Creates a [FSelectSectionStyle].
  FSelectSectionStyle({
    required this.labelTextStyle,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.labelPadding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FSelectSectionStyle] that inherits its properties.
  FSelectSectionStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
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
        itemStyle: FSelectItemStyle.inherit(colors: colors, style: style, typography: typography),
      );
}

/// A selectable item in a [FSelect] that can optionally be nested in a [FSelectSection].
class FSelectItem<T> extends StatefulWidget with FSelectItemMixin {
  static Widget? _defaultSuffixBuilder(BuildContext _, bool selected) => selected ? const Icon(FIcons.check) : null;

  /// The style. Defaults to the [FSelectItemStyle] inherited from the parent [FSelectSection] or [FSelect].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-item
  /// ```
  final FSelectItemStyle Function(FSelectItemStyle)? style;

  /// The value.
  final T value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to the value inherited from the parent [FSelectSection] or [FSelect].
  final bool? enabled;

  /// A prefix.
  final Widget? prefix;

  /// The subtitle.
  final Widget? subtitle;

  /// The child.
  final Widget title;

  /// The icon displayed when the item is selected. Defaults to a check icon.
  // ignore: avoid_positional_boolean_parameters
  final Widget? Function(BuildContext, bool) suffixBuilder;

  /// Creates a [FSelectItem].
  FSelectItem(String text, T value, {bool? enabled, Key? key})
    : this.from(key: key, value: value, enabled: enabled, title: Text(text));

  /// Creates a [FSelectItem] with a custom child widget.
  FSelectItem.from({
    required this.value,
    required this.title,
    this.style,
    this.enabled,
    this.prefix,
    this.subtitle,
    this.suffixBuilder = _defaultSuffixBuilder,
    super.key,
  });

  @override
  State<FSelectItem<T>> createState() => _FSelectItemState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder));
  }
}

class _FSelectItemState<T> extends State<FSelectItem<T>> {
  late final _focus = FocusNode(debugLabel: widget.value.toString());

  @override
  void initState() {
    super.initState();
    // This is hacky but I'm not sure how to properly do this.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final SelectControllerData(:contains, :onPress) = SelectControllerData.of<T>(context);
      final content = SelectContentData.of<T>(context);
      if (contains(widget.value)) {
        content.ensureVisible(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final SelectControllerData(:contains, :onPress) = SelectControllerData.of<T>(context);
    final content = SelectContentData.of<T>(context);

    final enabled = widget.enabled ?? content.enabled;
    final selected = contains(widget.value);
    final style = widget.style?.call(content.style.itemStyle).toFItemStyle(context);

    return FItem(
      style: style?.call,
      enabled: enabled,
      selected: selected,
      autofocus: selected || content.first,
      focusNode: _focus,
      onPress: () => onPress(widget.value),
      onHoverChange: (hover) => hover ? _focus.requestFocus() : _focus.unfocus(),
      prefix: widget.prefix,
      title: widget.title,
      subtitle: widget.subtitle,
      suffix: widget.suffixBuilder(context, selected),
    );
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }
}

/// A [FSelectItem]'s style.
class FSelectItemStyle with Diagnosticable, _$FSelectItemStyleFunctions {
  /// The margin around the image. Defaults to `EdgeInsets.symmetric(horizontal: 4, vertical: 2)`.
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

  /// Creates a [FSelectItemStyle].
  FSelectItemStyle({
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

  /// Creates a [FSelectItemStyle] that inherits its properties.
  FSelectItemStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
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
extension FSelectItemStyles on FSelectItemStyle {
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
