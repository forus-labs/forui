import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A Breadcrumb.
///
/// Displays the path to the current resource using a hierarchy of links..
///
/// See:
/// * https://forui.dev/docs/navigation/breadcrumb for working examples.
/// * [FBreadcrumbStyle] for customizing a breadcrumb's appearance.
final class FBreadcrumb extends StatelessWidget {
  /// The breadcrumb's style. Defaults to the appropriate style in [FThemeData.breadcrumbStyle].
  final FBreadcrumbStyle? style;

  /// The items.
  final List<FBreadcrumbItem> items;

  final Widget? dividerIcon;

  /// Creates an [FBreadcrumb].
  const FBreadcrumb({
    required this.items,
    this.dividerIcon,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.breadcrumbStyle;
    final dividerIcon =
        this.dividerIcon ?? FIcon(FAssets.icons.chevronRight, color: Colors.white, size: style.iconSize);

    return Row(
      children: [
        for (final (index, item) in items.indexed) ...[
          if (item is _Crumb) item else item as _NestedCrumbs,
          if (index < items.length-1) Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: dividerIcon),
        ]
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

abstract class FBreadcrumbItem {
  const FBreadcrumbItem._();

  /// Creates a crumb.
  ///
  /// It is typically used on pages at the root of the navigation stack.
  factory FBreadcrumbItem({
    required VoidCallback onPressed,
    required Widget child,
    bool? selected,
    Key? key,
  }) = _Crumb;

  /// Creates a nested crumb.
  ///
  /// It is typically used on pages NOT at the root of the navigation stack.
  factory FBreadcrumbItem.nested({
    required List<FTileGroup> menu,
    Key? key,
  }) =>
      _NestedCrumbs(menu: menu, key: key);
}

class _Crumb extends StatelessWidget implements FBreadcrumbItem {
  final bool selected;
  final VoidCallback onPressed;
  final Widget child;

  const _Crumb({
    required this.onPressed,
    required this.child,
    bool? selected,
    super.key,
  }) : selected = selected ?? false;

  @override
  Widget build(BuildContext context) {
    final style = context.theme.breadcrumbStyle;

    return FTappable(
      onPress: onPressed,
      child: DefaultTextStyle(
        style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
        child: child,
      ),
    );
  }
}

class _NestedCrumbs extends StatefulWidget implements FBreadcrumbItem {
  final List<FTileGroup> menu;

  const _NestedCrumbs({
    required this.menu,
    super.key,
  });

  @override
  State<_NestedCrumbs> createState() => _NestedCrumbsState();
}

class _NestedCrumbsState extends State<_NestedCrumbs> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget build(BuildContext context) => Container(
        child: FPopoverMenu.tappable(

          popoverController: controller,
          menuAnchor: Alignment.topRight,
          childAnchor: Alignment.bottomRight,
          menu: widget.menu,
          child: FIcon(FAssets.icons.ellipsis),
        ),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

/// The [FDivider] styles.
final class FBreadcrumbStyle with Diagnosticable {
  /// The selected breadcrumb [TextStyle].
  final TextStyle selectedTextStyle;

  /// The unselected breadcrumb [TextStyle].
  final TextStyle unselectedTextStyle;

  final double iconSize;
  final Color iconColor;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  final EdgeInsets padding;

  /// Creates a [FBreadcrumbStyle].
  FBreadcrumbStyle({
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    required this.iconColor,
    this.iconSize = 24,
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
          iconColor: colorScheme.mutedForeground,
        );

  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  @useResult
  FBreadcrumbStyle copyWith({
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    Color? iconColor,
    double? iconSize,
    EdgeInsets? padding,
  }) =>
      FBreadcrumbStyle(
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
        iconColor: iconColor ?? this.iconColor,
        iconSize: iconSize ?? this.iconSize,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBreadcrumbStyle &&
          runtimeType == other.runtimeType &&
          selectedTextStyle == other.selectedTextStyle &&
          unselectedTextStyle == other.unselectedTextStyle &&
          iconColor == other.iconColor &&
          iconSize == other.iconSize &&
          padding == other.padding;

  @override
  int get hashCode =>
      selectedTextStyle.hashCode ^
      unselectedTextStyle.hashCode ^
      iconColor.hashCode ^
      iconSize.hashCode ^
      padding.hashCode;
}
