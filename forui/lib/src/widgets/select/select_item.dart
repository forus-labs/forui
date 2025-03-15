import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select/select_controller.dart';
import 'package:meta/meta.dart';

part 'select_item.style.dart';

/// A marker interface which denotes that mixed-in widgets can be used in a [FSelect].
mixin FSelectItemMixin on Widget {}

@internal
class FSelectItemData<T> extends InheritedWidget {
  final FSelectItemStyle style;
  final bool enabled;
  final bool first;

  const FSelectItemData({
    required this.style,
    required this.enabled,
    required this.first,
    required super.child,
    super.key,
  });

  static FSelectItemData<T> of<T>(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<FSelectItemData<T>>();
    assert(result != null, 'No FSelectContentData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FSelectItemData<T> old) => first != old.first;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(FlagProperty('first', value: first, ifTrue: 'first'));
  }
}

/// A selectable item in a [FSelect] that can optionally be nested in a [FSelectSection].
class FSelectItem<T> extends StatefulWidget with FSelectItemMixin {
  /// The style. Defaults to the [FSelectItemStyle] inherited from the parent [FSelectSection] if present, and the
  /// default style otherwise.
  final FSelectItemStyle? style;

  /// The value.
  final T value;

  /// True if the item is enabled. Disabled items cannot be selected, and is skipped during traversal.
  ///
  /// Defaults to inheriting from the parent [FSelectSection] if present, and true otherwise.
  final bool? enabled;

  /// THe icon to display when the item is selected. Defaults to a check icon.
  final Widget selectedIcon;

  /// The child.
  final Widget child;

  /// Creates a [FSelectItem].
  FSelectItem({required this.value, required this.child, this.style, this.enabled, Widget? icon, super.key})
    : selectedIcon = icon ?? FIcon(FAssets.icons.check);

  /// Creates a [FSelectItem] that displays the [value] as its title.
  static FSelectItem<String> text(String value, {bool? enabled}) =>
      FSelectItem(value: value, enabled: enabled, child: Text(value));

  @override
  State<FSelectItem<T>> createState() => _FSelectItemState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'));
  }
}

class _FSelectItemState<T> extends State<FSelectItem<T>> {
  final _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final FSelectControllerData(:contains, :onPress) = FSelectControllerData.of<T>(context);
    final section = FSelectItemData.of<T>(context);

    final selected = contains(widget.value);
    final enabled = widget.enabled ?? section.enabled;
    final style = widget.style ?? section.style;
    final padding = style.padding.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);

    Widget item = Semantics(
      selected: selected,
      child: Padding(
        padding: padding.copyWith(left: padding.left - 4, right: padding.right - 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DefaultTextStyle(style: enabled ? style.enabledTextStyle : style.disabledTextStyle, child: widget.child),
            if (selected)
              FIconStyleData(style: enabled ? style.enabledIconStyle : style.disabledIconStyle, child: widget.selectedIcon),
          ],
        ),
      ),
    );

    if (enabled) {
      item = MouseRegion(
        onEnter: (_) => _focus.requestFocus(),
        onExit: (_) => _focus.unfocus(),
        child: FTappable(
          autofocus: selected || section.first,
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
