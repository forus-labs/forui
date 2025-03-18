import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/select_controller.dart';
import 'package:forui/src/widgets/select/content/content.dart';
import 'package:meta/meta.dart';

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

  /// The title.
  final Widget title;

  /// The nested [FSelectItem]s.
  final List<FSelectItem<T>> children;

  /// Creates a [FSelectSection].
  const FSelectSection({required this.title, required this.children, this.style, this.enabled, super.key});

  @override
  Widget build(BuildContext context) {
    final content = FSelectContentData.of<T>(context);
    final enabled = this.enabled ?? content.enabled;
    final style = this.style ?? content.style;

    return FSelectContentData<T>(
      style: style,
      enabled: enabled,
      first: false,
      ensureVisible: content.ensureVisible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(style: style.titleTextStyle, child: Padding(padding: style.titlePadding, child: title)),
          if (children.firstOrNull case final first?)
            FSelectContentData<T>(
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
  /// The title's text style.
  @override
  final TextStyle titleTextStyle;

  /// The padding around the title. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  @override
  final EdgeInsetsGeometry titlePadding;

  /// The section's items' style.
  @override
  final FSelectItemStyle itemStyle;

  /// Creates a [FSelectSectionStyle].
  FSelectSectionStyle({
    required this.titleTextStyle,
    required this.itemStyle,
    this.titlePadding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FSelectSectionStyle] that inherits from the given [FColorScheme], [FStyle], and [FTypography].
  FSelectSectionStyle.inherit({
    required FColorScheme colorScheme,
    required FStyle style,
    required FTypography typography,
  }) : this(
         titleTextStyle: typography.sm.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w600),
         itemStyle: FSelectItemStyle.inherit(colorScheme: colorScheme, style: style, typography: typography),
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

  /// The title.
  final Widget title;

  /// The icon displayed when the item is selected. Defaults to a check icon.
  final Widget selectedIcon;

  /// Creates a [FSelectItem].
  FSelectItem({required this.value, required this.title, this.style, this.enabled, Widget? icon, super.key})
    : selectedIcon = icon ?? FIcon(FAssets.icons.check);

  /// Creates a [FSelectItem] that displays the [value] as its title.
  static FSelectItem<String> text(String value, {bool? enabled}) =>
      FSelectItem(value: value, enabled: enabled, title: Text(value));

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
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // This is hacky but I'm not sure how to properly do this.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      final FSelectControllerData(:contains, :onPress) = FSelectControllerData.of<T>(context);
      final content = FSelectContentData.of<T>(context);
      if (contains(widget.value)) {
        content.ensureVisible(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FSelectControllerData(:contains, :onPress) = FSelectControllerData.of<T>(context);
    final content = FSelectContentData.of<T>(context);

    final selected = contains(widget.value);
    final enabled = widget.enabled ?? content.enabled;
    final style = widget.style ?? content.style.itemStyle;
    final padding = style.padding.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    Widget item = Semantics(
      selected: selected,
      child: Padding(
        padding: padding.copyWith(left: padding.left - 4, right: padding.right - 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultTextStyle(style: enabled ? style.enabledTextStyle : style.disabledTextStyle, child: widget.title),
            if (selected)
              FIconStyleData(
                style: enabled ? style.enabledIconStyle : style.disabledIconStyle,
                child: widget.selectedIcon,
              ),
          ],
        ),
      ),
    );

    if (enabled) {
      item = MouseRegion(
        onEnter: (_) => _focus.requestFocus(),
        onExit: (_) => _focus.unfocus(),
        child: FTappable(
          autofocus: selected || content.first,
          focusNode: _focus,
          behavior: HitTestBehavior.opaque,
          onPress: () => onPress(widget.value),
          builder: (context, data, child) {
            if (data.pressed || data.focused) {
              child = DecoratedBox(decoration: style.enabledHoveredDecoration, child: child);
            }

            return child!;
          },
          child: item,
        ),
      );
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

  /// The decoration for the item when enabled and hovered.
  @override
  final BoxDecoration enabledHoveredDecoration;

  /// The text style for the item's title when enabled.
  @override
  final TextStyle enabledTextStyle;

  /// The text style for the item's title when disabled.
  @override
  final TextStyle disabledTextStyle;

  /// The icon style for a checked item when enabled.
  @override
  final FIconStyle enabledIconStyle;

  /// The icon style for a checked item when disabled.
  @override
  final FIconStyle disabledIconStyle;

  /// Creates a [FSelectItemStyle].
  FSelectItemStyle({
    required this.enabledHoveredDecoration,
    required this.enabledTextStyle,
    required this.disabledTextStyle,
    required this.enabledIconStyle,
    required this.disabledIconStyle,
    this.padding = const EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10),
  });

  /// Creates a [FSelectItemStyle] that inherits from the given [FColorScheme], [FStyle], and [FTypography].
  FSelectItemStyle.inherit({required FColorScheme colorScheme, required FStyle style, required FTypography typography})
    : this(
        enabledHoveredDecoration: BoxDecoration(color: colorScheme.secondary, borderRadius: style.borderRadius),
        enabledTextStyle: typography.sm.copyWith(color: colorScheme.primary),
        disabledTextStyle: typography.sm.copyWith(color: colorScheme.disable(colorScheme.primary)),
        enabledIconStyle: FIconStyle(color: colorScheme.primary, size: 15),
        disabledIconStyle: FIconStyle(color: colorScheme.disable(colorScheme.primary), size: 15),
      );
}
