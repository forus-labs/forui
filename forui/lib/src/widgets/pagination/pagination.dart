import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination_controller.dart';
import 'package:meta/meta.dart';

/// A Pagination component that enables the user to select a specific page from a range of pages.
///
/// See:
/// * https://forui.dev/docs/navigation/pagination for working examples.
/// * [FPaginationStyle] for customizing a breadcrumb's appearance.
/// * [FBreadcrumbItem] for adding items to a breadcrumb.
final class FPagination extends StatelessWidget {
  /// The pagination's style. Defaults to the appropriate style in [FThemeData.breadcrumbStyle].
  final FPaginationStyle? style;

  final FPaginationController controller;

  final int count;

  final int displayed;

  final List<Widget> children;

  /// The previous button to move the current page to the previous page.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final Widget? previous;

  /// The next button placed in between the children.
  ///
  /// Defaults to an `FAssets.icons.chevronRight` icon.
  final Widget? next;

  /// Creates an [FPagination].
  const FPagination({
    required this.children,
    required this.controller,
    required this.count,
    required this.displayed,
    this.style,
    this.previous,
    this.next,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.paginationStyle;
    final divider = this.previous != null
        ? FIconStyleData(
      style: style.iconStyle,
      child: this.previous!,
    )
        : FIcon(
      FAssets.icons.chevronRight,
      color: style.iconStyle.color,
      size: style.iconStyle.size,
    );

    return Row(
      children: [
        FButton(
          onPress: () {},
          label: const Text('Previous'),
          prefix: FIcon(
            FAssets.icons.chevronLeft,
            color: style.iconStyle.color,
            size: style.iconStyle.size,
          ),
        ),

        for(int i = 0; i < count; i++)
          FPaginationData(style: style, child: child),

        FButton(
          onPress: () {},
          label: const Text('Next'),
          prefix: FIcon(
            FAssets.icons.chevronRight,
            color: style.iconStyle.color,
            size: style.iconStyle.size,
          ),
        ),
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
class FPaginationData extends InheritedWidget {
  /// Returns the [FPaginationData] of the [FPagination] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FPagination] in the given [context].
  @useResult
  static FPaginationData of(BuildContext context) {
    final data = context.dependOnInheritedWidgetOfExactType<FPaginationData>();
    assert(data != null, 'No FBreadcrumbData found in context');
    return data!;
  }

  /// The pagination's style.
  final FPaginationStyle style;

  /// Creates a [FPaginationData].
  const FPaginationData({
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FPaginationData oldWidget) => style != oldWidget.style;

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
  factory FBreadcrumbItem.collapsed({
    required List<FTileGroup> menu,
    FPopoverMenuStyle? popOverMenuStyle,
    Key? key,
  }) =>
      _CollapsedCrumb(
        menu: menu,
        popOverMenuStyle: popOverMenuStyle,
        key: key,
      );
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
    final style = FPaginationData
        .of(context)
        .style;
    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return FTappable(
      focusedOutlineStyle: focusedOutlineStyle,
      onPress: onPress,
      builder: (context, data, child) =>
          Padding(
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
    properties..add(FlagProperty('current', value: current, ifTrue: 'current'))..add(
        ObjectFlagProperty.has('onPress', onPress));
  }
}

// ignore: avoid_implementing_value_types
class _CollapsedCrumb extends StatefulWidget implements FBreadcrumbItem {
  final List<FTileGroup> menu;
  final FPopoverMenuStyle? popOverMenuStyle;

  const _CollapsedCrumb({
    required this.menu,
    this.popOverMenuStyle,
    super.key,
  });

  @override
  State<_CollapsedCrumb> createState() => _CollapsedCrumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('popOverMenuStyle', popOverMenuStyle));
  }
}

class _CollapsedCrumbState extends State<_CollapsedCrumb> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final style = FPaginationData
        .of(context)
        .style;
    return Padding(
      padding: style.padding,
      child: FPopoverMenu.tappable(
        style: widget.popOverMenuStyle,
        popoverController: controller,
        menuAnchor: Alignment.topLeft,
        childAnchor: Alignment.bottomLeft,
        menu: widget.menu,
        child: FIcon(
          FAssets.icons.ellipsis,
          size: style.iconStyle.size,
          color: style.iconStyle.color,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

/// The [FPagination] styles.
final class FPaginationStyle with Diagnosticable {
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

  /// Creates a [FPaginationStyle].
  FPaginationStyle({
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    required this.hoveredTextStyle,
    required this.iconStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
  });

  /// Creates a [FDividerStyles] that inherits its properties from [colorScheme] and [typography].
  FPaginationStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
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

  /// Returns a copy of this [FPaginationStyle] with the given properties replaced.
  @useResult
  FPaginationStyle copyWith({
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    TextStyle? hoveredTextStyle,
    FIconStyle? iconStyle,
    EdgeInsets? padding,
  }) =>
      FPaginationStyle(
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
        hoveredTextStyle: hoveredTextStyle ?? this.hoveredTextStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle))..add(
        DiagnosticsProperty('unselectedTextStyle', unselectedTextStyle))..add(
        DiagnosticsProperty('hoveredTextStyle', hoveredTextStyle))..add(
        DiagnosticsProperty('iconStyle', iconStyle))..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FPaginationStyle &&
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
