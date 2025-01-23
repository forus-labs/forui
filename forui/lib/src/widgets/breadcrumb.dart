import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A breadcrumb.
///
/// A breadcrumb is a list of links that help visualize a page's location within a site's hierarchical structure,
/// it allows navigation up to any of the ancestors.
///
/// See:
/// * https://forui.dev/docs/navigation/breadcrumb for working examples.
/// * [FBreadcrumbStyle] for customizing a breadcrumb's appearance.
/// * [FBreadcrumbItem] for adding items to a breadcrumb.
final class FBreadcrumb extends StatelessWidget {
  /// The breadcrumb's style. Defaults to the appropriate style in [FThemeData.breadcrumbStyle].
  final FBreadcrumbStyle? style;

  /// A list of breadcrumb items representing the navigation path.
  ///
  /// Each item is typically an [FBreadcrumbItem], separated by a [divider].
  /// /// The last item generally represents the current page and has its `current` property set to `true`.
  /// Navigation can be handled via the `onPress` callback.
  final List<Widget> children;

  /// The divider placed in between the children.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final Widget? divider;

  /// Creates an [FBreadcrumb].
  const FBreadcrumb({
    required this.children,
    this.style,
    this.divider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.breadcrumbStyle;
    final divider = this.divider != null
        ? FIconStyleData(
            style: style.iconStyle,
            child: this.divider!,
          )
        : FIcon(
            FAssets.icons.chevronRight,
            color: style.iconStyle.color,
            size: style.iconStyle.size,
          );

    return Row(
      children: [
        for (final (index, item) in children.indexed) ...[
          FBreadcrumbItemData(style: style, child: item),
          if (index < children.length - 1) divider,
        ],
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// The [FBreadcrumbItem] data.
class FBreadcrumbItemData extends InheritedWidget {
  /// Returns the [FBreadcrumbItemData] of the [FBreadcrumb] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FBreadcrumb] in the given [context].
  @useResult
  static FBreadcrumbItemData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FBreadcrumbItemData>();
    assert(data != null, 'No FBreadcrumbData found in context');
    return data!;
  }

  /// The breadcrumb's style.
  final FBreadcrumbStyle style;

  /// Creates a [FBreadcrumbItemData].
  const FBreadcrumbItemData({
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FBreadcrumbItemData oldWidget) => style != oldWidget.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A breadcrumb item.
abstract interface class FBreadcrumbItem extends Widget {
  /// Creates a crumb that typically represents a single item in the navigation path.
  factory FBreadcrumbItem({
    required Widget child,
    bool current = false,
    VoidCallback? onPress,
    Key? key,
  }) =>
      _Crumb(
        current: current,
        onPress: onPress,
        key: key,
        child: child,
      );

  /// Creates a collapsed crumb.
  ///
  /// It is typically used to keep the breadcrumb compact and reduce the number of items displayed.
  /// When tapped, it displays a popover menu with the collapsed items.
  const factory FBreadcrumbItem.collapsed({
    required List<FTileGroup> menu,
    FPopoverMenuStyle? popOverMenuStyle,
    FPopoverController? popoverController,
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight,
    DragStartBehavior dragStartBehavior,
    FTileDivider divider,
    Alignment menuAnchor,
    Alignment childAnchor,
    Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    FHidePopoverRegion hideOnTapOutside,
    bool directionPadding,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    String? semanticLabel,
    Key? key,
  }) = _CollapsedCrumb;
}

// ignore: avoid_implementing_value_types
class _Crumb extends StatelessWidget implements FBreadcrumbItem {
  final bool current;
  final VoidCallback? onPress;
  final Widget child;

  const _Crumb({
    required this.child,
    this.onPress,
    this.current = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = FBreadcrumbItemData.of(context).style;
    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return FTappable(
      focusedOutlineStyle: focusedOutlineStyle,
      onPress: onPress,
      builder: (context, data, child) => Padding(
        padding: style.padding,
        child: DefaultTextStyle(
          style: switch ((current, data.hovered)) {
            (false, false) => style.unselectedTextStyle,
            (false, true) => style.hoveredTextStyle,
            (true, true) => style.hoveredTextStyle,
            (true, false) => style.selectedTextStyle,
          },
          child: child!,
        ),
      ),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('current', value: current, ifTrue: 'current'))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

// ignore: avoid_implementing_value_types
class _CollapsedCrumb extends StatefulWidget implements FBreadcrumbItem {
  final List<FTileGroup> menu;
  final FPopoverMenuStyle? popOverMenuStyle;
  final FPopoverController? popoverController;
  final ScrollController? scrollController;
  final double? cacheExtent;
  final double maxHeight;
  final DragStartBehavior dragStartBehavior;
  final FTileDivider divider;
  final Alignment menuAnchor;
  final Alignment childAnchor;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;
  final FHidePopoverRegion hideOnTapOutside;
  final bool directionPadding;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final String? semanticLabel;

  const _CollapsedCrumb({
    required this.menu,
    this.popOverMenuStyle,
    this.popoverController,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FTileDivider.full,
    this.menuAnchor = Alignment.topLeft,
    this.childAnchor = Alignment.bottomLeft,
    this.shift = FPortalShift.flip,
    this.hideOnTapOutside = FHidePopoverRegion.excludeTarget,
    this.directionPadding = false,
    this.semanticLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    super.key,
  });

  @override
  State<_CollapsedCrumb> createState() => _CollapsedCrumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popOverMenuStyle', popOverMenuStyle))
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
      ..add(FlagProperty('directionPadding', value: directionPadding, ifTrue: 'directionPadding'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _CollapsedCrumbState extends State<_CollapsedCrumb> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.popoverController ?? FPopoverController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant _CollapsedCrumb old) {
    super.didUpdateWidget(old);
    if (widget.popoverController == old.popoverController) {
      return;
    }

    if (old.popoverController != null) {
      controller.dispose();
    }
    controller = widget.popoverController ?? FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final style = FBreadcrumbItemData.of(context).style;
    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;
    return FPopoverMenu(
      popoverController: controller,
      style: widget.popOverMenuStyle,
      menuAnchor: widget.menuAnchor,
      childAnchor: widget.childAnchor,
      shift: widget.shift,
      hideOnTapOutside: widget.hideOnTapOutside,
      directionPadding: widget.directionPadding,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFocusChange: widget.onFocusChange,
      scrollController: widget.scrollController,
      cacheExtent: widget.cacheExtent,
      maxHeight: widget.maxHeight,
      dragStartBehavior: widget.dragStartBehavior,
      semanticLabel: widget.semanticLabel,
      divider: widget.divider,
      menu: widget.menu,
      child: FTappable(
        focusedOutlineStyle: focusedOutlineStyle,
        onPress: controller.toggle,
        child: Padding(
          padding: style.padding,
          child: FIcon(
            FAssets.icons.ellipsis,
            size: style.iconStyle.size,
            color: style.iconStyle.color,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.popoverController == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

/// The [FBreadcrumb] styles.
final class FBreadcrumbStyle with Diagnosticable {
  /// The selected breadcrumb [TextStyle].
  final TextStyle selectedTextStyle;

  /// The unselected breadcrumb [TextStyle].
  final TextStyle unselectedTextStyle;

  /// The hovered breadcrumb [TextStyle].
  final TextStyle hoveredTextStyle;

  /// The divider icon style.
  final FIconStyle iconStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  final EdgeInsets padding;

  /// Creates a [FBreadcrumbStyle].
  FBreadcrumbStyle({
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    required this.hoveredTextStyle,
    required this.iconStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
  });

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [typography].
  FBreadcrumbStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : this(
          selectedTextStyle: typography.sm.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.foreground,
          ),
          unselectedTextStyle: typography.sm.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.mutedForeground,
          ),
          hoveredTextStyle: typography.sm.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
          iconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 16),
        );

  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  @useResult
  FBreadcrumbStyle copyWith({
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    TextStyle? hoveredTextStyle,
    FIconStyle? iconStyle,
    EdgeInsets? padding,
  }) =>
      FBreadcrumbStyle(
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
        hoveredTextStyle: hoveredTextStyle ?? this.hoveredTextStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle))
      ..add(DiagnosticsProperty('unselectedTextStyle', unselectedTextStyle))
      ..add(DiagnosticsProperty('hoveredTextStyle', hoveredTextStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBreadcrumbStyle &&
          runtimeType == other.runtimeType &&
          selectedTextStyle == other.selectedTextStyle &&
          unselectedTextStyle == other.unselectedTextStyle &&
          hoveredTextStyle == other.hoveredTextStyle &&
          iconStyle == other.iconStyle &&
          padding == other.padding;

  @override
  int get hashCode =>
      selectedTextStyle.hashCode ^
      unselectedTextStyle.hashCode ^
      hoveredTextStyle.hashCode ^
      iconStyle.hashCode ^
      padding.hashCode;
}
