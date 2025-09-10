import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:forui/src/widgets/select/select_controller.dart';

part 'select_item.design.dart';

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
  final FSelectSectionStyle Function(FSelectSectionStyle style)? style;

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

  /// Creates a [FSelectSection] from the given [items].
  ///
  /// For more control over the items' appearances, use [FSelectSection.rich].
  FSelectSection({
    required Widget label,
    required Map<String, T> items,
    FSelectSectionStyle Function(FSelectSectionStyle style)? style,
    bool? enabled,
    FItemDivider divider = FItemDivider.none,
    Key? key,
  }) : this.rich(
         label: label,
         children: [for (final e in items.entries) FSelectItem<T>(title: Text(e.key), value: e.value)],
         style: style,
         enabled: enabled,
         divider: divider,
         key: key,
       );

  /// Creates a [FSelectSection] with the given [children].
  const FSelectSection.rich({
    required this.label,
    required this.children,
    this.style,
    this.enabled,
    this.divider = FItemDivider.none,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final content = ContentData.of<T>(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style?.call(content.style) ?? content.style;
    final itemStyle = style.itemStyle.call(context);

    return ContentData<T>(
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
            ContentData<T>(
              style: style,
              first: content.first,
              enabled: enabled,
              ensureVisible: content.ensureVisible,
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
  final FItemStyle itemStyle;

  /// Creates a [FSelectSectionStyle].
  FSelectSectionStyle({
    required this.labelTextStyle,
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.labelPadding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FSelectSectionStyle] that inherits its properties.
  factory FSelectSectionStyle.inherit({
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

    return FSelectSectionStyle(
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

/// A selectable item in a [FSelect] that can optionally be nested in a [FSelectSection].
abstract class FSelectItem<T> extends StatefulWidget with FSelectItemMixin {
  /// The style. Defaults to the [FItemStyle] inherited from the parent [FSelectSection] or [FSelect].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create select-section
  /// ```
  final FItemStyle Function(FItemStyle style)? style;

  /// The value.
  final T value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to the value inherited from the parent [FSelectSection] or [FSelect].
  final bool? enabled;

  /// A prefix.
  final Widget? prefix;

  /// Creates a [FSelectItem] with a custom [title] and value.
  const factory FSelectItem({
    required Widget title,
    required T value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Widget? subtitle,
    // ignore: avoid_positional_boolean_parameters
    Widget? Function(BuildContext context, bool selected) suffixBuilder,
    Key? key,
  }) = _SelectItem<T>;

  /// Creates a [FSelectItem] with a raw layout.
  const factory FSelectItem.raw({
    required Widget child,
    required T value,
    FItemStyle Function(FItemStyle style)? style,
    bool? enabled,
    Widget? prefix,
    Key? key,
  }) = _RawSelectItem<T>;

  const FSelectItem._({required this.value, this.style, this.enabled, this.prefix, super.key});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

abstract class _State<W extends FSelectItem<T>, T> extends State<W> {
  late final _focus = FocusNode(debugLabel: widget.value.toString());

  @override
  void initState() {
    super.initState();

    // This is hacky but I'm not sure how to properly do this.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final InheritedSelectController(:focus, :onPress) = InheritedSelectController.of<T>(context);
      final content = ContentData.of<T>(context);
      if (focus(widget.value)) {
        content.ensureVisible(context);
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InheritedSelectController(:popover, :contains, :focus, :onPress) = InheritedSelectController.of<T>(context);
    final content = ContentData.of<T>(context);

    return _item(
      context,
      widget.enabled ?? content.enabled,
      contains(widget.value),
      focus(widget.value) || content.first,
      (delta) {
        if (delta.added.contains(WidgetState.hovered) ||
            (!delta.previous.contains(WidgetState.hovered) && delta.added.contains(WidgetState.pressed))) {
          _focus.requestFocus();
        } else if (delta.removed.contains(WidgetState.hovered) ||
            (!delta.current.contains(WidgetState.hovered) && delta.removed.contains(WidgetState.pressed))) {
          _focus.unfocus();
        }
      },
      () => onPress(widget.value),
    );
  }

  Widget _item(
    BuildContext context,
    bool enabled,
    bool selected,
    bool focused,
    ValueChanged<FWidgetStatesDelta> onStateChange,
    VoidCallback onPress,
  );
}

class _SelectItem<T> extends FSelectItem<T> {
  static Widget? _defaultSuffixBuilder(BuildContext _, bool selected) => selected ? const Icon(FIcons.check) : null;

  final Widget? subtitle;
  final Widget title;

  // ignore: avoid_positional_boolean_parameters
  final Widget? Function(BuildContext context, bool selected) suffixBuilder;

  const _SelectItem({
    required this.title,
    required super.value,
    this.subtitle,
    this.suffixBuilder = _defaultSuffixBuilder,
    super.style,
    super.enabled,
    super.prefix,
    super.key,
  }) : super._();

  @override
  State<_SelectItem<T>> createState() => _SelectItemState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty.has('suffixBuilder', suffixBuilder));
  }
}

class _SelectItemState<T> extends _State<_SelectItem<T>, T> {
  @override
  Widget _item(
    BuildContext context,
    bool enabled,
    bool selected,
    bool focused,
    ValueChanged<FWidgetStatesDelta> onStateChange,
    VoidCallback onPress,
  ) => FItem(
    style: widget.style?.call,
    enabled: enabled,
    selected: selected,
    autofocus: focused,
    focusNode: _focus,
    onStateChange: onStateChange,
    onPress: onPress,
    prefix: widget.prefix,
    title: widget.title,
    subtitle: widget.subtitle,
    suffix: widget.suffixBuilder(context, selected),
  );
}

class _RawSelectItem<T> extends FSelectItem<T> {
  final Widget child;

  const _RawSelectItem({required this.child, required super.value, super.style, super.enabled, super.prefix, super.key})
    : super._();

  @override
  _RawSelectItemState<T> createState() => _RawSelectItemState<T>();
}

class _RawSelectItemState<T> extends _State<_RawSelectItem<T>, T> {
  @override
  Widget _item(
    BuildContext context,
    bool enabled,
    bool selected,
    bool focused,
    ValueChanged<FWidgetStatesDelta> onStateChange,
    VoidCallback onPress,
  ) => FItem.raw(
    style: widget.style?.call,
    enabled: enabled,
    selected: selected,
    autofocus: focused,
    focusNode: _focus,
    onStateChange: onStateChange,
    onPress: onPress,
    prefix: widget.prefix,
    child: widget.child,
  );
}
