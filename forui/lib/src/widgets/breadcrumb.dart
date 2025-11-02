import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/debug.dart';

part 'breadcrumb.design.dart';

/// A breadcrumb.
///
/// A breadcrumb is a list of links that helps visualize a page's location within a site's hierarchical structure,
/// allowing navigation up to any of its ancestors.
///
/// See:
/// * https://forui.dev/docs/navigation/breadcrumb for working examples.
/// * [FBreadcrumbStyle] for customizing a breadcrumb's appearance.
/// * [FBreadcrumbItem] for adding items to a breadcrumb.
class FBreadcrumb extends StatelessWidget {
  /// The breadcrumb's style. Defaults to the appropriate style in [FThemeData.breadcrumbStyle].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create breadcrumb
  /// ```
  final FBreadcrumbStyle Function(FBreadcrumbStyle style)? style;

  /// A list of breadcrumb items representing the navigation path.
  ///
  /// Each item is typically an [FBreadcrumbItem], separated by a [divider]. The last item generally represents the
  /// current page and has its `current` property set to `true`. Navigation can be handled via the `onPress` callback.
  final List<Widget> children;

  /// The divider placed between the children.
  ///
  /// Defaults to [FIcons.chevronRight].
  final Widget? divider;

  /// Creates an [FBreadcrumb].
  const FBreadcrumb({required this.children, this.style, this.divider, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.breadcrumbStyle) ?? context.theme.breadcrumbStyle;
    final divider = IconTheme(data: style.iconStyle, child: this.divider ?? const Icon(FIcons.chevronRight));

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
  @useResult
  static FBreadcrumbItemData of(BuildContext context) {
    assert(debugCheckHasAncestor<FBreadcrumbItemData>('$FBreadcrumb', context));
    return context.dependOnInheritedWidgetOfExactType<FBreadcrumbItemData>()!;
  }

  /// The breadcrumb's style.
  final FBreadcrumbStyle style;

  /// Creates a [FBreadcrumbItemData].
  const FBreadcrumbItemData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FBreadcrumbItemData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A breadcrumb item.
abstract interface class FBreadcrumbItem extends Widget {
  /// Creates a crumb that typically represents a single item in the navigation path.
  const factory FBreadcrumbItem({
    required Widget child,
    bool current,
    bool autofocus,
    FocusNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<Set<WidgetState>>? onStateChange,
    VoidCallback? onPress,
    Key? key,
  }) = _Crumb;

  /// Creates a collapsed crumb using [FItem]s.
  ///
  /// Recommended for desktops & web.
  ///
  /// It is typically used to keep the breadcrumb compact and reduce the number of items displayed. When tapped, it
  /// displays a popover menu with the collapsed items.
  const factory FBreadcrumbItem.collapsed({
    required List<FItemGroup> menu,
    FPopoverMenuStyle Function(FPopoverMenuStyle style)? popoverMenuStyle,
    FPopoverController? popoverController,
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight,
    DragStartBehavior dragStartBehavior,
    FItemDivider divider,
    AlignmentGeometry menuAnchor,
    AlignmentGeometry childAnchor,
    FPortalSpacing spacing,
    FPortalOverflow overflow,
    Offset offset,
    FPopoverHideRegion hideRegion,
    VoidCallback? onTapHide,
    bool autofocus,
    FocusScopeNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<Set<WidgetState>>? onStateChange,
    TraversalEdgeBehavior traversalEdgeBehavior,
    String? semanticsLabel,
    Key? key,
  }) = _CollapsedCrumb;

  /// Creates a collapsed crumb using [FTile]s.
  ///
  /// Recommended for touch devices.
  ///
  /// It is typically used to keep the breadcrumb compact and reduce the number of items displayed. When tapped, it
  /// displays a popover menu with the collapsed items.
  const factory FBreadcrumbItem.collapsedTiles({
    required List<FTileGroup> menu,
    FPopoverMenuStyle Function(FPopoverMenuStyle style)? popoverMenuStyle,
    FPopoverController? popoverController,
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight,
    DragStartBehavior dragStartBehavior,
    FItemDivider divider,
    AlignmentGeometry menuAnchor,
    AlignmentGeometry childAnchor,
    FPortalSpacing spacing,
    FPortalOverflow overflow,
    Offset offset,
    FPopoverHideRegion hideRegion,
    bool autofocus,
    FocusScopeNode? focusNode,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<Set<WidgetState>>? onStateChange,
    TraversalEdgeBehavior traversalEdgeBehavior,
    String? semanticsLabel,
    Key? key,
  }) = _CollapsedCrumb.tiles;
}

// ignore: avoid_implementing_value_types
class _Crumb extends StatelessWidget implements FBreadcrumbItem {
  final bool current;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<Set<WidgetState>>? onStateChange;
  final VoidCallback? onPress;
  final Widget child;

  const _Crumb({
    required this.child,
    this.onPress,
    this.current = false,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = FBreadcrumbItemData.of(context).style;
    final focusedOutlineStyle = context.theme.style.focusedOutlineStyle;

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: focusedOutlineStyle,
      selected: current,
      onPress: onPress,
      builder: (_, states, child) => DefaultTextStyle(style: style.textStyle.resolve(states), child: child!),
      child: Padding(padding: style.padding, child: child),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('current', value: current, ifTrue: 'current'))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(ObjectFlagProperty.has('onPress', onPress));
  }
}

// ignore: avoid_implementing_value_types
class _CollapsedCrumb extends StatefulWidget implements FBreadcrumbItem {
  final List<FTileGroup>? tileMenu;
  final List<FItemGroup>? itemMenu;
  final FPopoverMenuStyle Function(FPopoverMenuStyle style)? popoverMenuStyle;
  final FPopoverController? popoverController;
  final ScrollController? scrollController;
  final double? cacheExtent;
  final double maxHeight;
  final DragStartBehavior dragStartBehavior;
  final FItemDivider divider;
  final AlignmentGeometry menuAnchor;
  final AlignmentGeometry childAnchor;
  final FPortalSpacing spacing;
  final FPortalOverflow overflow;
  final Offset offset;
  final FPopoverHideRegion hideRegion;
  final VoidCallback? onTapHide;
  final bool autofocus;
  final FocusScopeNode? focusNode;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<bool>? onHoverChange;
  final ValueChanged<Set<WidgetState>>? onStateChange;
  final TraversalEdgeBehavior? traversalEdgeBehavior;
  final String? semanticsLabel;

  const _CollapsedCrumb({
    required List<FItemGroup> menu,
    this.popoverMenuStyle,
    this.popoverController,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FItemDivider.full,
    this.menuAnchor = Alignment.topLeft,
    this.childAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.traversalEdgeBehavior,
    super.key,
  }) : itemMenu = menu,
       tileMenu = null;

  const _CollapsedCrumb.tiles({
    required List<FTileGroup> menu,
    this.popoverMenuStyle,
    this.popoverController,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FItemDivider.full,
    this.menuAnchor = Alignment.topLeft,
    this.childAnchor = Alignment.bottomLeft,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.traversalEdgeBehavior = TraversalEdgeBehavior.closedLoop,
    super.key,
  }) : itemMenu = null,
       tileMenu = menu;

  @override
  State<_CollapsedCrumb> createState() => _CollapsedCrumbState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverMenuStyle', popoverMenuStyle))
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('menuAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

class _CollapsedCrumbState extends State<_CollapsedCrumb> with SingleTickerProviderStateMixin {
  late FPopoverController _popoverController = widget.popoverController ?? FPopoverController(vsync: this);

  @override
  void didUpdateWidget(covariant _CollapsedCrumb old) {
    super.didUpdateWidget(old);
    if (widget.popoverController != old.popoverController) {
      if (old.popoverController == null) {
        _popoverController.dispose();
      }

      _popoverController = widget.popoverController ?? FPopoverController(vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = FBreadcrumbItemData.of(context).style;
    if (widget.itemMenu case final menu?) {
      return FPopoverMenu(
        popoverController: _popoverController,
        style: widget.popoverMenuStyle?.call(context.theme.popoverMenuStyle) ?? context.theme.popoverMenuStyle,
        menuAnchor: widget.menuAnchor,
        childAnchor: widget.childAnchor,
        spacing: widget.spacing,
        overflow: widget.overflow,
        offset: widget.offset,
        hideRegion: widget.hideRegion,
        onTapHide: widget.onTapHide,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onFocusChange: widget.onFocusChange,
        traversalEdgeBehavior: widget.traversalEdgeBehavior,
        scrollController: widget.scrollController,
        cacheExtent: widget.cacheExtent,
        maxHeight: widget.maxHeight,
        dragStartBehavior: widget.dragStartBehavior,
        semanticsLabel: widget.semanticsLabel,
        divider: widget.divider,
        menu: menu,
        child: FTappable(
          focusedOutlineStyle: style.focusedOutlineStyle,
          onPress: _popoverController.toggle,
          child: Padding(
            padding: style.padding,
            child: IconTheme(data: style.iconStyle, child: const Icon(FIcons.ellipsis)),
          ),
        ),
      );
    } else {
      return FPopoverMenu.tiles(
        popoverController: _popoverController,
        style: widget.popoverMenuStyle?.call(context.theme.popoverMenuStyle) ?? context.theme.popoverMenuStyle,
        menuAnchor: widget.menuAnchor,
        childAnchor: widget.childAnchor,
        spacing: widget.spacing,
        overflow: widget.overflow,
        offset: widget.offset,
        hideRegion: widget.hideRegion,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onFocusChange: widget.onFocusChange,
        traversalEdgeBehavior: widget.traversalEdgeBehavior,
        scrollController: widget.scrollController,
        cacheExtent: widget.cacheExtent,
        maxHeight: widget.maxHeight,
        dragStartBehavior: widget.dragStartBehavior,
        semanticsLabel: widget.semanticsLabel,
        divider: widget.divider,
        menu: widget.tileMenu!,
        child: FTappable(
          focusedOutlineStyle: style.focusedOutlineStyle,
          onPress: _popoverController.toggle,
          child: Padding(
            padding: style.padding,
            child: IconTheme(data: style.iconStyle, child: const Icon(FIcons.ellipsis)),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    if (widget.popoverController == null) {
      _popoverController.dispose();
    }
    super.dispose();
  }
}

/// The [FBreadcrumb] styles.
class FBreadcrumbStyle with Diagnosticable, _$FBreadcrumbStyleFunctions {
  /// The text style.
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The divider icon style.
  @override
  final IconThemeData iconStyle;

  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FBreadcrumbStyle].
  FBreadcrumbStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
  });

  /// Creates a [FBreadcrumbStyle] that inherits its properties.
  FBreadcrumbStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        textStyle: FWidgetStateMap({
          // Selected
          WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): typography.sm.copyWith(
            fontWeight: FontWeight.w400,
            color: colors.foreground,
            decoration: TextDecoration.underline,
          ),
          WidgetState.selected: typography.sm.copyWith(fontWeight: FontWeight.w400, color: colors.foreground),

          // Unselected
          WidgetState.hovered | WidgetState.pressed: typography.sm.copyWith(
            fontWeight: FontWeight.w400,
            color: colors.primary,
            decoration: TextDecoration.underline,
          ),
          WidgetState.any: typography.sm.copyWith(fontWeight: FontWeight.w400, color: colors.mutedForeground),
        }),
        iconStyle: IconThemeData(color: colors.mutedForeground, size: 16),
        tappableStyle: style.tappableStyle.copyWith(motion: FTappableMotion.none),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}
