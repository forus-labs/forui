import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A Breadcrumb.
///
/// A breadcrumb is a list of links that help visualize a page's location within a site's hierarchical structure,
/// it allows navigation up to any of the ancestors.
///
/// See:
/// * https://forui.dev/docs/navigation/breadcrumb for working examples.
/// * [FBreadcrumbStyle] for customizing a breadcrumb's appearance.
final class FBreadcrumb extends StatelessWidget {
  /// The breadcrumb's style. Defaults to the appropriate style in [FThemeData.breadcrumbStyle].
  final FBreadcrumbStyle? style;

  /// The list of breadcrumb items.
  ///
  /// Each item in the list is typically an [FBreadcrumbItem], with a [divider] placed between consecutive items.
  /// The last item in the list is usually an [FBreadcrumbItem] with the `selected` property set to true,
  /// to indicate the current page in the breadcrumb.
  final List<Widget> children;

  /// The divider icons place in between the children.
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
          if (index < children.length - 1) Padding(padding: const EdgeInsets.symmetric(horizontal: 5), child: divider),
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
mixin FBreadcrumbItem on Widget {
  /// Creates a basic crumb.
  ///
  /// It is typically used to represent a single item in the breadcrumb.
  static Widget of({
    required VoidCallback onPress,
    required Widget child,
    bool? selected,
    Key? key,
  }) =>
      _Crumb(onPress: onPress, selected: selected, key: key, child: child);

  /// Creates a collapsed crumb.
  ///
  /// It is typically used to keep the breadcrumb compact when there are too many items.
  static Widget collapsed({
    required List<FTileGroup> menu,
    Key? key,
  }) =>
      _NestedCrumbs(menu: menu, key: key);
}

class _Crumb extends StatelessWidget implements FBreadcrumbItem {
  final bool selected;
  final VoidCallback onPress;
  final Widget child;

  const _Crumb({
    required this.onPress,
    required this.child,
    bool? selected,
    super.key,
  }) : selected = selected ?? false;

  @override
  Widget build(BuildContext context) {
    final style = FBreadcrumbItemData.of(context).style;

    return FTappable(
      onPress: onPress,
      child: DefaultTextStyle(
        style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(ObjectFlagProperty.has('onPress', onPress));
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
  Widget build(BuildContext context) {
    final style = FBreadcrumbItemData.of(context).style;
    return FPopoverMenu.tappable(
      popoverController: controller,
      menuAnchor: Alignment.topLeft,
      childAnchor: Alignment.bottomLeft,
      menu: widget.menu,
      child: FIcon(
        FAssets.icons.ellipsis,
        size: style.iconStyle.size,
        color: style.iconStyle.color,
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

/// The [FBreadcrumb] styles.
final class FBreadcrumbStyle with Diagnosticable {
  /// The selected breadcrumb [TextStyle].
  final TextStyle selectedTextStyle;

  /// The unselected breadcrumb [TextStyle].
  final TextStyle unselectedTextStyle;

  /// The divider icon style.
  final FIconStyle iconStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  final EdgeInsets padding;

  /// Creates a [FBreadcrumbStyle].
  FBreadcrumbStyle({
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
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
          iconStyle: FIconStyle(color: colorScheme.mutedForeground, size: 24),
        );

  /// Returns a copy of this [FBreadcrumbStyle] with the given properties replaced.
  @useResult
  FBreadcrumbStyle copyWith({
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    FIconStyle? iconStyle,
    EdgeInsets? padding,
  }) =>
      FBreadcrumbStyle(
        selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
        unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('selectedTextStyle', selectedTextStyle))
      ..add(DiagnosticsProperty('unselectedTextStyle', unselectedTextStyle))
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
          iconStyle == other.iconStyle &&
          padding == other.padding;

  @override
  int get hashCode => selectedTextStyle.hashCode ^ unselectedTextStyle.hashCode ^ iconStyle.hashCode ^ padding.hashCode;
}
