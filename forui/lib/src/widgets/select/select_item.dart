import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  final FSelectSectionStyle? style;

  /// True if the section is enabled. Disabled sections cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to inheriting from the [FSelect].
  final bool? enabled;

  /// The label.
  final Widget label;

  /// The nested [FSelectItem]s.
  final List<FSelectItem<T>> children;

  /// Creates a [FSelectSection].
  const FSelectSection({required this.label, required this.children, this.style, this.enabled, super.key});

  @override
  Widget build(BuildContext context) {
    final content = SelectContentData.of<T>(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style ?? content.style;

    return SelectContentData<T>(
      style: style,
      enabled: enabled,
      first: false,
      ensureVisible: content.ensureVisible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: enabled ? style.enabledLabelTextStyle : style.disabledLabelTextStyle,
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
              child: first,
            ),
          ...children.skip(1),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

/// A [FSelectSection]'s style.
class FSelectSectionStyle with Diagnosticable, _$FSelectSectionStyleFunctions {
  /// The enabled label's text style.
  @override
  final TextStyle enabledLabelTextStyle;

  /// The disabled label's text style.
  @override
  final TextStyle disabledLabelTextStyle;

  /// The padding around the label. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  @override
  final EdgeInsetsGeometry labelPadding;

  /// The section's items' style.
  @override
  final FSelectItemStyle itemStyle;

  /// Creates a [FSelectSectionStyle].
  FSelectSectionStyle({
    required this.enabledLabelTextStyle,
    required this.disabledLabelTextStyle,
    required this.itemStyle,
    this.labelPadding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FSelectSectionStyle] that inherits its properties.
  FSelectSectionStyle.inherit({required FColors colors, required FStyle style, required FTypography typography})
    : this(
        enabledLabelTextStyle: typography.sm.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
        disabledLabelTextStyle: typography.sm.copyWith(
          color: colors.disable(colors.primary),
          fontWeight: FontWeight.w600,
        ),
        itemStyle: FSelectItemStyle.inherit(colors: colors, style: style, typography: typography),
      );
}

/// A selectable item in a [FSelect] that can optionally be nested in a [FSelectSection].
class FSelectItem<T> extends StatefulWidget with FSelectItemMixin {
  /// The style. Defaults to the [FSelectItemStyle] inherited from the parent [FSelectSection] or [FSelect].
  final FSelectItemStyle? style;

  /// The value.
  final T value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to the value inherited from the parent [FSelectSection] or [FSelect].
  final bool? enabled;

  /// The child.
  final Widget child;

  /// The icon displayed when the item is selected. Defaults to a check icon.
  final Widget selectedIcon;

  /// Creates a [FSelectItem].
  FSelectItem({
    required this.value,
    required this.child,
    this.style,
    this.enabled,
    this.selectedIcon = const Icon(FIcons.check),
    super.key,
  });

  /// Creates a [FSelectItem] that displays the [value] as the a typography.
  static FSelectItem<String> text(String value, {bool? enabled}) =>
      FSelectItem(value: value, enabled: enabled, child: Text(value));

  @override
  State<FSelectItem<T>> createState() => _FSelectItemState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
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

    final selected = contains(widget.value);
    final enabled = widget.enabled ?? content.enabled;
    final style = widget.style ?? content.style.itemStyle;
    final padding = style.padding.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    Widget item = FTappable(
      style: style.tappableStyle,
      autofocus: selected || content.first,
      focusNode: _focus,
      behavior: HitTestBehavior.opaque,
      onPress: enabled ? () => onPress(widget.value) : null,
      builder: (_, states, _) {
        states = {...states, if (selected) WidgetState.selected};
        final child = Semantics(
          selected: selected,
          child: Padding(
            padding: padding.copyWith(left: padding.left - 4, right: padding.right - 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultTextStyle(style: style.textStyle.resolve(states), child: widget.child),
                if (selected) IconTheme(data: style.iconStyle.resolve(states), child: widget.selectedIcon),
              ],
            ),
          ),
        );

        if (style.decoration.resolve(states) case final decoration?) {
          return DecoratedBox(decoration: decoration, child: child);
        }

        return child;
      },
    );

    if (enabled) {
      item = MouseRegion(onEnter: (_) => _focus.requestFocus(), onExit: (_) => _focus.unfocus(), child: item);
    }

    return Padding(padding: const EdgeInsetsDirectional.only(start: 4, end: 4), child: item);
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }
}

/// A [FSelectItem]'s style.
class FSelectItemStyle with Diagnosticable, _$FSelectItemStyleFunctions {
  /// The padding around the item. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<BoxDecoration?> decoration;

  /// The default text style for the child.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The icon style for a checked item.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The tappable style for the item.
  @override
  final FTappableStyle tappableStyle;

  /// Creates a [FSelectItemStyle].
  FSelectItemStyle({
    required this.decoration,
    required this.textStyle,
    required this.iconStyle,
    required this.tappableStyle,
    this.padding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
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
        textStyle: FWidgetStateMap({
          WidgetState.disabled: typography.sm.copyWith(color: colors.disable(colors.primary)),
          WidgetState.any: typography.sm.copyWith(color: colors.primary),
        }),
        iconStyle: FWidgetStateMap({
          WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 15),
          WidgetState.any: IconThemeData(color: colors.primary, size: 15),
        }),
        tappableStyle: style.tappableStyle.copyWith(animationTween: FTappableAnimations.none),
      );
}
