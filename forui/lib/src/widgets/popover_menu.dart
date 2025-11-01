import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'popover_menu.design.dart';

/// A popover menu displays a menu in a portal aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover-menu for working examples.
/// * [FPopoverController] for controlling a popover menu.
/// * [FPopoverMenuStyle] for customizing a popover menu's appearance.
/// * [FTileGroup] for customizing the items in the menu.
class FPopoverMenu extends StatelessWidget {
  static List<FItemGroupMixin> _defaultItemBuilder(
    BuildContext context,
    FPopoverController controller,
    List<FItemGroupMixin>? menu,
  ) => menu!;

  static List<FTileGroupMixin> _defaultTileBuilder(
    BuildContext context,
    FPopoverController controller,
    List<FTileGroupMixin>? menu,
  ) => menu!;

  static Widget _builder(BuildContext _, FPopoverController _, Widget? child) => child!;

  /// The popover menu's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create popover-menu
  /// ```
  final FPopoverMenuStyle Function(FPopoverMenuStyle style)? style;

  /// The controller.
  final FPopoverController? popoverController;

  /// {@macro forui.widgets.FTileGroup.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.widgets.FTileGroup.cacheExtent}
  final double? cacheExtent;

  /// {@macro forui.widgets.FTileGroup.maxHeight}
  final double maxHeight;

  /// {@macro forui.widgets.FTileGroup.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.widgets.FTileGroup.divider}
  ///
  /// Defaults to [FItemDivider.full].
  final FItemDivider divider;

  /// The anchor point on the menu used for positioning relative to the [childAnchor].
  ///
  /// For example, with `menuAnchor: Alignment.topCenter` and `childAnchor: Alignment.bottomCenter`,
  /// the menu's top edge will align with the child's bottom edge.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry menuAnchor;

  /// The anchor point on the child used for positioning relative to the [menuAnchor].
  ///
  /// For example, with `childAnchor: Alignment.bottomCenter` and `menuAnchor: Alignment.topCenter`,
  /// the child's bottom edge will align with the menu's top edge.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.overflow}
  final FPortalOverflow overflow;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? groupId;

  /// {@macro forui.widgets.FPopover.hideRegion}
  final FPopoverHideRegion hideRegion;

