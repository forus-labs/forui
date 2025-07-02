import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'popover_menu.style.dart';

/// A popover menu displays a menu in a portal aligned to a child.
///
/// See:
/// * https://forui.dev/docs/overlay/popover-menu for working examples.
/// * [FPopoverController] for controlling a popover menu.
/// * [FPopoverMenuStyle] for customizing a popover menu's appearance.
/// * [FTileGroup] for customizing the items in the menu.
class FPopoverMenu extends StatelessWidget {
  static List<FTileGroupMixin<FTileMixin>> _menuBuilder(
    BuildContext context,
    FPopoverController controller,
    List<FTileGroupMixin<FTileMixin>>? menu,
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
  final FPopoverMenuStyle Function(FPopoverMenuStyle)? style;

  /// The controller that shows and hides the menu. It initially hides the menu.
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

  /// The point on the menu (floating content) that connects with the child at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the menu will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  ///
  /// Defaults to [Alignment.topCenter].
  final AlignmentGeometry menuAnchor;

  /// The point on the child that connects with the menu at the menu's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the menu.
  /// See [menuAnchor] for changing the menu's anchor.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

  /// {@macro forui.widgets.FPopover.spacing}
  final FPortalSpacing spacing;

  /// {@macro forui.widgets.FPopover.shift}
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// {@macro forui.widgets.FPopover.offset}
  final Offset offset;

  /// {@macro forui.widgets.FPopover.groupId}
  final Object? groupId;

  /// {@macro forui.widgets.FPopover.hideOnTapOutside}
  final FHidePopoverRegion hideOnTapOutside;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool? autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusScopeNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.widgets.FPopover.traversalEdgeBehavior}
  final TraversalEdgeBehavior traversalEdgeBehavior;

  /// {@macro forui.widgets.FPopover.barrierSemanticsLabel}
  final String? barrierSemanticsLabel;

  /// {@macro forui.widgets.FPopover.barrierSemanticsDismissible}
  final bool barrierSemanticsDismissible;

  /// The menu's semantic label used by accessibility frameworks.
  final String? semanticsLabel;

  /// An optional builder which returns the menu that the popover is aligned to.
  ///
  /// Can incorporate a value-independent widget subtree from the [menu] into the returned widget tree.
  ///
  /// This can be null if the entire widget subtree the [menuBuilder] builds doest not require the controller.
  final List<FTileGroupMixin<FTileMixin>> Function(BuildContext, FPopoverController, List<FTileGroupMixin<FTileMixin>>?)
  menuBuilder;

  /// The menu.
  ///
  /// Passed to [menuBuilder] if provided.
  final List<FTileGroupMixin<FTileMixin>>? menu;

  /// {@macro forui.widgets.FPopover.builder}
  final ValueWidgetBuilder<FPopoverController> builder;

  /// The child.
  ///
  /// Passed to [builder] if provided.
  final Widget? child;

  /// Creates a menu that only shows the menu when the controller is manually toggled.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * neither [builder] nor [child] is provided.
  /// * neither [menuBuilder] nor [menu] is provided.
  const FPopoverMenu({
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
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    this.groupId,
    this.hideOnTapOutside = FHidePopoverRegion.anywhere,
    this.barrierSemanticsLabel,
    this.barrierSemanticsDismissible = true,
    this.semanticsLabel,
    this.autofocus,
    this.focusNode,
    this.onFocusChange,
    this.traversalEdgeBehavior = TraversalEdgeBehavior.closedLoop,
    this.menuBuilder = _menuBuilder,
    this.menu,
    this.builder = _builder,
    this.child,
    super.key,
  }) : assert(builder != _builder || child != null, 'Either builder or child must be provided.'),
       assert(menuBuilder != _menuBuilder || menu != null, 'Either menuBuilder or menu must be provided.');

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
      shift: shift,
      offset: offset,
      groupId: groupId,
      hideOnTapOutside: hideOnTapOutside,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      traversalEdgeBehavior: traversalEdgeBehavior,
      barrierSemanticsLabel: barrierSemanticsLabel,
      barrierSemanticsDismissible: barrierSemanticsDismissible,
      popoverBuilder: (context, controller) => FTileGroup.merge(
        scrollController: scrollController,
        cacheExtent: cacheExtent,
        maxHeight: maxHeight,
        dragStartBehavior: dragStartBehavior,
        semanticsLabel: semanticsLabel,
        style: style.tileGroupStyle,
        divider: divider,
        children: menuBuilder(context, controller, menu),
      ),
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
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('groupId', groupId))
      ..add(EnumProperty('hideOnTapOutside', hideOnTapOutside))
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
      ..add(ObjectFlagProperty.has('menuBuilder', menuBuilder))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// A [FPopoverMenuStyle]'s style.
class FPopoverMenuStyle extends FPopoverStyle with _$FPopoverMenuStyleFunctions {
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
    required this.tileGroupStyle,
    required super.decoration,
    this.maxWidth = 250,
    super.barrierFilter,
    super.backgroundFilter,
    super.viewInsets,
  }) : assert(0 < maxWidth, 'maxWidth must be positive');

  /// Creates a [FPopoverMenuStyle] that inherits its properties.
  FPopoverMenuStyle.inherit({required super.colors, required super.style, required FTypography typography})
    : tileGroupStyle = FTileGroupStyle.inherit(colors: colors, style: style, typography: typography),
      maxWidth = 250,
      super.inherit();
}