  /// {@macro forui.widgets.FPopover.onTapHide}
  ///
  /// This is only called if [hideRegion] is set to [FPopoverHideRegion.anywhere] or [FPopoverHideRegion.excludeChild].
  final VoidCallback? onTapHide;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool? autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.widgets.FPopover.traversalEdgeBehavior}
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// {@macro forui.widgets.FPopover.barrierSemanticsLabel}
  final String? barrierSemanticsLabel;

  /// {@macro forui.widgets.FPopover.barrierSemanticsDismissible}
  final bool barrierSemanticsDismissible;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// {@macro forui.widgets.FPopover.builder}
  final ValueWidgetBuilder<FPopoverController> builder;

  /// The child.
  ///
  /// Passed to [builder] if provided.
  final Widget? child;

  final Widget Function(BuildContext context, FPopoverController controller, FPopoverMenuStyle style) _menuBuilder;

  /// Creates a menu of [FItem]s that is only shown when toggled.
  ///
  /// Recommended for desktops & web.
  ///
  /// [menuBuilder] is an optional builder which returns the menu that the popover is aligned to. It can incorporate a
  /// value-independent widget subtree from the [menu] into the returned widget tree. It can be null if the entire
  /// widget subtree the [menuBuilder] builds doest not require the controller.
  ///
  /// [menu] is an optional list of [FItemMixin]s that will be used as the menu items. If provided, it will be
  /// passed to [menuBuilder].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * neither [builder] nor [child] is provided.
  /// * neither [menuBuilder] nor [menu] is provided.
  FPopoverMenu({
    this.popoverController,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FItemDivider.full,
    this.menuAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.groupId,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    List<FItemGroupMixin> Function(BuildContext context, FPopoverController controller, List<FItemGroupMixin>? menu)
        menuBuilder =
        _defaultItemBuilder,
    List<FItemGroupMixin>? menu,
    this.builder = _builder,
    this.child,
    super.key,
  }) : _menuBuilder = ((context, controller, style) => FItemGroup.merge(
         scrollController: scrollController,
         cacheExtent: cacheExtent,
         maxHeight: maxHeight,
         dragStartBehavior: dragStartBehavior,
         semanticsLabel: semanticsLabel,
         style: style.itemGroupStyle,
         divider: divider,
         children: menuBuilder(context, controller, menu),
       )),
       assert(builder != _builder || child != null, 'Either builder or child must be provided'),
       assert(menuBuilder != _defaultTileBuilder || menu != null, 'Either menuBuilder or menu must be provided');

  /// Creates a menu of [FTile]s that is only shown when toggled.
  ///
  /// Recommended for touch devices.
  ///
  /// [menuBuilder] is an optional builder which returns the menu that the popover is aligned to. It can incorporate a
  /// value-independent widget subtree from the [menu] into the returned widget tree. It can be null if the entire
  /// widget subtree the [menuBuilder] builds doest not require the controller.
  ///
  /// [menu] is an optional list of [FTileGroupMixin]s that will be used as the menu items. If provided, it will be
  /// passed to [menuBuilder].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * neither [builder] nor [child] is provided.
  /// * neither [menuBuilder] nor [menu] is provided.
  FPopoverMenu.tiles({
    this.popoverController,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FItemDivider.full,
    this.menuAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.spacing = const FPortalSpacing(4),
    this.overflow = FPortalOverflow.flip,
    this.offset = Offset.zero,
    this.groupId,
    this.hideRegion = FPopoverHideRegion.excludeChild,
    this.onTapHide,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior,
    List<FTileGroupMixin> Function(BuildContext context, FPopoverController controller, List<FTileGroupMixin>? menu)
        menuBuilder =
        _defaultTileBuilder,
    List<FTileGroupMixin>? menu,
    this.builder = _builder,
    this.child,
    super.key,
  }) : _menuBuilder = ((context, controller, style) => FTileGroup.merge(
         scrollController: scrollController,
         cacheExtent: cacheExtent,
         maxHeight: maxHeight,
         dragStartBehavior: dragStartBehavior,
         semanticsLabel: semanticsLabel,
         style: style.tileGroupStyle,
         divider: divider,
         children: menuBuilder(context, controller, menu),
       )),
       assert(builder != _builder || child != null, 'Either builder or child must be provided'),
       assert(menuBuilder != _defaultTileBuilder || menu != null, 'Either menuBuilder or menu must be provided');

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.popoverMenuStyle) ?? context.theme.popoverMenuStyle;
    return FPopover(
      controller: popoverController,
      style: style,
      constraints: FPortalConstraints(maxWidth: style.maxWidth),
      popoverAnchor: menuAnchor,
      childAnchor: childAnchor,
      spacing: spacing,
      overflow: overflow,
      offset: offset,
      groupId: groupId,
      hideRegion: hideRegion,
      onTapHide: onTapHide,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      traversalEdgeBehavior: traversalEdgeBehavior,
      barrierSemanticsLabel: barrierSemanticsLabel,
      barrierSemanticsDismissible: barrierSemanticsDismissible,
      popoverBuilder: (context, controller) => FInheritedItemData(child: _menuBuilder(context, controller, style)),
      builder: builder,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('popoverController', popoverController))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(EnumProperty('divider', divider))
      ..add(DiagnosticsProperty('popoverAnchor', menuAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('spacing', spacing))
      ..add(ObjectFlagProperty.has('overflow', overflow))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideRegion', hideRegion))
      ..add(ObjectFlagProperty.has('onTapHide', onTapHide))
      ..add(StringProperty('barrierSemanticsLabel', barrierSemanticsLabel))
      ..add(
        FlagProperty(
          'barrierSemanticsDismissible',
          value: barrierSemanticsDismissible,
          ifTrue: 'barrier semantics dismissible',
        ),
      )
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(EnumProperty('traversalEdgeBehavior', traversalEdgeBehavior))
      ..add(ObjectFlagProperty.has('menuBuilder', _menuBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// A [FPopoverMenuStyle]'s style.
class FPopoverMenuStyle extends FPopoverStyle with _$FPopoverMenuStyleFunctions {
  /// The item group's style.
  @override
  final FItemGroupStyle itemGroupStyle;

  /// The tile group's style.
  @override
  final FTileGroupStyle tileGroupStyle;

  /// The menu's max width. Defaults to 250.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the width is not positive.
  @override
  final double maxWidth;

  /// Creates a [FPopoverMenuStyle].
  const FPopoverMenuStyle({
    required this.itemGroupStyle,
    required this.tileGroupStyle,
    required super.decoration,
    this.maxWidth = 250,
    super.barrierFilter,
    super.backgroundFilter,
    super.viewInsets,
  }) : assert(0 < maxWidth, 'maxWidth ($maxWidth) must be > 0');

  /// Creates a [FPopoverMenuStyle] that inherits its properties.
  FPopoverMenuStyle.inherit({required super.colors, required super.style, required FTypography typography})
    : itemGroupStyle = FItemGroupStyle.inherit(colors: colors, style: style, typography: typography).copyWith(
        decoration: BoxDecoration(
          border: Border.all(color: colors.border, width: style.borderWidth),
          borderRadius: style.borderRadius,
        ),
      ),
      tileGroupStyle = FTileGroupStyle.inherit(colors: colors, style: style, typography: typography),
      maxWidth = 250,
      super.inherit();
}
